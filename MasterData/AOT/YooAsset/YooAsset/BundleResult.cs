using System.IO;
using UnityEngine.SceneManagement;

namespace YooAsset;

internal abstract class BundleResult
{
	public abstract void UnloadBundleFile();

	public abstract string GetBundleFilePath();

	public virtual Stream OpenBundleFileStream()
	{
		return File.OpenRead(GetBundleFilePath());
	}

	public abstract byte[] ReadBundleFileData();

	public abstract string ReadBundleFileText();

	public abstract FSLoadAssetOperation LoadAssetAsync(AssetInfo assetInfo);

	public abstract FSLoadAllAssetsOperation LoadAllAssetsAsync(AssetInfo assetInfo);

	public abstract FSLoadSubAssetsOperation LoadSubAssetsAsync(AssetInfo assetInfo);

	public abstract FSLoadSceneOperation LoadSceneOperation(AssetInfo assetInfo, LoadSceneParameters loadParams, bool suspendLoad);
}
