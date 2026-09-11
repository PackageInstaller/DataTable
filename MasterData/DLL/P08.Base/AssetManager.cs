using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEngine;
using UnityEngine.SceneManagement;

public class AssetManager : MonoBehaviour
{
	private static Dictionary<string, LoadedAssetBundle> m_LoadedAssetBundles = new Dictionary<string, LoadedAssetBundle>();

	private static Dictionary<string, AssetBundleLoadOperation> m_InProgressOperations = new Dictionary<string, AssetBundleLoadOperation>();

	private static List<AssetBundleLoadOperation> m_GetAssetInProgressOperations = new List<AssetBundleLoadOperation>();

	private static Dictionary<string, string> m_DownloadingErrors = new Dictionary<string, string>();

	private static string[] m_BundleNameList;

	private static Dictionary<string, int[]> m_AssetBundleManifestTable = new Dictionary<string, int[]>();

	private static List<string> bundlesWithVariant = new List<string>();

	private static AssetNameList m_AssetNames = null;

	private static AssetHashManifest m_AssetHashManifest = null;

	private static string s_ABLog;

	private static string[] m_ActiveVariants = new string[0];

	public static bool SimulateAssetBundleInEditor = true;

	private static GameObject go;

	private static List<string> UsePrefabList = new List<string>();

	private List<string> mPendingRemove = new List<string>();

	public static string[] ActiveVariants
	{
		get
		{
			return m_ActiveVariants;
		}
		set
		{
			m_ActiveVariants = value;
		}
	}

	private static string GetStreamingAssetsPath()
	{
		if (Application.isEditor)
		{
			return "file://" + Environment.CurrentDirectory.Replace("\\", "/");
		}
		if (Application.isMobilePlatform || Application.isConsolePlatform)
		{
			return Application.streamingAssetsPath;
		}
		return "file://" + Application.streamingAssetsPath;
	}

	public static Dictionary<string, LoadedAssetBundle> GetLoadedAssetbundle()
	{
		return m_LoadedAssetBundles;
	}

	public static LoadedAssetBundle GetLoadedAssetBundle(string assetBundleName, out string error)
	{
		if (m_DownloadingErrors.TryGetValue(assetBundleName, out error))
		{
			return null;
		}
		LoadedAssetBundle value = null;
		m_LoadedAssetBundles.TryGetValue(assetBundleName, out value);
		if (value == null)
		{
			return null;
		}
		string[] dependencies = null;
		if (!GetAllDependencies(assetBundleName, out dependencies))
		{
			return value;
		}
		for (int i = 0; i < dependencies.Length; i++)
		{
			if (!string.IsNullOrEmpty(dependencies[i]))
			{
				if (m_DownloadingErrors.TryGetValue(dependencies[i], out error))
				{
					return null;
				}
				m_LoadedAssetBundles.TryGetValue(dependencies[i], out var value2);
				if (value2 == null)
				{
					return null;
				}
			}
		}
		return value;
	}

	public static void TagDontDestroyAssetbundle(string path, bool isLoad, bool isManifest)
	{
		if (TryGetAssetNameAndBundleName(path, out var _, out var assetBundleName))
		{
			string text = assetBundleName;
			if (!isManifest)
			{
				text = text.ToLower(StringTools.sCultureInfo);
			}
			TagDontDestroyAssetbundle(text, isLoad);
		}
	}

	public static void TagDontDestroyAssetbundle(string assetBundleName, bool isLoad)
	{
		LoadedAssetBundle value = null;
		m_LoadedAssetBundles.TryGetValue(assetBundleName, out value);
		if (value == null)
		{
			return;
		}
		if (isLoad)
		{
			value.IncreaseManualRef();
		}
		else
		{
			value.DecreaseManualRef();
		}
		string[] dependencies = null;
		if (!GetAllDependencies(assetBundleName, out dependencies))
		{
			return;
		}
		string[] array = dependencies;
		foreach (string key in array)
		{
			m_LoadedAssetBundles.TryGetValue(key, out var value2);
			if (isLoad)
			{
				value2.IncreaseManualRef();
			}
			else
			{
				value2.DecreaseManualRef();
			}
		}
	}

