using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using LuaInterface;
using UnityEngine;

public class ResourceManager : MonoBehaviour
{
	private class LoadTask
	{
		public enum LoadType
		{
			none,
			bundle,
			asset
		}

		public LoadType loadType;

		public string bundlePath;

		public string assetName;

		public AssetBundle bundle;

		public bool async;

		public Type type;

		public Action<UnityEngine.Object> callback;

		public LoadTask()
		{
			callback = delegate
			{
			};
		}

		public static bool operator ==(LoadTask t1, LoadTask t2)
		{
			bool flag = object.Equals(t1, null);
			bool flag2 = object.Equals(t2, null);
			if (flag & flag2)
			{
				return true;
			}
			if (!flag && !flag2 && t1.loadType == t2.loadType)
			{
				if (t1.loadType != LoadType.bundle || !(t1.bundlePath == t2.bundlePath))
				{
					if (t1.loadType == LoadType.asset && t1.bundle == t2.bundle)
					{
						return t1.assetName == t2.assetName;
					}
					return false;
				}
				return true;
			}
			return false;
		}

		public static bool operator !=(LoadTask t1, LoadTask t2)
		{
			return !(t1 == t2);
		}

		public override bool Equals(object obj)
		{
			return base.Equals(obj);
		}

		public override int GetHashCode()
		{
			return base.GetHashCode();
		}
	}

	private class AssetBundleRef
	{
		private int _refCount;

		private AssetBundle _assetbundle;

		public AssetBundle assetBundle => _assetbundle;

		public int refCount => _refCount;

		public AssetBundleRef(AssetBundle ab, int refCount = 1)
		{
			_assetbundle = ab;
			_refCount = refCount;
		}

		public void Retain(int count = 1)
		{
			_refCount += count;
		}

		public void Release(int count = 1)
		{
			_refCount -= count;
		}
	}

	private static ResourceManager _inst;

	private const int MaxParallelLoadNums = 20;

	private AssetBundleManifest manifest;

	private HashSet<string> assetBundleMap;

	private Dictionary<string, AssetBundleRef> cachedBundles;

	private Queue<LoadTask> waitings;

	private List<LoadTask> loadings;

	public static ResourceManager inst => _inst;

	private void Awake()
	{
		if (_inst == null)
		{
			_inst = this;
		}
	}

	public void Init()
	{
		waitings = new Queue<LoadTask>();
		loadings = new List<LoadTask>();
		cachedBundles = new Dictionary<string, AssetBundleRef>();
		string assetBundle = PathManager.inst.GetAssetBundle("dependencies");
		AssetBundle assetBundle2 = AssetBundle.LoadFromMemory(FileManager.inst.ReadAllBytes(assetBundle));
		manifest = assetBundle2.LoadAsset<AssetBundleManifest>("AssetBundleManifest");
		assetBundle2.Unload(unloadAllLoadedObjects: false);
		assetBundleMap = new HashSet<string>();
		string[] allAssetBundles = manifest.GetAllAssetBundles();
		foreach (string item in allAssetBundles)
		{
			assetBundleMap.Add(item);
		}
	}

	public void Load(string bundlePath, string assetName, Type type, bool async, Action<UnityEngine.Object> callback = null)
	{
		LoadBundle(bundlePath, async, 1, delegate(UnityEngine.Object obj)
		{
			LoadAsset(obj as AssetBundle, assetName, type, async, callback);
		});
	}

	public void LoadBundle(string bundlePath, bool async, int refCount = 1, Action<UnityEngine.Object> callback = null)
	{
		LoadTask loadTask = new LoadTask
		{
			loadType = LoadTask.LoadType.bundle,
			bundlePath = bundlePath,
			async = async
		};
		loadTask.callback = (Action<UnityEngine.Object>)Delegate.Combine(loadTask.callback, (Action<UnityEngine.Object>)delegate(UnityEngine.Object obj)
		{
			AssetBundle bundle = obj as AssetBundle;
			Retain(bundlePath, bundle, refCount);
		});
		loadTask.callback = (Action<UnityEngine.Object>)Delegate.Combine(loadTask.callback, callback);
		AddLoadTask(loadTask);
	}

	public void LoadAsset(AssetBundle bundle, string assetName, Type type, bool async, Action<UnityEngine.Object> callback = null)
	{
		LoadTask loadTask = new LoadTask
		{
			loadType = LoadTask.LoadType.asset,
			bundle = bundle,
			assetName = assetName,
			type = type,
			async = async
		};
		loadTask.callback = (Action<UnityEngine.Object>)Delegate.Combine(loadTask.callback, callback);
		AddLoadTask(loadTask);
	}

	public void Retain(string bundlePath, AssetBundle bundle = null, int refCount = 1)
	{
		if (!cachedBundles.ContainsKey(bundlePath))
		{
			cachedBundles[bundlePath] = new AssetBundleRef(bundle, 0);
		}
		cachedBundles[bundlePath].Retain(refCount);
	}

	public void Release(string bundlePath, bool unloadBundle = false)
	{
		if (cachedBundles.ContainsKey(bundlePath))
		{
			AssetBundleRef assetBundleRef = cachedBundles[bundlePath];
			assetBundleRef.Release();
			if ((assetBundleRef.refCount <= 0) & unloadBundle)
			{
				assetBundleRef.assetBundle.Unload(unloadAllLoadedObjects: false);
				cachedBundles.Remove(bundlePath);
			}
		}
	}

	public void UnloadUnusedBundles()
	{
		Dictionary<string, AssetBundleRef> dictionary = new Dictionary<string, AssetBundleRef>();
		foreach (KeyValuePair<string, AssetBundleRef> cachedBundle in cachedBundles)
		{
			AssetBundleRef value = cachedBundle.Value;
			if (value.refCount <= 0)
			{
				value.assetBundle.Unload(unloadAllLoadedObjects: false);
			}
			else
			{
				dictionary.Add(cachedBundle.Key, cachedBundle.Value);
			}
		}
		cachedBundles = dictionary;
	}

