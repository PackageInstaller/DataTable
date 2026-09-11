using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Config;
using FlowCanvas;
using FlowCanvas.Nodes;
using Google.Protobuf;
using NetProcol;
using NodeCanvas.Framework;
using P08.EnvironmentHelper;
using Packages.P08Base.Net;
using ParadoxNotion.Serialization;
using UnityEngine;
using UnityEngine.SceneManagement;

public class BattleScene : BattleSceneLoader
{
	public Action onBattleSceneLoad;

	public Action onBattleSceneReady;

	public Action<BattleResultForLua> onShowPauseUI;

	public Action onShowRecoverUI;

	public GameMode mGameMode = GameMode.SinglePlayer;

	public int resurrectMode;

	public bool resurrectImmediately;

	public long resurrectCoinNumber;

	public long maxResurrectCoinNumber = 5L;

	public static bool Newbie = false;

	public string nickName;

	public static EEffectQuality AIQuality = EEffectQuality.Medium;

	public static EEffectQuality MainPlayerQuality = EEffectQuality.Fantastic;

	public static bool IsHideFriendEffect = false;

	protected BattleSimulatorSystem mBattleSimulator;

	protected INetCallback mNetwork;

	public static long LastBattleID = 0L;

	public static string IP = "10.108.1.32";

	public static string Port = "9527";

	public static bool isPause = false;

	private bool enableNextAreaIndicator;

	private Vector3 nextAreaDirection = Vector3.zero;

	private Vector3 charInitPos = Vector3.zero;

	private static bool _isInitNLog = false;

	public static En_CooperateUniqueSkillPlayControlledType PlayControlledType = En_CooperateUniqueSkillPlayControlledType.None;

	public static bool PlayedOfBattle = false;

	public static bool PlayedOfStart = false;

	public static bool PlayedOfDaily = false;

	public static bool FullPlay = true;

	public INetCallback GetNetwork()
	{
		return mNetwork;
	}

	public void SetNetwork(INetCallback net)
	{
		mNetwork = net;
	}

	public AgentManager GetAgentManager()
	{
		return mBattleSimulator.ClientAgentManager;
	}

	public NAgent GetPlayerAgent()
	{
		return mBattleSimulator.ClientAgentManager.GetPlayerAgent();
	}

	public BuffManager GetBuffManager()
	{
		return mBattleSimulator.BuffManager;
	}

	public MapTriggerManager GetMapTriggerManager()
	{
		return mBattleSimulator.MapTriggerManager;
	}

	public BattleSimulatorSystem GetBattleSimulatorSystem()
	{
		return mBattleSimulator;
	}

	public WorldStateManager GetWorldSatetManager()
	{
		return mBattleSimulator.WorldStateManager;
	}

	public bool IsGameOver()
	{
		return mBattleSimulator.IsGameOver();
	}

	public void SetCharInitPos(Vector3 pos)
	{
		charInitPos = pos;
	}

	public Vector3 GetCharInitPos()
	{
		return charInitPos;
	}

	public void SetNextAreaDirection(Vector3 direction)
	{
		enableNextAreaIndicator = true;
		nextAreaDirection = direction;
	}

	public void CleanNextAreaDirection()
	{
		enableNextAreaIndicator = false;
	}

	public bool GetNextAreaDirection(out Vector3 direction)
	{
		direction = nextAreaDirection;
		return enableNextAreaIndicator;
	}

	public bool SetEnableNextAreaIndicator(bool flag)
	{
		enableNextAreaIndicator = flag;
		return enableNextAreaIndicator;
	}

	public override void OnSceneEnter()
	{
		ClearFramePool();
		base.OnSceneEnter();
		if (!_isInitNLog)
		{
			_isInitNLog = true;
		}
		Debug.Log("== OnSceneEnter == ");
		_timelineAndHitInfoCache = new RunTimeTimelineAndHitCache();
		if (mBattleSimulator == null)
		{
			mBattleSimulator = new BattleSimulatorSystem();
			mBattleSimulator.Initialize(mGameMode, mNetwork);
		}
		HandPoint.Initialize();
	}

