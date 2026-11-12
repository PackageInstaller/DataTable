using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text;
using Coffee.UIEffects;
using Coffee.UIExtensions;
using DG.Tweening;
using DG.Tweening.Core;
using DG.Tweening.Plugins.Options;
using ExcelDataReader;
using Live2D.Cubism.Core;
using Live2D.Cubism.Rendering;
using Live2D.Cubism.Rendering.Masking;
using Mobcast.Coffee.UI;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using Newtonsoft.Json;
using Nova.Hotfix;
using TMPro;
using TrueSync;
using UnityEngine;
using UnityEngine.Android;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Playables;
using UnityEngine.Rendering.Universal;
using UnityEngine.UI;
using UnityEngine.UI.Extensions;
using XLua;

public static class NovaAPI
{
	private static readonly Dictionary<string, int> RecorderKeys = new Dictionary<string, int>();

	public static string ApplicationDataPath => Application.dataPath;

	public static string StreamingAssetsPath => Application.streamingAssetsPath;

	public static Dictionary<string, string[]> dictL2DFallbackOrder
	{
		get
		{
			return NovaCoreAPI.dictL2DFallbackOrder;
		}
		set
		{
			NovaCoreAPI.dictL2DFallbackOrder = value;
		}
	}

	public static string TOKEN
	{
		get
		{
			if (!(MonoSingleton<HttpNetworkManager>.Instance == null))
			{
				return MonoSingleton<HttpNetworkManager>.Instance.TOKEN;
			}
			return null;
		}
		set
		{
			if (MonoSingleton<HttpNetworkManager>.Instance != null)
			{
				MonoSingleton<HttpNetworkManager>.Instance.TOKEN = value;
			}
		}
	}

	public static HttpNetworkManager.ServerListInfo ServerListInfo
	{
		get
		{
			if (!(MonoSingleton<HttpNetworkManager>.Instance == null))
			{
				return MonoSingleton<HttpNetworkManager>.Instance.serverInfo;
			}
			return null;
		}
	}

	public static float GetGlobalTimeScale()
	{
		return (float)LockStepManager.globalTimeScale;
	}

	public static float GetLogicTimeScale()
	{
		return (float)LockStepManager.logicTimeScale;
	}

	public static float GetLogicTime()
	{
		return (float)LockStepManager.time;
	}

	public static float GetLogicUnscaledTime()
	{
		return (float)LockStepManager.unscaledTime;
	}

	public static float GetLogicDeltaTime()
	{
		return (float)LockStepManager.deltaTime;
	}

	public static float GetLogicUnscaledDeltaTime()
	{
		return (float)LockStepManager.unscaledDeltaTime;
	}

	public static string GetNotificationSettings()
	{
		bool flag = true;
		int num = 0;
		using (AndroidJavaClass androidJavaClass = new AndroidJavaClass("android.os.Build$VERSION"))
		{
			num = androidJavaClass.GetStatic<int>("SDK_INT");
		}
		if (num >= 33)
		{
			flag = Permission.HasUserAuthorizedPermission("android.permission.POST_NOTIFICATIONS");
		}
		if (!flag)
		{
			return "Denied";
		}
		return "Granted";
	}

	public static bool IsInputEnabled()
	{
		if (SceneSingleton<AdventurePlayerController>.Instance != null)
		{
			return SceneSingleton<AdventurePlayerController>.Instance.inputEnabled;
		}
		return false;
	}

	public static void InputEnable()
	{
		if (SceneSingleton<AdventurePlayerController>.Instance != null)
		{
			SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
		}
	}

	public static void InputDisable()
	{
		if (SceneSingleton<AdventurePlayerController>.Instance != null)
		{
			SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		}
	}

	public static void SetTouchScreenSupport(bool val)
	{
		CrossPlatformInputManager.SetTouchScreenSupport(val);
	}

	public static void SetNormalSupport(bool val)
	{
		CrossPlatformInputManager.SetNormalSupport(val);
	}

	public static void RegisterVirtualJoystick(string x, string y, GameObject go)
	{
		CrossPlatformInputManager.RegisterVirtualJoystick(x, y, go);
	}

	public static void RegisterVirtualButton(string buttonName, GameObject go)
	{
		CrossPlatformInputManager.RegisterVirtualButton(buttonName, go);
	}

	public static void RegisterRealButton(string buttonName, float holdThreshold)
	{
		CrossPlatformInputManager.RegisterRealButton(buttonName, holdThreshold);
	}

	public static void RegisterRealAxisButton(string buttonName, float holdThreshold, float pressThreshold)
	{
		CrossPlatformInputManager.RegisterRealAxisButton(buttonName, holdThreshold, pressThreshold);
	}

	public static void RegisterRealMouseButton(string buttonName, float holdThreshold)
	{
		CrossPlatformInputManager.RegisterRealMouseButton(buttonName, holdThreshold);
	}

	public static void UnRegisterVirtualJoystick(string x, string y)
	{
		CrossPlatformInputManager.UnRegisterVirtualJoystick(x, y);
	}

	public static void UnRegisterVirtualButton(string buttonName)
	{
		CrossPlatformInputManager.UnRegisterVirtualButton(buttonName);
	}

	public static void UnRegisterRealButton(string buttonName)
	{
		CrossPlatformInputManager.UnRegisterRealButton(buttonName);
	}

	public static void UnRegisterRealAxisButton(string buttonName)
	{
		CrossPlatformInputManager.UnRegisterRealAxisButton(buttonName);
	}

	public static void UnRegisterRealMouseButton(string buttonName)
	{
		CrossPlatformInputManager.UnRegisterRealMouseButton(buttonName);
	}

	public static void SetRealButtonActive(string name, bool active)
	{
		CrossPlatformInputManager.SetRealButtonActive(name, active);
	}

	public static void AddRecorderKey(string key, int val)
	{
		if (key != null)
		{
			if (RecorderKeys.ContainsKey(key))
			{
				RecorderKeys.set_Item(key, val);
			}
			else
			{
				RecorderKeys.Add(key, val);
			}
		}
	}

	public static bool GetRecorderKey(string key, out int val)
	{
		return RecorderKeys.TryGetValue(key, out val);
	}

	public static void SetRecorderFloorId(int floorId)
	{
		ModuleController<AdventureModuleController>.Instance?.SetFloorId(floorId);
	}

	public static void SetRecorderExcludeIds(List<int> excludeIds)
	{
		ModuleController<AdventureModuleController>.Instance?.SetExcludeIds(excludeIds);
	}

	public static void StopRecord()
	{
		ModuleController<AdventureModuleController>.Instance?.StopRecord();
	}

	public static void SetBuglyPlayerUid(string uid)
	{
		if (MonoSingleton<GameBuglyManager>.Instance != null)
		{
			MonoSingleton<GameBuglyManager>.Instance.SetPlayerUid(uid);
		}
	}

	public static void SendLogsToFeishu(string name, Action onSuccessCallback, Action<string> onErrorCallback)
	{
		Singleton<LogManager>.Instance.SendLogsToFeishu(name, onSuccessCallback, onErrorCallback);
	}

	public static AchievementManager.AchievementDataDic GetAchievementData()
	{
		if (!(SceneSingleton<AchievementManager>.Instance == null))
		{
			return SceneSingleton<AchievementManager>.Instance.GetAchievementData();
		}
		return default;
	}

	public static bool IsDirtyWordsInit()
	{
		if (Singleton<DirtyWords>.Instance != null)
		{
			return Singleton<DirtyWords>.Instance.Initialized;
		}
		return false;
	}

	public static void InitDirtyWords()
	{
		Singleton<DirtyWords>.Instance?.Init();
	}

	public static void ShutdownDirtyWords()
	{
		Singleton<DirtyWords>.Instance?.Shutdown();
	}

	public static bool IsDirtyString(string inputString)
	{
		return false;
	}

	public static bool IsChannelString(string inputString)
	{
		return InputRegex.IsChannelString(inputString);
	}

	public static bool IsBinFormatEnabled()
	{
		return GameDataController.binFormatEnabled;
	}

	public static void LoadAllDataTable(string languageType)
	{
		Singleton<GameDataController>.Instance?.Load(languageType);
	}

	public static void UnLoadAllDataTable()
	{
		Singleton<GameDataController>.Instance?.Unload();
	}

	public static string LoadTextData(string filepath)
	{
		return Singleton<GameDataController>.Instance?.LoadTextData(filepath);
	}

	public static string LoadTableData(string filepath)
	{
		return Singleton<GameDataController>.Instance?.LoadTableData(filepath);
	}

	public static void LoadCommonBinData(string filepath, LuaTable tab)
	{
		Singleton<GameDataController>.Instance?.LoadCommonBinData(filepath, tab);
	}

	public static string GetCurrentModuleName()
	{
		if (!(MonoSingleton<GameController>.Instance == null))
		{
			return MonoSingleton<GameController>.Instance.currentModuleName;
		}
		return null;
	}

