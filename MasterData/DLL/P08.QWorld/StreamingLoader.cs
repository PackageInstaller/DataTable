using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class StreamingLoader : MonoBehaviour
{
	private AssetBundleManifest m_manifest;

	internal Dictionary<string, IAsyncAsset> m_assets = new Dictionary<string, IAsyncAsset>();

	internal Dictionary<string, AsyncScene> m_scenes = new Dictionary<string, AsyncScene>();

	private List<AsyncAsset<GameObject>> m_runningInstances = new List<AsyncAsset<GameObject>>();

	private AssetNameList m_AssetNames;

	public static StreamingLoader Instance;

	public static bool m_ABMode;

	public float m_ClearTick = 1f;

	private float _curTick;

	private List<AsyncAsset<GameObject>.AsyncResult> m_pendingInstances = new List<AsyncAsset<GameObject>.AsyncResult>();

	public bool IsReady()
	{
		return m_AssetNames != null;
	}

	public AssetNameList GetAssetNames()
	{
		return m_AssetNames;
	}

	public static void Create()
	{
		GameObject obj = new GameObject("streamingloader");
		UnityEngine.Object.DontDestroyOnLoad(obj);
		obj.AddComponent<StreamingLoader>();
	}

	public void Awake()
	{
		Instance = this;
		string platformName = Platform.GetPlatformName();
		Debug.Log("current platformName: " + platformName + " ABMode: " + m_ABMode);
		if (m_ABMode)
		{
			Instance.LoadAsync<AssetBundleManifest>("AssetBundleManifest", platformName, OnReadyAssetBundleManifestHandler);
		}
		else
		{
			LoadAsync<TextAsset>("Assets/ABResources/AssetUrl.txt", "asseturl.ys", OnReadyHandler);
		}
	}

	private void OnReadyAssetBundleManifestHandler(AssetBundleManifest asset)
	{
		m_manifest = asset;
		if (m_manifest == null)
		{
			Debug.Log("Init AssetBundleManifest failed!!!");
			return;
		}
		Debug.Log("Init AssetBundleManifest success!!!");
		LoadAsync<TextAsset>("Assets/ABResources/AssetUrl.txt", "asseturl.ys", OnReadyHandler);
	}

	private void OnReadyHandler(TextAsset asset)
	{
		m_AssetNames = Platform.GetMPFile<AssetNameList>(asset.bytes);
		if (m_AssetNames == null)
		{
			Debug.Log("Init asseturl failed!!!");
		}
		else
		{
			Debug.Log("Init asseturl success!!! count: " + m_AssetNames.assetNames.Count);
		}
	}

	public bool TryGetAssetNameAndBundleName(string path, out string assetName, out string assetBundleName)
	{
		assetName = string.Empty;
		assetBundleName = string.Empty;
		if (path.Contains("."))
		{
			path = path.Split('.')[0];
		}
		if (m_AssetNames != null && m_AssetNames.assetNames.TryGetValue(path, out var value))
		{
			assetName = value.assetName;
			assetBundleName = value.bundleName;
			return true;
		}
		return false;
	}

	public bool TryGetAsset<T>(string assetName, out AsyncAsset<T> asset) where T : UnityEngine.Object
	{
		bool num = m_assets.TryGetValue(assetName, out var value);
		asset = value as AsyncAsset<T>;
		if (num)
		{
			return asset != null;
		}
		return false;
	}

	public void Update()
	{
		if (!IsReady())
		{
			return;
		}
		if (_curTick <= 0f)
		{
			_curTick = m_ClearTick;
			TryAutoClear();
		}
		else
		{
			_curTick -= Time.deltaTime;
		}
		for (int num = m_pendingInstances.Count - 1; num >= 0; num--)
		{
			AsyncAsset<GameObject>.AsyncResult asyncResult = m_pendingInstances[num];
			if (asyncResult.op.isDone)
			{
				GameObject[] result = asyncResult.op.Result;
				foreach (GameObject obj in result)
				{
					m_runningInstances.Add(asyncResult.asset);
					if (asyncResult.callback != null)
					{
						asyncResult.callback(obj);
					}
				}
				m_pendingInstances.RemoveAt(num);
			}
		}
	}

	private void TryAutoClear()
	{
		for (int num = m_runningInstances.Count - 1; num >= 0; num--)
		{
			if (m_runningInstances[num].TryUnloadInstance())
			{
				UnloadAsync(m_runningInstances[num].GetAssetName());
				m_runningInstances.RemoveAt(num);
			}
		}
	}

	public void DebugInfo()
	{
	}

	public void OnDestroy()
	{
		m_assets.Clear();
		m_scenes.Clear();
		m_assets = null;
		m_scenes = null;
		Instance = null;
	}

	public GameObject InstantiateAsync(string loadName, Transform parent, bool isAsync, Action<GameObject> callback)
	{
		if (TryGetAssetNameAndBundleName(loadName, out var assetName, out var assetBundleName))
		{
			LoadAsync<GameObject>(assetName, assetBundleName, delegate
			{
				if (m_assets.TryGetValue(assetName, out var value))
				{
					AsyncAsset<GameObject> asyncAsset = value as AsyncAsset<GameObject>;
					AsyncAsset<GameObject>.AsyncResult item = (isAsync ? asyncAsset.InstantiateAsync(parent) : asyncAsset.Instantiate(parent));
					if (item.gameObject != null)
					{
						m_runningInstances.Add(asyncAsset);
						if (callback != null)
						{
							callback(item.gameObject);
						}
					}
					else
					{
						item.callback = callback;
						m_pendingInstances.Add(item);
					}
				}
				else
				{
					Debug.LogError("assetname: " + assetName + " is null!!");
				}
			});
		}
		return null;
	}

	public AsyncScene LoadSceneAsync(string sceneName, LoadSceneMode mode, bool allowSceneActivation)
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			return null;
		}
		if (TryGetAssetNameAndBundleName(sceneName, out var assetName, out var assetBundleName))
		{
			if (!m_scenes.TryGetValue(assetName, out var value))
			{
				value = new AsyncScene(assetName, assetBundleName, mode, allowSceneActivation, m_manifest);
				m_scenes.Add(assetName, value);
			}
			value.LoadAsync();
			return value;
		}
		Debug.LogError("scene assetname: " + assetName + " is null!!");
		return null;
	}

	public void UnloadSceneAsync(string sceneName)
	{
		if (string.IsNullOrEmpty(sceneName))
		{
			return;
		}
		if (TryGetAssetNameAndBundleName(sceneName, out var assetName, out var _))
		{
			if (m_scenes.TryGetValue(assetName, out var value))
			{
				if (value.Release())
				{
					m_scenes.Remove(assetName);
				}
			}
			else
			{
				Debug.LogError("卸载不存在的场景!");
			}
		}
		else
		{
			Debug.LogError("scene assetname: " + assetName + " is null!!");
		}
	}

	public AsyncAsset<T> LoadAsync<T>(string loadName, Action<T> callback) where T : UnityEngine.Object
	{
		if (TryGetAssetNameAndBundleName(loadName, out var assetName, out var assetBundleName))
		{
			return LoadAsync(assetName, assetBundleName, callback);
		}
		Debug.LogError("loadname: " + loadName + " could not found in asset url file!!!");
		return null;
	}

	public AsyncAsset<T> LoadAsync<T>(string assetName, string bundleName, Action<T> callback) where T : UnityEngine.Object
	{
		AssetBundleObject value = null;
		if (m_ABMode)
		{
			if (string.IsNullOrEmpty(bundleName) || string.IsNullOrEmpty(assetName))
			{
				return null;
			}
			if (!AssetBundleObject.s_bundleObjects.TryGetValue(bundleName, out value))
			{
				value = new AssetBundleObject(bundleName, m_manifest);
				AssetBundleObject.s_bundleObjects.Add(bundleName, value);
			}
		}
		if (!m_assets.TryGetValue(assetName, out var value2))
		{
			value2 = new AsyncAsset<T>(assetName, value, m_ABMode);
			m_assets.Add(assetName, value2);
		}
		if (value2 == null)
		{
			Debug.LogError("assetname: " + assetName + " bundlename: " + bundleName + "is null !");
		}
		AsyncOperationAsset<T> asyncOperationAsset = (value2 as AsyncAsset<T>).LoadAsync();
		if (asyncOperationAsset.IsDone())
		{
			callback?.Invoke(asyncOperationAsset.m_asset);
		}
		else if (callback != null)
		{
			asyncOperationAsset.m_asset_compeleted += callback;
		}
		return value2 as AsyncAsset<T>;
	}

	public void UnloadAsync(string assetName)
	{
		if (string.IsNullOrEmpty(assetName))
		{
			return;
		}
		if (m_assets.TryGetValue(assetName, out var value))
		{
			if (value.Release())
			{
				m_assets.Remove(assetName);
			}
		}
		else
		{
			Debug.LogError("卸载不存在的资源!");
		}
	}

	public AsyncAssets<T> LoadAllAssetsAsync<T>(string bundleName, Action<T[]> callback) where T : UnityEngine.Object
	{
		AssetBundleObject value = null;
		if (m_ABMode)
		{
			if (string.IsNullOrEmpty(bundleName))
			{
				return null;
			}
			if (!AssetBundleObject.s_bundleObjects.TryGetValue(bundleName, out value))
			{
				value = new AssetBundleObject(bundleName, m_manifest);
				AssetBundleObject.s_bundleObjects.Add(bundleName, value);
			}
		}
		if (!m_assets.TryGetValue(bundleName, out var value2))
		{
			value2 = new AsyncAssets<T>(bundleName, value, m_ABMode);
			m_assets.Add(bundleName, value2);
		}
		AsyncOperationAllAsset<T> asyncOperationAllAsset = (value2 as AsyncAssets<T>).LoadAsync();
		if (asyncOperationAllAsset.IsDone())
		{
			callback?.Invoke(asyncOperationAllAsset.m_assets);
		}
		else if (callback != null)
		{
			asyncOperationAllAsset.m_asset_compeleted += callback;
		}
		return value2 as AsyncAssets<T>;
	}

	public void UnloadAllAssetsAsync(string bundleName)
	{
		if (string.IsNullOrEmpty(bundleName))
		{
			return;
		}
		if (m_assets.TryGetValue(bundleName, out var value))
		{
			if (value.Release())
			{
				m_assets.Remove(bundleName);
			}
		}
		else
		{
			Debug.LogError("卸载不存在的资源!");
		}
	}
}
