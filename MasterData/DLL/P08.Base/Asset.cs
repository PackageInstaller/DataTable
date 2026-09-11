using UnityEngine;
using UnityEngine.Events;
using UnityEngine.SceneManagement;

public static class Asset
{
	private static bool ready;

	public static AssetObjectPool pool;

	public static bool GetReady()
	{
		return ready;
	}

	public static void Initialize()
	{
		if (!ready)
		{
			if (pool == null)
			{
				pool = new AssetObjectPool();
			}
			AssetManager.Create();
			ready = true;
			NaiveAngleConfigManager.Initialize();
			I18NConfigManager.Initialize();
		}
	}

	public static void Initialize(AssetHashManifest hashManifest)
	{
		if (!ready)
		{
			if (pool == null)
			{
				pool = new AssetObjectPool();
			}
			AssetManager.Create(hashManifest);
			ready = true;
			NaiveAngleConfigManager.Initialize();
			I18NConfigManager.Initialize();
		}
	}

	public static void ClearPool()
	{
		if (pool != null)
		{
			pool.Destroy();
		}
	}

	public static void Destroy()
	{
		ready = false;
		pool.Destroy();
		AssetManager.Destroy();
	}

	public static DownloadRequest StartDownload(string url)
	{
		return DownloadManager.Instance.StartDownload(url);
	}

	public static DownloadRequest StartDownloadWitchCache(string url, string localCachePath, UnityAction<DownloadRequest> callback = null, bool forceDownload = false)
	{
		return DownloadManager.Instance.StartDownloadWithCache(url, localCachePath, callback, 0, forceDownload);
	}

	public static DownloadRequest StartDownload(string url, object userData)
	{
		return DownloadManager.Instance.StartDownload(url, userData);
	}

	public static bool IsDownloading(string url)
	{
		return false;
	}

	public static DownloadRequest GetWWW(string url)
	{
		return DownloadManager.Instance.GetWWW(url);
	}

	public static string GetDownloadError(string url)
	{
		return DownloadManager.Instance.GetError(url);
	}

	public static void StopDownload(string url)
	{
		DownloadManager.Instance.StopDownload(url);
	}

	public static void StopAllDownload()
	{
		DownloadManager.Instance.StopAll();
	}

	public static void Cache(string path, int size = 1, bool dontDestroy = false)
	{
		pool.Cache(path, size, dontDestroy);
	}

	public static void Cache(GameObject prefab, int size = 1, bool dontDestroy = false)
	{
		if (!(prefab == null))
		{
			pool.Cache(prefab, size, dontDestroy);
		}
	}

	public static void Cache(string path, GameObject prefab, int size = 1, bool dontDestroy = false)
	{
		if (!(prefab == null))
		{
			pool.Cache(path, prefab, size, dontDestroy);
		}
	}

	public static T Instantiate<T>(string path, bool dontDestroy = false) where T : Component
	{
		GameObject orCreate = pool.GetOrCreate(path, active: true, dontDestroy);
		if (dontDestroy)
		{
			Object.DontDestroyOnLoad(orCreate);
		}
		return orCreate.GetComponent<T>();
	}

	public static GameObject Instantiate(string path, bool dontDestroy = false)
	{
		path = RemapVariantPath(path);
		GameObject orCreate = pool.GetOrCreate(path, active: true, dontDestroy);
		if (dontDestroy)
		{
			Object.DontDestroyOnLoad(orCreate);
		}
		return orCreate;
	}

	public static GameObject InstantiateAutoUnloadWhileDestroy(string path, bool dontDestroy = false)
	{
		path = RemapVariantPath(path);
		GameObject orCreate = pool.GetOrCreate(path, active: true, dontDestroy);
		if (dontDestroy)
		{
			Object.DontDestroyOnLoad(orCreate);
		}
		if (orCreate != null)
		{
			pool.SetAssetPath(path, dontDestroy);
		}
		return orCreate;
	}