	public static void EnterModule(string moduleName, bool clearHistory, int loadingType = 3, Action callback = null)
	{
		if (MonoSingleton<GameController>.Instance != null)
		{
			MonoSingleton<GameController>.Instance.EnterModule(moduleName, clearHistory, loadingType, callback);
		}
	}

	public static void ExitCurrentModule()
	{
		if (MonoSingleton<GameController>.Instance != null)
		{
			MonoSingleton<GameController>.Instance.ExitCurrentModule();
		}
	}

	public static void GetLoadParam(out AdventureModuleLevelLoadParams.BootConfigLoadType loadType, out string mapId, out string id, out int floor, out List<int> actors, out List<FixedRoguelikeRoomData> fixedRoguelikeRoomData, out int[] affixes, out int[] breakCounts, out int[] levels, out int stageId, out List<OutfiInfo> outfitList, out bool isVampireFirstHalf, out List<NoteInfo> noteList, out List<int> skins)
	{
		loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.None;
		mapId = null;
		id = null;
		actors = null;
		skins = null;
		floor = 0;
		fixedRoguelikeRoomData = null;
		affixes = null;
		breakCounts = null;
		levels = null;
		stageId = 0;
		outfitList = null;
		noteList = null;
		isVampireFirstHalf = false;
		if (!(MonoSingleton<GameController>.Instance == null) && AdventureGameContext.LevelLoadParam != null)
		{
			loadType = AdventureGameContext.LevelLoadParam.loadType;
			mapId = AdventureGameContext.LevelLoadParam.mapId;
			id = AdventureGameContext.LevelLoadParam.id;
			actors = AdventureGameContext.TeamConfig.ActorIDs.ToList();
			skins = AdventureGameContext.TeamConfig.ActorSkins.ToList();
			floor = AdventureGameContext.LevelLoadParam.floor;
			fixedRoguelikeRoomData = AdventureGameContext.LevelLoadParam.fixedRoguelikeRoomData;
			affixes = AdventureGameContext.TeamConfig.TravelerDuelAffixes.ToArray();
			breakCounts = AdventureGameContext.TeamConfig.BreakCounts;
			levels = AdventureGameContext.TeamConfig.Levels;
			stageId = AdventureGameContext.LevelLoadParam.starTowerStageID;
			outfitList = AdventureGameContext.TeamConfig.OutfiList;
			isVampireFirstHalf = AdventureGameContext.LevelLoadParam.isVampireFirstHalf;
			noteList = AdventureGameContext.TeamConfig.NoteList;
		}
	}

	public static int GetDynamicLevelTypeBootConfig()
	{
		return AdventureGameContext.LevelLoadParam.dynamicLevelType;
	}

	public static string[] GetDynamicLevelParamsBootConfig()
	{
		return AdventureGameContext.LevelLoadParam.enterDynamicLevelParams;
	}

	public static HotfixEnum.elementType GetAutoBattleBalanceEET()
	{
		return AdventureGameContext.LevelLoadParam.autoBattleBalanceEET;
	}

	public static List<ABTeam> GetAutoBattleBalanceConfigTeam()
	{
		if (AdventureGameContext.LevelLoadParam.autoBattleBalanceConfig != null)
		{
			return AdventureGameContext.LevelLoadParam.autoBattleBalanceConfig.ABTeamlist;
		}
		return null;
	}

	public static void ExitGame()
	{
		if (MonoSingleton<GameController>.Instance != null)
		{
			MonoSingleton<GameController>.Instance.ExitGame();
		}
	}

	public static void SetEntryLevelFade(bool isFade)
	{
		if (MonoSingleton<GameController>.Instance != null)
		{
			MonoSingleton<GameController>.Instance.entryLevelUIFadeIn = isFade;
		}
	}

	public static bool GetEntryLevelFade()
	{
		if (MonoSingleton<GameController>.Instance != null)
		{
			return MonoSingleton<GameController>.Instance.entryLevelUIFadeIn;
		}
		return false;
	}

	public static string GetClientChannel()
	{
		return ClientConfig.ChannelName;
	}

	[Obsolete]
	public static string GetClientChannelName()
	{
		return ClientConfig.CurrentVendorEnvData.serverChannelName;
	}

	public static string GetServerLoginName()
	{
		return ClientConfig.CurrentVendorEnvData.serverLoginName;
	}

	public static string GetServerChannelName()
	{
		return ClientConfig.CurrentVendorEnvData.serverChannelName;
	}

	public static byte[] LoadLuaBytes(ref string filepath)
	{
		if (!(MonoSingleton<LuaManager>.Instance == null))
		{
			return MonoSingleton<LuaManager>.Instance.LoadBytes(ref filepath);
		}
		return null;
	}

	public static bool IsMobilePlatform()
	{
		return Application.isMobilePlatform;
	}

	public static void OpenURL(string url)
	{
		Application.OpenURL(url);
	}

	public static bool IsRuntimeWindowsPlayer()
	{
		return Application.platform == RuntimePlatform.WindowsPlayer;
	}

	public static bool IsEditorPlatform()
	{
		if (Application.platform != RuntimePlatform.WindowsEditor)
		{
			return Application.platform == RuntimePlatform.OSXEditor;
		}
		return true;
	}

	public static string GetDeviceId()
	{
		string text = "";
		try
		{
			using AndroidJavaObject androidJavaObject = new AndroidJavaClass("com.unity3d.player.UnityPlayer").GetStatic<AndroidJavaObject>("currentActivity");
			AndroidJavaObject androidJavaObject2 = androidJavaObject.Call<AndroidJavaObject>("getContentResolver", Array.Empty<object>());
			text = new AndroidJavaClass("android.provider.Settings$Secure").CallStatic<string>("getString", new object[2] { androidJavaObject2, "android_id" });
			if (string.IsNullOrEmpty(text))
			{
				text = androidJavaObject.Call<AndroidJavaObject>("getSystemService", new object[1] { "wifi" }).Call<AndroidJavaObject>("getConnectionInfo", Array.Empty<object>()).Call<string>("getMacAddress", Array.Empty<object>());
			}
		}
		catch (Exception ex)
		{
			Debug.LogError(ex.Message);
			text = "fail";
		}
		return text;
	}

	public static string GetClientVersion()
	{
		return MonoSingleton<ClientManager>.Instance.GetPublicVersion();
	}

	public static string GetResVersion()
	{
		return MonoSingleton<ClientManager>.Instance.GetServerResourceVersion();
	}

	public static bool IsReviewServerEnv()
	{
		return ClientConfig.IsReviewServerEnv;
	}

	public static bool DispatchEventWithData(string type, object sender, object data)
	{
		if (Singleton<EventDispatchManager>.Instance != null)
		{
			return Singleton<EventDispatchManager>.Instance.DispatchEventWithData(type, sender, data);
		}
		return false;
	}

	public static void PlayGachaOpenDoor(GameObject go, int rare, int type)
	{
		GachaVideoController component = go.GetComponent<GachaVideoController>();
		if (component != null)
		{
			switch (rare)
			{
			case 1:
				component.ShowSSR(type);
				break;
			case 2:
				component.ShowSR();
				break;
			case 3:
				component.ShowR();
				break;
			}
		}
	}

	public static void PlayGachaDisc(GameObject go, int type, int rare, bool sup)
	{
		GachaVideoController component = go.GetComponent<GachaVideoController>();
		if (component != null)
		{
			component.ShowDisc(type, rare, sup);
		}
	}

	public static void PlayCustomVideo(GameObject go, string[] path, bool[] loop, bool[] canJump, int[] closeIdx, int[] reopenIdx, bool[] showEft)
	{
		GachaVideoController component = go.GetComponent<GachaVideoController>();
		if (component != null)
		{
			component.ShowCustomList(path, loop, canJump, closeIdx, reopenIdx, showEft);
		}
	}

	public static void PlayVideo(GameObject goPlayerVideo, string[] videoFileNameOrder, string[] soundTrackNameOrder, string[] srtFileNameOrder, bool bDebugLog = false)
	{
		if (!(goPlayerVideo == null))
		{
			PlayerVideo component = goPlayerVideo.GetComponent<PlayerVideo>();
			if (!(component == null))
			{
				component.PlayVideo(videoFileNameOrder, soundTrackNameOrder, srtFileNameOrder, bDebugLog);
			}
		}
	}

	public static void SetL2DAnimFallbackRules(string sJson)
	{
		NovaCoreAPI.SetL2DAnimFallbackRules(sJson);
	}

	public static float PlayL2DCGAnim(Transform tr)
	{
		PlayableDirector component = tr.GetComponent<PlayableDirector>();
		if (component != null && component.playableAsset != null)
		{
			component.Play();
			return (float)component.duration;
		}
		return 0f;
	}

