using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ES3AutoSaveMgr : MonoBehaviour
{
	public enum LoadEvent
	{
		None,
		Awake,
		Start
	}

	public enum SaveEvent
	{
		None,
		OnApplicationQuit,
		OnApplicationPause
	}

	public static ES3AutoSaveMgr _current;

	public string key = Guid.NewGuid().ToString();

	public SaveEvent saveEvent = SaveEvent.OnApplicationQuit;

	public LoadEvent loadEvent = LoadEvent.Awake;

	public ES3SerializableSettings settings = new ES3SerializableSettings("AutoSave.es3", ES3.Location.Cache);

	public HashSet<ES3AutoSave> autoSaves = new HashSet<ES3AutoSave>();

	public static ES3AutoSaveMgr Current
	{
		get
		{
			if (_current == null)
			{
				GameObject[] rootGameObjects = SceneManager.GetActiveScene().GetRootGameObjects();
				GameObject[] array = rootGameObjects;
				foreach (GameObject gameObject in array)
				{
					if (gameObject.name == "Easy Save 3 Manager")
					{
						return _current = gameObject.GetComponent<ES3AutoSaveMgr>();
					}
				}
				array = rootGameObjects;
				for (int i = 0; i < array.Length; i++)
				{
					if ((_current = array[i].GetComponentInChildren<ES3AutoSaveMgr>()) != null)
					{
						return _current;
					}
				}
			}
			return _current;
		}
	}

	public static ES3AutoSaveMgr Instance => Current;

	public void Save()
	{
		if (autoSaves == null || autoSaves.Count == 0)
		{
			return;
		}
		if (settings.location == ES3.Location.Cache && !ES3.FileExists(settings))
		{
			ES3.CacheFile(settings);
		}
		if (autoSaves == null || autoSaves.Count == 0)
		{
			ES3.DeleteKey(key, settings);
		}
		else
		{
			List<GameObject> list = new List<GameObject>();
			foreach (ES3AutoSave autoSafe in autoSaves)
			{
				if (autoSafe != null && autoSafe.enabled)
				{
					list.Add(autoSafe.gameObject);
				}
			}
			ES3.Save(key, list.OrderBy((GameObject x) => GetDepth(x.transform)).ToArray(), settings);
		}
		if (settings.location == ES3.Location.Cache && ES3.FileExists(settings))
		{
			ES3.StoreCachedFile(settings);
		}
	}

	public void Load()
	{
		try
		{
			if (settings.location == ES3.Location.Cache && !ES3.FileExists(settings))
			{
				ES3.CacheFile(settings);
			}
		}
		catch
		{
		}
		ES3.Load(key, new GameObject[0], settings);
	}

	private void Start()
	{
		if (loadEvent == LoadEvent.Start)
		{
			Load();
		}
	}

	public void Awake()
	{
		GetAutoSaves();
		if (loadEvent == LoadEvent.Awake)
		{
			Load();
		}
	}

	private void OnApplicationQuit()
	{
		if (saveEvent == SaveEvent.OnApplicationQuit)
		{
			Save();
		}
	}

	private void OnApplicationPause(bool paused)
	{
		if ((saveEvent == SaveEvent.OnApplicationPause || (Application.isMobilePlatform && saveEvent == SaveEvent.OnApplicationQuit)) & paused)
		{
			Save();
		}
	}

	public static void AddAutoSave(ES3AutoSave autoSave)
	{
		if (Current != null)
		{
			Current.autoSaves.Add(autoSave);
		}
	}

	public static void RemoveAutoSave(ES3AutoSave autoSave)
	{
		if (Current != null)
		{
			Current.autoSaves.Remove(autoSave);
		}
	}

	public void GetAutoSaves()
	{
		autoSaves = new HashSet<ES3AutoSave>();
		GameObject[] rootGameObjects = base.gameObject.scene.GetRootGameObjects();
		foreach (GameObject gameObject in rootGameObjects)
		{
			autoSaves.UnionWith(gameObject.GetComponentsInChildren<ES3AutoSave>(includeInactive: true));
		}
	}

	private static int GetDepth(Transform t)
	{
		int num = 0;
		while (t.parent != null)
		{
			t = t.parent;
			num++;
		}
		return num;
	}
}
