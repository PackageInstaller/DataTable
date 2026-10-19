namespace YooAsset;

public struct DownloadStatus
{
	public bool IsDone;

	public float Progress;

	public long TotalBytes;

	public long DownloadedBytes;

	public static DownloadStatus CreateDefaultStatus()
	{
		return default;
	}
}