	public static void BindL2dColorController(GameObject goController, GameObject goL2d)
	{
		if (!(goController == null) && !(goL2d == null))
		{
			goController.GetComponent<L2DScreenColorController>().BindL2DRendererController(goL2d.GetComponentInChildren<CubismRenderController>());
		}
	}

	public static void UnBindL2dColorController(GameObject goController)
	{
		if (!(goController == null))
		{
			goController.GetComponent<L2DScreenColorController>().UnBindL2DRendererController();
		}
	}

	public static void SetL2DTimeState(bool isUnscledTime)
	{
		CubismMotionTimeUtil.SetTimeState(isUnscledTime);
	}

	public static int GetMaskTextureSize()
	{
		return CubismMaskTexture.TextureSize;
	}

	public static void SetMaskTextureSize(int size)
	{
		CubismMaskTexture.TextureSize = size;
	}

	public static int GetMaskFilterMode()
	{
		return (int)CubismMaskTexture.MaskFilterMode;
	}

	public static void SetMaskFilterMode(int mode)
	{
		CubismMaskTexture.MaskFilterMode = (FilterMode)mode;
	}

	public static int GetMaskMaxRenderTextureCount()
	{
		return CubismMaskTexture.MaxRenderTextureCount;
	}

	public static void SetMaskMaxRenderTextureCount(int count)
	{
		CubismMaskTexture.MaxRenderTextureCount = count;
	}

	public static int GetMaskRenderTextureCount()
	{
		return CubismMaskTexture.RenderTextureCount;
	}

	public static int GetMaskTotalUsedCount()
	{
		return CubismMaskTexture.TotalUsedCount;
	}

	public static void DisposeMaskTexture()
	{
		CubismMaskTexture.Dispose();
	}

	public static string CompressString(string str)
	{
		return Convert.ToBase64String(GZipUtils.CompressString(str));
	}

	public static string CompressBytes(byte[] bytes)
	{
		return Convert.ToBase64String(GZipUtils.CompressBytes(bytes));
	}

	public static byte[] DecompressString(string str)
	{
		return GZipUtils.DecompressBytes(Convert.FromBase64String(str));
	}

	public static string ParseStarTowerData(StarTowerTempData data)
	{
		return JsonConvert.SerializeObject(data);
	}

	public static StarTowerTempData DecodeStarTowerData(string jsonStr)
	{
		if (string.IsNullOrEmpty(jsonStr))
		{
			return new StarTowerTempData(1);
		}
		return JsonConvert.DeserializeObject<StarTowerTempData>(jsonStr);
	}

	public static string ParseStarTowerDataCompressed(StarTowerTempData data, out int length)
	{
		string text = JsonConvert.SerializeObject(data);
		Encoding.Default.GetBytes(text);
		Debug.Log("Origin Length:" + Encoding.Default.GetByteCount(text));
		string text2 = Convert.ToBase64String(GZipUtils.CompressString(text, System.IO.Compression.CompressionLevel.Optimal));
		length = Encoding.Default.GetByteCount(text2);
		Debug.Log("Bytes Length:" + length);
		return text2;
	}

	public static StarTowerTempData DecodeStarTowerDataCompressed(string str)
	{
		if (string.IsNullOrEmpty(str))
		{
			return new StarTowerTempData(1);
		}
		try
		{
			string value = GZipUtils.DecompressString(Convert.FromBase64String(str));
			if (string.IsNullOrEmpty(value))
			{
				return new StarTowerTempData(1);
			}
			return JsonConvert.DeserializeObject<StarTowerTempData>(value);
		}
		catch (Exception ex)
		{
			Debug.LogError("Decompress failed: " + ex.Message);
			return new StarTowerTempData(1);
		}
	}

	public static long GetJointDrillBossMaxHp(int monsterId, int difficulty)
	{
		Monster monster = Singleton<HotfixDataController>.Instance.GetMonster(monsterId);
		if (monster == null)
		{
			return 0L;
		}
		MonsterValueTempleteAdjust monsterValueTempleteAdjust = Singleton<HotfixDataController>.Instance.GetMonsterValueTempleteAdjust(monster.Templete);
		if (monsterValueTempleteAdjust == null)
		{
			return 0L;
		}
		int num = monsterValueTempleteAdjust.TemplateId * 1000 + difficulty * 10 + 1;
		MonsterValueTemplete monsterValueTemplete = Singleton<HotfixDataController>.Instance.GetMonsterValueTemplete(num);
		if (monsterValueTemplete == null)
		{
			return 0L;
		}
		int hpRatio = monsterValueTempleteAdjust.HpRatio;
		long hpFix = monsterValueTempleteAdjust.HpFix;
		return (long)(monsterValueTemplete.Hp * (FDP.One + FDP.FromMyriad(hpRatio))) + hpFix;
	}

	public static JointDrillTempData DecodeJointDrillData(string jsonStr)
	{
		if (string.IsNullOrEmpty(jsonStr))
		{
			return new JointDrillTempData(1);
		}
		return JsonConvert.DeserializeObject<JointDrillTempData>(jsonStr);
	}

	public static string ParseJointDrillDataCompressed(JointDrillTempData data, out int length)
	{
		string text = JsonConvert.SerializeObject(data);
		Encoding.Default.GetBytes(text);
		Debug.Log("Origin Length:" + Encoding.Default.GetByteCount(text));
		string text2 = Convert.ToBase64String(GZipUtils.CompressString(text, System.IO.Compression.CompressionLevel.Optimal));
		length = Encoding.Default.GetByteCount(text2);
		Debug.Log("Bytes Length:" + length);
		return text2;
	}

	public static JointDrillTempData DecodeJointDrillDataCompressed(string str)
	{
		if (string.IsNullOrEmpty(str))
		{
			return new JointDrillTempData(1);
		}
		try
		{
			string value = GZipUtils.DecompressString(Convert.FromBase64String(str));
			if (string.IsNullOrEmpty(value))
			{
				return new JointDrillTempData(1);
			}
			return JsonConvert.DeserializeObject<JointDrillTempData>(value);
		}
		catch (Exception ex)
		{
			Debug.LogError("Decompress failed: " + ex.Message);
			return new JointDrillTempData(1);
		}
	}

	public static void ShowGMMonsterAI(long monsterId)
	{
	}

	public static void SetBuildReportInfo(string buildJson, string buildName, BuildCharData[] buildCharData, BuildDiscData[] buildDiscData, int[] secondarySkills, int[][] notes)
	{
		ModuleController<AdventureModuleController>.Instance.SetBuildData(buildJson, buildName, buildCharData, buildDiscData, secondarySkills, notes);
	}

	public static void TryUploadFile()
	{
		MonoSingleton<RankFileUploaderManager>.Instance.UploadCachedReport();
	}

	public static void UploadStartowerFile(string token, string reportId)
	{
		MonoSingleton<RankFileUploaderManager>.Instance.UploadBattleReport(token, reportId);
	}

	public static void DeleteRecFile(string reportId)
	{
		if (reportId == null)
		{
			Debug.Log("empty reportId");
			return;
		}
		string text = Path.Combine(Application.persistentDataPath, "Recorder/" + reportId + ".rec");
		if (!File.Exists(text))
		{
			Debug.LogError("Record file not exist:" + text);
		}
		else
		{
			new FileInfo(text).Delete();
		}
	}

	public static void SetReportUrl(string url)
	{
		MonoSingleton<RankFileUploaderManager>.Instance.SetUrl(url);
		MonoSingleton<RankFileUploaderManager>.Instance.UploadCachedReport();
	}

	public static void UserEventUpload(string strEventName, List<List<string>> parameter)
	{
		Dictionary<string, string> dictionary = new Dictionary<string, string>();
		for (int i = 0; i < parameter.Count; i++)
		{
			List<string> list = parameter.get_Item(i);
			dictionary.Add(list.get_Item(0), list.get_Item(1));
		}
		MonoSingleton<SDKManager>.Instance.UserEventUpload(strEventName, dictionary);
	}

