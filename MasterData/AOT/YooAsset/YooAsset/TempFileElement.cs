namespace YooAsset;

internal class TempFileElement
{
	public volatile int Result;

	public string TempFilePath { get; private set; }

	public string TempFileCRC { get; private set; }

	public long TempFileSize { get; private set; }

	public TempFileElement(string filePath, string fileCRC, long fileSize)
	{
		TempFilePath = filePath;
		TempFileCRC = fileCRC;
		TempFileSize = fileSize;
	}
}