	private static List<GlobalAffix> GetGlobalAffixes(SceneDataForExcehangeInfo sceneDataForExcehange)
	{
		List<GlobalAffix> list = new List<GlobalAffix>();
		if (sceneDataForExcehange.TypeIDListAffix == null || sceneDataForExcehange.LevelList == null || sceneDataForExcehange.EnemyTypes == null)
		{
			return list;
		}
		for (int i = 0; i < sceneDataForExcehange.TypeIDListAffix.Count; i++)
		{
			list.Add(new GlobalAffix
			{
				affixTypeID = sceneDataForExcehange.TypeIDListAffix.get_Item(i),
				affixLevel = sceneDataForExcehange.LevelList.get_Item(i),
				targetLevel = (EnemyType)sceneDataForExcehange.EnemyTypes.get_Item(i)
			});
		}
		return list;
	}

	public static Dictionary<int, RoleData> GetRoleData(SceneDataForExcehangeInfo sceneDataForExcehange, ulong uuid)
	{
		Dictionary<int, RoleData> dictionary = new Dictionary<int, RoleData>();
		for (int i = 0; i < sceneDataForExcehange.RoleDataInLua.Count; i++)
		{
			RoleDataForExchangeInfo roleDataForExchangeInfo = sceneDataForExcehange.RoleDataInLua.get_Item(i);
			if (roleDataForExchangeInfo != null && roleDataForExchangeInfo.ID != 0)
			{
				Dictionary<int, long> dictionary2 = new Dictionary<int, long>();
				for (int j = 0; j < roleDataForExchangeInfo.AttributeID.Count; j++)
				{
					dictionary2.Add(roleDataForExchangeInfo.AttributeID.get_Item(j), roleDataForExchangeInfo.AttributeValue.get_Item(j));
				}
				Dictionary<int, int> dictionary3 = new Dictionary<int, int>();
				for (int k = 0; k < roleDataForExchangeInfo.EquipmentSkill.Count; k++)
				{
					dictionary3.Add(roleDataForExchangeInfo.EquipmentSkill.get_Item(k), roleDataForExchangeInfo.EquipmentSkillLv.get_Item(k));
				}
				dictionary[i] = new RoleData
				{
					UID = (long)uuid,
					ID = roleDataForExchangeInfo.ID,
					level = roleDataForExchangeInfo.Level,
					AI_ID = -i,
					SkinID = roleDataForExchangeInfo.ID,
					playerLevel = roleDataForExchangeInfo.PlayerLevel,
					attribute = dictionary2,
					astrolabe = roleDataForExchangeInfo.Astrolabe.ToArray(),
					equipment = roleDataForExchangeInfo.Equipment.ToArray(),
					skillLevel = roleDataForExchangeInfo.SkillLevel.ToArray(),
					weaponEffectID = roleDataForExchangeInfo.WeaponEffectID,
					weaponEffectLevel = roleDataForExchangeInfo.WeaponEffectLevel,
					equipLv = dictionary3,
					AIEffect = roleDataForExchangeInfo.AIChip.ToArray()
				};
			}
		}
		return dictionary;
	}

