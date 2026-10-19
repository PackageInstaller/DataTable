using UnityEngine;

namespace YooAsset;

internal abstract class DownloadAssetBundleOperation : DefaultDownloadFileOperation
{
	public AssetBundle Result;

	internal DownloadAssetBundleOperation(PackageBundle bundle, DownloadFileOptions options)
		: base(bundle, options)
	{
	}
}
