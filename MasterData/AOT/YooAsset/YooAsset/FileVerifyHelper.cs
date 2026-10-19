using System;
using System.IO;

namespace YooAsset;

internal class FileVerifyHelper
{
	public static EFileVerifyResult FileVerify(string filePath, long fileSize, string fileCRC, EFileVerifyLevel verifyLevel)
	{
		try
		{
			if (!File.Exists(filePath))
			{
				return EFileVerifyResult.DataFileNotExisted;
			}
			long fileSize2 = FileUtility.GetFileSize(filePath);
			if (fileSize2 < fileSize)
			{
				return EFileVerifyResult.FileNotComplete;
			}
			if (fileSize2 > fileSize)
			{
				return EFileVerifyResult.FileOverflow;
			}
			if (verifyLevel == EFileVerifyLevel.High)
			{
				if (HashUtility.FileCRC32(filePath) == fileCRC)
				{
					return EFileVerifyResult.Succeed;
				}
				return EFileVerifyResult.FileCrcError;
			}
			return EFileVerifyResult.Succeed;
		}
		catch (Exception)
		{
			return EFileVerifyResult.Exception;
		}
	}
}
