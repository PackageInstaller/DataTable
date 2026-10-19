using System.Collections.Generic;
using UnityEngine.SceneManagement;

namespace YooAsset;

internal class ResourceManager
{
	internal readonly Dictionary<string, ProviderOperation> ProviderDic = new Dictionary<string, ProviderOperation>(5000);

	internal readonly Dictionary<string, LoadBundleFileOperation> LoaderDic = new Dictionary<string, LoadBundleFileOperation>(5000);

	internal readonly List<SceneHandle> SceneHandles = new List<SceneHandle>(100);

	private long _sceneCreateIndex;

	private IBundleQuery _bundleQuery;

	private int _bundleLoadingMaxConcurrency;

	public readonly string PackageName;

	public bool LockLoadOperation;

	public int BundleLoadingCounter;

	public ResourceManager(string packageName)
	{
		PackageName = packageName;
	}

	public void Initialize(InitializeParameters parameters, IBundleQuery bundleServices)
	{
		_bundleLoadingMaxConcurrency = parameters.BundleLoadingMaxConcurrency;
		_bundleQuery = bundleServices;
		SceneManager.sceneUnloaded += OnSceneUnloaded;
	}

	public void Destroy()
	{
		SceneManager.sceneUnloaded -= OnSceneUnloaded;
	}

	public void TryUnloadUnusedAsset(AssetInfo assetInfo)
	{
		if (assetInfo.IsInvalid)
		{
			YooLogger.Error("Failed to unload asset ! " + assetInfo.Error);
			return;
		}
		string mainBundleName = _bundleQuery.GetMainBundleName(assetInfo);
		LoadBundleFileOperation loadBundleFileOperation = TryGetBundleFileLoader(mainBundleName);
		if (loadBundleFileOperation != null)
		{
			loadBundleFileOperation.TryDestroyProviders();
			if (loadBundleFileOperation.CanDestroyLoader())
			{
				string bundleName = loadBundleFileOperation.LoadBundleInfo.Bundle.BundleName;
				loadBundleFileOperation.DestroyLoader();
				LoaderDic.Remove(bundleName);
			}
		}
		string[] dependBundleNames = _bundleQuery.GetDependBundleNames(assetInfo);
		foreach (string bundleName2 in dependBundleNames)
		{
			LoadBundleFileOperation loadBundleFileOperation2 = TryGetBundleFileLoader(bundleName2);
			if (loadBundleFileOperation2 != null && loadBundleFileOperation2.CanDestroyLoader())
			{
				string bundleName3 = loadBundleFileOperation2.LoadBundleInfo.Bundle.BundleName;
				loadBundleFileOperation2.DestroyLoader();
				LoaderDic.Remove(bundleName3);
			}
		}
	}

	public SceneHandle LoadSceneAsync(AssetInfo assetInfo, LoadSceneParameters loadSceneParams, bool suspendLoad, uint priority)
	{
		if (LockLoadOperation)
		{
			string text = "The load operation locked !";
			YooLogger.Error(text);
			CompletedProvider completedProvider = new CompletedProvider(this, assetInfo);
			completedProvider.SetCompletedWithError(text);
			return completedProvider.CreateHandle<SceneHandle>();
		}
		if (assetInfo.IsInvalid)
		{
			YooLogger.Error("Failed to load scene ! " + assetInfo.Error);
			CompletedProvider completedProvider2 = new CompletedProvider(this, assetInfo);
			completedProvider2.SetCompletedWithError(assetInfo.Error);
			return completedProvider2.CreateHandle<SceneHandle>();
		}
		string text2 = $"{assetInfo.GUID}-{++_sceneCreateIndex}";
		ProviderOperation providerOperation = new SceneProvider(this, text2, assetInfo, loadSceneParams, suspendLoad);
		ProviderDic.Add(text2, providerOperation);
		OperationSystem.StartOperation(PackageName, providerOperation);
		providerOperation.Priority = priority;
		SceneHandle sceneHandle = providerOperation.CreateHandle<SceneHandle>();
		sceneHandle.PackageName = PackageName;
		SceneHandles.Add(sceneHandle);
		return sceneHandle;
	}