	public static GameObject InstantiateWithoutCache(string path, bool dontDestroy = false)
	{
		path = RemapVariantPath(path);
		GameObject gameObject = Load<GameObject>(path, dontDestroy);
		if (gameObject == null)
		{
			return null;
		}
		GameObject gameObject2 = Object.Instantiate(gameObject);
		if (dontDestroy)
		{
			Object.DontDestroyOnLoad(gameObject2);
		}
		gameObject2.SetActive(value: true);
		return gameObject2;
	}

	public static GameObject Instantiate(GameObject prefab, bool dontDestroy = false)
	{
		if (prefab == null)
		{
			return null;
		}
		GameObject orCreate = pool.GetOrCreate(prefab, active: true);
		if (dontDestroy)
		{
			Object.DontDestroyOnLoad(orCreate);
		}
		return orCreate;
	}

	public static GameObject InstantiateWithoutCache(string path, Transform parent, bool worldPositionStays = false, bool dontDestroy = false)
	{
		path = RemapVariantPath(path);
		GameObject gameObject = Load<GameObject>(path, dontDestroy);
		if (gameObject == null)
		{
			return null;
		}
		GameObject gameObject2 = Object.Instantiate(gameObject, parent, worldPositionStays);
		gameObject2.name = gameObject2.name.Replace("(Clone)", string.Empty);
		if (dontDestroy)
		{
			Object.DontDestroyOnLoad(gameObject2);
		}
		return gameObject2;
	}

	public static void MoveToDontDestroyCache(string path)
	{
		pool.MoveToDontDestroyCache(path);
	}

	public static T[] LoadAllFromBundle<T>(string bundleName, bool isDontDestroy = false) where T : Object
	{
		if (string.IsNullOrEmpty(bundleName))
		{
			return null;
		}
		Initialize();
		T[] assets = null;
		AssetManager.LoadAll(bundleName, ref assets);
		if (isDontDestroy)
		{
			AssetManager.TagDontDestroyAssetbundle(bundleName, isLoad: true);
		}
		return assets;
	}

	public static AssetBundleLoadAssetsOperationFull<T> LoadAllFromBundleAsync<T>(string bundleName, OnVoidHandler<T[]> callback = null) where T : Object
	{
		if (string.IsNullOrEmpty(bundleName))
		{
			return null;
		}
		Initialize();
		return AssetManager.LoadAllAsync(bundleName, callback);
	}

	public static AssetBundleSyncLoadAssetsOperationFull<T> LoadAllFromBundleSync<T>(string bundleName, OnVoidHandler<T[]> callback = null) where T : Object
	{
		if (string.IsNullOrEmpty(bundleName))
		{
			return null;
		}
		Initialize();
		return AssetManager.LoadAllSync(bundleName, callback);
	}

	public static Object Load(string path, bool isDontDestroy = false)
	{
		if (string.IsNullOrEmpty(path))
		{
			Debug.LogError("============ load path is null =============");
		}
		path = RemapVariantPath(path);
		Initialize();
		Object result = AssetManager.Load<Object>(path);
		if (isDontDestroy)
		{
			AssetManager.TagDontDestroyAssetbundle(path, isLoad: true, isManifest: false);
		}
		return result;
	}

	public static T Load<T>(string path, bool isDontDestroy = false) where T : Object
	{
		if (string.IsNullOrEmpty(path))
		{
			Debug.LogError("============ load path is null =============");
		}
		path = RemapVariantPath(path);
		Initialize();
		T result = AssetManager.Load<T>(path);
		if (isDontDestroy)
		{
			AssetManager.TagDontDestroyAssetbundle(path, isLoad: true, isManifest: false);
		}
		return result;
	}

