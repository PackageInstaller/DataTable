namespace YooAsset;

internal class DownloadFileOptions
{
	public readonly int FailedTryAgain;

	public readonly int Timeout;

	public string MainURL { get; set; }

	public string FallbackURL { get; set; }

	public string ImportFilePath { get; set; }

	public string DeviceID { get; set; }

	public DownloadFileOptions(int failedTryAgain, int timeout)
	{
		FailedTryAgain = failedTryAgain;
		Timeout = timeout;
	}
}
