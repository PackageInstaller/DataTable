using System;
using System.Collections;
using UnityEngine;

public class NScene : MonoBehaviour, ISceneLoader
{
	public bool isLoaded;

	public bool isLoading;

	public bool isReady;

	public string sceneName;

	public string scenePath;

	public static DoubleMap<Type, string> mRegSceneTable = new DoubleMap<Type, string>();

	public virtual float Progress { get; set; }

	public static T Load<T>() where T : NScene
	{
		if (SceneDirector.Instance == null)
		{
			SceneDirector.Create();
		}
		return SceneDirector.Instance.Load<T>(typeof(T));
	}

	public static void RegSceneName<T>(string sceneName)
	{
		if (!mRegSceneTable.ContainsKey(typeof(T)))
		{
			if (string.IsNullOrEmpty(sceneName))
			{
				mRegSceneTable.Add(typeof(T), typeof(T).Name);
			}
			else
			{
				mRegSceneTable.Add(typeof(T), sceneName);
			}
		}
	}

	public static void Load(string sceneName)
	{
		if (SceneDirector.Instance == null)
		{
			SceneDirector.Create();
		}
		Type keyByValue = mRegSceneTable.GetKeyByValue(sceneName);
		if (keyByValue != null)
		{
			SceneDirector.Instance.Load(keyByValue).sceneName = sceneName;
		}
		else
		{
			Debug.LogError(sceneName + " 沒有场景类！");
		}
	}

	public static void Load(Type type)
	{
		if (SceneDirector.Instance == null)
		{
			SceneDirector.Create();
		}
		SceneDirector.Instance.Load(type);
	}

	public static NScene GetCurrentScene()
	{
		if (SceneDirector.Instance == null)
		{
			return null;
		}
		return SceneDirector.Instance.curScene;
	}

	public static Type GetLastScene()
	{
		return SceneDirector.Instance.LastSceneType;
	}

	public virtual void FastReload()
	{
		SceneDirector.Instance.FastReload();
	}

	public virtual void Reload()
	{
		SceneDirector.Instance.Reload();
	}

	public static bool IsLoaded<T>()
	{
		return SceneDirector.Instance.IsLoaded<T>();
	}

	public static bool IsHanding()
	{
		return SceneDirector.Instance.isHanding;
	}

	public virtual void OnBeginLoad()
	{
	}

	public virtual void ShowLoadUI()
	{
	}

	public virtual float ShowLoadUIDuration()
	{
		return 0f;
	}

	public virtual float EndLoadUIDuration()
	{
		return 0f;
	}

	public virtual float CloseLoadUIDuration()
	{
		return 0f;
	}

	public virtual void CloseLoadUI()
	{
	}

	public virtual void OnSceneEnter()
	{
	}

	public virtual void OnSceneExit(NScene nextScene)
	{
	}

	public virtual IEnumerator OnSceneRestartCoroutine(int sceneID)
	{
		yield return null;
	}

	public virtual IEnumerator OnLoadCoroutine()
	{
		yield return null;
	}

	public virtual void OnSceneLoaded()
	{
	}

	public virtual void OnSceneReady()
	{
	}

	public virtual IEnumerator OnSceneReadyCoroutine()
	{
		yield return null;
	}

	private void OnDestroy()
	{
		Debug.Log("OnDestroy");
	}
}