	public static void InitWorldState(SimWorldState status, Op_C2B_PlayerReady ready)
	{
		status.coinConsume = ready.SceneDataForExcehange.CoinConsume;
		status.coinNumber = ready.SceneDataForExcehange.CoinNumber;
		status.needResurrect = ready.SceneDataForExcehange.NeedResurrect;
		status.resurrectTimes = 0;
		status.resurrectHP = ready.SceneDataForExcehange.ResurrectHP;
		status.m_CooperateUniqueSkillID = ready.SceneDataForExcehange.CooperateUniqueSkillID;
		status.m_CooperateUniqueSkillLevel = ready.SceneDataForExcehange.CooperateUniqueSkillLevel;
		Int3 @int = new Int3(ready.SceneDataForExcehange.AttributeFactorX, ready.SceneDataForExcehange.AttributeFactorY, ready.SceneDataForExcehange.AttributeFactorZ);
		status.currentEnemyATKAttributeFactor = ((@int.x > 0) ? @int.x : 1000);
		status.currentEnemyDEFAttributeFactor = ((@int.y > 0) ? @int.y : 1000);
		status.currentEnemyHPAttributeFactor = ((@int.z > 0) ? @int.z : 1000);
		status.mMissionClearTimes = ready.SceneDataForExcehange.MMissionClearTimes;
		status.mSceneMap = ConfigHelper.GetInstance().GetConfig<SceneMap>(ready.SceneDataForExcehange.MSceneID);
		status.mChallengeFactor = ready.SceneDataForExcehange.ChallengeFactor;
		status.difficulty = ready.SceneDataForExcehange.Difficulty;
		status.adaptiveEnemyLevel = ready.SceneDataForExcehange.AdaptiveEnemyLevel;
		status.targetEnemyType = ready.SceneDataForExcehange.TargetEnemyID;
		status.mGlobalAffixes = GetGlobalAffixes(ready.SceneDataForExcehange);
		Dictionary<int, RoleData> roleData = GetRoleData(ready.SceneDataForExcehange, ready.Uuid);
		status.mRoleID = roleData[0].ID;
		Dictionary<MemberPosition, RemoteMember> mRoomMembers = status.mRoomMembers;
		Dictionary<int, RoleData>.Enumerator enumerator = roleData.GetEnumerator();
		while (enumerator.MoveNext())
		{
			MemberPosition key = (MemberPosition)enumerator.Current.Key;
			if (enumerator.Current.Value.ID == 0)
			{
				Debug.Log("0 member is null @ " + key);
				continue;
			}
			Debug.Log(enumerator.Current.Value.ID + " member ready @: " + key);
			RoleData value = enumerator.Current.Value;
			Skin config = ConfigHelper.GetInstance().GetConfig<Skin>(value.ID);
			value.SkinID = value.ID;
			if (config != null)
			{
				value.ID = config.Hero;
				value.SkinID = config.ID;
			}
			mRoomMembers[key] = new RemoteMember
			{
				mEntityPosition = key,
				roleData = value
			};
		}
		status.m_indexOfMaxCountRace = ready.SceneDataForExcehange.IndexOfMaxCountRace;
		status.m_numOfMaxCountRace = ready.SceneDataForExcehange.NumOfMaxCountRace;
		status.mBattleID = ready.BattleID;
		status.leftTimeAtStart = ready.SceneDataForExcehange.LeftTime;
		status.mVHLResult = ready.SceneDataForExcehange.VHLResult;
		foreach (int item in ready.SceneDataForExcehange.VHLSkillID)
		{
			status.mVHLSkill.Add(item);
		}
		RoleDataForExchangeInfo masterSkill = ready.SceneDataForExcehange.MasterSkill;
		if (masterSkill != null)
		{
			Dictionary<int, long> dictionary = new Dictionary<int, long>();
			for (int i = 0; i < masterSkill.AttributeID.Count; i++)
			{
				dictionary.Add(masterSkill.AttributeID.get_Item(i), masterSkill.AttributeValue.get_Item(i));
			}
			status.attribute = dictionary;
		}
	}

	public override IEnumerator OnSceneReadyCoroutine()
	{
		yield return null;
		Record();
		AudioManager.Instance.CreateCriAtom();
		AudioManager.Instance.SetListener(Camera.main.gameObject);
		InitWorldState(ClientSimulator.Instance.mSimContext.sEntityWorldState.status, ready);
		yield return null;
		Print("OnSceneReadyCoroutine1");
		yield return null;
		Record();
		StartBehaviour();
		yield return null;
		Print("StartBehaviour");
		yield return null;
		Record();
		if (onBattleSceneLoad != null)
		{
			onBattleSceneLoad();
		}
		yield return null;
		Print("OnSceneReadyCoroutine3");
		yield return null;
		yield return null;
		Record();
		RequestSimulator();
		while (!ClientSimulator.Instance.mWasSimRunning)
		{
			yield return null;
		}
		yield return null;
		Print("RequestSimulator");
	}