	public static bool IsAssetBundleDownloaded(string assetBundleName)
	{
		return m_LoadedAssetBundles.ContainsKey(assetBundleName.ToLower(StringTools.sCultureInfo));
	}

	public static void Create()
	{
		AssetBundle.UnloadAllAssetBundles(unloadAllObjects: true);
		string text = "manifest";
		go = new GameObject("AssetBundleManager", typeof(AssetManager));
		if (Application.isPlaying)
		{
			UnityEngine.Object.DontDestroyOnLoad(go);
		}
		s_ABLog = Platform.GetDownloadPersistentDataPath() + "ab_load_history_log";
		new GameObject("AtlasHelper", typeof(AtlasHelper));
		Platform.GetABXXteaKey();
		m_AssetBundleManifestTable.Clear();
		bundlesWithVariant.Clear();
		sbpAssetBundleManifest sbpAssetBundleManifest2 = Load<sbpAssetBundleManifest>(text, "AssetBundleManifest", isManifest: true);
		if (sbpAssetBundleManifest2 != null)
		{
			m_BundleNameList = sbpAssetBundleManifest2.GetAllAssetBundles();
			bundlesWithVariant.AddRange(sbpAssetBundleManifest2.GetAllAssetBundlesWithVariant());
			if (m_BundleNameList == null)
			{
				Debug.LogError(text + "is empty!");
			}
			for (int i = 0; i < m_BundleNameList.Length; i++)
			{
				string text2 = m_BundleNameList[i];
				int[] allDependenciesIndices = sbpAssetBundleManifest2.GetAllDependenciesIndices(text2);
				m_AssetBundleManifestTable.Add(text2, allDependenciesIndices);
			}
			UnloadAssetBundle(text);
		}
		m_AssetNames = Platform.GetMPFile<AssetNameList>(Load<TextAsset>("asseturl.ys", "Assets/ABResources/AssetUrl.txt").bytes);
		if (m_AssetNames == null)
		{
			Debug.Log("asseturl json failed!!!");
		}
		else
		{
			Debug.Log("Init asseturl success!!! count: " + m_AssetNames.assetNames.Count);
		}
		UnloadAssetBundle("assetUrl.ys");
		TagDontDestroyAssetbundle(text, isLoad: true, isManifest: true);
		InitSceneABInfo("comscene/manifest", "comscene/asseturlcomscene.ys", "Assets/ComScene/ABResources/AssetUrlComScene.txt", "comscene/", "ComScene");
		InitSceneABInfo("comsceneq/manifest", "comsceneq/asseturlcomsceneq.ys", "Assets/ComSceneQ/ABResources/AssetUrlComSceneQ.txt", "comsceneq/", "ComSceneQ");
		InitSceneABInfo("comsingle/manifest", "comsingle/asseturlcomsingle.ys", "Assets/ComSingle/ABResources/AssetUrlComSingle.txt", "comsingle/", "ComSingle");
		InitSceneABInfo("comchar/manifest", "comchar/asseturlcomchar.ys", "Assets/ComChar/ABResources/AssetUrlComChar.txt", "comchar/", "ComChar");
		InitSceneABInfo("comcharq/manifest", "comcharq/asseturlcomcharq.ys", "Assets/ComCharQ/ABResources/AssetUrlComCharQ.txt", "comcharq/", "ComCharQ");
		InitSceneABInfo("comeffect/manifest", "comeffect/asseturlcomeffect.ys", "Assets/ComEffect/ABResources/AssetUrlComEffect.txt", "comeffect/", "ComEffect");
		InitSceneABInfo("combattle/manifest", "combattle/asseturlcombattle.ys", "Assets/ComBattle/ABResources/AssetUrlComBattle.txt", "combattle/", "ComBattle");
	}

