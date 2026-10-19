using System.IO;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace YooAsset;

internal class AssetBundleResult : BundleResult
{
	private readonly IFileSystem _fileSystem;

	private readonly PackageBundle _packageBundle;

	private readonly AssetBundle _assetBundle;

	private readonly Stream _managedStream;

	public AssetBundleResult(IFileSystem fileSystem, PackageBundle packageBundle, AssetBundle assetBundle, Stream managedStream)
	{
		_fileSystem = fileSystem;
		_packageBundle = packageBundle;
		_assetBundle = assetBundle;
		_managedStream = managedStream;
	}

	public override void UnloadBundleFile()
	{
		if (_assetBundle != null)
		{
			_assetBundle.Unload(unloadAllLoadedObjects: true);
		}
		if (_managedStream != null)
		{
			_managedStream.Close();
			_managedStream.Dispose();
		}
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
		return new AssetBundleLoadAssetOperation(_packageBundle, _assetBundle, assetInfo);
	}

	public override FSLoadAllAssetsOperation LoadAllAssetsAsync(AssetInfo assetInfo)
	{
		return new AssetBundleLoadAllAssetsOperation(_packageBundle, _assetBundle, assetInfo);
	}

	public override FSLoadSubAssetsOperation LoadSubAssetsAsync(AssetInfo assetInfo)
	{
		return new AssetBundleLoadSubAssetsOperation(_packageBundle, _assetBundle, assetInfo);
	}

	public override FSLoadSceneOperation LoadSceneOperation(AssetInfo assetInfo, LoadSceneParameters loadParams, bool suspendLoad)
	{
		return new AssetBundleLoadSceneOperation(assetInfo, loadParams, suspendLoad);
	}
}
