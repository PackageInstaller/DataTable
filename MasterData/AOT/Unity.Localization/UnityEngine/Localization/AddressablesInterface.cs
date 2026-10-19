using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine.ResourceManagement;
using UnityEngine.ResourceManagement.AsyncOperations;
using UnityEngine.ResourceManagement.Util;
using YooAsset;

namespace UnityEngine.Localization;

internal class AddressablesInterface
{
	private static AddressablesInterface s_Instance;

	private static ResourcePackage s_LocalizationPackage;

	public static readonly ResourceManager ResourceManager = new ResourceManager(new LRUCacheAllocationStrategy(1000, 1000, 100, 10));

	public static AddressablesInterface Instance
	{
		get
		{
			if (s_Instance == null)
			{
				s_Instance = new AddressablesInterface();
			}
			return s_Instance;
		}
		set
		{
			s_Instance = value;
		}
	}

	internal static ResourcePackage GetLocalizationPackage()
	{
		if (s_LocalizationPackage == null)
		{
			s_LocalizationPackage = YooAssets.GetPackage("ClientStatic");
		}
		return s_LocalizationPackage;
	}

	public static void Acquire(AsyncOperationHandle handle)
	{
		Instance.AcquireInternal(handle);
	}

	public static void Release(AsyncOperationHandle handle)
	{
		Instance.ReleaseInternal(handle);
	}

	public static void SafeRelease(AsyncOperationHandle handle)
	{
		if (handle.IsValid())
		{
			Instance.ReleaseInternal(handle);
		}
	}

	public static IList<AssetInfo> LoadResourceLocationsWithLabelsAsync(IEnumerable<string> labels, Type type = null)
	{
		return Instance.LoadResourceLocationsWithLabelsAsyncInternal(labels, type);
	}

	public static AssetInfo LoadTableLocationsAsync(string tableName, LocaleIdentifier id, Type type)
	{
		return Instance.LoadTableLocationsAsyncInternal(tableName, id, type);
	}

	public static AsyncOperationHandle<IList<TObject>> LoadAssetsFromLocations<TObject>(IList<AssetInfo> locations, Action<TObject> callback) where TObject : Object
	{
		return Instance.LoadAssetsFromLocationsInternal(locations, callback);
	}

	public static AsyncOperationHandle<TObject> LoadAssetFromGUID<TObject>(string guid) where TObject : class
	{
		return Instance.LoadAssetFromGUIDInternal<TObject>(guid);
	}

	public static AsyncOperationHandle<TObject> LoadAssetFromName<TObject>(string name) where TObject : Object
	{
		return Instance.LoadAssetFromNameInternal<TObject>(name);
	}

	public static AsyncOperationHandle<TObject> LoadTableFromLocation<TObject>(AssetInfo location) where TObject : Object
	{
		return Instance.LoadTableFromLocationInternal<TObject>(location);
	}

	public static AsyncOperationHandle<IList<TObject>> LoadAssetsWithLabel<TObject>(string label, Action<TObject> callback) where TObject : Object
	{
		return Instance.LoadAssetsWithLabelInternal(label, callback);
	}

	internal virtual void AcquireInternal(AsyncOperationHandle handle)
	{
		ResourceManager.Acquire(handle);
	}

	internal virtual void ReleaseInternal(AsyncOperationHandle handle)
	{
		handle.Release();
	}

	internal virtual IList<AssetInfo> LoadResourceLocationsWithLabelsAsyncInternal(IEnumerable<string> labels, Type type = null)
	{
		List<AssetInfo> list = new List<AssetInfo>();
		AssetInfo[] assetInfosByAllTags = GetLocalizationPackage().GetAssetInfosByAllTags(labels.ToArray());
		list.AddRange(assetInfosByAllTags);
		return list;
	}

	internal virtual AssetInfo LoadTableLocationsAsyncInternal(string tableName, LocaleIdentifier id, Type type)
	{
		string tableAddress = AddressHelper.GetTableAddress(tableName, id);
		return GetLocalizationPackage().GetAssetInfo(tableAddress);
	}

	internal virtual AsyncOperationHandle<IList<TObject>> LoadAssetsFromLocationsInternal<TObject>(IList<AssetInfo> locations, Action<TObject> callback) where TObject : Object
	{
		List<AssetHandle> list = new List<AssetHandle>();
		ResourcePackage localizationPackage = GetLocalizationPackage();
		foreach (AssetInfo location in locations)
		{
			AssetHandle assetHandle = localizationPackage.LoadAssetAsync(location);
			list.Add(assetHandle);
			assetHandle.Completed += (AssetHandle o) =>
			{
				callback?.Invoke((TObject)o.AssetObject);
			};
		}
		return list.ToAsyncOperationHandle<TObject>();
	}

	internal virtual AsyncOperationHandle<TObject> LoadAssetFromGUIDInternal<TObject>(string guid) where TObject : class
	{
		ResourcePackage localizationPackage = GetLocalizationPackage();
		AssetInfo assetInfoByGUID = localizationPackage.GetAssetInfoByGUID(guid);
		return localizationPackage.LoadAssetAsync(assetInfoByGUID).ToAsyncOperationHandle<TObject>();
	}

	internal virtual AsyncOperationHandle<TObject> LoadAssetFromNameInternal<TObject>(string name) where TObject : Object
	{
		return GetLocalizationPackage().LoadAssetAsync<TObject>(name).ToAsyncOperationHandle<TObject>();
	}

	internal virtual AsyncOperationHandle<TObject> LoadTableFromLocationInternal<TObject>(AssetInfo location) where TObject : Object
	{
		return GetLocalizationPackage().LoadAssetAsync(location).ToAsyncOperationHandle<TObject>();
	}

	internal virtual AsyncOperationHandle<IList<TObject>> LoadAssetsWithLabelInternal<TObject>(string label, Action<TObject> callback) where TObject : Object
	{
		ResourcePackage localizationPackage = GetLocalizationPackage();
		AssetInfo[] assetInfos = localizationPackage.GetAssetInfos(label);
		if (assetInfos == null || assetInfos.Length == 0)
		{
			return default;
		}
		List<AssetHandle> list = new List<AssetHandle>();
		for (int i = 0; i < assetInfos.Length; i++)
		{
			AssetHandle assetHandle = localizationPackage.LoadAssetAsync(assetInfos[i]);
			assetHandle.Completed += (AssetHandle o) =>
			{
				callback?.Invoke((TObject)o.AssetObject);
			};
			list.Add(assetHandle);
		}
		return list.ToAsyncOperationHandle<TObject>();
	}
}
