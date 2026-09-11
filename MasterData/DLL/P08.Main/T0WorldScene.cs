using System.Collections;
using Cinemachine;
using CriWare;
using P08.Gamepad;
using P08.SimBusiness;
using T0World;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

public class T0WorldScene : T0WorldSceneLoader
{
	private bool _isResetPlayerPosAfterSceneLoad;

	private Vector3 _playerPosAfterSceneLoad;

	private Vector3 _playerRotAfterSceneLoad;

	private static T0WorldScene mScene;

	public T0WorldCameraManager cameraManager;

	public T0WorldAgentManager agentManager;

	public T0WorldInteractionManager interactionManager;

	public T0CaptureManagerBase captureManager;

	public T0WorldDataBaseContext dataContext;

	public T0WorldMapData mapData;

	public CinemachineBrain chineBrain;

	public static T0WorldScene Scene => mScene;

	public T0WorldUIBase mWorldUI { get; private set; }

	private string GetSceneName(string scenePath)
	{
		int num = scenePath.LastIndexOf('/');
		return scenePath.Substring(num + 1);
	}

	public void GotoScene(string sceneName, int sceneID)
	{
		T0SDKSystem.SendSDKData(T0WorldConst.SDKInterationTypeEnum.SCENE_CHANGE);
		_isResetPlayerPosAfterSceneLoad = false;
		StartCoroutine(LoadScene(sceneName, sceneID));
	}

	public void GotoScene(string sceneName, int sceneID, Vector3 playerPos, Vector3 playerRot)
	{
		T0SDKSystem.SendSDKData(T0WorldConst.SDKInterationTypeEnum.SCENE_CHANGE);
		_isResetPlayerPosAfterSceneLoad = true;
		_playerPosAfterSceneLoad = playerPos;
		_playerRotAfterSceneLoad = playerRot;
		StartCoroutine(LoadScene(sceneName, sceneID));
	}

	private IEnumerator LoadSceneAsset()
	{
		sceneName = (t0SceneName = GetSceneName(t0SceneName));
		scenePath = "Levels/" + t0SceneName;
		AssetBundleLoadOperation ops = Asset.LoadLevelAsync(scenePath, isAddtive: true);
		yield return null;
		while (!ops.IsDone())
		{
			yield return null;
		}
		LoadMapSceneData();
		yield return null;
	}

	public IEnumerator LoadScene(string nextSceneName, int sceneID)
	{
		ExitCurrentScene();
		t0SceneID = sceneID;
		sceneName = (t0SceneName = GetSceneName(t0SceneName));
		scenePath = "Levels/" + t0SceneName;
		if (t0SceneName != nextSceneName)
		{
			AsyncOperation op = SceneManager.UnloadSceneAsync(t0SceneName);
			while (!op.isDone)
			{
				yield return null;
			}
			Asset.Unload(scenePath);
			U3DUtil.ClearMemory();
			sceneName = (t0SceneName = nextSceneName);
			OnSceneEnter();
			IEnumerator itor = LoadSceneAsset();
			while (itor.MoveNext())
			{
				yield return itor.Current;
			}
		}
		else
		{
			OnSceneEnter();
		}
		OnSceneLoaded();
		T0WorldCreator.GetLoadingInst()?.CloseLoadUI();
		yield return null;
		LuaHelper.CallFunction("T0WorldUIShow");
		RegisterUICamera();
	}

	public void ExitCurrentScene()
	{
		Scene.interactionManager.InteractContext.ClearFocusEvent();
		Scene.agentManager.CharacteraAgent?.ClearEvent();
		Scene.agentManager.CharacteraAgent?.CharacterBoard.CloseAI();
		cameraManager?.Dispose();
		agentManager?.Dispose();
		interactionManager?.Dispose();
		captureManager?.Dispose();
		AudioManager.Instance.StopAll();
		cameraManager = null;
		agentManager = null;
		interactionManager = null;
		captureManager = null;
		T0SDKSystem.SendSDKData(T0WorldConst.SDKInterationTypeEnum.EXIT_SCENE);
		dataContext?.Dispose();
		mWorldUI?.Dispose();
		mWorldUI = null;
		LuaHelper.CallFunction("T0ExitWorldSecene");
	}

