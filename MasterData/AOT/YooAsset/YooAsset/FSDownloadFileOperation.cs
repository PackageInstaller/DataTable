namespace YooAsset;

internal abstract class FSDownloadFileOperation : AsyncOperationBase
{
	public PackageBundle Bundle { get; private set; }

	public int RefCount { get; private set; }

	public long HttpCode { get; protected set; }

	public long DownloadedBytes { get; protected set; }

	public float DownloadProgress { get; protected set; }

	public FSDownloadFileOperation(PackageBundle bundle)
	{
		Bundle = bundle;
		RefCount = 0;
		HttpCode = 0L;
		DownloadedBytes = 0L;
		DownloadProgress = 0f;
	}

	internal override string InternalGetDesc()
	{
		return $"RefCount : {RefCount}";
	}

	public virtual void Release()
	{
		RefCount--;
	}

	public virtual void Reference()
	{
		RefCount++;
	}
}
