using UnityEngine;

public abstract class AssetBundleLoadAssetsOperation<T> : AssetBundleLoadOperationWithCallback where T : Object
{
	public abstract T[] GetAssets();
}
