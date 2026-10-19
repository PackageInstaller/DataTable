namespace UnityEngine.ResourceManagement.AsyncOperations;

public struct DownloadStatus
{
	public long TotalBytes;

	public long DownloadedBytes;

	public bool IsDone;

	public float Percent
	{
		get
		{
			if (TotalBytes <= 0)
			{
				if (!IsDone)
				{
					return 0f;
				}
				return 1f;
			}
			return (float)DownloadedBytes / (float)TotalBytes;
		}
	}
}
