using UnityEngine;

public abstract class AssetBundleDownloadOperation : AssetBundleLoadOperation
{
	private bool done;

	public string assetBundleName { get; private set; }

	public LoadedAssetBundle assetBundle { get; protected set; }

	public string error { get; protected set; }

	protected abstract bool downloadIsDone { get; }

	protected abstract void FinishDownload();

	public override bool Update()
	{
		if (timeout > 0f)
		{
			timeout -= Time.deltaTime;
		}
		else
		{
			Debug.Log(assetBundle?.ToString() + " is more thrn 1 minus");
		}
		if (!done && downloadIsDone)
		{
			FinishDownload();
			done = true;
		}
		return !done;
	}

	public override bool IsDone()
	{
		return done;
	}

	public abstract string GetSourceURL();

	public AssetBundleDownloadOperation(string assetBundleName)
	{
		this.assetBundleName = assetBundleName;
	}
}