	public override void OnSceneReady()
	{
		base.OnSceneReady();
		_timelineAndHitInfoCache.Initialize();
		onBattleSceneReady?.Invoke();
		BindEnvironmentHelper();
	}

	public void RequestSimulator()
	{
		Debug.Log("<color=yellow>当前游戏模式为:" + mGameMode.ToString() + "</color>");
		LastBattleID = ready.BattleID;
		ulong uuid = ready.Uuid;
		mBattleSimulator.StartSimulate(ref mBinMap, mTriggerData);
		if (mGameMode == GameMode.Multiplayer || mGameMode == GameMode.EditorMultiPlayer)
		{
			ClientSimulator.Instance.Ready(ready);
			Debug.Log(uuid + " join battle: " + ready.BattleID + ", member count: " + ready.SceneDataForExcehange.RoleDataInLua.Count);
		}
		else if (mGameMode == GameMode.SinglePlayer)
		{
			ClientSimulator.Instance.Ready(ready);
			Debug.Log(ready.SceneDataForExcehange.RoleDataInLua.get_Item(0).ID + " join battle: " + ready.BattleID + ", member count: " + ready.SceneDataForExcehange.RoleDataInLua.Count);
		}
		else if (mGameMode == GameMode.EditorSinglePlayer)
		{
			ClientSimulator.Instance.StartSinglePlayerGame(ready.SceneDataForExcehange.RoleDataInLua.get_Item(0).ID);
			ClientSimulator.Instance.StartSim();
			Debug.Log(ready.SceneDataForExcehange.RoleDataInLua.get_Item(0).ID + " join editor battle: " + ready.BattleID + ", member count: " + ready.SceneDataForExcehange.RoleDataInLua.Count);
		}
		else if (mGameMode == GameMode.ReplayMultiPlayer)
		{
			ClientSimulator.Instance.StartSinglePlayerGame(ready.SceneDataForExcehange.RoleDataInLua.get_Item(0).ID);
			ClientSimulator.Instance.StartSim();
		}
	}

	public void StartBehaviour()
	{
		for (int num = flowScripts.Count - 1; num >= 0; num--)
		{
			if (flowScripts[num] == null || flowScripts[num].graph == null)
			{
				flowScripts.RemoveAt(num);
				if (flowScripts[num].gameObject != null)
				{
					Debug.LogError(flowScripts[num].gameObject.name + " 有一张图为空");
				}
			}
		}
		flowScripts.Sort(delegate(FlowScriptController x, FlowScriptController y)
		{
			string strA = x.graph.name;
			string strB = y.graph.name;
			return string.Compare(strA, strB);
		});
		for (int num2 = 0; num2 < flowScripts.Count; num2++)
		{
			if (!(flowScripts[num2].graph == null))
			{
				flowScripts[num2].graph.mSimContext = ClientSimulator.Instance.mSimContext;
				flowScripts[num2].graph.mLogicEvent = new ISimulatorInferface();
				flowScripts[num2].graph.mMapTriggers = mMapTriggers;
				flowScripts[num2].StartBehaviour();
			}
		}
		SimWorldState status = ClientSimulator.Instance.mSimContext.sEntityWorldState.status;
		foreach (KeyValuePair<int, MapTrigger> mMapTrigger in mMapTriggers)
		{
			List<ISimulatorInferface> list = new List<ISimulatorInferface>();
			foreach (FlowScriptController flowScript in mMapTrigger.Value.flowScripts)
			{
				list.Add(flowScript.graph.mLogicEvent);
			}
			status.mTriggerScripts.Add(mMapTrigger.Key, list);
		}
		IntMath.VectorOfAngle(0);
		JSONSerializer.ClearCache();
	}

