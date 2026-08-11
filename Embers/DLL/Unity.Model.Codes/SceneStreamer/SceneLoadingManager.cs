#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections;
using System.Collections.Generic;
using Ase;
using GameFramework;
using GameFramework.Resource;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace SceneStreamer;

public class SceneLoadingManager
{
	private enum LoadingManagerState
	{
		Loading,
		Unloading
	}

	private enum SceneLoadingType
	{
		SceneAddtive,
		SceneSplit
	}

	private struct SceneLoadingData
	{
		public SceneLoadingType sceneLoadingType;

		public string SceneName;

		public SceneHandler sceneHandler;
	}

	private class SceneLoadingOperation
	{
		public Action<string, SceneLoadingOperation> OnComplete;

		public Action<SceneLoadingOperation> OnFailed;

		public void LoadingSuccessed(string sceneassetname, float duration, object userdata)
		{
			if (OnComplete != null)
			{
				OnComplete(sceneassetname, this);
			}
		}

		public void LoadingFailed(string sceneassetname, LoadResourceStatus status, string errormessage, object userdata)
		{
			if (OnFailed != null)
			{
				OnFailed(this);
			}
		}

		public void OnException()
		{
			if (OnFailed != null)
			{
				OnFailed(this);
			}
		}

		public void UnLoadingSuccessed(string sceneassetname, object userdata)
		{
			if (OnComplete != null)
			{
				OnComplete(sceneassetname, this);
			}
		}

		public void LoadingUpdate(string sceneassetname, float progress, object userdata)
		{
		}

		public void UnLoadingFailed(string sceneassetname, object userdata)
		{
			if (OnFailed != null)
			{
				OnFailed(this);
			}
		}

		public void Clear()
		{
			OnFailed = null;
			OnComplete = null;
		}
	}

	private BvhStreamer streamer;

	private List<SceneLoadingData> scenesToUnload = new List<SceneLoadingData>();

	private List<SceneLoadingData> scenesToLoad = new List<SceneLoadingData>();

	private List<SceneLoadingOperation> asyncOperations = new List<SceneLoadingOperation>();

	private LoadingManagerState loadingManagerState;

	private bool operationStarted;

	public BvhStreamer Streamer => streamer;

	public int ScenesToUnloadCount => scenesToUnload.Count;

	public int ScenesToLoadCount => scenesToLoad.Count;

	public int AsyncOperationsCount => asyncOperations.Count;

	public SceneLoadingManager(BvhStreamer streamer)
	{
		this.streamer = streamer;
	}

	public void HandleUpdate()
	{
		if (!operationStarted && asyncOperations.Count <= 0 && !streamer.TryUpdateLightprobe())
		{
			HandleUnLoading();
			HandleLoading();
		}
	}

	private void HandleLoading()
	{
		if (loadingManagerState == LoadingManagerState.Loading)
		{
			if (scenesToLoad.Count > 0)
			{
				operationStarted = true;
				Streamer.StartCoroutine(LoadAsync());
			}
			if (scenesToLoad.Count == 0)
			{
				loadingManagerState = LoadingManagerState.Unloading;
			}
		}
	}

	private void HandleUnLoading()
	{
		if (loadingManagerState == LoadingManagerState.Unloading)
		{
			if (scenesToLoad.Count > 0)
			{
				loadingManagerState = LoadingManagerState.Loading;
			}
			else if (scenesToUnload.Count > 0)
			{
				operationStarted = true;
				Streamer.StartCoroutine(UnloadAsync());
			}
		}
	}

	private IEnumerator LoadAsync()
	{
		for (int i = 0; i < scenesToLoad.Count; i++)
		{
			SceneLoadingOperation sceneLoadingOperation = new SceneLoadingOperation();
			if (scenesToLoad[i].sceneLoadingType == SceneLoadingType.SceneSplit)
			{
				SceneHandler split = scenesToLoad[i].sceneHandler;
				sceneLoadingOperation.OnComplete = (Action<string, SceneLoadingOperation>)Delegate.Combine(sceneLoadingOperation.OnComplete, (Action<string, SceneLoadingOperation>)delegate(string sceneAssetName, SceneLoadingOperation operation)
				{
					SceneLoadComplete(sceneAssetName, split);
					OnOperationDone(operation);
				});
				sceneLoadingOperation.OnFailed = (Action<SceneLoadingOperation>)Delegate.Combine(sceneLoadingOperation.OnFailed, (Action<SceneLoadingOperation>)delegate(SceneLoadingOperation operation)
				{
					SceneLoadFailed(split);
					OnOperationDone(operation);
				});
				asyncOperations.Add(sceneLoadingOperation);
				try
				{
					GameEntry.Scene.LoadSceneByPackage(split.sceneName, "Scenes", LoadSceneMode.Additive, new LoadSceneCallbacks(sceneLoadingOperation.LoadingSuccessed, sceneLoadingOperation.LoadingFailed));
				}
				catch (Exception ex)
				{
					sceneLoadingOperation.OnException();
					Log.Error("切片场景加载失败：[" + split.sceneName + "," + ex.Message + "]");
				}
			}
			else
			{
				sceneLoadingOperation.OnComplete = (Action<string, SceneLoadingOperation>)Delegate.Combine(sceneLoadingOperation.OnComplete, (Action<string, SceneLoadingOperation>)delegate(string sceneAssetName, SceneLoadingOperation operation)
				{
					OnOperationDone(operation);
				});
				sceneLoadingOperation.OnFailed = (Action<SceneLoadingOperation>)Delegate.Combine(sceneLoadingOperation.OnFailed, (Action<SceneLoadingOperation>)delegate(SceneLoadingOperation operation)
				{
					OnOperationDone(operation);
				});
				asyncOperations.Add(sceneLoadingOperation);
				try
				{
					GameEntry.Scene.LoadSceneByPackage(scenesToLoad[i].SceneName, "Scenes", LoadSceneMode.Additive, new LoadSceneCallbacks(sceneLoadingOperation.LoadingSuccessed, sceneLoadingOperation.LoadingFailed));
				}
				catch (Exception ex2)
				{
					sceneLoadingOperation.OnException();
					Log.Error("切片场景加载失败：[" + scenesToLoad[i].SceneName + "," + ex2.Message + "]");
				}
			}
			yield return null;
		}
		scenesToLoad.Clear();
		operationStarted = false;
	}

