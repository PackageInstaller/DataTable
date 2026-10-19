using System.IO;
using UnityEngine.SceneManagement;

namespace YooAsset;

internal class RawBundleResult : BundleResult
{
	private readonly IFileSystem _fileSystem;

	private readonly PackageBundle _packageBundle;

	public RawBundleResult(IFileSystem fileSystem, PackageBundle packageBundle)
	{
		_fileSystem = fileSystem;
		_packageBundle = packageBundle;
	}

	public override void UnloadBundleFile()
	{
	}

	public override string GetBundleFilePath()
	{
		return _fileSystem.GetBundleFilePath(_packageBundle);
	}

	public override Stream OpenBundleFileStream()
	{
		return _fileSystem.OpenBundleFileStream(_packageBundle);
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
		return new RawBundleLoadAssetOperation();
	}

	public override FSLoadAllAssetsOperation LoadAllAssetsAsync(AssetInfo assetInfo)
	{
		return new RawBundleLoadAllAssetsOperation();
	}

	public override FSLoadSubAssetsOperation LoadSubAssetsAsync(AssetInfo assetInfo)
	{
		return new RawBundleLoadSubAssetsOperation();
	}

	public override FSLoadSceneOperation LoadSceneOperation(AssetInfo assetInfo, LoadSceneParameters loadParams, bool suspendLoad)
	{
		return new RawBundleLoadSceneOperation();
	}
}