	public AssetHandle LoadAssetAsync(AssetInfo assetInfo, uint priority)
	{
		if (LockLoadOperation)
		{
			string text = "The load operation locked !";
			YooLogger.Error(text);
			CompletedProvider completedProvider = new CompletedProvider(this, assetInfo);
			completedProvider.SetCompletedWithError(text);
			return completedProvider.CreateHandle<AssetHandle>();
		}
		if (assetInfo.IsInvalid)
		{
			YooLogger.Error("Failed to load asset ! " + assetInfo.Error);
			CompletedProvider completedProvider2 = new CompletedProvider(this, assetInfo);
			completedProvider2.SetCompletedWithError(assetInfo.Error);
			return completedProvider2.CreateHandle<AssetHandle>();
		}
		string text2 = "LoadAssetAsync" + assetInfo.GUID;
		ProviderOperation providerOperation = TryGetAssetProvider(text2);
		if (providerOperation == null)
		{
			providerOperation = new AssetProvider(this, text2, assetInfo);
			ProviderDic.Add(text2, providerOperation);
			OperationSystem.StartOperation(PackageName, providerOperation);
		}
		providerOperation.Priority = priority;
		return providerOperation.CreateHandle<AssetHandle>();
	}

	public SubAssetsHandle LoadSubAssetsAsync(AssetInfo assetInfo, uint priority)
	{
		if (LockLoadOperation)
		{
			string text = "The load operation locked !";
			YooLogger.Error(text);
			CompletedProvider completedProvider = new CompletedProvider(this, assetInfo);
			completedProvider.SetCompletedWithError(text);
			return completedProvider.CreateHandle<SubAssetsHandle>();
		}
		if (assetInfo.IsInvalid)
		{
			YooLogger.Error("Failed to load sub assets ! " + assetInfo.Error);
			CompletedProvider completedProvider2 = new CompletedProvider(this, assetInfo);
			completedProvider2.SetCompletedWithError(assetInfo.Error);
			return completedProvider2.CreateHandle<SubAssetsHandle>();
		}
		string text2 = "LoadSubAssetsAsync" + assetInfo.GUID;
		ProviderOperation providerOperation = TryGetAssetProvider(text2);
		if (providerOperation == null)
		{
			providerOperation = new SubAssetsProvider(this, text2, assetInfo);
			ProviderDic.Add(text2, providerOperation);
			OperationSystem.StartOperation(PackageName, providerOperation);
		}
		providerOperation.Priority = priority;
		return providerOperation.CreateHandle<SubAssetsHandle>();
	}

	public AllAssetsHandle LoadAllAssetsAsync(AssetInfo assetInfo, uint priority)
	{
		if (LockLoadOperation)
		{
			string text = "The load operation locked !";
			YooLogger.Error(text);
			CompletedProvider completedProvider = new CompletedProvider(this, assetInfo);
			completedProvider.SetCompletedWithError(text);
			return completedProvider.CreateHandle<AllAssetsHandle>();
		}
		if (assetInfo.IsInvalid)
		{
			YooLogger.Error("Failed to load all assets ! " + assetInfo.Error);
			CompletedProvider completedProvider2 = new CompletedProvider(this, assetInfo);
			completedProvider2.SetCompletedWithError(assetInfo.Error);
			return completedProvider2.CreateHandle<AllAssetsHandle>();
		}
		string text2 = "LoadAllAssetsAsync" + assetInfo.GUID;
		ProviderOperation providerOperation = TryGetAssetProvider(text2);
		if (providerOperation == null)
		{
			providerOperation = new AllAssetsProvider(this, text2, assetInfo);
			ProviderDic.Add(text2, providerOperation);
			OperationSystem.StartOperation(PackageName, providerOperation);
		}
		providerOperation.Priority = priority;
		return providerOperation.CreateHandle<AllAssetsHandle>();
	}

	public RawFileHandle LoadRawFileAsync(AssetInfo assetInfo, uint priority)
	{
		if (LockLoadOperation)
		{
			string text = "The load operation locked !";
			YooLogger.Error(text);
			CompletedProvider completedProvider = new CompletedProvider(this, assetInfo);
			completedProvider.SetCompletedWithError(text);
			return completedProvider.CreateHandle<RawFileHandle>();
		}
		if (assetInfo.IsInvalid)
		{
			YooLogger.Error("Failed to load raw file ! " + assetInfo.Error);
			CompletedProvider completedProvider2 = new CompletedProvider(this, assetInfo);
			completedProvider2.SetCompletedWithError(assetInfo.Error);
			return completedProvider2.CreateHandle<RawFileHandle>();
		}
		string text2 = "LoadRawFileAsync" + assetInfo.GUID;
		ProviderOperation providerOperation = TryGetAssetProvider(text2);
		if (providerOperation == null)
		{
			providerOperation = new RawFileProvider(this, text2, assetInfo);
			ProviderDic.Add(text2, providerOperation);
			OperationSystem.StartOperation(PackageName, providerOperation);
		}
		providerOperation.Priority = priority;
		return providerOperation.CreateHandle<RawFileHandle>();
	}