	public void StopBehaviour()
	{
		if (flowScripts == null)
		{
			Debug.LogError("图列表是空的");
			return;
		}
		for (int i = 0; i < flowScripts.Count; i++)
		{
			flowScripts[i].StopBehaviour();
			flowScripts[i].graph.mSimContext = null;
			flowScripts[i].graph.mLogicEvent = null;
			flowScripts[i].graph.mMapTriggers = null;
		}
	}

	public override void CloseLoadUI()
	{
		base.CloseLoadUI();
		Resources.UnloadUnusedAssets();
		GC.Collect();
		GC.Collect();
		GC.Collect();
		LuaHelper.CallFunction("LuaGcCollect");
	}

	public void CloseSimulator()
	{
		StopBehaviour();
		if (mBattleSimulator != null)
		{
			mBattleSimulator.Destroy();
			mBattleSimulator = null;
		}
	}

	private void ClearFramePool()
	{
		FrameListPool<BuffParams>.Clear();
		FrameListPool<int>.Clear();
		AudioManager.Instance.RemoveUsedSheetList("music");
		AudioManager.Instance.RemoveUsedSheetList("voice");
		AudioManager.Instance.RemoveUsedSheetList("effect");
	}

	public override void OnSceneExit(NScene nextScene)
	{
		base.OnSceneExit(nextScene);
		CloseSimulator();
		if (mNetwork != null)
		{
			UnityEngine.Object.DestroyImmediate(mNetwork as ClientUDPNet);
			mNetwork = null;
		}
		ClearFramePool();
	}

