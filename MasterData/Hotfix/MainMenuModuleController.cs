using System;
using System.Collections;
using System.Collections.Generic;
using Nova.Hotfix;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MainMenuModuleController : ModuleController<MainMenuModuleController>
{
	[Serializable]
	public class SceneConfig
	{
		public string sceneConfigName;

		public string sceneFullPath;

		public SceneConfig(string sceneConfigName, string sceneFullPath)
		{
			this.sceneConfigName = sceneConfigName;
			this.sceneFullPath = sceneFullPath;
		}
	}

	private List<SceneConfig> scenePathConfig;

	private Dictionary<string, Scene> loadedScenes = new Dictionary<string, Scene>();

	private int activeSceneRc;

	public override void OnEnter(Action flowCallback)
	{
		MonoSingleton<GameCameraStackManager>.Instance.StopMainCameraBlackScreenTransition(0f);
		scenePathConfig = new List<SceneConfig>();
		List<FormationScene> formationSceneData = Singleton<HotfixDataController>.Instance.FormationSceneData;
		for (int i = 0; i < formationSceneData.Count; i++)
		{
			scenePathConfig.Add(new SceneConfig(formationSceneData.get_Item(i).SceneName, formationSceneData.get_Item(i).Path));
		}
		flowCallback();
	}

	private IEnumerator LoadSceneOnEnter(SceneConfig sceneConifg, Action flowCallback)
	{
		yield return new WaitForEndOfFrame();
		MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(NormalizePath(sceneConifg.sceneFullPath), LoadSceneMode.Additive, LocalPhysicsMode.None, (string scenePath, int process) =>
		{
			if (process == 200)
			{
				string[] array = scenePath.Split('/');
				Scene sceneByName = SceneManager.GetSceneByName(array[array.Length - 1]);
				GameObject[] rootGameObjects = sceneByName.GetRootGameObjects();
				for (int i = 0; i < rootGameObjects.Length; i++)
				{
					rootGameObjects[i].SetActive(value: false);
				}
				loadedScenes.Add(sceneConifg.sceneConfigName, sceneByName);
				if (loadedScenes.Count == scenePathConfig.Count)
				{
					flowCallback();
				}
				return true;
			}
			return true;
		});
	}

	public override void OnExit(Action flowCallback)
	{
		if (loadedScenes.Count == 0)
		{
			flowCallback();
		}
		else
		{
			foreach (KeyValuePair<string, Scene> loadedScene in loadedScenes)
			{
				StartCoroutine(UnloadSceneOnExit(loadedScene.Value, flowCallback, loadedScene.Key));
			}
		}
		CameraProjectionModifier component = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.GetComponent<CameraProjectionModifier>();
		if (component != null)
		{
			component.enabled = false;
		}
	}

	private IEnumerator UnloadSceneOnExit(Scene scene, Action flowCallback, string sceneName)
	{
		yield return new WaitForEndOfFrame();
		loadedScenes.Remove(sceneName);
		MonoSingleton<SceneLoaderController>.Instance.UnloadAdditiveSceneAsync(scene, UnloadSceneOptions.None, (string path, int progess) =>
		{
			if (progess == 300 && loadedScenes.Count == 0)
			{
				flowCallback();
			}
			return true;
		}, unloadBundle: true);
	}

	public void LoadConfigScene(string configName, Action callback)
	{
		if (loadedScenes.ContainsKey(configName))
		{
			Debug.Log("场景已加载" + configName);
			callback();
			return;
		}
		for (int i = 0; i < scenePathConfig.Count; i++)
		{
			if (!(scenePathConfig.get_Item(i).sceneConfigName == configName))
			{
				continue;
			}
			int idx = i;
			MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(NormalizePath(scenePathConfig.get_Item(i).sceneFullPath), LoadSceneMode.Additive, LocalPhysicsMode.None, (string scenePath, int process) =>
			{
				if (process == 200)
				{
					string[] array = scenePath.Split('/');
					Scene sceneByName = SceneManager.GetSceneByName(array[array.Length - 1]);
					loadedScenes.Add(scenePathConfig.get_Item(idx).sceneConfigName, sceneByName);
					callback();
					return true;
				}
				return true;
			});
			return;
		}
		Debug.LogError("没有找到配置的场景" + configName);
		callback();
	}

	public void UnloadConfigScene(string configName, Action callback)
	{
		if (loadedScenes.TryGetValue(configName, out var value))
		{
			loadedScenes.Remove(configName);
			MonoSingleton<SceneLoaderController>.Instance.UnloadAdditiveSceneAsync(value, UnloadSceneOptions.None, (string path, int progess) =>
			{
				if (progess == 300)
				{
					callback();
				}
				return true;
			}, unloadBundle: true);
		}
		else
		{
			Debug.LogError("没有加载该场景" + configName);
			callback();
		}
	}

	public void ActiveScene(string sceneConfigName, Action<bool> callback)
	{
		if (!loadedScenes.ContainsKey(sceneConfigName))
		{
			LoadConfigScene(sceneConfigName, LoadSceneCallback);
		}
		else
		{
			LoadSceneCallback();
		}
		void LoadSceneCallback()
		{
			if (loadedScenes.TryGetValue(sceneConfigName, out var value))
			{
				GameObject[] rootGameObjects = value.GetRootGameObjects();
				for (int i = 0; i < rootGameObjects.Length; i++)
				{
					rootGameObjects[i].SetActive(value: true);
				}
				SceneManager.SetActiveScene(value);
				if (activeSceneRc < 1)
				{
					GameCameraStackManager instance = MonoSingleton<GameCameraStackManager>.Instance;
					CameraClearFlags? overrideCameraClearFlags = CameraClearFlags.Skybox;
					instance.SetupMainCameraRender(null, overrideCameraClearFlags);
					CameraProjectionModifier component = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.GetComponent<CameraProjectionModifier>();
					if (component != null)
					{
						component.enabled = true;
					}
				}
				activeSceneRc++;
				callback(obj: true);
			}
			else
			{
				Debug.LogError("没有找到加载的场景：" + sceneConfigName);
				callback(obj: false);
			}
		}
	}

	public void DeActiveScene(string sceneConfigName, Action<bool> unloadCallback)
	{
		if (!loadedScenes.TryGetValue(sceneConfigName, out var value))
		{
			return;
		}
		if (true)
		{
			UnloadConfigScene(sceneConfigName, () =>
			{
				Debug.Log("LowMeneryType unload scene：" + sceneConfigName);
				unloadCallback(obj: true);
			});
		}
		else
		{
			GameObject[] rootGameObjects = value.GetRootGameObjects();
			for (int num = 0; num < rootGameObjects.Length; num++)
			{
				rootGameObjects[num].SetActive(value: false);
			}
			unloadCallback(obj: true);
		}
		activeSceneRc--;
		if (activeSceneRc < 1)
		{
			CameraProjectionModifier component = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.GetComponent<CameraProjectionModifier>();
			if (component != null)
			{
				component.enabled = false;
			}
			MonoSingleton<GameCameraStackManager>.Instance.ShutdownMainCameraRender();
			Debug.Log("ActiveCurModuleScene" + MonoSingleton<GameController>.Instance.currentModuleName);
			SceneManager.SetActiveScene(SceneManager.GetSceneByName(MonoSingleton<GameController>.Instance.currentModuleName));
		}
	}

	public Transform GetMainMenuSceneRoot(string configName)
	{
		if (loadedScenes.TryGetValue(configName, out var value))
		{
			GameObject[] rootGameObjects = value.GetRootGameObjects();
			if (rootGameObjects.Length != 0)
			{
				return rootGameObjects[0].transform;
			}
			return null;
		}
		Debug.LogError("没有加载该场景" + configName);
		return null;
	}

	public string NormalizePath(string path)
	{
		path = path.Replace('\\', '/');
		return path;
	}
}
