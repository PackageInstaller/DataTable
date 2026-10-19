using System;
using System.IO;

namespace YooAsset;

internal class VerifyFileElement
{
	public string DataFileCRC;

	public long DataFileSize;

	public volatile int Result;

	public string PackageName { get; private set; }

	public string BundleGUID { get; private set; }

	public string FileRootPath { get; private set; }

	public string DataFilePath { get; private set; }

	public string InfoFilePath { get; private set; }

	public VerifyFileElement(string packageName, string bundleGUID, string fileRootPath, string dataFilePath, string infoFilePath)
	{
		PackageName = packageName;
		BundleGUID = bundleGUID;
		FileRootPath = fileRootPath;
		DataFilePath = dataFilePath;
		InfoFilePath = infoFilePath;
	}

	public void DeleteFiles()
	{
		try
		{
			Directory.Delete(FileRootPath, recursive: true);
		}
		catch (Exception arg)
		{
			YooLogger.Warning($"Failed to delete cache bundle folder : {arg}");
		}
	}
}