	private static bool InitSceneABInfo(string manifestName, string asseturlBundle, string asseturlPath, string prefix, string spName)
	{
		if (0 == 0)
		{
			sbpAssetBundleManifest sbpAssetBundleManifest2 = Load<sbpAssetBundleManifest>(manifestName, "AssetBundleManifest", isManifest: true);
			if (sbpAssetBundleManifest2 != null)
			{
				string[] allAssetBundles = sbpAssetBundleManifest2.GetAllAssetBundles();
				string[] array = new string[allAssetBundles.Length];
				for (int i = 0; i < allAssetBundles.Length; i++)
				{
					string text = prefix + allAssetBundles[i];
					array[i] = text;
				}
				int start = 0;
				if (m_BundleNameList == null)
				{
					m_BundleNameList = array;
				}
				else
				{
					start = m_BundleNameList.Length;
					m_BundleNameList = m_BundleNameList.Concat(array).ToArray();
				}
				bundlesWithVariant.AddRange(sbpAssetBundleManifest2.GetAllAssetBundlesWithVariant());
				if (m_BundleNameList == null)
				{
					Debug.LogError(manifestName + "is empty!");
				}
				int package_com_ys_index = -1;
				int shader_ys_index = -1;
				for (int j = 0; j < m_BundleNameList.Length; j++)
				{
					if ("packages/com.ys" == m_BundleNameList[j])
					{
						package_com_ys_index = j;
					}
					if ("shader.ys" == m_BundleNameList[j])
					{
						shader_ys_index = j;
					}
					if (-1 != package_com_ys_index && -1 != shader_ys_index)
					{
						break;
					}
				}
				string packages_com_ys_name = prefix + "packages/com.ys";
				string shader_ys_name = prefix + "shader.ys";
				for (int k = 0; k < allAssetBundles.Length; k++)
				{
					string key = prefix + allAssetBundles[k];
					IEnumerable<int> source = sbpAssetBundleManifest2.GetAllDependenciesIndices(allAssetBundles[k]).Select(delegate(int index)
					{
						int num = index + start;
						string text2 = m_BundleNameList[num];
						if (-1 != package_com_ys_index && text2 == packages_com_ys_name)
						{
							num = package_com_ys_index;
						}
						if (-1 != shader_ys_index && text2 == shader_ys_name)
						{
							num = shader_ys_index;
						}
						return num;
					});
					m_AssetBundleManifestTable.Add(key, source.ToArray());
				}
				UnloadAssetBundle(manifestName);
			}
		}
		AssetNameList mPFile = Platform.GetMPFile<AssetNameList>(Load<TextAsset>(asseturlBundle, asseturlPath).bytes);
		if (m_AssetNames == null)
		{
			m_AssetNames = mPFile;
		}
		else
		{
			foreach (KeyValuePair<string, AssetName> assetName in mPFile.assetNames)
			{
				if (m_AssetNames.assetNames.ContainsKey(assetName.Key))
				{
					Debug.LogError(assetName.Key + " 资源名重复 " + prefix + assetName.Value.bundleName);
					Debug.LogError(assetName.Key + " 资源名重复 " + m_AssetNames.assetNames[assetName.Key].bundleName);
				}
				else
				{
					AssetName value = assetName.Value;
					value.bundleName = prefix + value.bundleName;
					m_AssetNames.assetNames[assetName.Key] = value;
				}
			}
		}
		if (m_AssetNames == null)
		{
			Debug.Log("asseturl json failed!!!");
		}
		else
		{
			Debug.Log("Init asseturl success!!! count: " + m_AssetNames.assetNames.Count);
		}
		UnloadAssetBundle(asseturlBundle);
		return true;
	}

	public static void Create(AssetHashManifest hashManifest)
	{
		m_AssetHashManifest = hashManifest;
		Create();
	}

	public static void Destroy()
	{
		UnloadAllAssetBundles(skipDontDestroy: false);
		Resources.UnloadUnusedAssets();
		m_LoadedAssetBundles.Clear();
		m_DownloadingErrors.Clear();
		m_BundleNameList = null;
		m_AssetBundleManifestTable.Clear();
		if (null != go)
		{
			UnityEngine.Object.DestroyImmediate(go);
			go = null;
		}
	}

