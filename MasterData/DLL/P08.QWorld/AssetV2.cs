using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public static class AssetV2
{
	private static bool ready;

	public static void Initialize()
	{
		if (!ready)
		{
			ready = true;
			new List<int[]>();
			StreamingLoader.Create();
		}
	}

	public static T[] LoadAll<T>(string bundleName) where T : UnityEngine.Object
	{
		Initialize();
		return StreamingLoader.Instance.LoadAllAssetsAsync<T>(bundleName, null).Block();
	}

	public static void UnloadAll(string bundleName)
	{
		Initialize();
		StreamingLoader.Instance.UnloadAllAssetsAsync(bundleName);
	}

	public static T Load<T>(string path) where T : UnityEngine.Object
	{
		Initialize();
		return LoadAsync<T>(path).Block();
	}

	public static AsyncAsset<T> LoadAsync<T>(string path, Action<UnityEngine.Object> callback = null) where T : UnityEngine.Object
	{
		Initialize();
		return StreamingLoader.Instance.LoadAsync(path, (Action<T>)callback);
	}

	public static void UnloadAsync(string path)
	{
		Initialize();
		if (StreamingLoader.Instance.TryGetAssetNameAndBundleName(path, out var assetName, out var _))
		{
			StreamingLoader.Instance.UnloadAsync(assetName);
		}
	}

	public static AsyncScene LoadLevelAsync(string path, LoadSceneMode mode, bool allowSceneActivation)
	{
		Initialize();
		return StreamingLoader.Instance.LoadSceneAsync(path, mode, allowSceneActivation);
	}

	public static void UnloadLevelSync(string path)
	{
		Initialize();
		StreamingLoader.Instance.UnloadSceneAsync(path);
	}

	public static void InstantiateAsync(string path, Transform parent, Action<GameObject> callback, bool isAsync = true)
	{
		Initialize();
		StreamingLoader.Instance.InstantiateAsync(path, parent, isAsync, delegate(GameObject go)
		{
			go.name = go.name.Replace("(Clone)", string.Empty);
			if (callback != null)
			{
				callback(go);
			}
		});
	}

	public static GameObject Instantiate(string path, Transform parent = null)
	{
		Initialize();
		AsyncAsset<GameObject> asyncAsset = LoadAsync<GameObject>(path);
		asyncAsset.Block();
		return asyncAsset.Instantiate(parent).gameObject;
	}

	public static void Cache(string path, int count, Transform parent = null)
	{
		Initialize();
		for (int i = 0; i < count; i++)
		{
			AsyncAsset<GameObject> asyncAsset = LoadAsync<GameObject>(path);
			asyncAsset.Block();
			asyncAsset.Cache(parent);
		}
	}

	public static void Return(string path, GameObject go)
	{
		if (StreamingLoader.Instance.TryGetAssetNameAndBundleName(path, out var assetName, out var _))
		{
			if (StreamingLoader.Instance.TryGetAsset(assetName, out AsyncAsset<GameObject> asset))
			{
				asset.ReturnPool(go);
			}
			else
			{
				Debug.LogError(path + " cant not find asset!!");
			}
		}
		else
		{
			Debug.LogError(path + " cant not find bundleName!!");
		}
	}
}
