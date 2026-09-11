using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using Config;
using FlowCanvas;
using Google.Protobuf;
using NetProcol;
using NodeCanvas.Framework;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class UIBattleScene : BattleScene
{
	private Action<StatisticsData> gameOverCallback;

	public override IEnumerator OnLoadCoroutine()
	{
		Debug.Log("======= Start Load Coroutine ======= ");
		Asset.Initialize();
		Debug.Log("======= Loading Config ======= ");
		BattleSceneLoader._isInitConfig = GlobalStaticLoader.sIsInitConfig;
		if (!BattleSceneLoader._isInitConfig)
		{
			TextAsset textAsset = Asset.Load<TextAsset>("Config");
			if (null == textAsset)
			{
				Debug.Log("Can't Load Config");
			}
			using (MemoryStream input = new MemoryStream(textAsset.bytes))
			{
				using BinaryReader binaryReader = new BinaryReader(input);
				ConfigHelper.GetInstance().Initialize(binaryReader);
			}
			Asset.Unload("Config");
			BattleSceneLoader._isInitConfig = true;
		}
		flowScripts.Clear();
		charList.Clear();
		if (ready == null || ready.SceneDataForExcehange == null || ready.SceneDataForExcehange.RoleDataInLua == null || ready.SceneDataForExcehange.RoleDataInLua.Count <= 0)
		{
			Debug.LogError("Role Data is null");
			ready = BattleSceneLoader.CreateDefaultReadyMessage();
		}
		Debug.Log("sceneid: " + ready.SceneDataForExcehange.MSceneID);
		mapConfig = ConfigHelper.GetInstance().GetConfig<SceneMap>(ready.SceneDataForExcehange.MSceneID);
		Debug.Log("加载BattlePanel " + Progress);
		string text = mapConfig.SpBattlePanelPath;
		if (string.IsNullOrEmpty(text))
		{
			text = "UI/BattlePanel";
		}
		GameObject gameObject = Asset.InstantiateWithoutCache(text, GameObject.Find("UICamera/Canvas/UIMain").transform);
		gameObject.name = "BattlePanel";
		battlePanelGameObject = gameObject;
		InjectUI(gameObject);
		yield return null;
		Debug.Log("加载暂停界面需要的资源 " + Progress);
		Asset.Load("Atlas/Setting");
		IEnumerator<RoleDataForExchangeInfo> enumerator = ready.SceneDataForExcehange.RoleDataInLua.GetEnumerator();
		while (enumerator.MoveNext())
		{
			int iD = enumerator.Current.ID;
			if (iD != 0)
			{
				Asset.Load("TextureConfig/Character/Icon/" + iD);
			}
		}
		GameObject gameObject2 = Asset.InstantiateWithoutCache("UI/MovieBlackBorder");
		if (gameObject2 != null)
		{
			gameObject2.name = "MovieBlackBorder";
			gameObject2.transform.SetParent(GameObject.Find("UICamera/Canvas/UIMain").transform, worldPositionStays: false);
		}
		GameObject gameObject3 = Asset.InstantiateWithoutCache("UI/BattleUIEffectPanel");
		if (gameObject3 != null)
		{
			gameObject3.name = "BattleUIEffectPanel";
			gameObject3.transform.SetParent(GameObject.Find("UICamera/Canvas/UIMain").transform, worldPositionStays: false);
			gameObject3.transform.SetAsFirstSibling();
		}
		yield return new WaitForEndOfFrame();
	}

	public override IEnumerator OnSceneReadyCoroutine()
	{
		BattleScene.InitWorldState(ClientSimulator.Instance.mSimContext.sEntityWorldState.status, ready);
		yield return null;
		RequestSimulator();
		while (!ClientSimulator.Instance.mWasSimRunning)
		{
			yield return null;
		}
		SetBattleCallback();
	}

	public void SetBattleCallback()
	{
		ClientSimulator.Instance.mSimContext.GetSimInterface().mGSRecvBattleResultFinishEvent = null;
		ISimulatorInferface simInterface = ClientSimulator.Instance.mSimContext.GetSimInterface();
		simInterface.mGSRecvBattleResultFinishEvent = (Action<int>)Delegate.Combine(simInterface.mGSRecvBattleResultFinishEvent, new Action<int>(OnGameOverEventHandler));
	}

	public static StatisticsData CalcStatisticsData(int result)
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
		StatisticsData data = worldSatetManager.data;
		worldSatetManager.CalcCurrentHp();
		bool result2 = result == 1;
		BattleResultForLua dataForLua = data.dataForLua;
		dataForLua.Result = result2;
		dataForLua.battleId = battleScene.ready.BattleID;
		dataForLua.loadMilliseconds = (int)(LoadingTime.GetInstance().finishedTime * 1000f - LoadingTime.GetInstance().startTime * 1000f);
		data.currentFrameNumber = worldSatetManager.currentFrameNumber;
		return data;
	}

	private void OnGameOverEventHandler(int result)
	{
		BattleResultForLua dataForLua = CalcStatisticsData(1).dataForLua;
		LuaHelper.CallFunction("SendQuitBattle", dataForLua, result == 3);
		OpenSettlement();
	}

	private void OpenSettlement()
	{
		GameObject gameObject = GameObject.Find("UICamera/Canvas");
		if (!(gameObject == null))
		{
			UnityEngine.CanvasGroup component = gameObject.GetComponent<UnityEngine.CanvasGroup>();
			component.alpha = 1f;
			component.interactable = true;
			component.blocksRaycasts = true;
			LuaHelper.CallFunction("ShowSettlement");
		}
	}

	public override IEnumerator OnSceneRestartCoroutine(int sceneID)
	{
		yield return new WaitForEndOfFrame();
		if (CommonProcessor.IsMultiplePlayerGameMode(mGameMode))
		{
			yield break;
		}
		onBattleSceneLoad = null;
		onShowPauseUI = null;
		onShowRecoverUI = null;
		FlowScriptController[] componentsInChildren = battlePanelGameObject.GetComponentsInChildren<FlowScriptController>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			flowScripts.Remove(componentsInChildren[i]);
		}
		UnityEngine.Object.Destroy(battlePanelGameObject);
		if (mBattleSimulator != null)
		{
			mBattleSimulator.Destroy();
			mBattleSimulator = null;
		}
		yield return null;
		yield return null;
		if (mBattleSimulator == null)
		{
			mBattleSimulator = new BattleSimulatorSystem();
			mBattleSimulator.Initialize(mGameMode, mNetwork);
		}
		yield return null;
		if (sceneID != 0 && sceneID != ready.SceneDataForExcehange.MSceneID)
		{
			ready = new Op_C2B_PlayerReady(ready);
			ready.SceneDataForExcehange.MSceneID = sceneID;
			mapConfig = ConfigHelper.GetInstance().GetConfig<SceneMap>(sceneID);
		}
		Debug.Log("加载BattlePanel " + Progress);
		GameObject gameObject = Asset.InstantiateWithoutCache("UI/BattlePanel", GameObject.Find("UICamera/Canvas/UIMain").transform);
		gameObject.name = "BattlePanel";
		battlePanelGameObject = gameObject;
		componentsInChildren = gameObject.GetComponentsInChildren<FlowScriptController>(includeInactive: true);
		foreach (FlowScriptController flowScriptController in componentsInChildren)
		{
			Debug.Log("====>>" + flowScriptController.name);
			flowScripts.Add(flowScriptController);
			flowScriptController.enableAction = GraphOwner.EnableAction.DoNothing;
			flowScriptController.disableAction = GraphOwner.DisableAction.DoNothing;
		}
		yield return null;
		BattleScene.InitWorldState(ClientSimulator.Instance.mSimContext.sEntityWorldState.status, ready);
		if (BattleScene.LastBattleID == ready.BattleID)
		{
			mBattleSimulator.StartSimulate(ref mBinMap, mTriggerData);
			ClientSimulator.Instance.mSimContext.PostEvent(EntityTriggerEvent.Claim(TriggerEventType.MapInit));
			ClientSimulator.Instance.StartSim();
		}
		else
		{
			RequestSimulator();
		}
		Scene sceneByPath = SceneManager.GetSceneByPath(scenePath);
		if (sceneByPath.IsValid())
		{
			SceneManager.SetActiveScene(sceneByPath);
			List<GameObject> list = new List<GameObject>();
			sceneByPath.GetRootGameObjects(list);
			for (int k = 0; k < list.Count; k++)
			{
				sceneSetting = list[k].GetComponentInChildren<SceneSetting>();
				if (sceneSetting != null)
				{
					break;
				}
			}
			if (sceneSetting != null)
			{
				m_sceneDefaultBGM = sceneSetting.GetComponent<SceneDefaultBGM>();
				if (m_sceneDefaultBGM == null)
				{
					m_sceneDefaultBGM = sceneSetting.gameObject.AddComponent<SceneDefaultBGM>();
					foreach (KeyValuePair<int, IMessage> item in ConfigHelper.GetInstance().GetAllConfig(typeof(SceneBGM)))
					{
						SceneBGM sceneBGM = item.Value as SceneBGM;
						if (sceneBGM.SceneName == sceneSetting.gameObject.name)
						{
							m_sceneDefaultBGM.m_audioID = sceneBGM.AudioID;
						}
					}
				}
			}
		}
		else
		{
			Debug.LogError("can't find scene by path: " + scenePath);
		}
		AddEnvironmentHelper();
		BindEnvironmentHelper();
		if (InnerSceneSettingOnSourceSpaceAsset != null && InnerSceneSettingOnSourceSpaceAsset.gameObject != null)
		{
			InnerSceneSettingOnSourceSpaceAsset.gameObject.SetActive(value: false);
		}
		if (sceneSetting != null && sceneSetting.gameObject != null)
		{
			sceneSetting.gameObject.SetActive(value: true);
		}
		if (virtualCameraParam != null && virtualCameraParam.composer != null && virtualCameraParam.lockTargetCinemachine != null)
		{
			virtualCameraParam.composer.m_DeadZoneWidth = 0f;
			virtualCameraParam.composer.m_SoftZoneWidth = 0f;
			Vector3 followOffset = virtualCameraParam.transposer.m_FollowOffset;
			followOffset.y = virtualCameraParam.lockTargetCinemachine.heightDefault;
			followOffset.z = 0f - virtualCameraParam.lockTargetCinemachine.radiusDefault;
			virtualCameraParam.transposer.m_FollowOffset = followOffset;
		}
		while (!ClientSimulator.Instance.mWasSimRunning)
		{
			yield return null;
		}
	}

	private void InjectUI(GameObject root)
	{
		Button button = root.transform.Find("ScreenAdjustContainer/RightTopButtons/btn_pause")?.GetComponent<Button>();
		if (!(button != null))
		{
			return;
		}
		_ = button.transform.parent;
		Button component = UnityEngine.Object.Instantiate(button.gameObject, root.transform).GetComponent<Button>();
		(component.transform as RectTransform).anchorMin = new Vector2(0.5f, 0.5f);
		(component.transform as RectTransform).anchorMax = new Vector2(0.5f, 0.5f);
		component.transform.localRotation = Quaternion.identity;
		component.transform.localPosition = Vector3.zero;
		component.transform.localScale = Vector3.one * 10f;
		button.onClick.AddListener(delegate
		{
			BattleResultForLua battleResultForLua = GetBattleResultForLua();
			if (LuaHelper.IsLuaClientInited())
			{
				LuaHelper.CallFunction("ShowBattlePausePage", battleResultForLua, BattleScene.Newbie);
			}
		});
		component.onClick.AddListener(delegate
		{
			UI_FakeGameOver(1);
		});
	}

	public static void UI_FakeGameOver(int result)
	{
		UIBattleScene uIBattleScene = NScene.GetCurrentScene() as UIBattleScene;
		ClientSimulator.Instance.SendBattleResult(uIBattleScene.ready.BattleID, uIBattleScene.ready.Uuid, (E_BattleResult)result, CalcStatisticsData(result).ToBattleResultInfo(), null);
		uIBattleScene.gameOverCallback?.Invoke((NScene.GetCurrentScene() as BattleScene).GetWorldSatetManager().data);
	}

	public void AddGameOverCallback(Action<StatisticsData> callback)
	{
		gameOverCallback = callback;
	}
}