	public override IEnumerator OnSceneRestartCoroutine(int sceneID)
	{
		yield return new UnityEngine.WaitForEndOfFrame();
		if (CommonProcessor.IsMultiplePlayerGameMode(mGameMode))
		{
			yield break;
		}
		onBattleSceneLoad = null;
		onShowPauseUI = null;
		onShowRecoverUI = null;
		for (int i = 0; i < flowScripts.Count; i++)
		{
			flowScripts[i].StopBehaviour();
			flowScripts[i].graph.mSimContext = null;
			flowScripts[i].graph.mLogicEvent = null;
			flowScripts[i].graph.mMapTriggers = null;
		}
		if (sceneID != 0 && sceneID != ready.SceneDataForExcehange.MSceneID)
		{
			UnLoadMapTriggerData(sceneID);
		}
		FlowScriptController[] componentsInChildren = battlePanelGameObject.GetComponentsInChildren<FlowScriptController>(includeInactive: true);
		for (int j = 0; j < componentsInChildren.Length; j++)
		{
			flowScripts.Remove(componentsInChildren[j]);
		}
		UnityEngine.Object.Destroy(battlePanelGameObject);
		if (mBattleSimulator != null)
		{
			mBattleSimulator.Destroy();
			mBattleSimulator = null;
		}
		yield return null;
		virtualCameraParam.lockTargetCinemachine.OnLockTargetUpdate = null;
		virtualCameraParam.lockTargetCinemachine.SetLoseTarget();
		if (AudioManager.mInstance != null)
		{
			AudioManager.mInstance.OnSceneRestart();
		}
		Asset.pool.ReturnAll();
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
			string mapDataPath = mapConfig.MapDataPath;
			IEnumerator triggerIEnumerator = LoadMapTriggerData(mapDataPath, ImmediateCache: true);
			while (triggerIEnumerator.MoveNext())
			{
				Debug.Log("加载地图数据中 " + Progress);
				yield return new UnityEngine.WaitForEndOfFrame();
			}
		}
		LoadSourceSpaceMapDataByRaceID();
		Debug.Log("加载BattlePanel " + Progress);
		string text = mapConfig.SpBattlePanelPath;
		if (string.IsNullOrEmpty(text))
		{
			text = "UI/BattlePanel";
		}
		GameObject gameObject = Asset.InstantiateWithoutCache(text, GameObject.Find("UICamera/Canvas/UIMain").transform);
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
		for (int l = 0; l < flowScripts.Count; l++)
		{
			if (flowScripts[l] == null)
			{
				Debug.LogError("黑板flowcanvas为空！！" + l);
				continue;
			}
			IBlackboard blackboard = flowScripts[l].blackboard;
			if (blackboard != null)
			{
				(blackboard as Blackboard).RestartBlackboard();
			}
		}
		foreach (KeyValuePair<int, MapTrigger> mMapTrigger in mMapTriggers)
		{
			IBlackboard blackboard2 = mMapTrigger.Value.blackboard;
			if (blackboard2 != null)
			{
				(blackboard2 as Blackboard).RestartBlackboard();
			}
		}
		StartBehaviour();
		yield return null;
		InitWorldState(ClientSimulator.Instance.mSimContext.sEntityWorldState.status, ready);
		mTriggerData = LoadTriggerMap(triggerPath);
		if (LastBattleID == ready.BattleID)
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
			for (int m = 0; m < list.Count; m++)
			{
				sceneSetting = list[m].GetComponentInChildren<SceneSetting>();
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

	public void BindEnvironmentHelper()
	{
		TimelineBase[] array = UnityEngine.Object.FindObjectsOfType<TimelineBase>(includeInactive: true);
		List<IBehavior> environmentHelperList = mBattleSimulator.MapTriggerManager.EnvironmentHelperList;
		environmentHelperList.Clear();
		for (int i = 0; i < array.Length; i++)
		{
			environmentHelperList.Add(array[i]);
		}
	}

	public void PauseEnvironmentEffect(bool pCleanEffect = false)
	{
		List<IBehavior> environmentHelperList = mBattleSimulator.MapTriggerManager.EnvironmentHelperList;
		for (int i = 0; i < environmentHelperList.Count; i++)
		{
			(environmentHelperList[i] as TimelineBase).Pause(pCleanEffect);
		}
	}

	public void ResumeEnvironmentEffect()
	{
		List<IBehavior> environmentHelperList = mBattleSimulator.MapTriggerManager.EnvironmentHelperList;
		for (int i = 0; i < environmentHelperList.Count; i++)
		{
			(environmentHelperList[i] as TimelineBase).Resume();
		}
	}

	private void Awake()
	{
	}

	private void FixedUpdate()
	{
		if (mBattleSimulator != null && isReady)
		{
			mBattleSimulator.FixedUpdate();
		}
	}

	private void Update()
	{
		if (!isReady)
		{
			SetUIProgress(Progress);
		}
		if (mBattleSimulator != null && isReady)
		{
			mBattleSimulator.Update();
		}
	}

	private void LateUpdate()
	{
		if (mBattleSimulator != null && isReady)
		{
			mBattleSimulator.LateUpdate();
		}
	}

	private void Start()
	{
		Application.lowMemory += OnLowMemory;
	}

	private void OnDestroy()
	{
		Application.lowMemory -= OnLowMemory;
	}

	private void OnLowMemory()
	{
		Resources.UnloadUnusedAssets();
	}

	private void OnApplicationPause(bool pause)
	{
		if (ClientSimulator.Instance.mWasSimRunning && !mBattleSimulator.IsGameOverEnd() && pause)
		{
			ShowPauseUI();
			mBattleSimulator.PauseGame();
		}
	}

	public bool ShowPauseUI()
	{
		if (!ClientSimulator.Instance.mWasSimRunning)
		{
			return false;
		}
		if (mBattleSimulator.IsGameOverEnd())
		{
			return false;
		}
		if (mGameMode == GameMode.SinglePlayer || mGameMode == GameMode.EditorSinglePlayer)
		{
			CallPauseUI();
		}
		else if (mGameMode == GameMode.Multiplayer && onShowRecoverUI != null)
		{
			onShowRecoverUI();
		}
		return false;
	}

	public BattleResultForLua GetBattleResultForLua()
	{
		return GetWorldSatetManager().data.dataForLua;
	}

	public void CallPauseUI()
	{
		if (!isPause)
		{
			BattleResultForLua battleResultForLua = GetBattleResultForLua();
			if (onShowPauseUI != null)
			{
				onShowPauseUI(battleResultForLua);
			}
		}
	}

	private void OnApplicationQuit()
	{
		OnSceneExit(null);
	}
}