	public override void OnSceneEnter()
	{
		base.OnSceneEnter();
		EnterScene();
		T0SDKSystem.SendSDKData(T0WorldConst.SDKInterationTypeEnum.ENTER_SCENE);
	}

	public override void OnSceneLoaded()
	{
		base.OnSceneLoaded();
		InitAStar();
		Scene.agentManager.CharacteraAgent?.CharacterBoard.InitAI();
		if (agentManager?.agents == null)
		{
			return;
		}
		foreach (T0WorldAgent agent in agentManager.agents)
		{
			agent?.EnterInterationState(T0InterationTreeType.DEBUT);
		}
	}

	public override void CloseLoadUI()
	{
		base.CloseLoadUI();
	}

	public override void OnSceneExit(NScene nextScene)
	{
		ExitCurrentScene();
		int num = sceneName.LastIndexOf('/');
		string text = sceneName.Substring(num + 1);
		base.OnSceneExit(nextScene);
		GameObject[] rootGameObjects = SceneManager.GetSceneByName(text).GetRootGameObjects();
		for (int i = 0; i < rootGameObjects.Length; i++)
		{
			Object.DestroyImmediate(rootGameObjects[i]);
		}
	}

	public override IEnumerator OnLoadCoroutine()
	{
		InitCommonContent();
		IEnumerator itor = LoadSceneAsset();
		while (itor.MoveNext())
		{
			yield return itor.Current;
		}
		Scene sceneByName = SceneManager.GetSceneByName("Common");
		if (sceneByName.IsValid())
		{
			SceneManager.SetActiveScene(sceneByName);
		}
		else
		{
			Debug.LogError("can't find scene by path: " + t0SceneName);
		}
		LuaHelper.CallFunction("T0WorldUIShow");
		RegisterUICamera();
		yield return null;
	}

	public override IEnumerator OnSceneReadyCoroutine()
	{
		while (CheckCameraIsBlending())
		{
			yield return null;
		}
	}

	public bool CheckCameraIsBlending()
	{
		if (chineBrain != null)
		{
			return chineBrain.IsBlending;
		}
		return false;
	}

	private void RegisterUICamera()
	{
		if (!(mWorldUI == null))
		{
			mWorldUI.uiCamera.RegisterCamera();
		}
	}

	public void InitCommonContent()
	{
		T0EntityContent = new GameObject("T0EntityContent").transform;
		GameObject gameObject = Asset.Instantiate(T0WorldTools.PlayerAssetPath);
		gameObject.transform.SetParent(T0EntityContent);
		player = gameObject.GetComponent<T0WorldPlayer>();
		T0WorldFreeLookCamera.Create();
	}

	public void LoadMapSceneData()
	{
		LoadMapData();
		if (_isResetPlayerPosAfterSceneLoad)
		{
			player.SetPosAndRot(_playerPosAfterSceneLoad, _playerRotAfterSceneLoad);
			_isResetPlayerPosAfterSceneLoad = false;
		}
		else
		{
			player.SetPosAndRot(mapData.playerStartPos, mapData.playerStartRot);
		}
	}

	public void ChangeSwitchCursor(bool value)
	{
		if (CheckGamePadTypeIsMeet())
		{
			LuaForCursor.SwitchCursor(value);
		}
	}

	public bool CheckGamePadTypeIsMeet()
	{
		En_GamepadType gamepadType = (En_GamepadType)LuaForGamepad.GetGamepadType();
		if (gamepadType == En_GamepadType.Xbox || gamepadType == En_GamepadType.PS4 || gamepadType == En_GamepadType.KeyMouse)
		{
			return true;
		}
		return false;
	}

