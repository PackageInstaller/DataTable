using System.Collections.Generic;
using Bamboo.AssetField;
using Bamboo.Precache;
using Cysharp.Threading.Tasks;
using UnityEngine.Pool;

namespace ACT;

public static class PrecacheUtility
{
	public delegate void GetList<T>(List<T> list) where T : AssetID;

	public static void Preload(List<YooAssetReference> assetReferences)
	{
		foreach (YooAssetReference assetReference in assetReferences)
		{
			PrecacheManager.Instance.Preload(assetReference.GUID);
		}
	}

	public static void Preload<T>(GetList<T> get) where T : AssetID
	{
		List<T> list = CollectionPool<List<T>, T>.Get();
		get(list);
		foreach (T item in list)
		{
			if (item != null)
			{
				PrecacheManager.Instance.Preload(item.GUID);
			}
		}
		CollectionPool<List<T>, T>.Release(list);
	}

	public static void ReleasePreload<T>(GetList<T> get) where T : AssetID
	{
		List<T> list = CollectionPool<List<T>, T>.Get();
		get(list);
		foreach (T item in list)
		{
			if (item != null)
			{
				PrecacheManager.Instance.ReleasePreload(item.GUID);
			}
		}
		CollectionPool<List<T>, T>.Release(list);
	}

	public static UniTask.Awaiter GetAwaiter(this InstanceHandle self)
	{
		return UniTask.WaitUntil(() => self.IsDone).GetAwaiter();
	}

	public static UniTask.Awaiter GetAwaiter(this PrecacheHandle self)
	{
		return UniTask.WaitUntil(() => self.IsDone).GetAwaiter();
	}
}
