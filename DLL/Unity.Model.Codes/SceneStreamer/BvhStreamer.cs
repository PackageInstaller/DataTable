#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace SceneStreamer;

public class BvhStreamer : MonoBehaviour
{
	public bool streamerActive = true;

	[Header("Settings")]
	public float positionCheckTime = 0.1f;

	public float destroyTileDelay = 2f;

	public int sceneLoadWaitFrames = 2;

	public SceneCollectionManager layer;

	public Transform player;

	public bool initialized;

	public int tilesToLoad = int.MaxValue;

	public int tilesLoaded;

	[HideInInspector]
	public bool showLoadingScreen;

	public Action<int, int, float> showLoadingCallback;

	private List<SceneHandler> scenesToLoad = new List<SceneHandler>();

	private bool canTetrahedralize;

	private int sceneLoadFrameNext;

	private bool sceneLoadFramesNextWaited;

	public static SceneLoadingManager loadingManager;

	private static bool canUnload = true;

	private static float waitTillNextUnload = 20f;

	private static bool unloadNext = false;

	public bool tetrahedralizeAsync;

	public bool needsRetetrahedralization;

	public float LoadingProgress
	{
		get
		{
			if (tilesToLoad <= 0)
			{
				return 1f;
			}
			return (float)tilesLoaded / (float)tilesToLoad;
		}
	}

	public void InitStreamer()
	{
	}

	public void StartStreamer()
	{
		_ = loadingManager;
		loadingManager = new SceneLoadingManager(this);
		if (layer != null)
		{
			PrepareScenesArray();
			StartCoroutine(PositionChecker());
		}
		LightProbes.tetrahedralizationCompleted += TetrahedralizationCompleted;
		LightProbes.needsRetetrahedralization += NeedsRetetrahedralization;
	}

	private void NeedsRetetrahedralization()
	{
		needsRetetrahedralization = true;
	}

	private async void TetrahedralizationCompleted()
	{
		await UniTask.Delay(500);
		tetrahedralizeAsync = false;
	}

	private void PrepareScenesArray()
	{
		layer.PrepareSceneBvhSpace();
	}

	private void Update()
	{
		LoadLevelAsyncManage();
		loadingManager?.HandleUpdate();
	}

	private void LoadLevelAsyncManage()
	{
		if (scenesToLoad.Count <= 0)
		{
			return;
		}
		if (LoadingProgress < 1f || (sceneLoadFramesNextWaited && sceneLoadFrameNext <= 0))
		{
			sceneLoadFramesNextWaited = false;
			sceneLoadFrameNext = sceneLoadWaitFrames;
			int num = 0;
			while (scenesToLoad.Count > 0 && num < scenesToLoad.Count)
			{
				SceneHandler sceneHandler = scenesToLoad[num];
				if (sceneHandler.sceneCollectionManager.currentlySceneLoading < sceneHandler.sceneCollectionManager.maxParallelSceneLoading)
				{
					scenesToLoad.Remove(sceneHandler);
					sceneHandler.sceneCollectionManager.currentlySceneLoading++;
					loadingManager.LoadSceneAsync(sceneHandler);
					num--;
				}
				num++;
			}
		}
		else
		{
			sceneLoadFramesNextWaited = true;
			sceneLoadFrameNext--;
		}
	}

	private IEnumerator PositionChecker()
	{
		while (true)
		{
			if (streamerActive && player != null)
			{
				CheckPositionTiles();
			}
			else
			{
				bool flag = false;
				if (layer.loadedScenes.Count > 0)
				{
					flag = true;
				}
				if (flag)
				{
					UnloadAllScenes();
				}
			}
			yield return new WaitForSeconds(positionCheckTime);
		}
	}

	public void CheckPositionTiles()
	{
		Vector3 position = player.position;
		bool flag = false;
		if (layer.CheckPosition(position))
		{
			flag = true;
		}
		if (flag)
		{
			SceneLoading();
			Invoke("SceneUnloading", destroyTileDelay);
		}
	}

	private void SceneLoading()
	{
		if (showLoadingScreen)
		{
			showLoadingScreen = false;
			if (tilesLoaded >= tilesToLoad)
			{
				tilesToLoad = int.MaxValue;
				tilesLoaded = 0;
			}
		}
		int num = 0;
		if (layer.active)
		{
			List<SceneHandler> list = layer.Query(player.position);
			SceneHandler sceneHandler = null;
			for (int i = 0; i < list.Count; i++)
			{
				sceneHandler = list[i];
				if (sceneHandler != null && !sceneHandler.loaded)
				{
					sceneHandler.loaded = true;
					scenesToLoad.Add(sceneHandler);
					layer.loadedScenes.Add(sceneHandler);
					num++;
				}
			}
		}
		tilesToLoad = num;
		initialized = true;
	}

