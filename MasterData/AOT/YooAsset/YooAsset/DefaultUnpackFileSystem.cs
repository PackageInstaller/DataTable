namespace YooAsset;

internal class DefaultUnpackFileSystem : DefaultCacheFileSystem
{
	public override void OnCreate(string packageName, string rootDirectory)
	{
		base.OnCreate(packageName, rootDirectory);
		_cacheBundleFilesRoot = PathUtility.Combine(_packageRoot, "UnpackBundleFiles");
		_cacheManifestFilesRoot = PathUtility.Combine(_packageRoot, "UnpackManifestFiles");
		_tempFilesRoot = PathUtility.Combine(_packageRoot, "UnpackTempFiles");
	}
}
