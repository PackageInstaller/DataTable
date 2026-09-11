using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using Cinemachine;
using Config;
using FlowCanvas;
using FlowCanvas.Nodes;
using Google.Protobuf;
using Google.Protobuf.Collections;
using NetProcol;
using NodeCanvas.Framework;
using P08.EnvironmentHelper;
using Unity.Profiling;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class BattleSceneLoader : NScene
{
	public static int customLoading = -1;

	public const string COMMON_SOURCE_SPACE_SCENE_PATH = "Effect/SourceSpaceScene/X01";

	public const float CAMERE_NEAR_CLIP_PLANE = 0.3f;

	protected byte[] mBinMap;

	protected ProtoMapdata mTriggerData;

	public SceneMap mapConfig;

	public List<FlowScriptController> flowScripts = new List<FlowScriptController>();

	protected List<int> charList = new List<int>();

	protected List<string> loadedCharFlowScript = new List<string>();

	protected List<string> loadedCharTimeline = new List<string>();

	public CameraParamComponent virtualCameraParam;

	protected Dictionary<int, MapTrigger> mMapTriggers = new Dictionary<int, MapTrigger>(new IntComparer());

	protected Dictionary<int, GameObject> mRenderCharactorCache = new Dictionary<int, GameObject>(new IntComparer());

	public Graph formula;

	public SceneSetting sceneSetting;

	public BakeSetting bakeSetting;

	public GameObject battlePanelGameObject;

	public InnerSceneSetting InnerSceneSettingOnSourceSpaceAsset;

	public CameraExtension CameraExtension;

	public SceneDefaultBGM m_sceneDefaultBGM;

	private List<int> mMapConfigAffixes = new List<int>();

	public Op_C2B_PlayerReady ready;

	public int localPlayerIndex;

	public List<string> m_cooperateAssetPrefabName = new List<string>(4);

	public MasterSkillRenderHigh masterSkillRenderHigh;

	public MasterSkillRenderMedium masterSkillRenderMedium;

	public MasterSkillRenderMedium masterSkillRenderLow;

	public static bool _isInitConfig = false;

	private GameObject ui;

	private Image progress;

	protected RunTimeTimelineAndHitCache _timelineAndHitInfoCache = new RunTimeTimelineAndHitCache();

	private float loadTime;

	private long useMemory;

	private ProfilerRecorder systemUsedMemoryRecorder;

	private bool switchRecord = true;

	protected string triggerPath;

	protected Dictionary<int, List<string>> mRunningTriggerTypes;

	public int masterSkillLevel = 1;

	public int masterSkinID;

	public int roleSkinID;

	public bool isMasterSkillVow;

	public RunTimeTimelineAndHitCache GetTimelineAndHitCache()
	{
		return _timelineAndHitInfoCache;
	}

	public override void ShowLoadUI()
	{
		if (customLoading != -1)
		{
			LuaHelper.CallFunction("ShowCustomLoading", customLoading);
		}
		else
		{
			LoadingUIManager.inst.ShowLoadUI(LoadingUIType.Battle);
		}
	}

	public override float ShowLoadUIDuration()
	{
		if (customLoading == 4)
		{
			return 1f;
		}
		return base.ShowLoadUIDuration();
	}

	public override float EndLoadUIDuration()
	{
		Resources.UnloadUnusedAssets();
		LuaHelper.CallFunction("LuaGcCollect");
		if (customLoading == 4)
		{
			return 1f;
		}
		return base.EndLoadUIDuration();
	}

	public override float CloseLoadUIDuration()
	{
		if (customLoading == 4)
		{
			return 0.5f;
		}
		return base.CloseLoadUIDuration();
	}

	protected void SetUIProgress(float value)
	{
		if (customLoading == -1)
		{
			LoadingUIManager.inst.SetUIProgress(value);
		}
	}

	public override void CloseLoadUI()
	{
		if (customLoading != -1)
		{
			LuaHelper.CallFunction("CloseCustomLoading", customLoading);
		}
		else
		{
			LoadingUIManager.inst.CloseLoadUI();
		}
		customLoading = -1;
	}

	public override void OnSceneEnter()
	{
	}

	public override void OnSceneExit(NScene nextScene)
	{
		if (battlePanelGameObject != null)
		{
			battlePanelGameObject.SetActive(value: false);
		}
		Debug.Log("=====>>OnSceneExit");
		if (_timelineAndHitInfoCache != null)
		{
			_timelineAndHitInfoCache.Shutdown();
			_timelineAndHitInfoCache = null;
		}
		if (InnerSceneSettingOnSourceSpaceAsset != null && InnerSceneSettingOnSourceSpaceAsset.gameObject != null)
		{
			InnerSceneSettingOnSourceSpaceAsset.gameObject.SetActive(value: false);
			SceneSetting component = InnerSceneSettingOnSourceSpaceAsset.GetComponent<SceneSetting>();
			if (component != null)
			{
				component.grayness = 0f;
				component.darkness = 0f;
				sceneSetting.invert = false;
			}
		}
		if (sceneSetting != null)
		{
			sceneSetting.grayness = 0f;
			sceneSetting.darkness = 0f;
			sceneSetting.invert = false;
			UnityEngine.Pipelines.SimPipeline.RenderSettings.invert = false;
			UnityEngine.Pipelines.SimPipeline.RenderSettings.grayness = 0f;
			UnityEngine.Pipelines.SimPipeline.RenderSettings.darkness = 0f;
		}
	}

	protected void Record()
	{
		if (switchRecord)
		{
			loadTime = Time.realtimeSinceStartup;
			if (!systemUsedMemoryRecorder.Valid)
			{
				systemUsedMemoryRecorder = ProfilerRecorder.StartNew(ProfilerCategory.Memory, "System Used Memory");
			}
			if (systemUsedMemoryRecorder.Valid)
			{
				useMemory = systemUsedMemoryRecorder.CurrentValue;
			}
		}
	}

	protected void Print(string s)
	{
		if (switchRecord)
		{
			Debug.Log(">>>>>=========================================");
			Debug.Log(s);
			Debug.Log(Time.realtimeSinceStartup - loadTime);
			if (systemUsedMemoryRecorder.Valid)
			{
				Debug.Log(systemUsedMemoryRecorder.CurrentValue - useMemory);
				Debug.Log(systemUsedMemoryRecorder.CurrentValue);
			}
			Debug.Log("<<<<<=========================================");
		}
	}

	private void Dispose()
	{
		if (switchRecord)
		{
			systemUsedMemoryRecorder.Dispose();
		}
	}

	private void OnDisable()
	{
		Dispose();
	}

	public static Op_C2B_PlayerReady CreateDefaultReadyMessage()
	{
		Op_C2B_PlayerReady op_C2B_PlayerReady = new Op_C2B_PlayerReady();
		SceneDataForExcehangeInfo sceneDataForExcehangeInfo = new SceneDataForExcehangeInfo
		{
			MSceneID = 10205,
			ChallengeFactor = 2,
			Difficulty = 1,
			AdaptiveEnemyLevel = 1,
			NeedResurrect = true,
			CoinNumber = 1000L,
			CoinConsume = 1L,
			CooperateUniqueSkillID = 0,
			AttributeFactorX = 1000,
			AttributeFactorY = 1000,
			AttributeFactorZ = 1000,
			IndexOfMaxCountRace = 0,
			NumOfMaxCountRace = 0,
			LeftTime = 0
		};
		RoleDataForExchangeInfo item = new RoleDataForExchangeInfo
		{
			ID = 1084,
			Level = 1,
			PlayerLevel = 1,
			AttributeID = { 3 },
			AttributeValue = { 10000L }
		};
		sceneDataForExcehangeInfo.RoleDataInLua.Add(item);
		op_C2B_PlayerReady.BattleVersionCode = GlobalStaticLoader.battleVersionCode;
		op_C2B_PlayerReady.SceneDataForExcehange = sceneDataForExcehangeInfo;
		return op_C2B_PlayerReady;
	}

	public override IEnumerator OnLoadCoroutine()
	{
		yield return null;
		Record();
		Graph.mToggleBinary = true;
		Blackboard.mToggleBinary = true;
		Debug.Log("======= Start Load Coroutine ======= ");
		Asset.Initialize();
		Debug.Log("======= Loading Config ======= ");
		ConfigHelper.GetInstance().ClearData();
		_isInitConfig = GlobalStaticLoader.sIsInitConfig;
		if (!_isInitConfig)
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
			_isInitConfig = true;
		}
		flowScripts.Clear();
		charList.Clear();
		yield return null;
		Record();
		GlobalCachedAssets globalCachedAssets = Asset.Load<GlobalCachedAssets>("GlobalCachedAssets");
		if (globalCachedAssets != null && globalCachedAssets.list != null)
		{
			for (int i = 0; i < globalCachedAssets.list.Count; i++)
			{
				AssetDescriptionToCache assetDescriptionToCache = globalCachedAssets.list[i];
				if (!string.IsNullOrEmpty(assetDescriptionToCache.path) && assetDescriptionToCache.type == AssetDescriptionToCacheType.AssetDotCache)
				{
					Asset.Cache(assetDescriptionToCache.path, assetDescriptionToCache.number);
				}
			}
		}
		Asset.Unload("GlobalCachedAssets");
		yield return null;
		Print("GlobalCachedAssets");
		UnityEngine.Random.InitState(Time.frameCount);
		if (ready == null || ready.SceneDataForExcehange == null || ready.SceneDataForExcehange.RoleDataInLua == null || ready.SceneDataForExcehange.RoleDataInLua.Count <= 0)
		{
			Debug.LogError("Role Data is null");
			ready = CreateDefaultReadyMessage();
		}
		Debug.Log("======= Loading flowScripts ======= ");
		yield return null;
		Record();
		FlowScriptController component = Asset.InstantiateWithoutCache("FlowScript/FormulaPrefab").GetComponent<FlowScriptController>();
		flowScripts.Add(component);
		component.enableAction = GraphOwner.EnableAction.DoNothing;
		component.disableAction = GraphOwner.DisableAction.DoNothing;
		formula = component.graph;
		LoadBaseFlowScripts("FlowScript/TimelinePrefab/BattleLogicLaucher");
		LoadBaseFlowScripts("FlowScript/TimelinePrefab/SourceSpace");
		LoadBaseFlowScripts("FlowScript/TimelinePrefab/BattleRenderLaucher");
		LoadBaseFlowScripts("FlowScript/AI/CommonPlayerAIPrefab");
		LoadBaseFlowScripts("FlowScript/TimelinePrefab/BattleRecordData");
		yield return null;
		Print("LoadBaseFlowScripts");
		yield return new UnityEngine.WaitForEndOfFrame();
		Debug.Log("sceneid: " + ready.SceneDataForExcehange.MSceneID);
		mapConfig = ConfigHelper.GetInstance().GetConfig<SceneMap>(ready.SceneDataForExcehange.MSceneID);
		string mapDataPath = mapConfig.MapDataPath;
		IEnumerator triggerIEnumerator = LoadMapTriggerData(mapDataPath);
		while (triggerIEnumerator.MoveNext())
		{
			Debug.Log("加载地图数据中 " + Progress);
			yield return new UnityEngine.WaitForEndOfFrame();
		}
		yield return null;
		Record();
		Debug.Log("通过角色种类加载对应的间层 " + Progress);
		LoadSourceSpaceMapDataByRaceID();
		Debug.Log("加载间层的timeline " + Progress);
		LoadTimeline("65535_timeline");
		yield return null;
		Print("间层");
		yield return null;
		yield return null;
		Record();
		Debug.Log(Progress + " 开始缓存缓存编号为 " + ready.SceneDataForExcehange.CooperateUniqueSkillID + " 连携奥义预制体 ");
		LoadCooperateUniqueSkillPrefab();
		yield return null;
		Print("连携奥义预制体");
		yield return null;
		Record();
		Debug.Log("加载装备图 " + Progress);
		LoadEquipFlowScript();
		Debug.Log("加载装备timeline " + Progress);
		LoadEquipTimeline();
		Debug.Log("加载词缀的timeline " + Progress);
		LoadTimeline("800_timeline");
		Debug.Log("加载道具和qte的timeline " + Progress);
		LoadTimeline("801_timeline");
		if (mapConfig.TimelinePath != null)
		{
			for (int j = 0; j < mapConfig.TimelinePath.Count; j++)
			{
				LoadTimeline(mapConfig.TimelinePath.get_Item(j));
			}
		}
		yield return null;
		Print("装备, 词缀, 道具");
		yield return null;
		Debug.Log("加载路径引导" + Progress);
		Asset.InstantiateWithoutCache("Path");
		IEnumerator<RoleDataForExchangeInfo> enumerator = ready.SceneDataForExcehange.RoleDataInLua.GetEnumerator();
		while (enumerator.MoveNext())
		{
			int iD = enumerator.Current.ID;
			if (iD != 0)
			{
				charList.Add(iD);
			}
		}
		for (int k = 0; k < charList.Count; k++)
		{
			IEnumerator cit = CacheRenderCharactor(charList[k]);
			while (cit.MoveNext())
			{
				yield return null;
			}
		}
		for (int k = 0; k < ready.SceneDataForExcehange.RoleDataInLua.Count; k++)
		{
			int id = ready.SceneDataForExcehange.RoleDataInLua.get_Item(k).ID;
			if (id != 0)
			{
				Debug.Log("实例化主角 tpose " + id + " , " + Progress);
				yield return null;
				Record();
				CreateRenderCharactor(id, k);
				yield return null;
				Print("实例化主角 tpose " + id);
			}
		}
		yield return null;
		Record();
		Debug.Log("加载BattlePanel " + Progress);
		string text = mapConfig.SpBattlePanelPath;
		if (string.IsNullOrEmpty(text))
		{
			text = "UI/BattlePanel";
		}
		GameObject gameObject = Asset.InstantiateWithoutCache(text, GameObject.Find("UICamera/Canvas/UIMain").transform);
		gameObject.name = "BattlePanel";
		battlePanelGameObject = gameObject;
		FlowScriptController[] componentsInChildren = gameObject.GetComponentsInChildren<FlowScriptController>(includeInactive: true);
		foreach (FlowScriptController flowScriptController in componentsInChildren)
		{
			flowScripts.Add(flowScriptController);
			flowScriptController.enableAction = GraphOwner.EnableAction.DoNothing;
			flowScriptController.disableAction = GraphOwner.DisableAction.DoNothing;
		}
		yield return null;
		Debug.Log("加载暂停界面需要的资源 " + Progress);
		Asset.Load("Atlas/Setting");
		enumerator = ready.SceneDataForExcehange.RoleDataInLua.GetEnumerator();
		while (enumerator.MoveNext())
		{
			int iD2 = enumerator.Current.ID;
			if (iD2 != 0)
			{
				Asset.Load("TextureConfig/Character/Icon/" + iD2);
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
		yield return null;
		Print("UI ");
		yield return new UnityEngine.WaitForEndOfFrame();
		Scene sceneByPath = SceneManager.GetSceneByPath(scenePath);
		if (sceneByPath.IsValid())
		{
			SceneManager.SetActiveScene(sceneByPath);
			List<GameObject> list = new List<GameObject>();
			sceneByPath.GetRootGameObjects(list);
			LightmapsMode lightmapsMode = LightmapsMode.NonDirectional;
			for (int m = 0; m < list.Count; m++)
			{
				bakeSetting = list[m].GetComponentInChildren<BakeSetting>();
				if (lightmapsMode == LightmapsMode.NonDirectional && bakeSetting != null)
				{
					lightmapsMode = bakeSetting.lightmapsMode;
				}
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
		GamepadManager.Instance.UseController();
	}

	protected void AddEnvironmentHelper()
	{
		if (sceneSetting != null)
		{
			U3DUtil.Get<TimelinePostEffectHelper>(sceneSetting.gameObject).InitSceneSetting(sceneSetting);
			U3DUtil.Get<TimelineTintEffectHelper>(sceneSetting.gameObject).InitSceneSetting(sceneSetting);
			U3DUtil.Get<TimelineDynamicFogEffectHelper>(sceneSetting.gameObject).InitSceneSetting(sceneSetting);
		}
		if (CameraExtension != null)
		{
			U3DUtil.Get<TimelineAbberationEffectHelper>(CameraExtension.gameObject).InitCameraExtension(CameraExtension);
			U3DUtil.Get<TimelineGlitchEffectHelper>(CameraExtension.gameObject).InitCameraExtension(CameraExtension);
		}
	}

	private FlowScriptController[] LoadBaseFlowScripts(string prefabPath)
	{
		GC.Collect();
		GameObject obj = Asset.InstantiateWithoutCache(prefabPath);
		if (obj == null)
		{
			Debug.Log(prefabPath);
		}
		FlowScriptController[] components = obj.GetComponents<FlowScriptController>();
		for (int i = 0; i < components.Length; i++)
		{
			flowScripts.Add(components[i]);
			components[i].enableAction = GraphOwner.EnableAction.DoNothing;
			components[i].disableAction = GraphOwner.DisableAction.DoNothing;
		}
		return components;
	}

	private void LoadEquipTimeline()
	{
		IEnumerator<RoleDataForExchangeInfo> enumerator = ready.SceneDataForExcehange.RoleDataInLua.GetEnumerator();
		while (enumerator.MoveNext())
		{
			RoleDataForExchangeInfo current = enumerator.Current;
			if (current.WeaponEffectID != 0)
			{
				weapon_effect config = ConfigHelper.GetInstance().GetConfig<weapon_effect>(current.WeaponEffectID);
				if (config != null && !string.IsNullOrEmpty(config.TimelinePath))
				{
					LoadTimeline(config.TimelinePath);
				}
			}
			if (current.Equipment == null)
			{
				continue;
			}
			for (int i = 0; i < current.Equipment.Count; i++)
			{
				int num = current.Equipment.get_Item(i);
				if (num == 0)
				{
					break;
				}
				equip_effect config2 = ConfigHelper.GetInstance().GetConfig<equip_effect>(num);
				if (config2 == null)
				{
					Debug.LogError("=====>>>>>> 在 equip_effect 中找不到装备技能数据, id为:" + num);
				}
				else if (!string.IsNullOrEmpty(config2.TimelinePath))
				{
					LoadTimeline(config2.TimelinePath);
				}
			}
		}
	}

	public void InstantiateSourceSpaceScenePrefabSync(string path, int raceID)
	{
		GameObject gameObject = Asset.Instantiate(path);
		if (gameObject != null)
		{
			InnerSceneSetting component = gameObject.GetComponent<InnerSceneSetting>();
			if (component != null)
			{
				InnerSceneSettingOnSourceSpaceAsset = component;
			}
			gameObject.SetActive(value: false);
		}
	}

	protected void LoadSourceSpaceMapDataByRaceID()
	{
		string text = string.Empty;
		if (ConfigHelper.GetInstance().TryGetConfig<Race>(ready.SceneDataForExcehange.IndexOfMaxCountRace, out var config) && ConfigHelper.GetInstance().TryGetConfig<SourceSpace>(config.SoueceSpaceId, out var config2))
		{
			text = config2.PrefabPath;
		}
		IEnumerator<RoleDataForExchangeInfo> enumerator = ready.SceneDataForExcehange.RoleDataInLua.GetEnumerator();
		while (enumerator.MoveNext())
		{
			int iD = enumerator.Current.ID;
			if (iD != 0 && ConfigHelper.GetInstance().TryGetConfig<Skin>(iD, out var config3) && !string.IsNullOrEmpty(config3.SourceSpaceAssetPath))
			{
				text = config3.SourceSpaceAssetPath;
				break;
			}
		}
		if (!string.IsNullOrEmpty(text))
		{
			InstantiateSourceSpaceScenePrefabSync(text, ready.SceneDataForExcehange.IndexOfMaxCountRace);
			return;
		}
		Debug.LogError("=====>>>>>> 找不到多数神系对应的间层资源路径,请检查 CharacterParam 表的 RaceID 列,多数神系为:" + ready.SceneDataForExcehange.IndexOfMaxCountRace);
		InstantiateSourceSpaceScenePrefabSync("Effect/SourceSpaceScene/X01", ready.SceneDataForExcehange.IndexOfMaxCountRace);
	}

	public void LoadCooperateUniqueSkillPrefab()
	{
		if (!ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(ready.SceneDataForExcehange.CooperateUniqueSkillID, out var config))
		{
			return;
		}
		string text = "CooperateUniqueSkillTimeline/" + config.PrefabPath;
		Asset.Cache(text);
		m_cooperateAssetPrefabName.Add(text);
		IEnumerator<RoleDataForExchangeInfo> enumerator = ready.SceneDataForExcehange.RoleDataInLua.GetEnumerator();
		while (enumerator.MoveNext())
		{
			int num = enumerator.Current.ID;
			if (num != 0)
			{
				if (num < 10000)
				{
					num *= 100;
				}
				if (config.CooperateRoleIds.Contains(num / 100))
				{
					string text2 = $"CooperateUniqueSkillTimeline/{num}/{config.PrefabPath}";
					Asset.Cache(text2);
					m_cooperateAssetPrefabName.Add(text2);
				}
			}
		}
	}

	public void LoadBinMap(string mapGridPath)
	{
		TextAsset textAsset = Asset.Load<TextAsset>(mapGridPath);
		mBinMap = textAsset.bytes;
	}

	public ProtoMapdata LoadTriggerMap(string triggerPath)
	{
		TextAsset textAsset = Asset.Load<TextAsset>(triggerPath);
		mTriggerData = ProtoMapdata.Parser.ParseFrom(textAsset.bytes);
		return mTriggerData;
	}

	public static bool HasEnoughMemory()
	{
		return SystemInfo.systemMemorySize > 5000;
	}

	public void LoadTimeline(string assetBundleName)
	{
		if (string.IsNullOrEmpty(assetBundleName))
		{
			return;
		}
		if (!assetBundleName.StartsWith("timeline/"))
		{
			assetBundleName = "combattle/timeline/" + assetBundleName;
		}
		else if (!assetBundleName.StartsWith("combattle/"))
		{
			assetBundleName = "combattle/" + assetBundleName;
		}
		if (!assetBundleName.EndsWith(".ys"))
		{
			assetBundleName += ".ys";
		}
		if (loadedCharTimeline.Contains(assetBundleName))
		{
			return;
		}
		Debug.Log("加载角色timeline " + assetBundleName + " " + Time.realtimeSinceStartup);
		loadedCharTimeline.Add(assetBundleName);
		UnityEngine.Object[] array = Asset.LoadAllFromBundle<UnityEngine.Object>(assetBundleName);
		if (array == null)
		{
			return;
		}
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i] is RoleRenderConfig)
			{
				RoleRenderConfig roleRenderConfig = array[i] as RoleRenderConfig;
				_timelineAndHitInfoCache.Add(roleRenderConfig.ID, roleRenderConfig);
				continue;
			}
			if (!(array[i] is TimelineInfo))
			{
				Debug.Log(array[i].name);
				continue;
			}
			TimelineInfo timelineInfo = array[i] as TimelineInfo;
			if (null == timelineInfo)
			{
				Debug.LogError("无法加载Timeline数据 ");
				break;
			}
			_timelineAndHitInfoCache.Add(timelineInfo.ID, timelineInfo);
			if (!HasEnoughMemory())
			{
				continue;
			}
			List<TimelineEffectClip>.Enumerator enumerator = timelineInfo.effects.GetEnumerator();
			while (enumerator.MoveNext())
			{
				if (!string.IsNullOrEmpty(enumerator.Current.effectPath))
				{
					Asset.Cache(enumerator.Current.effectPath);
				}
				if (!string.IsNullOrEmpty(enumerator.Current.conditionEffectPath))
				{
					Asset.Cache(enumerator.Current.conditionEffectPath);
				}
			}
			for (int j = 0; j < timelineInfo.hitEffects.Count; j++)
			{
				CriwareCueInfo customHitAudioCriwareInfo = timelineInfo.hitEffects[j].CustomHitAudioCriwareInfo;
				if (!string.IsNullOrEmpty(customHitAudioCriwareInfo.mCueSheet.Replace(".acb", "")))
				{
					AudioManager.Instance.AddCue("effect", customHitAudioCriwareInfo.mCueSheet.Replace(".acb", ""), !string.IsNullOrEmpty(customHitAudioCriwareInfo.mCueAwb));
				}
				if (!string.IsNullOrEmpty(timelineInfo.hitEffects[j].hitEffectPath))
				{
					Asset.Cache(timelineInfo.hitEffects[j].hitEffectPath, 2);
				}
			}
			for (int k = 0; k < timelineInfo.cameras.Count; k++)
			{
				if (!string.IsNullOrEmpty(timelineInfo.cameras[k].cameraPath))
				{
					Asset.Cache(timelineInfo.cameras[k].cameraPath);
				}
			}
			for (int l = 0; l < timelineInfo.audioPlayActionClips.Count; l++)
			{
				AudioPlayActionClip audioPlayActionClip = timelineInfo.audioPlayActionClips[l];
				if (!string.IsNullOrEmpty(audioPlayActionClip.CueSheet.Replace(".acb", "")))
				{
					string key = (audioPlayActionClip.IsVoice ? "voice" : "effect");
					AudioManager.Instance.AddCue(key, audioPlayActionClip.CueSheet.Replace(".acb", ""), !string.IsNullOrEmpty(audioPlayActionClip.AwbName));
				}
			}
			for (int m = 0; m < timelineInfo.footstepAudioClips.Count; m++)
			{
				AudioPlayActionClip audioPlayActionClip2 = timelineInfo.footstepAudioClips[m];
				if (!string.IsNullOrEmpty(audioPlayActionClip2.CueSheet.Replace(".acb", "")))
				{
					string key2 = (audioPlayActionClip2.IsVoice ? "voice" : "effect");
					AudioManager.Instance.AddCue(key2, audioPlayActionClip2.CueSheet.Replace(".acb", ""), !string.IsNullOrEmpty(audioPlayActionClip2.AwbName));
				}
			}
			for (int n = 0; n < timelineInfo.earlyWarningClips.Count; n++)
			{
				if (!string.IsNullOrEmpty(timelineInfo.earlyWarningClips[n].WarningPrefabPath))
				{
					Asset.Cache(timelineInfo.earlyWarningClips[n].WarningPrefabPath);
				}
			}
			for (int num = 0; num < timelineInfo.thrownCollisionCheckClips.Count; num++)
			{
				if (!string.IsNullOrEmpty(timelineInfo.thrownCollisionCheckClips[num].LinkMainEffectPath))
				{
					Asset.Cache(timelineInfo.thrownCollisionCheckClips[num].LinkMainEffectPath);
				}
				if (!string.IsNullOrEmpty(timelineInfo.thrownCollisionCheckClips[num].LinkOtherEffectPath))
				{
					Asset.Cache(timelineInfo.thrownCollisionCheckClips[num].LinkOtherEffectPath);
				}
			}
			for (int num2 = 0; num2 < timelineInfo.footstepEffectClips.Count; num2++)
			{
				if (!string.IsNullOrEmpty(timelineInfo.footstepEffectClips[num2].effectPath))
				{
					Asset.Cache(timelineInfo.footstepEffectClips[num2].effectPath);
				}
				if (!string.IsNullOrEmpty(timelineInfo.footstepEffectClips[num2].conditionEffectPath))
				{
					Asset.Cache(timelineInfo.footstepEffectClips[num2].conditionEffectPath);
				}
			}
		}
	}

	public void CreateRenderCharactor(int roleID, int rolePosition)
	{
		Dictionary<int, GameObject> renderCharactor = GetRenderCharactor();
		Skin config = ConfigHelper.GetInstance().GetConfig<Skin>(roleID);
		GameObject gameObject = Asset.Instantiate(config.BattleModelPath);
		if (!(U3DUtil.Get<AgentHuman>(gameObject) == null))
		{
			CharacterEffect component = gameObject.GetComponent<CharacterEffect>();
			if (component != null)
			{
				component.shareMaterial = true;
			}
			renderCharactor.Add(rolePosition, gameObject);
			string empty = string.Empty;
			if (rolePosition == localPlayerIndex)
			{
				InitFollowCamera(config, gameObject);
				empty = $"StoryTimeline/Win/{roleID}_win_uitpose";
			}
			else
			{
				empty = $"StoryTimeline/Win/{roleID}_win_battletpose";
			}
			if (mapConfig != null && (mapConfig.SkipWinAction & 1) == 0 && !string.IsNullOrEmpty(empty))
			{
				Asset.Cache(empty);
			}
		}
	}

	public IEnumerator CacheRenderCharactor(int roleID)
	{
		Skin config = ConfigHelper.GetInstance().GetConfig<Skin>(roleID);
		int logicID = config.Hero;
		RepeatedField<string> additionalRenderTimelineArray = config.AdditionalRenderTimelineArray;
		RoleConfig role = ConfigHelper.GetInstance().GetConfig<RoleConfig>(logicID);
		Debug.Log("缓存角色tpose " + config.BattleModelPath + " @" + Time.realtimeSinceStartup);
		yield return null;
		Record();
		Asset.Cache(config.BattleModelPath);
		yield return null;
		Print(config.BattleModelPath);
		yield return null;
		if (role == null)
		{
			Debug.Log("====>>>> 找不到 " + logicID);
			yield break;
		}
		yield return null;
		Record();
		LoadCharFlowscript(role.FlowCavansID);
		yield return null;
		if (!string.IsNullOrEmpty(config.RenderFlowscript) && !loadedCharFlowScript.Contains(config.RenderFlowscript))
		{
			LoadBaseFlowScripts(config.RenderFlowscript);
			Debug.Log("加载角色渲染图 flowscript" + config.RenderFlowscript + " " + Time.realtimeSinceStartup);
			loadedCharFlowScript.Add(config.RenderFlowscript);
		}
		yield return null;
		Print("LoadCharFlowscript " + role.FlowCavansID);
		yield return null;
		Record();
		LoadTimeline(config.RenderTimeline);
		for (int i = 0; i < additionalRenderTimelineArray.Count; i++)
		{
			Debug.Log("加载渲染挂件timeline " + additionalRenderTimelineArray.get_Item(i) + " " + Time.realtimeSinceStartup);
			LoadTimeline(additionalRenderTimelineArray.get_Item(i));
		}
		yield return null;
		Print(config.RenderTimeline);
		if (role.AdditionalRoleIDs.Count <= 0)
		{
			yield break;
		}
		for (int j = 0; j < role.AdditionalRoleIDs.Count; j++)
		{
			int num = role.AdditionalRoleIDs.get_Item(j);
			if (num == config.Transfiguration / 100)
			{
				num = config.Transfiguration;
			}
			IEnumerator cit = CacheRenderCharactor(num);
			while (cit.MoveNext())
			{
				yield return null;
			}
		}
	}

	protected void InitFollowCamera(Skin config, GameObject agentGameObject)
	{
		GameObject gameObject = Asset.InstantiateWithoutCache("Camera/CMFreeLookFollowCamera2");
		gameObject.name = "FollowCamera";
		virtualCameraParam = gameObject.GetComponent<CameraParamComponent>();
		if (ConfigHelper.GetInstance().TryGetConfig<FollowCameraParam>(config.BattleCameraParam, out var config2))
		{
			virtualCameraParam.lockTargetCinemachine.heightLock = config2.LockHeight;
			virtualCameraParam.lockTargetCinemachine.heightDefault = config2.FollowHeight;
			virtualCameraParam.lockTargetCinemachine.curHeight = config2.FollowHeight;
			virtualCameraParam.lockTargetCinemachine.radiusLock = config2.LockRadius;
			virtualCameraParam.lockTargetCinemachine.radiusDefault = config2.FollowRadius;
			virtualCameraParam.lockTargetCinemachine.curRadius = config2.FollowRadius;
			virtualCameraParam.lockTargetCinemachine.followCameraLock = config2.LockHeight;
			U3DUtil.Get<CinemachineCameraOffset>(gameObject).m_Offset = new Vector3(config2.OffsetX, config2.OffsetY, config2.OffsetZ);
		}
		U3DUtil.Get<CinemachineBrain>(Camera.main.gameObject).m_UpdateMethod = CinemachineBrain.UpdateMethod.LateUpdate;
		virtualCameraParam.virtualCamera.Follow = agentGameObject.transform;
		Transform transform = agentGameObject.transform.Find("Bip001");
		if (transform == null)
		{
			transform = agentGameObject.transform.Find("MotionRoot/Bip001");
		}
		if (transform == null)
		{
			transform = agentGameObject.transform.Find("root/Bip001");
		}
		if (transform == null)
		{
			transform = agentGameObject.transform.Find("Dummy002");
		}
		if (transform == null)
		{
			transform = agentGameObject.transform.Find("root/Bone001");
		}
		if (transform == null)
		{
			transform = agentGameObject.transform;
			Debug.LogError("相机找不到lookAt点");
		}
		virtualCameraParam.targetGroup.m_Targets[0].target = agentGameObject.transform;
		virtualCameraParam.composer.m_TrackedObjectOffset = transform.position - agentGameObject.transform.position;
		if (config.Hero == 1054)
		{
			Vector3 trackedObjectOffset = virtualCameraParam.composer.m_TrackedObjectOffset;
			virtualCameraParam.composer.m_TrackedObjectOffset = trackedObjectOffset.NewX(0f);
		}
		CameraExtension = Camera.main.gameObject.GetComponent<CameraExtension>();
	}

	public Dictionary<int, GameObject> GetRenderCharactor()
	{
		return mRenderCharactorCache;
	}

	public List<FlowScriptController> GetTriggers(int id)
	{
		return mMapTriggers[id].flowScripts;
	}

	public Blackboard GetTriggerBlackboards(int id)
	{
		return mMapTriggers[id].blackboard as Blackboard;
	}

	public List<string> GetTypesFromEntityData(EntityData entityData)
	{
		List<string> list = new List<string>();
		foreach (FlowScriptMeta item in entityData.flowScript)
		{
			list.Add(Path.GetFileNameWithoutExtension(item.scriptPath));
		}
		return list;
	}

	public List<string> GetTriggerTypes(int id)
	{
		return mMapTriggers[id].types;
	}

	public virtual IEnumerator LoadMapTriggerData(string name, bool ImmediateCache = false)
	{
		Mapdata mapData = Asset.Load<Mapdata>(name);
		Dictionary<string, FlowScriptController> loadedFlowScript = new Dictionary<string, FlowScriptController>();
		if (null == mapData)
		{
			Debug.LogError("Cán't Load MapData by " + name);
			yield break;
		}
		GameObject flowScript = new GameObject("FlowScript");
		for (int i = 0; i < mapData.entityDatas.Count; i++)
		{
			EntityData entityData = mapData.entityDatas[i];
			MapTrigger triggerData = new MapTrigger();
			GameObject trigger = new GameObject(entityData.name);
			trigger.transform.SetParent(flowScript.transform);
			Blackboard blackboard = trigger.AddComponent<Blackboard>();
			blackboard.BinDeserialize(entityData.binBlackboard);
			triggerData.id = entityData.id;
			triggerData.types = GetTypesFromEntityData(entityData);
			triggerData.blackboard = blackboard;
			triggerData.flowScripts = new List<FlowScriptController>();
			for (int j = 0; j < entityData.flowScript.Count; j++)
			{
				string scriptPath = entityData.flowScript[j].scriptPath;
				if (loadedFlowScript.ContainsKey(scriptPath))
				{
					triggerData.flowScripts.Add(loadedFlowScript[scriptPath]);
					continue;
				}
				FlowScriptController flowScriptController = trigger.AddComponent<FlowScriptController>();
				flowScriptController.enableAction = GraphOwner.EnableAction.DoNothing;
				flowScriptController.disableAction = GraphOwner.DisableAction.DoNothing;
				yield return null;
				Record();
				Debug.Log("load script: " + scriptPath);
				FlowScript originalGraph = Asset.Load<FlowScript>(scriptPath);
				flowScriptController.graph = flowScriptController.GetInstance(originalGraph);
				triggerData.flowScripts.Add(flowScriptController);
				loadedFlowScript.Add(scriptPath, flowScriptController);
				flowScripts.Add(flowScriptController);
				yield return null;
				Print(scriptPath);
			}
			mMapTriggers[triggerData.id] = triggerData;
			if (triggerData.id == 0)
			{
				Variable<List<string>> list = blackboard.GetVariable<List<string>>("EnemyList");
				if (list != null && list.value != null)
				{
					for (int j = 0; j < list.value.Count; j++)
					{
						if (!int.TryParse(list.value[j], out var result))
						{
							continue;
						}
						if (!ImmediateCache)
						{
							charList.Add(result);
							continue;
						}
						IEnumerator cit = CacheRenderCharactor(result);
						while (cit.MoveNext())
						{
							yield return null;
						}
					}
				}
				yield return null;
				Record();
				string scriptPath = blackboard.GetVariable<string>("地图网格资源路径").value;
				if (!string.IsNullOrEmpty(scriptPath))
				{
					LoadBinMap(scriptPath);
				}
				else
				{
					Debug.LogError("地图网格资源路径没有配置");
				}
				yield return null;
				Print(scriptPath);
				yield return null;
				Record();
				string mapTriggerPath = blackboard.GetVariable<string>("地图触发器路径").value;
				if (!string.IsNullOrEmpty(mapTriggerPath))
				{
					LoadTriggerMap(mapTriggerPath);
				}
				else
				{
					Debug.LogError("地图触发器路径没有配置");
				}
				triggerPath = mapTriggerPath;
				yield return null;
				Print(mapTriggerPath);
				string prefabPath = blackboard.GetVariable<string>("地图场景资源路径").value;
				if (!string.IsNullOrEmpty(prefabPath))
				{
					Debug.Log("==================> " + prefabPath);
					if (sceneName != prefabPath)
					{
						yield return null;
						Record();
						if (!string.IsNullOrEmpty(scenePath))
						{
							Scene sceneByPath = SceneManager.GetSceneByPath(scenePath);
							Scene sceneByName = SceneManager.GetSceneByName("Common");
							GameObject[] rootGameObjects = sceneByPath.GetRootGameObjects();
							foreach (GameObject gameObject in rootGameObjects)
							{
								if (!(sceneSetting.gameObject == gameObject) && !(gameObject.GetComponent<PooledAsset>() == null))
								{
									SceneManager.MoveGameObjectToScene(gameObject, sceneByName);
								}
							}
							AsyncOperation op = SceneManager.UnloadSceneAsync(sceneByPath);
							while (!op.isDone)
							{
								yield return null;
							}
							Asset.Unload(scenePath);
							AsyncOperation unloadOp = Resources.UnloadUnusedAssets();
							while (!unloadOp.isDone)
							{
								yield return null;
							}
						}
						yield return null;
						Print("卸载老场景");
						yield return null;
						Record();
						sceneName = prefabPath;
						AssetManager.TryGetAssetNameAndBundleName(prefabPath, out scenePath, out var _);
						Asset.LoadLevelSync(prefabPath, isAddtive: true);
						yield return null;
						Print("加载新场景 " + prefabPath);
					}
				}
				else
				{
					Debug.LogError("地图预制体资源路径没有配置");
				}
			}
			if (blackboard != null)
			{
				Variable<List<int>> variable = blackboard.GetVariable<List<int>>("词缀ID");
				if (variable != null && variable.value != null)
				{
					List<int> value = variable.value;
					mMapConfigAffixes.AddRange(value);
				}
			}
		}
		if (ready.SceneDataForExcehange.TargetEnemyID != 0)
		{
			if (!ImmediateCache)
			{
				charList.Add(ready.SceneDataForExcehange.TargetEnemyID);
			}
			else
			{
				IEnumerator cit = CacheRenderCharactor(ready.SceneDataForExcehange.TargetEnemyID);
				while (cit.MoveNext())
				{
					yield return null;
				}
			}
		}
		yield return null;
	}

	public void UnLoadMapTriggerData(int sceneID)
	{
		if (mMapTriggers != null && mMapTriggers.Count > 0)
		{
			foreach (KeyValuePair<int, MapTrigger> mMapTrigger in mMapTriggers)
			{
				IBlackboard blackboard = mMapTrigger.Value.blackboard;
				List<FlowScriptController> list = mMapTrigger.Value.flowScripts;
				for (int i = 0; i < list.Count; i++)
				{
					flowScripts.Remove(list[i]);
				}
				if (blackboard != null && mMapTrigger.Value.id == 0)
				{
					blackboard.GetVariable<List<string>>("EnemyList");
					string value = blackboard.GetVariable<string>("地图场景资源路径").value;
					mMapConfigAffixes.Clear();
					mBinMap = null;
					mTriggerData = null;
					if (!string.IsNullOrEmpty(value))
					{
						Debug.Log("unload==================> " + value);
						sceneName = value;
						SceneManager.SetActiveScene(SceneManager.GetSceneByName("Common"));
					}
					else
					{
						Debug.LogError("地图预制体资源路径没有配置");
					}
				}
			}
		}
		UnityEngine.Object.Destroy(GameObject.Find("FlowScript"));
		mMapTriggers.Clear();
	}

	public void LoadEquipFlowScript()
	{
		GameObject go = new GameObject("EquipmentFlowScripts");
		List<string> loadedEquip = new List<string>();
		loadedEquip.Clear();
		IEnumerator<RoleDataForExchangeInfo> enumerator = ready.SceneDataForExcehange.RoleDataInLua.GetEnumerator();
		while (enumerator.MoveNext())
		{
			RoleDataForExchangeInfo current = enumerator.Current;
			if (current.WeaponEffectID != 0)
			{
				RepeatedField<string> flowName = ConfigHelper.GetInstance().GetConfig<weapon_effect>(current.WeaponEffectID).FlowName;
				for (int i = 0; i < flowName.Count; i++)
				{
					loadEquipFlowScript(flowName.get_Item(i));
				}
			}
			if (current.AIChip != null)
			{
				for (int j = 0; j < current.AIChip.Count; j++)
				{
					int num = current.AIChip.get_Item(j);
					if (num == 0)
					{
						break;
					}
					RepeatedField<string> flowName2 = ConfigHelper.GetInstance().GetConfig<ai_chip>(num).FlowName;
					for (int k = 0; k < flowName2.Count; k++)
					{
						loadEquipFlowScript(flowName2.get_Item(k));
					}
				}
			}
			if (current.Equipment == null)
			{
				continue;
			}
			for (int l = 0; l < current.Equipment.Count; l++)
			{
				int num2 = current.Equipment.get_Item(l);
				if (num2 == 0)
				{
					break;
				}
				string flowName3 = ConfigHelper.GetInstance().GetConfig<equip_effect>(num2).FlowName;
				loadEquipFlowScript(flowName3);
			}
			for (int m = 0; m < current.EquipmentSkill.Count; m++)
			{
				int num3 = current.EquipmentSkill.get_Item(m);
				if (num3 == 0)
				{
					break;
				}
				num3 = ConfigHelper.GetInstance().GetConfig<equip_skill>(num3).EquipEffectId;
				string flowName4 = ConfigHelper.GetInstance().GetConfig<equip_effect>(num3).FlowName;
				loadEquipFlowScript(flowName4);
			}
		}
		if (ready.SceneDataForExcehange.TypeIDListAffix != null)
		{
			for (int n = 0; n < ready.SceneDataForExcehange.TypeIDListAffix.Count; n++)
			{
				RepeatedField<string> flowscript = ConfigHelper.GetInstance().GetConfig<affix_type>(ready.SceneDataForExcehange.TypeIDListAffix.get_Item(n)).Flowscript;
				if (flowscript != null)
				{
					for (int num4 = 0; num4 < flowscript.Count; num4++)
					{
						loadEquipFlowScript(flowscript.get_Item(num4));
					}
				}
			}
		}
		if (mMapConfigAffixes != null)
		{
			for (int num5 = 0; num5 < mMapConfigAffixes.Count; num5++)
			{
				RepeatedField<string> flowscript2 = ConfigHelper.GetInstance().GetConfig<affix_type>(mMapConfigAffixes[num5]).Flowscript;
				if (flowscript2 != null)
				{
					for (int num6 = 0; num6 < flowscript2.Count; num6++)
					{
						loadEquipFlowScript(flowscript2.get_Item(num6));
					}
				}
			}
		}
		if (ready.SceneDataForExcehange.VHLSkillID == null)
		{
			return;
		}
		for (int num7 = 0; num7 < ready.SceneDataForExcehange.VHLSkillID.Count; num7++)
		{
			if (ready.SceneDataForExcehange.VHLSkillID.get_Item(num7) != 0)
			{
				activity_reforge_skill config = ConfigHelper.GetInstance().GetConfig<activity_reforge_skill>(ready.SceneDataForExcehange.VHLSkillID.get_Item(num7));
				if (config != null)
				{
					loadEquipFlowScript(config.FlowId);
				}
			}
		}
		void loadEquipFlowScript(string name)
		{
			if (!string.IsNullOrEmpty(name) && !loadedEquip.Contains(name))
			{
				Debug.Log("加载 " + name);
				FlowScriptController flowScriptController = go.AddComponent<FlowScriptController>();
				flowScriptController.enableAction = GraphOwner.EnableAction.DoNothing;
				flowScriptController.disableAction = GraphOwner.DisableAction.DoNothing;
				FlowScript originalGraph = Asset.Load<FlowScript>(name);
				flowScriptController.graph = flowScriptController.GetInstance(originalGraph);
				flowScripts.Add(flowScriptController);
				loadedEquip.Add(name);
			}
		}
	}

	public void LoadCharFlowscript(int id)
	{
		if (loadedCharFlowScript.Contains(id.ToString()))
		{
			return;
		}
		loadedCharFlowScript.Add(id.ToString());
		Debug.Log("加载角色flowscript" + id + " " + Time.realtimeSinceStartup);
		string prefabPath = $"FlowScript/Char/{id}_FlowscriptPrefab";
		if (mapConfig != null && mapConfig.SpCharID != null && mapConfig.SpCharID.Count > 0)
		{
			for (int i = 0; i < mapConfig.SpCharID.Count; i++)
			{
				if (mapConfig.SpCharID.get_Item(i) == id)
				{
					prefabPath = mapConfig.SpLogicPath.get_Item(i);
					break;
				}
			}
		}
		if (mapConfig.ActivityStrikeSystem && ConfigHelper.GetInstance().TryGetConfig<ActivityStrikeSystem>(id, out var config) && !string.IsNullOrEmpty(config.SpLogicPath))
		{
			prefabPath = config.SpLogicPath;
		}
		LoadBaseFlowScripts(prefabPath);
	}

	public override void OnSceneLoaded()
	{
	}
}