	private void SceneLoadComplete(string sceneName, SceneHandler handler)
	{
		Streamer.StartCoroutine(SceneLoadCompleteAsync(sceneName, handler));
	}

	private IEnumerator SceneLoadCompleteAsync(string sceneName, SceneHandler handler)
	{
		GameObject[] rootGameObjects = SceneManager.GetSceneByPath(sceneName).GetRootGameObjects();
		if (rootGameObjects.Length != 0)
		{
			rootGameObjects[0].SetActive(value: false);
			yield return null;
			Streamer.OnSceneLoaded(rootGameObjects[0], handler);
		}
	}

	private void SceneLoadFailed(SceneHandler handler)
	{
		Streamer.StartCoroutine(SceneLoadFailedAsync(handler));
	}

	private IEnumerator SceneLoadFailedAsync(SceneHandler handler)
	{
		yield return null;
		Streamer.OnSceneLoadedFailed(handler);
	}

	private void OnOperationDone(SceneLoadingOperation asyncOperation)
	{
		Streamer.StartCoroutine(RemoveAsyncOperation(asyncOperation));
	}

	private IEnumerator RemoveAsyncOperation(SceneLoadingOperation asyncOperation)
	{
		yield return null;
		yield return null;
		asyncOperations.Remove(asyncOperation);
		asyncOperation.Clear();
	}

	private IEnumerator UnloadAsync()
	{
		yield return null;
		for (int i = 0; i < scenesToUnload.Count; i++)
		{
			SceneHandler handler = scenesToUnload[i].sceneHandler;
			Scene scene = handler.scene;
			SceneLoadingOperation sceneLoadingOperation = new SceneLoadingOperation();
			sceneLoadingOperation.OnComplete = (Action<string, SceneLoadingOperation>)Delegate.Combine(sceneLoadingOperation.OnComplete, (Action<string, SceneLoadingOperation>)delegate(string sceneAssetName, SceneLoadingOperation operation)
			{
				SceneUnLoadComplete(handler);
				OnOperationDone(operation);
			});
			sceneLoadingOperation.OnFailed = (Action<SceneLoadingOperation>)Delegate.Combine(sceneLoadingOperation.OnFailed, (Action<SceneLoadingOperation>)delegate(SceneLoadingOperation operation)
			{
				SceneUnLoadComplete(handler);
				OnOperationDone(operation);
			});
			asyncOperations.Add(sceneLoadingOperation);
			try
			{
				if (GameEntry.Scene.SceneIsLoaded(scene.name))
				{
					GameEntry.Scene.UnloadSceneByPackage(scene.path, "Scenes", new UnloadSceneCallbacks(sceneLoadingOperation.UnLoadingSuccessed, sceneLoadingOperation.UnLoadingFailed));
				}
				else
				{
					sceneLoadingOperation.OnException();
				}
			}
			catch (Exception ex)
			{
				sceneLoadingOperation.OnException();
				Log.Error("切片场景加载失败：[" + scene.path + "," + ex.Message + "]");
			}
			yield return null;
		}
		scenesToUnload.Clear();
		operationStarted = false;
	}

	private void SceneUnLoadComplete(SceneHandler handler)
	{
		Streamer.StartCoroutine(SceneUnLoadCompleteAsync(handler));
	}

	private IEnumerator SceneUnLoadCompleteAsync(SceneHandler handler)
	{
		yield return null;
		Streamer.OnSceneUnLoaded(handler);
	}

	public void UnloadSceneAsync(SceneHandler handler)
	{
		scenesToUnload.Add(new SceneLoadingData
		{
			sceneLoadingType = SceneLoadingType.SceneSplit,
			SceneName = handler.sceneName,
			sceneHandler = handler
		});
	}

	public void UnloadSceneAsync(string sceneName)
	{
		scenesToUnload.Add(new SceneLoadingData
		{
			sceneLoadingType = SceneLoadingType.SceneAddtive,
			SceneName = sceneName
		});
	}

	public void LoadSceneAsync(SceneHandler handler)
	{
		scenesToLoad.Add(new SceneLoadingData
		{
			sceneLoadingType = SceneLoadingType.SceneSplit,
			SceneName = handler.sceneName,
			sceneHandler = handler
		});
	}

	public void LoadSceneAsync(string sceneName)
	{
		scenesToLoad.Add(new SceneLoadingData
		{
			sceneLoadingType = SceneLoadingType.SceneAddtive,
			SceneName = sceneName
		});
	}
}
