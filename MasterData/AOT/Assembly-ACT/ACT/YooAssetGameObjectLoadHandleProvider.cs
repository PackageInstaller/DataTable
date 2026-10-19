using Bamboo.Precache;
using UnityEngine;

namespace ACT;

public sealed class YooAssetGameObjectLoadHandleProvider : IAssetLoadHandleProvider<GameObject>
{
	public IAssetLoadHandle<GameObject> Create(string assetKey)
	{
		return new YooAssetGameObjectLoadHandle(AssetStationManager.Root.LoadAsync<GameObject>(assetKey));
	}
}
