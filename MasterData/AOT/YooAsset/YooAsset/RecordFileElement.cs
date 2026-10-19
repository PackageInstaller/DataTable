using System;
using System.IO;

namespace YooAsset;

internal class RecordFileElement
{
	public string InfoFilePath { get; private set; }

	public string DataFilePath { get; private set; }

	public string DataFileCRC { get; private set; }

	public long DataFileSize { get; private set; }

	public RecordFileElement(string infoFilePath, string dataFilePath, string dataFileCRC, long dataFileSize)
	{
		InfoFilePath = infoFilePath;
		DataFilePath = dataFilePath;
		DataFileCRC = dataFileCRC;
		DataFileSize = dataFileSize;
	}

	public bool DeleteFolder()
	{
		try
		{
			DirectoryInfo directoryInfo = new DirectoryInfo(Path.GetDirectoryName(InfoFilePath));
			if (directoryInfo.Exists)
			{
				directoryInfo.Delete(recursive: true);
				return true;
			}
			return false;
		}
		catch (Exception ex)
		{
			YooLogger.Error("Failed to delete cache file ! " + ex.Message);
			return false;
		}
	}
}