	public static void StopAllAsyncLoading()
	{
		m_InProgressOperations.Clear();
		m_GetAssetInProgressOperations.Clear();
	}

	public static AssetBundleLoadOperation LoadLevelAsync(string assetBundleName, LoadSceneMode mode, bool allowSceneActivation)
	{
		string levelName = string.Empty;
		if (assetBundleName.Contains("."))
		{
			assetBundleName = assetBundleName.Split('.')[0];
		}
		if (m_AssetNames != null)
		{
			if (m_AssetNames.assetNames.TryGetValue(assetBundleName, out var value))
			{
				levelName = value.assetName;
				assetBundleName = value.bundleName;
			}
			if (value == null)
			{
				return null;
			}
		}
		if (m_AssetNames == null)
		{
			return null;
		}
		AssetBundleLoadOperation assetBundleLoadOperation = null;
		LoadAssetBundle(assetBundleName, isLoadingAssetBundleManifest: false, isAsync: true);
		assetBundleLoadOperation = new AssetBundleLoadLevelOperation(assetBundleName, levelName, mode, allowSceneActivation);
		m_GetAssetInProgressOperations.Add(assetBundleLoadOperation);
		return assetBundleLoadOperation;
	}

	public static Scene LoadLevelSync(string assetBundleName, bool isAdditive)
	{
		string text = string.Empty;
		Scene result = default(Scene);
		if (assetBundleName.Contains("."))
		{
			assetBundleName = assetBundleName.Split('.')[0];
		}
		if (m_AssetNames != null)
		{
			if (m_AssetNames.assetNames.TryGetValue(assetBundleName, out var value))
			{
				text = value.assetName;
				assetBundleName = value.bundleName;
			}
			if (value == null)
			{
				return result;
			}
		}
		if (m_AssetNames != null)
		{
			LoadSceneParameters parameters = new LoadSceneParameters(isAdditive ? LoadSceneMode.Additive : LoadSceneMode.Single);
			if (LoadAssetBundle(assetBundleName, isLoadingAssetBundleManifest: false) == BundleLoadStatus.Success)
			{
				string error = null;
				if (GetLoadedAssetBundle(assetBundleName, out error) != null)
				{
					return SceneManager.LoadScene(text, parameters);
				}
				Debug.LogError("场景不存在:" + text);
			}
		}
		return result;
	}

	public static AssetBundleLoadAssetOperation<T> LoadAssetAsync<T>(string assetBundleName, OnVoidHandler<T> callback) where T : UnityEngine.Object
	{
		string assetName = string.Empty;
		if (assetBundleName.Contains("."))
		{
			assetBundleName = assetBundleName.Split('.')[0];
		}
		if (m_AssetNames != null)
		{
			if (m_AssetNames.assetNames.TryGetValue(assetBundleName, out var value))
			{
				assetName = value.assetName;
				assetBundleName = value.bundleName;
			}
			if (value == null)
			{
				return null;
			}
		}
		if (m_AssetNames == null)
		{
			return null;
		}
		AssetBundleLoadAssetOperation<T> assetBundleLoadAssetOperation = null;
		LoadAssetBundle(assetBundleName, isLoadingAssetBundleManifest: false, isAsync: true);
		assetBundleLoadAssetOperation = new AssetBundleLoadAssetOperationFull<T>(assetBundleName, assetName, callback);
		m_GetAssetInProgressOperations.Add(assetBundleLoadAssetOperation);
		return assetBundleLoadAssetOperation;
	}

