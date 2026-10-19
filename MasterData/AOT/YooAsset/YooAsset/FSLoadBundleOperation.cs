namespace YooAsset;

internal abstract class FSLoadBundleOperation : AsyncOperationBase
{
	public BundleResult Result { get; protected set; }

	public float DownloadProgress { get; protected set; }

	public long DownloadedBytes { get; protected set; }
}