	private void AddLoadTask(LoadTask task)
	{
		switch (task.loadType)
		{
		case LoadTask.LoadType.bundle:
			if (!assetBundleMap.Contains(task.bundlePath))
			{
				Debugger.LogError("assetbundle not exist: {0}", task.bundlePath);
				return;
			}
			if (cachedBundles.ContainsKey(task.bundlePath))
			{
				task.callback(cachedBundles[task.bundlePath].assetBundle);
				return;
			}
			break;
		case LoadTask.LoadType.asset:
			if (!task.bundle)
			{
				Debugger.LogError("assetbundle can not be null");
				return;
			}
			break;
		default:
			throw new NotSupportedException();
		}
		LoadTask loadTask = loadings.Find((LoadTask t) => t == task);
		if (loadTask == null)
		{
			loadTask = waitings.ToList().Find((LoadTask t) => t == task);
		}
		if (loadTask != null)
		{
			LoadTask loadTask2 = loadTask;
			loadTask2.callback = (Action<UnityEngine.Object>)Delegate.Combine(loadTask2.callback, task.callback);
			return;
		}
		if (!task.async)
		{
			switch (task.loadType)
			{
			case LoadTask.LoadType.bundle:
			{
				string[] allDependencies = manifest.GetAllDependencies(task.bundlePath);
				foreach (string bundlePath in allDependencies)
				{
					LoadBundle(bundlePath, task.async, 0);
				}
				task.callback(LoadAssetBundleSync(task.bundlePath));
				break;
			}
			case LoadTask.LoadType.asset:
				task.callback(LoadAssetSync(task.bundle, task.assetName, task.type));
				break;
			}
			return;
		}
		switch (task.loadType)
		{
		case LoadTask.LoadType.bundle:
		{
			string[] allDependencies = manifest.GetAllDependencies(task.bundlePath);
			foreach (string bundlePath2 in allDependencies)
			{
				LoadBundle(bundlePath2, task.async, 0);
			}
			LoadTaskAsync(task);
			break;
		}
		case LoadTask.LoadType.asset:
			LoadTaskAsync(task);
			break;
		}
	}

	private AssetBundle LoadAssetBundleSync(string path)
	{
		return AssetBundle.LoadFromFile(PathManager.inst.GetAssetBundle(path));
	}

	private UnityEngine.Object LoadAssetSync(AssetBundle bundle, string name, Type type)
	{
		UnityEngine.Object obj = null;
		if (type != null)
		{
			return bundle.LoadAsset(name, type);
		}
		return bundle.LoadAsset(name);
	}

	private void LoadTaskAsync(LoadTask task)
	{
		if (loadings.Count >= 20)
		{
			waitings.Enqueue(task);
			return;
		}
		LoadTask loadTask = task;
		loadTask.callback = (Action<UnityEngine.Object>)Delegate.Combine(loadTask.callback, (Action<UnityEngine.Object>)delegate
		{
			loadings.Remove(task);
			if (waitings.Count > 0)
			{
				LoadTaskAsync(waitings.Dequeue());
			}
		});
		loadings.Add(task);
		StartCoroutine(LoadTaskCoroutine(task));
	}

	private IEnumerator LoadTaskCoroutine(LoadTask task)
	{
		UnityEngine.Object obj = null;
		switch (task.loadType)
		{
		case LoadTask.LoadType.bundle:
		{
			string assetBundle = PathManager.inst.GetAssetBundle(task.bundlePath);
			WWW www = new WWW("file://" + assetBundle);
			yield return www;
			if (!string.IsNullOrEmpty(www.error))
			{
				Debugger.LogError("load assetbundle failed: " + www.url + "(" + www.error + ")");
				yield break;
			}
			obj = www.assetBundle;
			break;
		}
		case LoadTask.LoadType.asset:
		{
			AssetBundleRequest abr = ((!(task.type != null)) ? task.bundle.LoadAssetAsync(task.assetName) : task.bundle.LoadAssetAsync(task.assetName, task.type));
			yield return abr;
			if (abr.asset == null)
			{
				Debugger.LogError("could not found object: " + task.assetName + " in assetbundle" + task.bundle.name);
				yield break;
			}
			obj = abr.asset;
			break;
		}
		}
		task.callback(obj);
	}

	public UnityEngine.Object LoadSync(string bundlePath, string assetName, Type type)
	{
		bundlePath = bundlePath + "/" + assetName;
		AssetBundle assetBundle = LoadAssetBundleSyncWithCache(bundlePath);
		if (!assetBundle)
		{
			Debugger.LogWarning("getAssetSync: cound not load assetbundle : " + bundlePath + " " + assetName);
			return null;
		}
		Retain(bundlePath, assetBundle);
		return LoadAssetSync(assetBundle, assetName, type);
	}

	public AssetBundle LoadAssetBundleSyncWithCache(string bundlePath)
	{
		if (!assetBundleMap.Contains(bundlePath))
		{
			Debugger.LogWarning("getAssetSync: cound not found assetbundle at manifest: " + bundlePath);
			return null;
		}
		AssetBundle assetBundle = null;
		AssetBundleRef value = null;
		if (cachedBundles.TryGetValue(bundlePath, out value))
		{
			return value.assetBundle;
		}
		string[] allDependencies = manifest.GetAllDependencies(bundlePath);
		for (int i = 0; i < allDependencies.Length; i++)
		{
			LoadAssetBundleSync(allDependencies[i]);
		}
		return LoadAssetBundleSync(bundlePath);
	}
}