	public static AssetBundleSyncLoadAssetOperationFull<T> LoadAssetSync<T>(string assetBundleName, OnVoidHandler<T> callback) where T : UnityEngine.Object
	{
		string assetName = string.Empty;
		if (assetBundleName.Contains("."))
		{
			assetBundleName = assetBundleName.Split('.')[0];
		}
		if (m_AssetNames != null)
		{
			if (m_AssetNames.assetNames.TryGetValue(assetBundleName, out var value))
			{
				assetName = value.assetName;
				assetBundleName = value.bundleName;
			}
			if (value == null)
			{
				return null;
			}
		}
		if (m_AssetNames == null)
		{
			return null;
		}
		AssetBundleSyncLoadAssetOperationFull<T> assetBundleSyncLoadAssetOperationFull = null;
		LoadAssetBundle(assetBundleName, isLoadingAssetBundleManifest: false, isAsync: true);
		assetBundleSyncLoadAssetOperationFull = new AssetBundleSyncLoadAssetOperationFull<T>(assetBundleName, assetName, callback);
		m_GetAssetInProgressOperations.Add(assetBundleSyncLoadAssetOperationFull);
		return assetBundleSyncLoadAssetOperationFull;
	}

	public static AssetBundleLoadAssetsOperationFull<T> LoadAllAsync<T>(string assetBundleName, OnVoidHandler<T[]> callback) where T : UnityEngine.Object
	{
		AssetBundleLoadAssetsOperationFull<T> assetBundleLoadAssetsOperationFull = null;
		LoadAssetBundle(assetBundleName, isLoadingAssetBundleManifest: false, isAsync: true);
		assetBundleLoadAssetsOperationFull = new AssetBundleLoadAssetsOperationFull<T>(assetBundleName, callback);
		m_GetAssetInProgressOperations.Add(assetBundleLoadAssetsOperationFull);
		return assetBundleLoadAssetsOperationFull;
	}

	public static AssetBundleSyncLoadAssetsOperationFull<T> LoadAllSync<T>(string assetBundleName, OnVoidHandler<T[]> callback) where T : UnityEngine.Object
	{
		AssetBundleSyncLoadAssetsOperationFull<T> assetBundleSyncLoadAssetsOperationFull = null;
		LoadAssetBundle(assetBundleName, isLoadingAssetBundleManifest: false, isAsync: true);
		assetBundleSyncLoadAssetsOperationFull = new AssetBundleSyncLoadAssetsOperationFull<T>(assetBundleName, callback);
		m_GetAssetInProgressOperations.Add(assetBundleSyncLoadAssetsOperationFull);
		return assetBundleSyncLoadAssetsOperationFull;
	}

	public static bool TryGetAssetNameAndBundleName(string path, out string assetName, out string assetBundleName)
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

	public static bool TryGetBundleFileName(string bundleName, out string fileName)
	{
		fileName = string.Empty;
		if (m_AssetHashManifest != null)
		{
			if (m_AssetHashManifest.mBundleName2FileInfo.TryGetValue(bundleName, out var value))
			{
				fileName = value.mFilePath;
				return true;
			}
			Debug.LogError(bundleName + " 不在没有版本记录！");
		}
		if (string.IsNullOrEmpty(fileName))
		{
			Debug.LogError(bundleName + " 不在没有版本记录！");
			return false;
		}
		return true;
	}

	public static AssetHashManifest GetAssetHashManifest()
	{
		return m_AssetHashManifest;
	}

	public static int GetClientVersion()
	{
		if (m_AssetHashManifest != null)
		{
			return m_AssetHashManifest.GetClientVersion();
		}
		return 0;
	}

	public static int GetResourceVersion()
	{
		if (m_AssetHashManifest != null)
		{
			return m_AssetHashManifest.GetResourceVersion();
		}
		return 0;
	}

	public static string GetResourceVersionName()
	{
		if (m_AssetHashManifest != null)
		{
			return m_AssetHashManifest.GetResourceVersionName();
		}
		return "v0.0.0";
	}

	public static T Load<T>(string path, bool isManifest = false) where T : UnityEngine.Object
	{
		string assetName = string.Empty;
		string assetBundleName = string.Empty;
		if (!TryGetAssetNameAndBundleName(path, out assetName, out assetBundleName))
		{
			return null;
		}
		return Load<T>(assetBundleName, assetName, isManifest);
	}

