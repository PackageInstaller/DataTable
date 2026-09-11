using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneLoadAndUnloadManager : MonoBehaviour
{
	public static SceneLoadAndUnloadManager mInstance;

	private static HashSet<string> loadedAssets = new HashSet<string>();

	public static SceneLoadAndUnloadManager Instance
	{
		get
		{
			if (mInstance == null)
			{
				Create();
			}
			return mInstance;
		}
	}

	private static void Create()
	{
		GameObject obj = new GameObject("SceneLoadAndUnloadManager", typeof(SceneLoadAndUnloadManager));
		UnityEngine.Object.DontDestroyOnLoad(obj);
		mInstance = U3DUtil.Get<SceneLoadAndUnloadManager>(obj);
	}

	public void ChangeScene(string fullPath, string unloadScene, Action callBack)
	{
		AsyncOperation unloadOp = null;
		if (unloadScene.IsNotNullOrEmpty())
		{
			GameObject gameObject = GameObject.Find(unloadScene);
			if (gameObject != null && gameObject.GetComponent<SceneSetting>() != null)
			{
				MeshFilter[] componentsInChildren = gameObject.transform.GetComponentsInChildren<MeshFilter>();
				foreach (MeshFilter meshFilter in componentsInChildren)
				{
					if (meshFilter.sharedMesh != null && meshFilter.sharedMesh.name.StartsWith("Combined"))
					{
						UnityEngine.Object.DestroyImmediate(meshFilter.sharedMesh);
					}
				}
			}
			unloadOp = SceneManager.UnloadSceneAsync(unloadScene);
		}
		StartCoroutine(LoadSceneHander(fullPath, callBack, unloadScene, unloadOp));
	}

	private IEnumerator LoadSceneHander(string loadScene, Action callBack, string unloadScene, AsyncOperation unloadOp)
	{
		AssetBundleLoadOperation ops = Asset.LoadLevelAsync(loadScene, isAddtive: true);
		while (!ops.IsDone())
		{
			yield return null;
		}
		Scene sceneByName = SceneManager.GetSceneByName("Common");
		if (sceneByName.IsValid())
		{
			SceneManager.SetActiveScene(sceneByName);
		}
		loadedAssets.Add(loadScene);
		callBack?.Invoke();
		if (unloadOp == null)
		{
			yield break;
		}
		while (!unloadOp.isDone)
		{
			yield return null;
		}
		string item = null;
		foreach (string loadedAsset in loadedAssets)
		{
			if (loadedAsset.EndsWith(unloadScene))
			{
				Asset.Unload(loadedAsset);
				item = loadedAsset;
			}
		}
		loadedAssets.Remove(item);
	}
}
