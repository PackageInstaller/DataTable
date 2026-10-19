using UnityEngine.SceneManagement;

namespace YooAsset;

internal class VirtualBundleResult : BundleResult
{
	private readonly IFileSystem _fileSystem;

	private readonly PackageBundle _packageBundle;

	public VirtualBundleResult(IFileSystem fileSystem, PackageBundle bundle)
	{
		_fileSystem = fileSystem;
		_packageBundle = bundle;
	}

	public override void UnloadBundleFile()
	{
	}

	public override string GetBundleFilePath()
	{
		return _fileSystem.GetBundleFilePath(_packageBundle);
	}

	public override byte[] ReadBundleFileData()
	{
		return _fileSystem.ReadBundleFileData(_packageBundle);
	}

	public override string ReadBundleFileText()
	{
		return _fileSystem.ReadBundleFileText(_packageBundle);
	}

	public override FSLoadAssetOperation LoadAssetAsync(AssetInfo assetInfo)
	{
		return new VirtualBundleLoadAssetOperation(_packageBundle, assetInfo);
	}

	public override FSLoadAllAssetsOperation LoadAllAssetsAsync(AssetInfo assetInfo)
	{
		return new VirtualBundleLoadAllAssetsOperation(_packageBundle, assetInfo);
	}

	public override FSLoadSubAssetsOperation LoadSubAssetsAsync(AssetInfo assetInfo)
	{
		return new VirtualBundleLoadSubAssetsOperation(_packageBundle, assetInfo);
	}

	public override FSLoadSceneOperation LoadSceneOperation(AssetInfo assetInfo, LoadSceneParameters loadParams, bool suspendLoad)
	{
		return new VirtualBundleLoadSceneOperation(assetInfo, loadParams, suspendLoad);
	}
}