	internal LoadBundleFileOperation CreateMainBundleFileLoader(AssetInfo assetInfo)
	{
		BundleInfo mainBundleInfo = _bundleQuery.GetMainBundleInfo(assetInfo);
		return CreateBundleFileLoaderInternal(mainBundleInfo);
	}

	internal List<LoadBundleFileOperation> CreateDependBundleFileLoaders(AssetInfo assetInfo)
	{
		BundleInfo[] dependBundleInfos = _bundleQuery.GetDependBundleInfos(assetInfo);
		List<LoadBundleFileOperation> list = new List<LoadBundleFileOperation>(dependBundleInfos.Length);
		BundleInfo[] array = dependBundleInfos;
		foreach (BundleInfo bundleInfo in array)
		{
			LoadBundleFileOperation item = CreateBundleFileLoaderInternal(bundleInfo);
			list.Add(item);
		}
		return list;
	}

	internal void RemoveBundleProviders(List<ProviderOperation> removeList)
	{
		foreach (ProviderOperation remove in removeList)
		{
			ProviderDic.Remove(remove.ProviderGUID);
		}
	}

	internal bool CheckBundleDestroyed(int bundleID)
	{
		string mainBundleName = _bundleQuery.GetMainBundleName(bundleID);
		return TryGetBundleFileLoader(mainBundleName)?.IsDestroyed ?? true;
	}

	internal bool HasAnyLoader()
	{
		return LoaderDic.Count > 0;
	}

	internal bool BundleLoadingIsBusy()
	{
		return BundleLoadingCounter >= _bundleLoadingMaxConcurrency;
	}

	private LoadBundleFileOperation CreateBundleFileLoaderInternal(BundleInfo bundleInfo)
	{
		string bundleName = bundleInfo.Bundle.BundleName;
		LoadBundleFileOperation loadBundleFileOperation = TryGetBundleFileLoader(bundleName);
		if (loadBundleFileOperation != null)
		{
			return loadBundleFileOperation;
		}
		loadBundleFileOperation = new LoadBundleFileOperation(this, bundleInfo);
		LoaderDic.Add(bundleName, loadBundleFileOperation);
		return loadBundleFileOperation;
	}

	private LoadBundleFileOperation TryGetBundleFileLoader(string bundleName)
	{
		if (LoaderDic.TryGetValue(bundleName, out var value))
		{
			return value;
		}
		return null;
	}

	private ProviderOperation TryGetAssetProvider(string providerGUID)
	{
		if (ProviderDic.TryGetValue(providerGUID, out var value))
		{
			return value;
		}
		return null;
	}

	private void OnSceneUnloaded(Scene scene)
	{
		List<SceneHandle> list = new List<SceneHandle>();
		foreach (SceneHandle sceneHandle in SceneHandles)
		{
			if (sceneHandle.IsValid && sceneHandle.SceneObject == scene)
			{
				sceneHandle.Release();
				list.Add(sceneHandle);
			}
		}
		foreach (SceneHandle item in list)
		{
			SceneHandles.Remove(item);
		}
	}

	internal List<DebugProviderInfo> GetDebugProviderInfos()
	{
		List<DebugProviderInfo> list = new List<DebugProviderInfo>(ProviderDic.Count);
		foreach (ProviderOperation value in ProviderDic.Values)
		{
			list.Add(new DebugProviderInfo
			{
				AssetPath = value.MainAssetInfo.AssetPath,
				SpawnScene = value.SpawnScene,
				BeginTime = value.BeginTime,
				LoadingTime = value.ProcessTime,
				RefCount = value.RefCount,
				Status = value.Status.ToString(),
				DependBundles = value.GetDebugDependBundles()
			});
		}
		return list;
	}

	internal List<DebugBundleInfo> GetDebugBundleInfos()
	{
		List<DebugBundleInfo> list = new List<DebugBundleInfo>(LoaderDic.Values.Count);
		foreach (LoadBundleFileOperation value in LoaderDic.Values)
		{
			PackageBundle bundle = value.LoadBundleInfo.Bundle;
			list.Add(new DebugBundleInfo
			{
				BundleName = bundle.BundleName,
				RefCount = value.RefCount,
				Status = value.Status.ToString(),
				ReferenceBundles = FilterReferenceBundles(bundle)
			});
		}
		return list;
	}

	internal List<string> FilterReferenceBundles(PackageBundle packageBundle)
	{
		List<string> debugReferenceBundles = packageBundle.GetDebugReferenceBundles();
		List<string> list = new List<string>(debugReferenceBundles.Count);
		foreach (string item in debugReferenceBundles)
		{
			if (LoaderDic.ContainsKey(item))
			{
				list.Add(item);
			}
		}
		return list;
	}
}