	public bool CheckIsCanSwitchCursor()
	{
		if (mScene == null)
		{
			return false;
		}
		if (captureManager != null && captureManager.captureContext != null && captureManager.captureContext.isOpenCaptureMode)
		{
			return false;
		}
		return true;
	}

	private void InitSceneData()
	{
		cameraManager = new T0WorldCameraManager();
		cameraManager.Init();
		agentManager = new T0WorldAgentManager();
		agentManager.Init();
		interactionManager = new T0WorldInteractionManager();
		interactionManager.Init();
		captureManager = T0WorldCreator.CreateCaptureManager();
		captureManager.Init();
		dataContext = T0WorldCreator.CreateDataBaseContext();
		dataContext.Init();
	}

	public void EnterScene()
	{
		mScene = this;
		chineBrain = U3DUtil.Get<CinemachineBrain>(Camera.main.gameObject);
		U3DUtil.Get<PhysicsRaycaster>(Camera.main.gameObject);
		InitSceneData();
		LuaHelper.CallFunction("T0EnterWordScene", characterID, t0SceneID);
	}

	public void Update()
	{
		if (!(mScene == null))
		{
			cameraManager?.Tick();
			agentManager?.Tick();
		}
	}

	public void LateUpdate()
	{
		if (!(mScene == null))
		{
			captureManager?.LateTick();
		}
	}

	public void RegisterWorldUI(T0WorldUIBase worldUI)
	{
		mWorldUI = worldUI;
	}

	public void LoadMapData()
	{
		if (Scene.characterID == 108502)
		{
			mapData = Asset.Load<T0WorldMapData>(T0WorldTools.MapAssetPath);
		}
		else
		{
			T0WorldMainData t0WorldMainData = Asset.Load<T0WorldMainData>(T0WorldTools.MapAssetPath);
			int num = ((t0SceneID > 0) ? t0SceneID : t0WorldMainData.defaultSceneID);
			foreach (T0WorldMapData mapData in t0WorldMainData.mapDataList)
			{
				if (mapData.sceneID == num)
				{
					this.mapData = mapData;
					break;
				}
			}
		}
		if (this.mapData != null)
		{
			agentManager.InitAgentData(this.mapData);
		}
	}

	protected override void OnLowMemory()
	{
		Debug.LogWarning("T0 Low Memory - Before Cleanup");
		Debug.LogWarning($"T0 Low Memory - Cri Status\n\tfs={Common.GetFsMemoryUsage()}\n\tatom={Common.GetAtomMemoryUsage()}\n\tmana={Common.GetManaMemoryUsage()}");
		for (int i = 0; i < agentManager.agents.Count; i++)
		{
			agentManager.agents[i].OnLowMemory();
		}
		ClearAudioCache();
		Debug.LogWarning("T0 Low Memory - After Cleanup");
		Debug.LogWarning($"T0 Low Memory - Cri Status\n\tfs={Common.GetFsMemoryUsage()}\n\tatom={Common.GetAtomMemoryUsage()}\n\tmana={Common.GetManaMemoryUsage()}");
	}

	public void InitAStar()
	{
		if (Scene.characterID == 108502)
		{
			GameObject gameObject = GameObject.Find("Astar");
			if (gameObject == null)
			{
				gameObject = Asset.Instantiate("T0World/Common/Astar");
				gameObject.transform.SetParent(Scene.T0EntityContent);
			}
			SceneNavSurface component = gameObject.GetComponent<SceneNavSurface>();
			string[] array = t0SceneName.Split('/');
			string path = ((array.Length <= 1) ? ("Map/" + t0SceneName + "_graph.bytes") : ("Map/" + array[array.Length - 1] + "_graph.bytes"));
			TextAsset textAsset = Asset.Load<TextAsset>(path);
			if (textAsset != null)
			{
				byte[] bytes = textAsset.bytes;
				component.LoadAstarPath(ref bytes, rescan: false);
			}
		}
	}
}