	public static void ChangeAnimatorDefaultState(Transform rt)
	{
		Animator[] componentsInChildren = rt.GetComponentsInChildren<Animator>();
		if (componentsInChildren != null && componentsInChildren.Length != 0)
		{
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				componentsInChildren[i].writeDefaultValuesOnDisable = true;
			}
		}
	}

	public static void GuideProloguelSkill()
	{
		AdventureInputActionOperate adventureInputActionOperate = AdventureInputActionOperate.Generate();
		adventureInputActionOperate.key = ActionKey.B;
		adventureInputActionOperate.buttonState = ButtonState.Press;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureInputActionOperate);
	}

	public static bool IsLQA()
	{
		return Singleton<GameDataController>.Instance.isLQA;
	}

	public static void SetLQA(bool lqa)
	{
		Singleton<GameDataController>.Instance.isLQA = lqa;
	}

	public static void SetScreenSleepTimeout(bool bNeverSleep)
	{
		Screen.sleepTimeout = (bNeverSleep ? (-1) : (-2));
	}

	public static long FileGetLastWriteTime(string file)
	{
		DateTime lastWriteTime = File.GetLastWriteTime(file);
		return new DateTimeOffset(lastWriteTime).ToUnixTimeSeconds();
	}

	public static bool IsServerMaintained()
	{
		return Booter.serverMaintained;
	}

	public static string GetServerMaintainedInfo()
	{
		return Booter.serverMaintaineInfo;
	}

	public static void ResetIke()
	{
		if (MonoSingleton<HttpNetworkManager>.Instance != null)
		{
			MonoSingleton<HttpNetworkManager>.Instance.ResetIke();
		}
	}

	public static void SetRetryCount()
	{
		if (MonoSingleton<HttpNetworkManager>.Instance != null)
		{
			MonoSingleton<HttpNetworkManager>.Instance.SetRetryCount();
		}
	}

	public static void MarkServerTimeStamp(long serverTimeStamp)
	{
		if (MonoSingleton<HttpNetworkManager>.Instance != null)
		{
			MonoSingleton<HttpNetworkManager>.Instance.MarkServerTimeStamp(serverTimeStamp);
		}
	}

	public static void SetAeadKey(byte[] pubKey, int function)
	{
		if (MonoSingleton<HttpNetworkManager>.Instance != null)
		{
			MonoSingleton<HttpNetworkManager>.Instance.SetAeadKey(pubKey, function);
		}
	}

	public static byte[] GetPubKey()
	{
		if (!(MonoSingleton<HttpNetworkManager>.Instance == null))
		{
			return MonoSingleton<HttpNetworkManager>.Instance.GetPubKey();
		}
		return null;
	}

	public static HttpNetMsg ParseMessage(byte[] messageData, bool isNextPackage)
	{
		if (!(MonoSingleton<HttpNetworkManager>.Instance == null))
		{
			return MonoSingleton<HttpNetworkManager>.Instance.ParseMessage(messageData, isNextPackage);
		}
		return null;
	}

	public static void AddSendMsgRequest(short msgId, byte[] msgBody, Action<HttpNetMsg, object> callbackAction, string url)
	{
		if (MonoSingleton<HttpNetworkManager>.Instance != null)
		{
			MonoSingleton<HttpNetworkManager>.Instance.AddSendMsgRequest(msgId, msgBody, callbackAction, url);
		}
	}

	public static void RestartNetwork()
	{
		if (!(MonoSingleton<HttpNetworkManager>.Instance == null))
		{
			MonoSingleton<HttpNetworkManager>.Instance.Release();
			MonoSingleton<HttpNetworkManager>.Instance.Init();
		}
	}

	public static void ClearCachedCookie()
	{
		MonoSingleton<HttpNetworkManager>.Instance.ClearCachedCookies();
	}

	public static void CloseLaunchInfo(GameObject gameObject)
	{
		if (!(gameObject == null))
		{
			gameObject.GetComponent<LaunchUI>()?.CloseLaunchInfo();
		}
	}

	public static void CloseLaunchLoading(GameObject gameObject)
	{
		if (!(gameObject == null))
		{
			gameObject.GetComponent<LaunchUI>()?.CloseLaunchLoading();
		}
	}

	public static void OpenBooterRepairResourceMode()
	{
		Booter.mode = Booter.Mode.RepairResource;
	}

	public static string[] GetAvailable_TextLanguage()
	{
		return ClientConfig.AvailableTextLanguages;
	}

	public static string GetDefault_TextLanguage()
	{
		return ClientConfig.LocalLanguage;
	}

	public static string GetCur_TextLanguage()
	{
		return MonoSingleton<ClientManager>.Instance.localLanguage;
	}

	public static void SetCur_TextLanguage(string language)
	{
		MonoSingleton<ClientManager>.Instance.localLanguage = language;
	}

	public static string[] GetAvailable_VoLanguage()
	{
		return NovaCoreAPI.GetAvailable_VoLanguage();
	}

	public static string GetDefault_VoLanguage()
	{
		return NovaCoreAPI.GetDefault_VoLanguage();
	}

	public static string GetCur_VoiceLanguage()
	{
		return NovaCoreAPI.GetCur_VoiceLanguage();
	}

	public static void SetCur_VoiceLanguage(string language)
	{
		NovaCoreAPI.SetCur_VoiceLanguage(language);
	}

	public static bool HasDownload_VoLanguage(string language, out long totalSize, out long needDownloadSize)
	{
		return NovaCoreAPI.HasDownload_VoLanguage(language, out totalSize, out needDownloadSize);
	}

	public static bool HasDownload_Any_VoLanguage()
	{
		return NovaCoreAPI.HasDownload_Any_VoLanguage();
	}

	public static void Enable_VoLanguage(string language, bool downloadPackageUseResourceSupplement = true)
	{
		NovaCoreAPI.Enable_VoLanguage(language, downloadPackageUseResourceSupplement);
	}

	public static void Disable_VoLanguage(string language)
	{
		NovaCoreAPI.Disable_VoLanguage(language);
	}

	internal static string GetVoicePackageTagHeader()
	{
		return NovaCoreAPI.GetVoicePackageTagHeader();
	}

	internal static string GetVoicePackageTagFromLanguage(string language)
	{
		return NovaCoreAPI.GetVoicePackageTagFromLanguage(language);
	}

	internal static void SetupWwiseVoiceLanguage()
	{
		NovaCoreAPI.SetupWwiseVoiceLanguage();
	}

	public static void SetComponentEnableByName(GameObject go, string componentName, bool enable)
	{
		if (!go)
		{
			return;
		}
		Component component = go.GetComponent(componentName);
		if ((bool)component)
		{
			Behaviour behaviour = component as Behaviour;
			if (behaviour != null)
			{
				behaviour.enabled = enable;
			}
		}
	}

	public static void SetComponentEnable(Component component, bool enable)
	{
		if ((bool)component)
		{
			Behaviour behaviour = component as Behaviour;
			if (behaviour != null)
			{
				behaviour.enabled = enable;
			}
		}
	}

	public static void SetRaycastTarget(GameObject go, bool enable)
	{
		if (!(go == null))
		{
			Graphic component = go.GetComponent<Graphic>();
			if ((bool)component)
			{
				component.raycastTarget = enable;
			}
		}
	}

	public static void SetColor(GameObject go, float r, float g, float b, float a)
	{
		if (!(go == null))
		{
			Graphic component = go.GetComponent<Graphic>();
			if ((bool)component)
			{
				component.color = new Color(r, g, b, a);
			}
		}
	}

	public static void SetAlpha(GameObject go, float a)
	{
		if (!(go == null))
		{
			Graphic component = go.GetComponent<Graphic>();
			if ((bool)component)
			{
				Color color = component.color;
				component.color = new Color(color.r, color.g, color.b, a);
			}
		}
	}

	public static void SetParticleColor(GameObject go, Color color)
	{
		if (!(go == null))
		{
			ParticleSystem component = go.GetComponent<ParticleSystem>();
			if ((bool)component)
			{
				ParticleSystem.MainModule main = component.main;
				main.startColor = color;
			}
		}
	}

	public static void SetAdaptedAreaCustomWidth(int percent)
	{
		NovaCoreAPI.SetAdaptedAreaCustomWidth(percent);
	}

	public static int GetAdaptedAreaCustomWidth()
	{
		return NovaCoreAPI.GetAdaptedAreaCustomWidth();
	}

	public static void SetParentAndNormalized(Transform trTarget, Transform trParent)
	{
		if (!(trTarget == null) && !(trParent == null))
		{
			trTarget.SetParent(trParent);
			trParent.localPosition = Vector3.zero;
			trParent.localScale = Vector3.one;
			RectTransform component = trTarget.gameObject.GetComponent<RectTransform>();
			if (!(component == null))
			{
				component.anchoredPosition3D = Vector3.zero;
				component.sizeDelta = Vector3.zero;
			}
		}
	}

	public static float GetViewPointX(GameObject obj)
	{
		return MonoSingleton<GameCameraStackManager>.Instance.uiCamera.WorldToViewportPointAsHFOV(obj.transform.position).x;
	}

	public static void SetCanvasSortingOrder(Canvas canvas, int value)
	{
		if (!(canvas == null))
		{
			canvas.sortingOrder = value;
		}
	}

	public static int GetCanvasSortingOrder(Canvas canvas)
	{
		if (canvas == null)
		{
			return 0;
		}
		return canvas.sortingOrder;
	}

	public static void SetCanvasSortingName(Canvas canvas, string name)
	{
		if (!(canvas == null))
		{
			canvas.sortingLayerName = name;
		}
	}

	public static void SetCanvasSortingId(Canvas canvas, int id)
	{
		if (!(canvas == null))
		{
			canvas.sortingLayerID = id;
		}
	}

	public static void SetCanvasOverrideSorting(Canvas canvas, bool enable)
	{
		if (!(canvas == null))
		{
			canvas.overrideSorting = enable;
		}
	}

	public static void SetCanvasWorldCamera(Canvas canvas, Camera camera)
	{
		if (!(canvas == null))
		{
			canvas.worldCamera = camera;
		}
	}

	public static void SetCanvasPlaneDistance(Canvas canvas, float value)
	{
		if (!(canvas == null))
		{
			canvas.planeDistance = value;
		}
	}

	public static void ForceUpdateCanvases()
	{
		Canvas.ForceUpdateCanvases();
	}

	public static void SetMaskAllDirty(GameObject maskGameObject)
	{
		Mask component = maskGameObject.GetComponent<Mask>();
		if (component != null)
		{
			component.graphic.SetAllDirty();
		}
	}

	public static void SetTopGridCanvasSorting(GameObject go, int value)
	{
		if (!(go == null) && go.TryGetComponent<TopGridCanvas>(out var component))
		{
			component.SetSorting(value);
		}
	}

	public static void SetVariableJoystickMode(GameObject go)
	{
		if (!(go == null) && go.TryGetComponent<ClickableVariableJoystick>(out var component))
		{
			component.SetMode();
		}
	}

	public static void SetCanvasGroupAlpha(CanvasGroup canvasGroup, float alpha)
	{
		if ((bool)canvasGroup)
		{
			canvasGroup.alpha = alpha;
		}
	}

	public static float GetCanvasGroupAlpha(CanvasGroup canvasGroup)
	{
		if ((bool)canvasGroup)
		{
			return canvasGroup.alpha;
		}
		return 0f;
	}

	public static void SetCanvasGroupBlocksRaycasts(CanvasGroup canvasGroup, bool visible)
	{
		if ((bool)canvasGroup)
		{
			canvasGroup.blocksRaycasts = visible;
		}
	}

	public static void SetCanvasGroupInteractable(CanvasGroup canvasGroup, bool visible)
	{
		if ((bool)canvasGroup)
		{
			canvasGroup.interactable = visible;
		}
	}

	public static Tweener SetCanvasGroupDoFade(CanvasGroup canvasGroup, float value, float duration, bool update = false)
	{
		if (!canvasGroup)
		{
			return null;
		}
		return canvasGroup.DOFade(value, duration).SetUpdate(update);
	}

	public static void UIEffectSnapShotCapture(GameObject go)
	{
		if (!(go == null))
		{
			UIEffectSnapshot component = go.GetComponent<UIEffectSnapshot>();
			if (component != null)
			{
				component.captureCameraType = UIEffectSnapshotRequest.CaptureCameraType.UICamera;
				component.Capture();
			}
		}
	}

	public static void SetButtonInteractable(Button btn, bool enable)
	{
		if ((bool)btn)
		{
			btn.interactable = enable;
		}
	}

	public static void SetNaviButtonAction(NaviButton btn, bool enable)
	{
		NovaCoreAPI.SetNaviButtonAction(btn, enable);
	}

	public static void AddButtonListener(Button btn, UnityAction handle)
	{
		if ((bool)btn)
		{
			btn.onClick.AddListener(handle);
		}
	}

	public static void RemoveButtonListener(Button btn, UnityAction handle)
	{
		if ((bool)btn)
		{
			btn.onClick.RemoveListener(handle);
		}
	}

	public static void SetButtonExHoldThreshold(GameObject go, float fThreshold)
	{
		if (go != null)
		{
			ButtonEx component = go.GetComponent<ButtonEx>();
			if (component != null)
			{
				component.m_HoldThreshold = fThreshold;
			}
		}
	}

	public static void AddUIButtonListener(UIButton btn, UnityAction handle)
	{
		if ((bool)btn)
		{
			btn.onClick.AddListener(handle);
		}
	}

	public static void RemoveUIButtonListener(UIButton btn, UnityAction handle)
	{
		if ((bool)btn)
		{
			btn.onClick.RemoveListener(handle);
		}
	}

	public static void SetPersonalityRing(GameObject go, float[] fillAmount)
	{
		PersonalityRing component = go.GetComponent<PersonalityRing>();
		if (component != null)
		{
			component.Set(fillAmount);
		}
	}

	public static bool SetImageSprite(Image image, string assetsPath)
	{
		if (image == null)
		{
			return false;
		}
		UnityEngine.Object obj = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetsPath, typeof(Sprite));
		if (obj == null)
		{
			Debug.LogError("未找到icon资源" + assetsPath);
			return false;
		}
		image.sprite = (Sprite)obj;
		return true;
	}

	public static void SetImageSpriteAsset(Image image, Sprite sprite)
	{
		if ((bool)image)
		{
			image.sprite = sprite;
		}
	}

	public static void SetImageRaycastTarget(Image image, bool enable)
	{
		if ((bool)image)
		{
			image.raycastTarget = enable;
		}
	}

	public static void SetImageNativeSize(Image image)
	{
		if ((bool)image)
		{
			image.SetNativeSize();
		}
	}

	public static void SetImageColor(Image image, Color color)
	{
		if ((bool)image)
		{
			image.color = color;
		}
	}

	public static Color GetImageColor(Image image)
	{
		if (!image)
		{
			return Color.white;
		}
		return image.color;
	}

	public static float GetImageSpriteWidth(Image image)
	{
		if (!image)
		{
			return 0f;
		}
		return image.sprite.rect.width;
	}

	public static float GetImageSpriteHeight(Image image)
	{
		if (!image)
		{
			return 0f;
		}
		return image.sprite.rect.width;
	}

	public static Tweener ImageDoFade(Image image, float value, float duration, bool update = false)
	{
		if (!image)
		{
			return null;
		}
		return image.DOFade(value, duration).SetUpdate(update);
	}

	public static Tweener ImageDoColor(Image image, Color color, float duration, bool update = false)
	{
		if (!image)
		{
			return null;
		}
		return image.DOColor(color, duration).SetUpdate(update);
	}

	public static Tweener ImageDoFillAmount(Image image, float value, float duration, bool update = false)
	{
		if (!image)
		{
			return null;
		}
		return image.DOFillAmount(value, duration).SetUpdate(update);
	}

	public static void SetImageFillAmount(Image image, float value)
	{
		if ((bool)image)
		{
			image.fillAmount = value;
		}
	}

	public static float GetImageFillAmount(Image image)
	{
		if (!image)
		{
			return 0f;
		}
		return image.fillAmount;
	}

	public static bool SetTextureByPath(RawImage image, string assetsPath)
	{
		if (image == null)
		{
			return false;
		}
		UnityEngine.Object obj = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetsPath, typeof(Texture));
		if (obj == null)
		{
			Debug.LogError("未找\ufffd? icon 资源\ufffd?" + assetsPath);
			return false;
		}
		image.texture = (Texture)obj;
		return true;
	}

	public static bool SetTexture(RawImage rawImage, Texture texture)
	{
		if (!rawImage || !texture)
		{
			return false;
		}
		rawImage.texture = texture;
		return true;
	}

	public static Texture GetTexture(RawImage rawImage)
	{
		if (!rawImage)
		{
			return null;
		}
		return rawImage.texture;
	}

	public static void SetRawImageColor(RawImage rawImage, Color color)
	{
		if ((bool)rawImage)
		{
			rawImage.color = color;
		}
	}

	public static Color GetRawImageColor(RawImage rawImage)
	{
		if (!rawImage)
		{
			return Color.white;
		}
		return rawImage.color;
	}

	public static void SetRawImageMaterial(RawImage rawImage, Material mt)
	{
		if ((bool)rawImage)
		{
			rawImage.material = mt;
		}
	}

	public static Tweener DoRawImageColor(RawImage image, Color color, float time)
	{
		if (!image)
		{
			return null;
		}
		return image.DOColor(color, time);
	}

	public static void SetSpriteRendererSprite(SpriteRenderer spriteRenderer, Sprite sprite)
	{
		if ((bool)spriteRenderer)
		{
			spriteRenderer.sprite = sprite;
		}
	}

	public static void SetSpriteRendererColor(SpriteRenderer spriteRenderer, Color color)
	{
		if ((bool)spriteRenderer)
		{
			spriteRenderer.color = color;
		}
	}

	public static void SetSPSortingOrder(SpriteRenderer spriteRenderer, int value)
	{
		if ((bool)spriteRenderer)
		{
			spriteRenderer.sortingOrder = value;
		}
	}

	public static Tweener SpriteRendererDoColor(SpriteRenderer spriteRenderer, Color color, float duration)
	{
		if (!spriteRenderer)
		{
			return null;
		}
		return spriteRenderer.DOColor(color, duration);
	}

	public static Tweener SpriteRendererDoFade(SpriteRenderer spriteRenderer, float value, float duration)
	{
		if (!spriteRenderer)
		{
			return null;
		}
		return spriteRenderer.DOFade(value, duration);
	}

	public static void SetText(Text text, string content)
	{
		if (!(text == null))
		{
			text.text = content;
		}
	}

	public static string GetText(Text text)
	{
		if (text == null)
		{
			return "";
		}
		return text.text;
	}

	public static void SetTextColor(Text text, Color color)
	{
		if (!(text == null))
		{
			text.color = color;
		}
	}

	public static void SetTMPText(TMP_Text tmpText, string content)
	{
		NovaCoreAPI.SetTMPText(tmpText, content);
	}

	public static string GetTMPText(TMP_Text tmpText)
	{
		if (tmpText == null)
		{
			return string.Empty;
		}
		return tmpText.text;
	}

	public static void SetTMPColor(TMP_Text tmpText, Color color)
	{
		if (!(tmpText == null) && (bool)tmpText)
		{
			tmpText.color = color;
		}
	}

	public static void SetTMPRaycastTarget(TMP_Text tmpText, bool enable)
	{
		if (!(tmpText == null) && (bool)tmpText)
		{
			tmpText.raycastTarget = enable;
		}
	}

	public static void SetTMPFontSize(TMP_Text tmpText, float size)
	{
		if (!(tmpText == null) && (bool)tmpText)
		{
			tmpText.fontSize = size;
		}
	}

	public static void TMPSetAllDirty(TMP_Text tmpText)
	{
		if (!(tmpText == null) && (bool)tmpText)
		{
			tmpText.SetAllDirty();
		}
	}

	public static void SetTMPSourceText(TMP_Text tmpText, string content, bool syncTextInputBox = true)
	{
		if (!(tmpText == null))
		{
			tmpText.SetText(content, syncTextInputBox);
		}
	}

	public static void SetTMPWrappingEnable(TMP_Text tmpText, bool enabled)
	{
		if (!(tmpText == null))
		{
			tmpText.enableWordWrapping = enabled;
		}
	}

	public static void SetText_RubyTMP(RubyTextMeshProUGUI rubyTMP_a, string sContent, RubyTextMeshProUGUI rubyTMP_b)
	{
		if (!(rubyTMP_a == null))
		{
			if (rubyTMP_b == null)
			{
				rubyTMP_a.UnditedText = sContent;
			}
			else
			{
				rubyTMP_a.UnditedText = $"{sContent}{rubyTMP_b.UnditedText}";
			}
		}
	}

	public static string GetText_RubyTMP(RubyTextMeshProUGUI rubyTMP)
	{
		if (rubyTMP == null)
		{
			return string.Empty;
		}
		return rubyTMP.UnditedText;
	}

	public static Tweener DOText_RubyTMP(RubyTextMeshProUGUI rubyTMP, string sContent, float fDuration)
	{
		if (rubyTMP == null || string.IsNullOrEmpty(sContent) || fDuration <= 0f)
		{
			return null;
		}
		TweenerCore<string, string, StringOptions> tweenerCore = DOTween.To(() => rubyTMP.UnditedText, (string x) =>
		{
			rubyTMP.UnditedText = x;
		}, sContent, fDuration);
		tweenerCore.SetOptions(richTextEnabled: true).SetTarget(rubyTMP);
		tweenerCore.SetEase(Ease.Linear);
		return tweenerCore;
	}

	public static void SetTextColor_RubyTMP(RubyTextMeshProUGUI rubyTMP, string sColor)
	{
		if (!(rubyTMP == null))
		{
			ColorUtility.TryParseHtmlString(sColor, out var color);
			rubyTMP.color = color;
		}
	}

	public static bool GetRubyPos(RubyTextMeshProUGUI rubyTMP, string sBaseText, string sRubyText, out float fP1, out float fP2)
	{
		fP1 = 0f;
		fP2 = 0f;
		if (rubyTMP == null)
		{
			return false;
		}
		rubyTMP.CalcRpos(sBaseText, sRubyText, out fP1, out fP2);
		return true;
	}

	public static void SetTMP_AutoLineWrap(RubyTextMeshProUGUI rubyTMP, bool bEnableAutoWrap)
	{
		if (!(rubyTMP == null))
		{
			rubyTMP.enableWordWrapping = bEnableAutoWrap;
		}
	}

	public static float AvgCalcTMPLastWordPos(RubyTextMeshProUGUI rubyTMP)
	{
		rubyTMP.ForceMeshUpdate();
		TMP_TextInfo textInfo = rubyTMP.textInfo;
		if (textInfo.characterCount == 0)
		{
			return 0f;
		}
		int num = textInfo.characterCount - 1;
		return ((Vector2)textInfo.characterInfo[num].topRight).x;
	}

	public static void SetTMPInputFieldText(TMP_InputField tmpInputField, string content)
	{
		if (!(tmpInputField == null))
		{
			tmpInputField.text = content;
		}
	}

	public static string GetTMPInputFieldText(TMP_InputField tmpInputField)
	{
		if (tmpInputField == null)
		{
			return string.Empty;
		}
		return tmpInputField.text;
	}

	public static TMP_Text GetTMPInputFieldTextComponent(TMP_InputField tmpInputField)
	{
		if (tmpInputField == null)
		{
			return null;
		}
		return tmpInputField.textComponent;
	}

	public static void SetTMPInputFieldInteractable(TMP_InputField tmpInputField, bool enable)
	{
		if ((bool)tmpInputField)
		{
			tmpInputField.interactable = enable;
		}
	}

	public static void SetTMPInputFieldPlaceholderText(TMP_InputField tmpInputField, string content)
	{
		if ((bool)tmpInputField)
		{
			TMP_Text tMP_Text = (TMP_Text)tmpInputField.placeholder;
			if ((bool)tMP_Text)
			{
				tMP_Text.text = content;
			}
		}
	}

	public static void AddTMPEndEditListener(TMP_InputField tmpInputField, UnityAction<string> handle)
	{
		if ((bool)tmpInputField)
		{
			tmpInputField.onEndEdit.AddListener(handle);
		}
	}

	public static void RemoveTMPEndEditListener(TMP_InputField tmpInputField, UnityAction<string> handle)
	{
		if ((bool)tmpInputField)
		{
			tmpInputField.onEndEdit.RemoveListener(handle);
		}
	}

	public static void SetScrollRectVertical(ScrollRect sr, bool vertical)
	{
		if (!(sr == null))
		{
			sr.vertical = vertical;
		}
	}

	public static void SetScrollHorizontal(ScrollRect sr, bool horizontal)
	{
		if (!(sr == null))
		{
			sr.horizontal = horizontal;
		}
	}

	public static void SetVerticalNormalizedPosition(ScrollRect sr, float value)
	{
		if (!(sr == null))
		{
			sr.verticalNormalizedPosition = value;
		}
	}

	public static void SetHorizontalNormalizedPosition(ScrollRect sr, float value)
	{
		if (!(sr == null))
		{
			sr.horizontalNormalizedPosition = value;
		}
	}

	public static float GetVerticalNormalizedPosition(ScrollRect sr)
	{
		if (sr == null)
		{
			return 0f;
		}
		return sr.verticalNormalizedPosition;
	}

	public static float GetHorizontalNormalizedPosition(ScrollRect sr)
	{
		if (sr == null)
		{
			return 0f;
		}
		return sr.horizontalNormalizedPosition;
	}

	public static void AddScrollRectListener(ScrollRect sr, UnityAction<Vector2> handle)
	{
		if (!(sr == null))
		{
			sr.onValueChanged.AddListener(handle);
		}
	}

	public static void RemoveScrollRectListener(ScrollRect sr, UnityAction<Vector2> handle)
	{
		if (!(sr == null))
		{
			sr.onValueChanged.RemoveListener(handle);
		}
	}

	public static void UIScrollRectScrollTo(UIScrollRect sr, int index, bool reverse)
	{
		if ((bool)sr)
		{
			sr.ScrollTo(index, reverse);
		}
	}

	public static void SetDropDownValue(Dropdown dd, int value)
	{
		if (!(dd == null))
		{
			dd.value = value;
		}
	}

	public static int GetDropDownValue(Dropdown dd)
	{
		if (dd == null)
		{
			return 0;
		}
		return dd.value;
	}

	public static void ClearDropDownOptions(Dropdown dd)
	{
		if (!(dd == null))
		{
			dd.ClearOptions();
		}
	}

	public static void DropDownAddOptions(Dropdown dd, List<string> options)
	{
		if (!(dd == null))
		{
			dd.AddOptions(options);
		}
	}

	public static string GetCurDDOptionsText(Dropdown dd)
	{
		if (dd != null)
		{
			return dd.options.get_Item(dd.value).text;
		}
		return string.Empty;
	}

	public static void SetDDInteractable(Dropdown dd, bool enable)
	{
		if ((bool)dd)
		{
			dd.interactable = enable;
		}
	}

	public static bool GetDDInteractable(Dropdown dd)
	{
		if (!dd)
		{
			return false;
		}
		return dd.interactable;
	}

	public static void SetDDValueWithoutNotify(Dropdown dd, int value)
	{
		if ((bool)dd)
		{
			dd.SetValueWithoutNotify(value);
		}
	}

	public static void AddDropDownListener(Dropdown dd, UnityAction<int> handle)
	{
		if ((bool)dd)
		{
			dd.onValueChanged.AddListener(handle);
		}
	}

	public static void RemoveDropDownListener(Dropdown dd, UnityAction<int> handle)
	{
		if ((bool)dd)
		{
			dd.onValueChanged.RemoveListener(handle);
		}
	}

	public static void SetInputFieldText(InputField inputField, string text)
	{
		if ((bool)inputField)
		{
			inputField.text = text;
		}
	}

	public static string GetInputFieldText(InputField inputField)
	{
		if (!inputField)
		{
			return string.Empty;
		}
		return inputField.text;
	}

	public static void SetInputFieldPlaceholderText(InputField inputField, string content)
	{
		if ((bool)inputField)
		{
			Text text = (Text)inputField.placeholder;
			if ((bool)text)
			{
				text.text = content;
			}
		}
	}

	public static void SetInputFieldInteractable(InputField inputField, bool enable)
	{
		if ((bool)inputField)
		{
			inputField.interactable = enable;
		}
	}

	public static void AddEndEditListener(InputField inputField, UnityAction<string> handle)
	{
		if ((bool)inputField)
		{
			inputField.onEndEdit.AddListener(handle);
		}
	}

	public static void RemoveEndEditListener(InputField inputField, UnityAction<string> handle)
	{
		if ((bool)inputField)
		{
			inputField.onEndEdit.RemoveListener(handle);
		}
	}

	public static void AddIPValueChangedListener(InputField inputField, UnityAction<string> handle)
	{
		if ((bool)inputField)
		{
			inputField.onValueChanged.AddListener(handle);
		}
	}

	public static void RemoveIPValueChangedListener(InputField inputField, UnityAction<string> handle)
	{
		if ((bool)inputField)
		{
			inputField.onValueChanged.RemoveListener(handle);
		}
	}

	public static void SetToggleInteractable(Toggle toggle, bool enable)
	{
		if ((bool)toggle)
		{
			toggle.interactable = enable;
		}
	}

	public static void SetToggleIsOn(Toggle toggle, bool isOn)
	{
		if ((bool)toggle)
		{
			toggle.isOn = isOn;
		}
	}

	public static bool GetToggleIsOn(Toggle toggle)
	{
		if (!toggle)
		{
			return false;
		}
		return toggle.isOn;
	}

	public static void AddToggleListener(Toggle toggle, UnityAction<bool> handle)
	{
		if ((bool)toggle)
		{
			toggle.onValueChanged.AddListener(handle);
		}
	}

	public static void RemoveToggleListener(Toggle toggle, UnityAction<bool> handle)
	{
		if ((bool)toggle)
		{
			toggle.onValueChanged.RemoveListener(handle);
		}
	}

	public static void AddUIToggleListener(UIToggle toggle, UnityAction<bool> handle)
	{
		if ((bool)toggle)
		{
			toggle.onValueChanged.AddListener(handle);
		}
	}

	public static void RemoveUIToggleListener(UIToggle toggle, UnityAction<bool> handle)
	{
		if ((bool)toggle)
		{
			toggle.onValueChanged.RemoveListener(handle);
		}
	}

	public static void SetSliderInteractable(Slider slider, bool enable)
	{
		if ((bool)slider)
		{
			slider.interactable = enable;
		}
	}

	public static void SetSliderValue(Slider slider, float value, bool withoutNotify = false)
	{
		if ((bool)slider)
		{
			if (withoutNotify)
			{
				slider.SetValueWithoutNotify(value);
			}
			else
			{
				slider.value = value;
			}
		}
	}

	public static float GetSliderValue(Slider slider)
	{
		if (!slider)
		{
			return 0f;
		}
		return slider.value;
	}

	public static void SetSliderMinValue(Slider slider, float value)
	{
		if ((bool)slider)
		{
			slider.minValue = value;
		}
	}

	public static void SetSliderMaxValue(Slider slider, float value)
	{
		if ((bool)slider)
		{
			slider.maxValue = value;
		}
	}

	public static void AddSliderListener(Slider slider, UnityAction<float> handle)
	{
		if ((bool)slider)
		{
			slider.onValueChanged.AddListener(handle);
		}
	}

	public static void RemoveSliderListener(Slider slider, UnityAction<float> handle)
	{
		if ((bool)slider)
		{
			slider.onValueChanged.RemoveListener(handle);
		}
	}

	public static int LayerMaskGetMask(string name)
	{
		return LayerMask.GetMask(name);
	}

	public static int LayerMaskName2Layer(string name)
	{
		return LayerMask.NameToLayer(name);
	}

	public static bool PlayFX(bool bEnablePostProcessing, string sPath, float fPlaySpeed, out GameObject goIns)
	{
		AdventureFXPlayer adventureFXPlayer = AdventureFXManager.PlayFX(sPath, fPlaySpeed, Vector3.zero, Quaternion.identity);
		if (adventureFXPlayer == null)
		{
			goIns = null;
			return false;
		}
		if (!bEnablePostProcessing)
		{
			Transform transform = adventureFXPlayer.transform.FindInChildren("PostProcessFX");
			if (transform != null)
			{
				transform.gameObject.SetActive(value: false);
			}
		}
		adventureFXPlayer.SetIndependentUpdate(value: true);
		goIns = adventureFXPlayer.gameObject;
		return adventureFXPlayer.isLoop;
	}

	public static void StopFX(GameObject goIns)
	{
		AdventureFXPlayer component = goIns.GetComponent<AdventureFXPlayer>();
		if (!(component == null))
		{
			component.Stop();
		}
	}

	public static void SetEnable_Gradient2(GameObject go, bool bShadowMask)
	{
		if (!(go == null))
		{
			Gradient2 component = go.GetComponent<Gradient2>();
			if (component != null)
			{
				component.enabled = bShadowMask;
			}
		}
	}

	public static void PlayGradient2Anim(GameObject go, float fStart, float fEnd, float fDuration)
	{
		if (go == null)
		{
			return;
		}
		Gradient2 g2 = go.GetComponent<Gradient2>();
		if (g2 == null)
		{
			return;
		}
		if (fDuration > 0f)
		{
			g2.enabled = true;
			g2.Offset = fStart;
			DOTween.To(() => g2.Offset, (float x) =>
			{
				g2.Offset = x;
			}, fEnd, fDuration).SetTarget(g2).OnComplete(() =>
			{
				if (fEnd >= 1f && g2 != null)
				{
					g2.enabled = false;
				}
			});
		}
		else
		{
			g2.Offset = fEnd;
			g2.enabled = fEnd < 1f;
		}
	}

	public static void SetImageSpriteWithPrefab(Image imgHeadIcon, GameObject prefab)
	{
		if (!(imgHeadIcon == null) && !(prefab == null))
		{
			Image component = prefab.GetComponent<Image>();
			if (!(component == null))
			{
				imgHeadIcon.sprite = component.sprite;
			}
		}
	}

	public static void UnloadWwiseSoundBank(string sBnkName)
	{
		MonoSingleton<SoundBankManager>.Instance?.UnLoadBankByName(sBnkName);
	}

	public static string[][] ReadDataFromExcel(string xlsxFileFullPath)
	{
		if (!File.Exists(xlsxFileFullPath))
		{
			return null;
		}
		FileStream fileStream = File.Open(xlsxFileFullPath, FileMode.Open, FileAccess.Read);
		IExcelDataReader excelDataReader = ExcelReaderFactory.CreateOpenXmlReader(fileStream);
		DataTable dataTable = excelDataReader.AsDataSet().Tables.get_Item(0);
		int count = dataTable.Rows.Count;
		string[][] array = new string[count][];
		for (int i = 0; i < count; i++)
		{
			DataRow dataRow = dataTable.Rows.get_Item(i);
			int num = dataRow.ItemArray.Length;
			array[i] = new string[num];
			for (int j = 0; j < num; j++)
			{
				array[i][j] = dataRow.ItemArray[j].ToString();
			}
		}
		excelDataReader.Close();
		fileStream.Close();
		return array;
	}

	public static void WriteDataToExcel(LuaTable writeData, string xlsxFileFullPath, bool bRenameExistedFileByTimeStampSurfix = false)
	{
		int length = writeData.Length;
		int num = 0;
		string[][] array = new string[length][];
		for (int i = 1; i <= length; i++)
		{
			if (writeData.get_Item((object)i) is LuaTable luaTable)
			{
				num = luaTable.Length;
				array[i - 1] = new string[num];
				for (int j = 1; j <= num; j++)
				{
					array[i - 1][j - 1] = luaTable.get_Item((object)j).ToString();
				}
			}
		}
		IWorkbook workbook = new XSSFWorkbook();
		ISheet sheet = workbook.CreateSheet("Sheet1");
		for (int k = 0; k < length; k++)
		{
			IRow row = sheet.CreateRow(k);
			for (int l = 0; l < num; l++)
			{
				row.CreateCell(l).SetCellValue(array[k][l]);
			}
		}
		FileInfo fileInfo = new FileInfo(xlsxFileFullPath);
		if (!Directory.Exists(fileInfo.DirectoryName))
		{
			Directory.CreateDirectory(fileInfo.DirectoryName);
		}
		if (File.Exists(xlsxFileFullPath) && bRenameExistedFileByTimeStampSurfix)
		{
			string text = ".xlsx";
			string destFileName = xlsxFileFullPath.Replace(text, $"__{DateTime.Now:yyyy-MM-dd_HH-mm-ss}{text}");
			File.Move(xlsxFileFullPath, destFileName);
		}
		FileStream fileStream = new FileStream(xlsxFileFullPath, FileMode.Create, FileAccess.Write);
		workbook.Write(fileStream);
		fileStream.Close();
		workbook.Close();
	}

	public static void SetSkillIndicatorTarget(long entityId, GameObject gameObject, Vector3 offset)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (!(logicEntity == null))
		{
			Transform transform = logicEntity.transform;
			SkillHintIndicator skillHintIndicator = gameObject.AddOrGetComponent<SkillHintIndicator>();
			if (skillHintIndicator != null)
			{
				skillHintIndicator.SetFollowTarget(transform, offset);
			}
		}
	}

	public static void DoShakeEffect(GameObject go, float[][] v3Pos, float[][] v3Rot, bool bLoop)
	{
		ShakeEffect component = go.GetComponent<ShakeEffect>();
		if (!(component == null))
		{
			component.DoShake(v3Pos, v3Rot, bLoop);
		}
	}

	public static void StopShakeEffect(GameObject go)
	{
		ShakeEffect component = go.GetComponent<ShakeEffect>();
		if (!(component == null))
		{
			component.StopShake();
		}
	}

	public static void RestartShakeEffect(GameObject go)
	{
		ShakeEffect component = go.GetComponent<ShakeEffect>();
		if (!(component == null))
		{
			component.RestartShake();
		}
	}

	public static void SetUIEffectAndTransition(UIEffectAndTransition eft, int nEftMode, float width, float softness)
	{
		if (!(eft == null))
		{
			eft.effectModeTr = (UIEffectAndTransition.EffectModeTr)nEftMode;
			eft.dissolveWidth = width;
			eft.dissolveSoftness = softness;
			eft.dissolveColor = Color.black;
		}
	}

	public static float GetAnimClipLength(Animator anim, string[] clipNames)
	{
		float num = 0f;
		if (anim != null && anim.runtimeAnimatorController != null)
		{
			AnimationClip[] animationClips = anim.runtimeAnimatorController.animationClips;
			if (animationClips != null && animationClips.Length != 0)
			{
				List<string> list = new List<string>();
				if (clipNames != null && clipNames.Length != 0)
				{
					foreach (string item in clipNames)
					{
						if (!list.Contains(item))
						{
							list.Add(item);
						}
					}
				}
				foreach (AnimationClip animationClip in animationClips)
				{
					if (animationClip != null && list.Count > 0 && list.Contains(animationClip.name))
					{
						list.Remove(animationClip.name);
						num += animationClip.length;
					}
				}
			}
		}
		return num;
	}

	public static void CtrlDotweenAnimation(GameObject go, int nStatus)
	{
		if (go == null)
		{
			return;
		}
		DOTweenAnimation[] componentsInChildren = go.GetComponentsInChildren<DOTweenAnimation>();
		if (componentsInChildren == null || componentsInChildren.Length == 0)
		{
			return;
		}
		int num = componentsInChildren.Length;
		for (int i = 0; i < num; i++)
		{
			switch (nStatus)
			{
			case 0:
				componentsInChildren[i].DOPause();
				break;
			case 1:
				componentsInChildren[i].DOPlay();
				break;
			case 2:
				componentsInChildren[i].DORewind();
				break;
			}
		}
	}

	public static void SetAnimatorSpeed(Animator anim, float fSpeed)
	{
		if (!(anim == null) && !(fSpeed < 0f))
		{
			anim.speed = fSpeed;
		}
	}

	public static void ClearSelectedUI()
	{
		EventSystem.current.SetSelectedGameObject(null);
	}

	public static void SetSelectedUI(GameObject go)
	{
		BaseEventData baseEventData = new BaseEventData(EventSystem.current);
		baseEventData.Reset();
		EventSystem.current.SetSelectedGameObject(go, baseEventData);
	}

	public static GameObject GetSelectedUI()
	{
		return EventSystem.current.currentSelectedGameObject;
	}

	public static void SetGamepadUINavigation(Selectable[] selectables, bool isHorizontal = true, bool isLoop = true)
	{
		int num = selectables.Length;
		for (int i = 0; i < num; i++)
		{
			Navigation navigation = selectables[i].navigation;
			navigation.mode = Navigation.Mode.Explicit;
			Selectable selectable = null;
			if (i != 0)
			{
				selectable = selectables[i - 1];
			}
			else
			{
				selectable = (isLoop ? selectables[num - 1] : null);
			}
			Selectable selectable2 = null;
			if (i != num - 1)
			{
				selectable2 = selectables[i + 1];
			}
			else
			{
				selectable2 = (isLoop ? selectables[0] : null);
			}
			if (isHorizontal)
			{
				navigation.selectOnUp = null;
				navigation.selectOnDown = null;
				navigation.selectOnLeft = selectable;
				navigation.selectOnRight = selectable2;
			}
			else
			{
				navigation.selectOnUp = selectable;
				navigation.selectOnDown = selectable2;
				navigation.selectOnLeft = null;
				navigation.selectOnRight = null;
			}
			selectables[i].navigation = navigation;
		}
	}

	public static void SetRectMaskPadding(GameObject obj, float left, float bottom, float right, float top)
	{
		RectMask2D component = obj.GetComponent<RectMask2D>();
		if (component != null)
		{
			component.padding = new Vector4(left, bottom, right, top);
		}
	}

	public static void SetLayoutGroupPadding(GameObject obj, int left, int right, int top, int bottom)
	{
		LayoutGroup component = obj.GetComponent<LayoutGroup>();
		if (component != null)
		{
			component.padding = new RectOffset(left, right, top, bottom);
		}
	}

	public static void SetLayoutElementMinHeight(LayoutElement layout, float value)
	{
		if (!(layout == null))
		{
			layout.minHeight = value;
		}
	}

	public static void SetLayoutElementPreferredWidth(LayoutElement layout, float value)
	{
		if (!(layout == null))
		{
			layout.preferredWidth = value;
		}
	}

	public static void AddRedDotNode(GameObject obj, string key, string paramJson)
	{
		RedDotNode orAddComponent = obj.GetOrAddComponent<RedDotNode>();
		if ((bool)orAddComponent)
		{
			orAddComponent.InitNode(key, paramJson);
		}
	}

	public static void UnRegisterRedDotNode(GameObject obj)
	{
		RedDotNode component = obj.GetComponent<RedDotNode>();
		if ((bool)component)
		{
			component.UnRegisterRedDot();
		}
	}

	public static void ResetTouchEffect(Transform target, GameObject prefabMain, GameObject prefabSlide)
	{
		if (target == null)
		{
			return;
		}
		TouchEffect component = target.GetComponent<TouchEffect>();
		if (!(component == null))
		{
			component.ForceClear();
			if (prefabMain != null)
			{
				component.fxTouchPrefab = prefabMain;
			}
			if (prefabSlide != null)
			{
				component.fxDragPrefab = prefabSlide;
			}
		}
	}

	public static void SetupUIParallaxStageCameraControllerForModelView(UIParallaxStageCameraController component, Camera modelProjectionOverrideCamera)
	{
		if ((bool)component)
		{
			component.viewCamera = MonoSingleton<GameCameraStackManager>.Instance.uiCamera;
			component.renderCamera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
			component.renderCameraProjectionModifier = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.GetComponent<CameraProjectionModifier>();
			component.projectionOverrideCamera = modelProjectionOverrideCamera;
		}
	}

	public static void BindUIParallaxStageCameraControllerModel(UIParallaxStageCameraController component, int index, GameObject model, bool updateImmediately = false)
	{
		if ((bool)component)
		{
			component.BindActorModel(index, model, updateImmediately);
		}
	}

	public static void UnbindUIParallaxStageCameraControllerModel(UIParallaxStageCameraController component, int index)
	{
		if ((bool)component)
		{
			component.UnbindActorModel(index);
		}
	}

	public static void UnLoadBankByEventName(string eventName)
	{
		MonoSingleton<SoundBankManager>.Instance.UnLoadBankByEventName(eventName);
	}

	public static void AttachPrefabLuaInspector(GameObject obj, string luaCtrlPath, string luaPanelPath, string prefabPath)
	{
	}
}