	public static void LoadAll<T>(string assetBundleName, ref T[] assets) where T : UnityEngine.Object
	{
		if (LoadAssetBundle(assetBundleName, isLoadingAssetBundleManifest: false) != BundleLoadStatus.Failed)
		{
			string error = string.Empty;
			LoadedAssetBundle loadedAssetBundle = GetLoadedAssetBundle(assetBundleName, out error);
			if (!string.IsNullOrEmpty(error))
			{
				Debug.Log("Can not load asset bundle name" + error + "!!!");
			}
			else
			{
				loadedAssetBundle?.GetAllAssets(ref assets);
			}
		}
	}

	public static T Load<T>(string assetBundleName, string assetName, bool isManifest = false) where T : UnityEngine.Object
	{
		T val = null;
		BundleLoadStatus bundleLoadStatus = LoadAssetBundle(assetBundleName, isManifest);
		if (bundleLoadStatus != BundleLoadStatus.Failed && !UsePrefabList.Contains(assetName))
		{
			string error = string.Empty;
			LoadedAssetBundle loadedAssetBundle = GetLoadedAssetBundle(assetBundleName, out error);
			if (!string.IsNullOrEmpty(error))
			{
				Debug.Log("Can not load " + assetBundleName + " asset bundle @" + error + "!!!");
				return null;
			}
			if (loadedAssetBundle != null)
			{
				val = loadedAssetBundle.GetAsset<T>(assetName);
				if (null == val)
				{
					string text = "";
					string[] allAssetNames = loadedAssetBundle.m_AssetBundle.GetAllAssetNames();
					for (int i = 0; i < allAssetNames.Length; i++)
					{
						text += allAssetNames[i];
						text += "\n";
					}
					text = text + "===========> " + assetBundleName + ", " + assetName;
					Debug.Log(text);
				}
			}
			else
			{
				Debug.LogError(assetBundleName + "  bundle is null!!!" + bundleLoadStatus);
			}
		}
		else
		{
			Debug.LogError("LoadAssetBundle Failed " + bundleLoadStatus.ToString() + " " + assetBundleName + ", " + assetName);
		}
		if (val == null)
		{
			Debug.LogError(assetBundleName + " not exist.(it is harmless in editor, ignore it please!)");
		}
		return val;
	}

	protected static BundleLoadStatus LoadAssetBundle(string assetBundleName, bool isLoadingAssetBundleManifest, bool isAsync = false)
	{
		if (!isLoadingAssetBundleManifest && !IsManifestReady())
		{
			if (!m_DownloadingErrors.ContainsKey(assetBundleName))
			{
				m_DownloadingErrors.Add(assetBundleName, "loading " + assetBundleName + " error,Please initialize AssetBundleManifest by calling AssetBundleManager.Initialize()");
			}
			return BundleLoadStatus.Failed;
		}
		BundleLoadStatus num = LoadAssetBundleInternal(assetBundleName, isLoadingAssetBundleManifest, isAsync);
		if (num == BundleLoadStatus.Success && m_DownloadingErrors.ContainsKey(assetBundleName))
		{
			m_DownloadingErrors.Remove(assetBundleName);
		}
		if (!isLoadingAssetBundleManifest)
		{
			LoadDependencies(assetBundleName, isAsync);
		}
		return num;
	}