	private void SceneUnloading()
	{
		List<SceneHandler> list = new List<SceneHandler>();
		AABBData other = new AABBData(player.position - layer.CheckSize * 0.5f, player.position + layer.CheckSize * 0.5f);
		float num = layer.loadedScenes.Count;
		for (int i = 0; (float)i < num; i++)
		{
			SceneHandler sceneHandler = layer.loadedScenes[i];
			if (!layer.active)
			{
				list.Add(sceneHandler);
			}
			else if (!sceneHandler.aabbData.IsIntersect(other) && sceneHandler.loaded && sceneHandler.loadingFinished)
			{
				list.Add(sceneHandler);
			}
		}
		UnloadScenes(list);
		list.Clear();
		UnloadAssets(this);
	}

	private void UnloadScenes(List<SceneHandler> scenesToDestroy)
	{
		foreach (SceneHandler item in scenesToDestroy)
		{
			item.loadingFinished = false;
			item.sceneCollectionManager.loadedScenes.Remove(item);
			item.ClearSceneGo();
			loadingManager.UnloadSceneAsync(item);
		}
	}

	public void UnloadAllScenes()
	{
		foreach (KeyValuePair<string, SceneHandler> item in layer.scenesArray)
		{
			if (item.Value.sceneGo != null)
			{
				try
				{
					loadingManager.UnloadSceneAsync(item.Value);
				}
				catch (Exception ex)
				{
					Log.Error(ex.Message);
				}
			}
			item.Value.loadingFinished = false;
			item.Value.ClearSceneGo();
		}
		layer.loadedScenes.Clear();
		UnloadAssets(this);
	}

	public static void UnloadAssets(BvhStreamer streamer)
	{
		if (canUnload)
		{
			canUnload = false;
			streamer.StartCoroutine(streamer.UnloadAssetsWait());
		}
		else
		{
			unloadNext = true;
		}
	}

	public IEnumerator UnloadAssetsWait()
	{
		do
		{
			unloadNext = false;
			yield return new WaitForSeconds(waitTillNextUnload);
		}
		while (unloadNext);
		canUnload = true;
	}

	public bool CheckUnLoadAllFinish()
	{
		foreach (KeyValuePair<string, SceneHandler> item in layer.scenesArray)
		{
			if (item.Value.loaded)
			{
				return false;
			}
		}
		return true;
	}

	public void OnSceneLoaded(GameObject rootGameObject, SceneHandler handler)
	{
		if (rootGameObject != null)
		{
			AddSceneGOMin(handler, rootGameObject);
		}
	}

	public void OnSceneLoadedFailed(SceneHandler handler)
	{
		handler.loaded = false;
		tilesLoaded++;
		if (showLoadingCallback != null)
		{
			showLoadingCallback(tilesLoaded, tilesToLoad, LoadingProgress);
		}
		handler.sceneCollectionManager.currentlySceneLoading--;
	}

	public void OnSceneUnLoaded(SceneHandler handler)
	{
		handler.loaded = false;
	}

	public void AddSceneGOMin(SceneHandler handler, GameObject sceneGO)
	{
		_ = handler.sceneCollectionManager;
		sceneGO.GetComponent<SceneSplitManager>();
		tilesLoaded++;
		if (showLoadingCallback != null)
		{
			showLoadingCallback(tilesLoaded, tilesToLoad, LoadingProgress);
		}
		handler.SetSceneGo(sceneGO);
		handler.scene = sceneGO.scene;
		handler.loadingFinished = true;
		handler.OnSceneActiveUpdate();
		handler.sceneCollectionManager.currentlySceneLoading--;
	}

	public void RemoveScene(SceneHandler handler)
	{
		handler.loaded = false;
	}

	public void OnSceneActive(string sceneName)
	{
		if (layer.scenesArray.TryGetValue(sceneName, out var value))
		{
			value?.OnSceneActive();
		}
	}

	public void OnSceneInActive(string sceneName)
	{
		if (layer.scenesArray.TryGetValue(sceneName, out var value))
		{
			value?.OnSceneInActive();
		}
	}

	public void SetCanTetrahedralize(bool canTetrahedralize)
	{
		this.canTetrahedralize = canTetrahedralize;
	}

	public void OnUpdateLightProbe()
	{
		if (!tetrahedralizeAsync && needsRetetrahedralization)
		{
			needsRetetrahedralization = false;
			if (canTetrahedralize)
			{
				tetrahedralizeAsync = true;
				LightProbes.TetrahedralizeAsync();
			}
		}
	}

	public bool TryUpdateLightprobe()
	{
		OnUpdateLightProbe();
		return tetrahedralizeAsync;
	}

	private void OnDrawGizmos()
	{
		layer?.OnDrawGizmos();
	}

	private void OnDestroy()
	{
		layer?.OnDestroy();
	}
}
