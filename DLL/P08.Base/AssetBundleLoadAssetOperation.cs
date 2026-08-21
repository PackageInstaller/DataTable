using UnityEngine;

public abstract class AssetBundleLoadAssetOperation<T> : AssetBundleLoadOperationWithCallback where T : Object
{
	public abstract T GetAsset();
}