	public static void Unload(string path, bool isDontDestroy = false)
	{
		path = RemapVariantPath(path);
		if (isDontDestroy)
		{
			AssetManager.TagDontDestroyAssetbundle(path, isLoad: false, isManifest: false);
		}
		string assetName = string.Empty;
		string assetBundleName = string.Empty;
		if (AssetManager.TryGetAssetNameAndBundleName(path, out assetName, out assetBundleName))
		{
			LoadedAssetBundle loadedAssetBundle = AssetManager.GetLoadedAssetBundle(assetBundleName, out var _);
			AssetManager.UnloadAssetBundle(assetBundleName);
			if (loadedAssetBundle != null && loadedAssetBundle.IsUnusedBundle() && loadedAssetBundle.m_AssetBundle == null)
			{
				pool.RemovePrefabCache(path);
			}
		}
	}

	public static bool UnloadWithReturn(string path, bool isDontDestroy = false)
	{
		path = RemapVariantPath(path);
		if (isDontDestroy)
		{
			AssetManager.TagDontDestroyAssetbundle(path, isLoad: false, isManifest: false);
		}
		string assetName = string.Empty;
		string assetBundleName = string.Empty;
		if (!AssetManager.TryGetAssetNameAndBundleName(path, out assetName, out assetBundleName))
		{
			return true;
		}
		LoadedAssetBundle loadedAssetBundle = AssetManager.GetLoadedAssetBundle(assetBundleName, out var _);
		AssetManager.UnloadAssetBundle(assetBundleName);
		if (loadedAssetBundle != null && loadedAssetBundle.IsUnusedBundle() && loadedAssetBundle.m_AssetBundle == null)
		{
			pool.RemovePrefabCache(path);
		}
		return loadedAssetBundle?.IsUnusedBundle() ?? true;
	}

	public static void UnloadBundle(string bundleName, bool isDontDestroy = false)
	{
		if (isDontDestroy)
		{
			AssetManager.TagDontDestroyAssetbundle(bundleName, isLoad: false);
		}
		AssetManager.UnloadAssetBundle(bundleName);
	}

	public static void UnloadAllAssetBundles()
	{
		AssetManager.UnloadAllAssetBundles();
		ClearPool();
		Resources.UnloadUnusedAssets();
	}

	public static void StopAsyncLoading()
	{
		AssetManager.StopAllAsyncLoading();
	}

	public static AssetBundleLoadAssetOperation<T> LoadAssetAsync<T>(string path, OnVoidHandler<T> callback = null) where T : Object
	{
		path = RemapVariantPath(path);
		return AssetManager.LoadAssetAsync(path, callback);
	}

	public static AssetBundleSyncLoadAssetOperationFull<T> LoadAssetSync<T>(string path, OnVoidHandler<T> callback = null) where T : Object
	{
		path = RemapVariantPath(path);
		return AssetManager.LoadAssetSync(path, callback);
	}

	public static void LoadAsync(string path, OnVoidHandler<Object> callback = null)
	{
		LoadAssetAsync(path, callback);
	}

	public static AssetBundleLoadOperation LoadLevelAsync(string path, LoadSceneMode mode, bool allowSceneActivation = true)
	{
		return AssetManager.LoadLevelAsync(path, mode, allowSceneActivation);
	}

	public static AssetBundleLoadOperation LoadLevelAsync(string path, bool isAddtive, bool allowSceneActivation = true)
	{
		return AssetManager.LoadLevelAsync(path, isAddtive ? LoadSceneMode.Additive : LoadSceneMode.Single, allowSceneActivation);
	}

	public static void LoadLevelSync(string path, bool isAddtive)
	{
		AssetManager.LoadLevelSync(path, isAddtive);
	}

	public static void UnloadLevelSync(string path)
	{
	}

	public static void DontDestroyBundle(string bundleName, bool isDontDestroy)
	{
		AssetManager.TagDontDestroyAssetbundle(bundleName, isDontDestroy);
	}

	public static void DontDestroyAssetbundle(string path, bool isDontDestroy)
	{
		AssetManager.TagDontDestroyAssetbundle(path, isDontDestroy, isManifest: false);
	}

	public static string RemapVariantPath(string path)
	{
		path = NaiveAngleConfigManager.GetNiveModePathOrName(path);
		path = I18NConfigManager.GetI18NPathOrName(path);
		return path;
	}
}