	protected static BundleLoadStatus LoadAssetBundleInternal(string assetBundleName, bool isLoadingAssetBundleManifest, bool isAsync)
	{
		LoadedAssetBundle value = null;
		m_LoadedAssetBundles.TryGetValue(assetBundleName, out value);
		if (value != null)
		{
			value.IncreaseAutoRef();
			return BundleLoadStatus.Success;
		}
		if (m_InProgressOperations.ContainsKey(assetBundleName))
		{
			AssetBundleLoadOperation assetBundleLoadOperation = m_InProgressOperations[assetBundleName];
			assetBundleLoadOperation.m_ReferencedCount++;
			if (!isAsync && assetBundleLoadOperation is AssetBundleDownloadFromFile)
			{
				(assetBundleLoadOperation as AssetBundleDownloadFromFile).GetAssetBundleSync();
				ProcessFinishedOperation(assetBundleLoadOperation);
				m_InProgressOperations.Remove(assetBundleName);
				return BundleLoadStatus.Success;
			}
			return BundleLoadStatus.Processing;
		}
		try
		{
			string text = string.Empty;
			if (TryGetBundleFileName(assetBundleName, out var fileName))
			{
				text = Platform.GetDownloadPersistentDataPath() + fileName;
			}
			if (!File.Exists(text))
			{
				text = Platform.GetDownloadPath() + fileName;
			}
			AppendABLoadLog(assetBundleName, text);
			if (isAsync)
			{
				m_InProgressOperations.Add(assetBundleName, new AssetBundleDownloadFromFile(assetBundleName, text));
				return BundleLoadStatus.Processing;
			}
			if (!string.IsNullOrEmpty(text))
			{
				AssetBundle assetBundle;
				if (Platform.CheckABXXtea())
				{
					byte[] outData = null;
					XXTEA.DecryptFile(text, Platform.GetABXXteaKey(), ref outData);
					assetBundle = AssetBundle.LoadFromMemory(outData);
				}
				else if (Platform.CheckABEncypt() && fileName != string.Empty)
				{
					int num = assetBundleName.Length % 16 + 1;
					assetBundle = AssetBundle.LoadFromFile(text, 0u, (ulong)num);
				}
				else
				{
					assetBundle = AssetBundle.LoadFromFile(text);
				}
				if (!assetBundle)
				{
					return BundleLoadStatus.Failed;
				}
				LoadedAssetBundle value2 = new LoadedAssetBundle(assetBundle);
				m_LoadedAssetBundles.Add(assetBundleName, value2);
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			return BundleLoadStatus.Failed;
		}
		return BundleLoadStatus.Success;
	}

	protected static void LoadDependencies(string assetBundleName, bool isAsync)
	{
		string[] dependencies = null;
		try
		{
			if (!IsManifestReady() || !GetAllDependencies(assetBundleName, out dependencies))
			{
				return;
			}
			for (int i = 0; i < dependencies.Length; i++)
			{
				if (string.IsNullOrEmpty(dependencies[i]))
				{
					Debug.Log($"Assets bundle {assetBundleName} dependency is empty!");
				}
			}
			for (int j = 0; j < dependencies.Length; j++)
			{
				LoadAssetBundleInternal(dependencies[j], isLoadingAssetBundleManifest: false, isAsync);
			}
		}
		catch (Exception)
		{
			if (dependencies != null)
			{
				for (int k = 0; k < dependencies.Length; k++)
				{
					Debug.Log(dependencies[k]);
				}
			}
		}
	}

	public static void UnloadAssetBundle(string assetBundleName)
	{
		if (!string.IsNullOrEmpty(assetBundleName))
		{
			UnloadAssetBundleInternal(assetBundleName);
			UnloadDependencies(assetBundleName);
		}
	}

	protected static void UnloadDependencies(string assetBundleName)
	{
		if (GetAllDependencies(assetBundleName, out var dependencies))
		{
			string[] array = dependencies;
			for (int i = 0; i < array.Length; i++)
			{
				UnloadAssetBundleInternal(array[i]);
			}
		}
	}

	protected static void UnloadAssetBundleInternal(string assetBundleName)
	{
		LoadedAssetBundle value = null;
		m_LoadedAssetBundles.TryGetValue(assetBundleName, out value);
		if (value != null)
		{
			value.DecreaseAutoRef();
			if (value.IsUnusedBundle())
			{
				value.OnUnload(allUnload: true);
				m_LoadedAssetBundles.Remove(assetBundleName);
			}
		}
	}

	public static void UnloadAllAssetBundles(bool skipDontDestroy = true)
	{
		List<string> list = new List<string>();
		Dictionary<string, LoadedAssetBundle>.KeyCollection.Enumerator enumerator = m_LoadedAssetBundles.Keys.GetEnumerator();
		while (enumerator.MoveNext())
		{
			list.Add(enumerator.Current);
		}
		for (int i = 0; i < list.Count; i++)
		{
			LoadedAssetBundle value = null;
			m_LoadedAssetBundles.TryGetValue(list[i], out value);
			if (skipDontDestroy && value != null)
			{
				int manualRef = value.GetManualRef();
				if (manualRef > 0)
				{
					value.SetAutoRef(manualRef);
					continue;
				}
			}
			value?.OnUnload(allUnload: true);
			m_LoadedAssetBundles.Remove(list[i]);
		}
	}

	public void Update()
	{
		mPendingRemove.Clear();
		foreach (KeyValuePair<string, AssetBundleLoadOperation> inProgressOperation in m_InProgressOperations)
		{
			AssetBundleLoadOperation value = inProgressOperation.Value;
			if (!value.Update())
			{
				mPendingRemove.Add(inProgressOperation.Key);
				ProcessFinishedOperation(value);
			}
		}
		for (int i = 0; i < mPendingRemove.Count; i++)
		{
			m_InProgressOperations.Remove(mPendingRemove[i]);
		}
		mPendingRemove.Clear();
		int num = 0;
		while (num < m_GetAssetInProgressOperations.Count)
		{
			AssetBundleLoadOperation assetBundleLoadOperation = m_GetAssetInProgressOperations[num];
			if (assetBundleLoadOperation.Update())
			{
				num++;
				continue;
			}
			m_GetAssetInProgressOperations.RemoveAt(num);
			ProcessFinishedOperation(assetBundleLoadOperation);
		}
	}

	private static void ProcessFinishedOperation(AssetBundleLoadOperation operation)
	{
		if (operation is IAssetLoadCallbackHandler && operation.IsDone())
		{
			(operation as IAssetLoadCallbackHandler).Finish();
		}
		if (operation is AssetBundleDownloadFromFile)
		{
			AssetBundleDownloadFromFile assetBundleDownloadFromFile = operation as AssetBundleDownloadFromFile;
			assetBundleDownloadFromFile.assetBundle.SetAutoRef(operation.m_ReferencedCount);
			m_LoadedAssetBundles.Add(assetBundleDownloadFromFile.assetBundleName, assetBundleDownloadFromFile.assetBundle);
		}
		if (operation is AssetBundleDownloadFromWebOperation)
		{
			AssetBundleDownloadFromWebOperation assetBundleDownloadFromWebOperation = operation as AssetBundleDownloadFromWebOperation;
			assetBundleDownloadFromWebOperation.assetBundle.SetAutoRef(operation.m_ReferencedCount);
			if (string.IsNullOrEmpty(assetBundleDownloadFromWebOperation.error))
			{
				m_LoadedAssetBundles.Add(assetBundleDownloadFromWebOperation.assetBundleName, assetBundleDownloadFromWebOperation.assetBundle);
				return;
			}
			string value = $"Failed downloading bundle {assetBundleDownloadFromWebOperation.assetBundleName} from {assetBundleDownloadFromWebOperation.GetSourceURL()}: {assetBundleDownloadFromWebOperation.error}";
			m_DownloadingErrors.Add(assetBundleDownloadFromWebOperation.assetBundleName, value);
		}
	}

	protected static bool UsesExternalBundleVariantResolutionMechanism(string baseAssetBundleName)
	{
		return false;
	}

	public static bool GetAllDependencies(string assetbundleName, out string[] dependencies)
	{
		int[] value = null;
		dependencies = null;
		if (m_AssetBundleManifestTable.TryGetValue(assetbundleName, out value))
		{
			dependencies = new string[value.Length];
			for (int i = 0; i < dependencies.Length; i++)
			{
				dependencies[i] = ((value[i] != -1) ? m_BundleNameList[value[i]] : string.Empty);
			}
			return true;
		}
		return false;
	}

	private static bool IsManifestReady()
	{
		if (m_AssetBundleManifestTable != null)
		{
			return m_AssetBundleManifestTable.Count > 0;
		}
		return false;
	}

	public static void AppendABLoadLog(string assetBundleName, string path)
	{
	}
}
