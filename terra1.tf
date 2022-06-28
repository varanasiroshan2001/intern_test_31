provider "aws" {
  region  = "ap-south-1"
  profile = "roshan1"
}

//FOR CREATING A S3 BUCKET TO UPLOAD IMAGES AND VIDEOS ON CLOUD
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-tf-test-bucket-roshan"
  acl    = "public-read"

  tags = {
    Name  = "1234Myimgbucket9668033104"
  }
}

//FOR PUTTING THE OBJECTS IN s3
resource "aws_s3_bucket_object" "object" {
  depends_on = [
    aws_s3_bucket.my_bucket,
         ]
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "ROSHAN.jpeg"
  source = "C:/Users/V Roshan/Downloads/Roshan pic/ROSHAN.jpeg"
  acl    = "public-read"
  
}



//for creating lambda function
resource "aws_iam_role" "iam_for_lambda" {
  
  name = "iam_for_lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "test_lambda" {

  filename      = "lambda_function_payload.zip"
  function_name = "lambda_function_name"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.test"


  runtime = "nodejs12.x"

  environment {
    variables = {
      foo = "bar"
    }
  }
}