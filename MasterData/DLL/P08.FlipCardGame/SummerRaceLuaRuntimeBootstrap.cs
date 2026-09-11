using System;
using System.Collections;
using System.IO;
using System.Reflection;
using CriWare;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Serialization;
using UnityEngine.UI;

[DefaultExecutionOrder(-32000)]
public class SummerRaceLuaRuntimeBootstrap : MonoBehaviour
{
	private sealed class StandaloneValidationLogFilter : ILogHandler
	{
		private readonly ILogHandler inner;

		public StandaloneValidationLogFilter(ILogHandler innerHandler)
		{
			inner = innerHandler;
		}

		public void LogException(Exception exception, UnityEngine.Object context)
		{
			inner?.LogException(exception, context);
		}

		public void LogFormat(LogType logType, UnityEngine.Object context, string format, params object[] args)
		{
			string message = ((args != null && args.Length != 0) ? string.Format(format, args) : format);
			if (!ShouldSuppressStandaloneValidationLog(logType, message))
			{
				inner?.LogFormat(logType, context, format, args);
			}
		}
	}

	private enum ValidationBattleFlowPreset
	{
		None,
		ChampionshipFromCfg,
		SurvivalFromCfg,
		DuelFromCfg,
		Challenge
	}

	[Serializable]
	private sealed class ValidationOutGamePreset
	{
		public bool enabled;

		[FormerlySerializedAs("battleFlowPreset")]
		public ValidationBattleFlowPreset launchPreset = ValidationBattleFlowPreset.ChampionshipFromCfg;

		[FormerlySerializedAs("battleStageIdOverride")]
		public string stageIdOverride = string.Empty;

		[FormerlySerializedAs("battleFlowAutoEnter")]
		public bool autoEnterBattle = true;

		public string source = "validationBootstrap";
	}

	[Serializable]
	private sealed class ValidationOutGamePresetPayload
	{
		public string launchPreset = "championship_cfg";

		public string stageIdOverride = string.Empty;

		public bool autoEnterBattle = true;

		public string source = "validationBootstrap";
	}

	[SerializeField]
	private bool enableStandaloneValidationBootstrap;

	[SerializeField]
	private bool bootstrapOnAwake = true;

	[SerializeField]
	private bool ensureUiCameraDontDestroy = true;

	[SerializeField]
	private bool ensureLuaUiContext = true;

	[SerializeField]
	private int luaContextRetryCount = 20;

	[SerializeField]
	private float luaContextRetryIntervalSeconds = 0.25f;

	[SerializeField]
	private bool autoRunRouteProbeAfterContextReady = true;

	[Header("Validation OutGame Preset")]
	[SerializeField]
	private bool autoApplyValidationOutGamePresetAfterContextReady = true;

	[SerializeField]
	private bool suppressAutoRouteProbeWhenOutGamePresetEnabled = true;

	[SerializeField]
	private ValidationOutGamePreset validationOutGamePreset = new ValidationOutGamePreset();

	[SerializeField]
	private bool verboseLog = true;

	private static bool sBootstrapped;

	private static bool sUiContextInitialized;

	private static bool sSummerRaceBootstrapInvoked;

	private static bool sLuaContextProbeLogged;

	private static bool sStandaloneBootstrapDisabledLogged;

	private static bool sStandaloneValidationBootstrapEnabled;

	private static bool sValidationOutGamePresetEnabled;

	private static EventSystem sBootstrapEventSystem;

	private static bool sEditorAssetBootstrapSkippedLogged;

	private static ILogHandler sPreviousLogHandler;

	private static bool sStandaloneValidationLogFilterInstalled;

	private static SummerRaceLuaRuntimeBootstrap sActiveValidationBootstrap;

	private static bool sGameMgrTypeResolved;

	private static Type sGameMgrType;

	private static MethodInfo sGameMgrInitMethod;

	private static FieldInfo sGameMgrInstField;

	private Coroutine ensureLuaContextCoroutine;

	private bool bootstrapFallbackTicked;

	private bool gamepadRuntimeSuppressed;

	private bool validationOutGamePresetApplied;

	private bool standaloneValidationCleanupTriggered;

	public static bool IsLuaUiContextReady => sUiContextInitialized;

	public static bool IsStandaloneValidationBootstrapEnabled => sStandaloneValidationBootstrapEnabled;

	public static bool IsValidationOutGamePresetEnabled => sValidationOutGamePresetEnabled;

	public bool StandaloneValidationBootstrapEnabledInScene => enableStandaloneValidationBootstrap;

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
	private static void ResetStaticBootstrapStateForPlayMode()
	{
		sBootstrapped = false;
		sUiContextInitialized = false;
		sSummerRaceBootstrapInvoked = false;
		sLuaContextProbeLogged = false;
		sStandaloneBootstrapDisabledLogged = false;
		sStandaloneValidationBootstrapEnabled = false;
		sValidationOutGamePresetEnabled = false;
		sBootstrapEventSystem = null;
		sEditorAssetBootstrapSkippedLogged = false;
		sPreviousLogHandler = null;
		sStandaloneValidationLogFilterInstalled = false;
		sActiveValidationBootstrap = null;
		SummerRaceFightManager.SetLuaUiContextReady(isReady: false);
		SummerRaceFightManager.RegisterLuaUiContextReadyProvider(null);
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
	private static void EnsureSceneBootstrapAfterLoad()
	{
		SummerRaceLuaRuntimeBootstrap summerRaceLuaRuntimeBootstrap = UnityEngine.Object.FindObjectOfType<SummerRaceLuaRuntimeBootstrap>();
		if (summerRaceLuaRuntimeBootstrap != null)
		{
			summerRaceLuaRuntimeBootstrap.EnsureBootstrap();
		}
	}

	private void OnEnable()
	{
		if (Application.isPlaying)
		{
			SummerRaceFightManager.RegisterLuaUiContextReadyProvider(ReadLuaUiContextReadyForFightManager);
			SummerRaceFightManager.SetLuaUiContextReady(ReadLuaUiContextReadyForFightManager());
			InstallStandaloneValidationLogFilterIfNeeded();
			bootstrapFallbackTicked = false;
			gamepadRuntimeSuppressed = false;
			validationOutGamePresetApplied = false;
			standaloneValidationCleanupTriggered = false;
			if (bootstrapOnAwake)
			{
				EnsureBootstrap();
			}
		}
	}

	private void OnDisable()
	{
		if (Application.isPlaying)
		{
			TryCleanupStandaloneValidationRuntime();
			SummerRaceFightManager.SetLuaUiContextReady(isReady: false);
			SummerRaceFightManager.RegisterLuaUiContextReadyProvider(null);
			UninstallStandaloneValidationLogFilterIfNeeded();
		}
	}

	private void Awake()
	{
		if (Application.isPlaying)
		{
			sStandaloneValidationBootstrapEnabled = enableStandaloneValidationBootstrap;
			sValidationOutGamePresetEnabled = enableStandaloneValidationBootstrap && validationOutGamePreset != null && validationOutGamePreset.enabled;
			InstallStandaloneValidationLogFilterIfNeeded();
			if (bootstrapOnAwake)
			{
				EnsureBootstrap();
			}
		}
	}

	private void Start()
	{
		if (Application.isPlaying && bootstrapOnAwake)
		{
			EnsureBootstrap();
		}
	}

	private void Update()
	{
		if (!Application.isPlaying || bootstrapFallbackTicked)
		{
			if (Application.isPlaying && enableStandaloneValidationBootstrap && !gamepadRuntimeSuppressed)
			{
				gamepadRuntimeSuppressed = SuppressUnusedGamepadRuntime();
			}
			if (Application.isPlaying)
			{
				CleanupRedundantEventSystems();
			}
			return;
		}
		bootstrapFallbackTicked = true;
		if (!sBootstrapped)
		{
			EnsureBootstrap();
		}
		if (enableStandaloneValidationBootstrap && !gamepadRuntimeSuppressed)
		{
			gamepadRuntimeSuppressed = SuppressUnusedGamepadRuntime();
		}
		CleanupRedundantEventSystems();
	}

	[ContextMenu("Ensure Bootstrap")]
	public void EnsureBootstrap()
	{
		sStandaloneValidationBootstrapEnabled = enableStandaloneValidationBootstrap;
		sValidationOutGamePresetEnabled = enableStandaloneValidationBootstrap && validationOutGamePreset != null && validationOutGamePreset.enabled;
		SummerRaceFightManager.SetLuaUiContextReady(ReadLuaUiContextReadyForFightManager());
		if (!enableStandaloneValidationBootstrap)
		{
			if (verboseLog && !sStandaloneBootstrapDisabledLogged)
			{
				Debug.Log("[SummerRace][LuaBootstrap] standalone validation bootstrap disabled; skipping runtime simulation");
			}
			sStandaloneBootstrapDisabledLogged = true;
			return;
		}
		sStandaloneBootstrapDisabledLogged = false;
		if (sBootstrapped)
		{
			if (HasCoreRuntimeBootstrapReady())
			{
				return;
			}
			if (verboseLog)
			{
				Debug.LogWarning("[SummerRace][LuaBootstrap] detected stale static bootstrap state without GameMgr/LuaClient; forcing re-bootstrap");
			}
			sBootstrapped = false;
			sUiContextInitialized = false;
			sSummerRaceBootstrapInvoked = false;
			sLuaContextProbeLogged = false;
		}
		if (ensureUiCameraDontDestroy)
		{
			EnsureUiCameraRoot();
			EnsurePoolRoot();
			EnsureEventSystem();
		}
		EnsureCriwareRuntime();
		IniManager.Initialize();
		InitializeAssetRuntimeIfNeeded();
		InvokeGameMgrInit();
		if (!HasCoreRuntimeBootstrapReady())
		{
			ResetGameMgrSingletonForBootstrap();
			InvokeGameMgrInit();
		}
		if (!HasCoreRuntimeBootstrapReady())
		{
			Debug.LogWarning("[SummerRace][LuaBootstrap] GameMgr.Init completed but GameMgr/LuaClient is still missing");
		}
		if (ensureLuaUiContext)
		{
			StartEnsureLuaUiContext();
		}
		gamepadRuntimeSuppressed = SuppressUnusedGamepadRuntime();
		CleanupRedundantEventSystems();
		sBootstrapped = true;
		if (verboseLog)
		{
			Debug.Log("[SummerRace][LuaBootstrap] initialized IniManager + AssetManager + LuaClient");
		}
	}

	[ContextMenu("Apply Validation OutGame Preset")]
	public void ApplyValidationOutGamePreset()
	{
		EnsureBootstrap();
		if (!sUiContextInitialized)
		{
			Debug.LogWarning("[SummerRace][LuaBootstrap] UI context not ready; cannot apply validation outgame preset yet.");
		}
		else
		{
			ApplyValidationOutGamePresetIfNeeded(force: true);
		}
	}

	private void EnsureCriwareRuntime()
	{
		AudioManager.Create();
		AudioManager mInstance = AudioManager.mInstance;
		if (mInstance == null)
		{
			Debug.LogWarning("[SummerRace][LuaBootstrap] AudioManager.Create completed but AudioManager instance is still missing");
			return;
		}
		mInstance.CreateCriAtom();
		CriAtom mCriAtom = mInstance.mCriAtom;
		if (mCriAtom == null || string.IsNullOrEmpty(mCriAtom.acfFile))
		{
			if (verboseLog)
			{
				Debug.LogWarning("[SummerRace][LuaBootstrap] CriAtom/acfFile missing after AudioManager.Create");
			}
			return;
		}
		string pFilePath = mCriAtom.acfFile;
		CriAtomEx.UnregisterAcf();
		if (!CriWareExtension.TryGetFilePath(pFilePath, out pFilePath) && Common.IsStreamingAssetsPath(pFilePath))
		{
			pFilePath = Path.Combine(Common.streamingAssetsPath, pFilePath);
		}
		CriAtomEx.RegisterAcf(null, pFilePath);
		if (verboseLog)
		{
			Debug.Log("[SummerRace][LuaBootstrap] initialized CriWare runtime with acf: " + pFilePath);
		}
	}

	private bool SuppressUnusedGamepadRuntime()
	{
		GamepadManager gamepadManager = UnityEngine.Object.FindObjectOfType<GamepadManager>();
		if (gamepadManager == null)
		{
			return false;
		}
		gamepadManager.SetIsRuntime(flag: false);
		gamepadManager.enabled = false;
		if (verboseLog)
		{
			Debug.Log("[SummerRace][LuaBootstrap] disabled unused GamepadManager for standalone validation scene");
		}
		return true;
	}

	private static bool HasCoreRuntimeBootstrapReady()
	{
		bool flag = HasGameMgrInstance();
		bool flag2 = false;
		try
		{
			flag2 = LuaHelper.IsLuaClientInited();
		}
		catch
		{
			flag2 = false;
		}
		return flag & flag2;
	}

	private static void ResetGameMgrSingletonForBootstrap()
	{
		try
		{
			FieldInfo fieldInfo = ResolveGameMgrInstField();
			if (fieldInfo != null)
			{
				fieldInfo.SetValue(null, null);
			}
		}
		catch (Exception)
		{
		}
	}

	private static bool InvokeGameMgrInit()
	{
		MethodInfo methodInfo = ResolveGameMgrInitMethod();
		if (methodInfo == null)
		{
			Debug.LogWarning("[SummerRace][LuaBootstrap] GameMgr.Init method is unavailable.");
			return false;
		}
		try
		{
			methodInfo.Invoke(null, null);
			return true;
		}
		catch (Exception ex)
		{
			Debug.LogWarning("[SummerRace][LuaBootstrap] invoking GameMgr.Init failed: " + ex.Message);
			return false;
		}
	}

	private static bool HasGameMgrInstance()
	{
		Type type = ResolveGameMgrType();
		if (type == null)
		{
			return false;
		}
		return UnityEngine.Object.FindObjectOfType(type) != null;
	}

	private static Type ResolveGameMgrType()
	{
		if (sGameMgrTypeResolved)
		{
			return sGameMgrType;
		}
		sGameMgrTypeResolved = true;
		Assembly[] assemblies = AppDomain.CurrentDomain.GetAssemblies();
		for (int i = 0; i < assemblies.Length; i++)
		{
			Type type = assemblies[i].GetType("GameMgr", throwOnError: false);
			if (!(type == null))
			{
				sGameMgrType = type;
				sGameMgrInitMethod = type.GetMethod("Init", BindingFlags.Static | BindingFlags.Public);
				sGameMgrInstField = type.GetField("_inst", BindingFlags.Static | BindingFlags.Public);
				break;
			}
		}
		return sGameMgrType;
	}

	private static MethodInfo ResolveGameMgrInitMethod()
	{
		ResolveGameMgrType();
		return sGameMgrInitMethod;
	}

	private static FieldInfo ResolveGameMgrInstField()
	{
		ResolveGameMgrType();
		return sGameMgrInstField;
	}

	private static void EnsureUiCameraRoot()
	{
		EnsureMainCameraAlias();
		EnsureUiCameraMainRoot();
		EnsureUiCameraDontDestroyRoot();
	}

	private static void EnsureMainCameraAlias()
	{
		GameObject gameObject = GameObject.Find("MainCamera");
		if (gameObject != null)
		{
			EnsureSimPipelineCameraExtension(gameObject);
			return;
		}
		GameObject gameObject2 = GameObject.Find("Main Camera");
		if (gameObject2 != null)
		{
			gameObject2.name = "MainCamera";
			EnsureSimPipelineCameraExtension(gameObject2);
			return;
		}
		GameObject obj = new GameObject("MainCamera", typeof(Camera));
		obj.tag = "MainCamera";
		obj.transform.position = new Vector3(0f, 0f, -10f);
		EnsureSimPipelineCameraExtension(obj);
		Debug.LogWarning("[SummerRace][LuaBootstrap] missing MainCamera; created fallback camera");
	}

	private static void EnsureUiCameraMainRoot()
	{
		GameObject gameObject = GameObject.Find("UICamera");
		if (gameObject == null)
		{
			gameObject = new GameObject("UICamera");
		}
		GameObject obj = EnsureCanvasNode(gameObject.transform, "Canvas", screenSpaceCamera: true);
		EnsureComponent<CanvasGroup>(obj);
		EnsureRectNode(EnsureRectNode(obj.transform, "UIMain").transform, "HPPanel");
		EnsureCanvasPath(obj.transform, "UIStory/Canvas");
		EnsureCanvasPath(obj.transform, "UIPop/Canvas");
		EnsureCanvasPath(obj.transform, "UIMessage/Canvas");
		EnsureCanvasPath(obj.transform, "UITips/Canvas");
		EnsureCanvasPath(obj.transform, "UILoad/Canvas");
		EnsureComponent<CanvasGroup>(EnsureRectNode(EnsureRectNode(obj.transform, "UIScreenTap").transform, "ScreenTapUI"));
	}

	private static void EnsureUiCameraDontDestroyRoot()
	{
		GameObject gameObject = GameObject.Find("UICamera_DontDestroy");
		if (gameObject == null)
		{
			GameObject gameObject2 = Resources.Load<GameObject>("UICamera_DontDestroy");
			if (gameObject2 != null)
			{
				gameObject = UnityEngine.Object.Instantiate(gameObject2);
				gameObject.name = "UICamera_DontDestroy";
			}
			else
			{
				gameObject = new GameObject("UICamera_DontDestroy");
				Debug.LogWarning("[SummerRace][LuaBootstrap] missing Resources/UICamera_DontDestroy; created fallback root");
			}
		}
		if (Application.isPlaying)
		{
			UnityEngine.Object.DontDestroyOnLoad(gameObject);
		}
		GameObject obj = EnsureRectNode(EnsureCanvasNode(gameObject.transform, "Canvas", screenSpaceCamera: false).transform, "UIMessage");
		EnsureCanvasNode(obj.transform, "Canvas", screenSpaceCamera: false);
		Text text = EnsureComponent<Text>(EnsureRectNode(obj.transform, "UIDText"));
		if (text.font == null)
		{
			text.font = Resources.GetBuiltinResource<Font>("Arial.ttf");
		}
		EnsureComponent<Image>(EnsureRectNode(obj.transform, "TipImage"));
	}

	private static void EnsurePoolRoot()
	{
		if (!(GameObject.Find("/Pool") != null) && !(GameObject.Find("Pool") != null))
		{
			GameObject target = new GameObject("Pool");
			if (Application.isPlaying)
			{
				UnityEngine.Object.DontDestroyOnLoad(target);
			}
		}
	}

	private static void EnsureEventSystem()
	{
		EventSystem[] array = UnityEngine.Object.FindObjectsOfType<EventSystem>(includeInactive: true);
		if (array != null && array.Length != 0)
		{
			if (!(sBootstrapEventSystem != null))
			{
				return;
			}
			bool flag = false;
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i] == sBootstrapEventSystem)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				sBootstrapEventSystem = null;
			}
		}
		else
		{
			GameObject gameObject = new GameObject("SummerRaceBootstrapEventSystem", typeof(EventSystem), typeof(StandaloneInputModule));
			sBootstrapEventSystem = gameObject.GetComponent<EventSystem>();
			if (Application.isPlaying)
			{
				UnityEngine.Object.DontDestroyOnLoad(gameObject);
			}
		}
	}

	private static void CleanupRedundantEventSystems()
	{
		EventSystem[] array = UnityEngine.Object.FindObjectsOfType<EventSystem>(includeInactive: true);
		if (array == null || array.Length <= 1)
		{
			if (array == null || array.Length == 0)
			{
				sBootstrapEventSystem = null;
			}
			return;
		}
		if (sBootstrapEventSystem == null)
		{
			foreach (EventSystem eventSystem in array)
			{
				if (eventSystem != null && eventSystem.name == "SummerRaceBootstrapEventSystem")
				{
					sBootstrapEventSystem = eventSystem;
					break;
				}
			}
			if (sBootstrapEventSystem == null)
			{
				return;
			}
		}
		for (int j = 0; j < array.Length; j++)
		{
			if (!(array[j] == sBootstrapEventSystem))
			{
				if (Application.isPlaying)
				{
					UnityEngine.Object.Destroy(sBootstrapEventSystem.gameObject);
				}
				else
				{
					UnityEngine.Object.DestroyImmediate(sBootstrapEventSystem.gameObject);
				}
				sBootstrapEventSystem = null;
				break;
			}
		}
	}

	private void InitializeAssetRuntimeIfNeeded()
	{
		if (!Asset.GetReady())
		{
			Asset.Initialize();
		}
	}

	private void InstallStandaloneValidationLogFilterIfNeeded()
	{
	}

	private void UninstallStandaloneValidationLogFilterIfNeeded()
	{
	}

	private void TryCleanupStandaloneValidationRuntime()
	{
	}

	private void TryCloseStandaloneSummerRaceRoutes()
	{
		LuaState luaState = LuaHelper.GetLuaState();
		if (luaState == null)
		{
			Debug.LogWarning("[SummerRace][LuaBootstrap] shutdown ui cleanup skipped: luaState null");
			return;
		}
		luaState.DoString("\nfunction SummerRaceValidationShutdownUi()\n    if gameContext == nil then\n        return 'gameContext_missing'\n    end\n\n    local traces = {}\n    local routes = gameContext.GetAllOpenRoute and gameContext:GetAllOpenRoute() or {}\n    local routeCount = #routes\n\n    if gameContext.DestroyCurRoutes ~= nil then\n        local okDestroy, errDestroy = pcall(function()\n            gameContext:DestroyCurRoutes()\n        end)\n        traces[#traces + 1] = okDestroy and 'destroy_routes=ok' or ('destroy_routes_err=' .. tostring(errDestroy))\n    else\n        traces[#traces + 1] = 'destroy_routes_missing'\n    end\n\n    local reduxFactory = ReduxFactory and ReduxFactory.GetInstance and ReduxFactory.GetInstance() or nil\n    if reduxFactory ~= nil and reduxFactory.ClearCacheViews ~= nil then\n        local okClear, errClear = pcall(function()\n            reduxFactory:ClearCacheViews()\n        end)\n        traces[#traces + 1] = okClear and 'clear_cache=ok' or ('clear_cache_err=' .. tostring(errClear))\n    else\n        traces[#traces + 1] = 'clear_cache_missing'\n    end\n\n    local leakedBefore = 0\n    local leakedAfter = 0\n    if reduxFactory ~= nil and reduxFactory.existReduxViewList_ ~= nil then\n        leakedBefore = #reduxFactory.existReduxViewList_\n\n        for i = #reduxFactory.existReduxViewList_, 1, -1 do\n            local managedObj = reduxFactory.existReduxViewList_[i]\n            local className = managedObj and managedObj.class and managedObj.class.__cname or ''\n            local shouldDispose = className == 'LuaList' or\n                (type(className) == 'string' and string.find(className, 'SummerRace', 1, true) ~= nil)\n\n            if shouldDispose and type(managedObj.Dispose) == 'function' then\n                local okDispose, errDispose = pcall(function()\n                    managedObj:Dispose()\n                end)\n                traces[#traces + 1] = okDispose\n                    and ('dispose=' .. tostring(className))\n                    or ('dispose_err=' .. tostring(className) .. ':' .. tostring(errDispose))\n            end\n        end\n\n        leakedAfter = reduxFactory.existReduxViewList_ ~= nil and #reduxFactory.existReduxViewList_ or 0\n    else\n        traces[#traces + 1] = 'managed_list_missing'\n    end\n\n    local remainingRoutes = gameContext.GetAllOpenRoute and gameContext:GetAllOpenRoute() or {}\n    local lastPage = gameContext.GetLastOpenPage and gameContext:GetLastOpenPage() or 'nil'\n\n    for i = 1, #routes do\n        local route = routes[i]\n        if type(route) == 'string' and string.find(string.lower(route), 'summerrace', 1, true) ~= nil then\n            traces[#traces + 1] = route\n        end\n    end\n\n    return string.format('routes_before=%s routes_after=%s top=%s trace=%s',\n        tostring(routeCount),\n        tostring(#remainingRoutes),\n        tostring(lastPage),\n        table.concat(traces, ',') .. string.format(',managed_before=%s,managed_after=%s', tostring(leakedBefore), tostring(leakedAfter)))\nend\n", "SummerRaceLuaRuntimeBootstrap.ValidationShutdown.Define");
		LuaFunction function = luaState.GetFunction("SummerRaceValidationShutdownUi", beLogMiss: false);
		if (function == null)
		{
			Debug.LogWarning("[SummerRace][LuaBootstrap] shutdown ui cleanup skipped: function missing");
			return;
		}
		try
		{
			object[] array = function.LazyCall();
			string text = ((array == null || array.Length == 0) ? "nil" : array[0]?.ToString());
			Debug.Log("[SummerRace][LuaBootstrap] shutdown ui cleanup: " + text);
		}
		catch (Exception ex)
		{
			Debug.LogWarning("[SummerRace][LuaBootstrap] shutdown ui cleanup failed: " + ex.Message);
		}
	}

	private void TryCleanupStandaloneLeanTween()
	{
		try
		{
			LeanTween.cancelAll();
			LeanTween.reset();
			if (!TryDestroyStandaloneLeanTweenRoot("cleanup"))
			{
				Debug.LogWarning("[SummerRace][LuaBootstrap] LeanTween root still exists after cleanup");
			}
		}
		catch (Exception ex)
		{
			Debug.LogWarning("[SummerRace][LuaBootstrap] LeanTween.reset failed: " + ex.Message);
		}
	}

	private static GameObject FindStandaloneLeanTweenRoot()
	{
		GameObject[] array = Resources.FindObjectsOfTypeAll<GameObject>();
		foreach (GameObject gameObject in array)
		{
			if (gameObject != null && gameObject.name == "~LeanTween")
			{
				return gameObject;
			}
		}
		return null;
	}

	private void TryDestroyStandaloneLeanTweenRootLate()
	{
		if (enableStandaloneValidationBootstrap)
		{
			TryDestroyStandaloneLeanTweenRoot("late");
		}
	}

	private static bool TryDestroyStandaloneLeanTweenRoot(string phase)
	{
		GameObject gameObject = FindStandaloneLeanTweenRoot();
		if (gameObject == null)
		{
			return true;
		}
		UnityEngine.Object.DestroyImmediate(gameObject);
		gameObject = FindStandaloneLeanTweenRoot();
		if (gameObject == null)
		{
			Debug.Log("[SummerRace][LuaBootstrap] destroyed lingering LeanTween root during " + phase + " cleanup");
			return true;
		}
		return false;
	}

	private static bool ShouldSuppressStandaloneValidationLog(LogType logType, string message)
	{
		return false;
	}

	private static GameObject EnsureCanvasPath(Transform root, string path)
	{
		string[] array = path.Split('/');
		Transform transform = root;
		for (int i = 0; i < array.Length; i++)
		{
			transform = ((i == array.Length - 1 && string.Equals(array[i], "Canvas", StringComparison.Ordinal)) ? EnsureCanvasNode(transform, array[i], screenSpaceCamera: false).transform : EnsureRectNode(transform, array[i]).transform);
		}
		return transform.gameObject;
	}

	private static GameObject EnsureCanvasNode(Transform parent, string name, bool screenSpaceCamera)
	{
		GameObject obj = EnsureRectNode(parent, name);
		Canvas canvas = EnsureComponent<Canvas>(obj);
		EnsureComponent<CanvasScaler>(obj);
		EnsureComponent<GraphicRaycaster>(obj);
		if (screenSpaceCamera)
		{
			canvas.renderMode = RenderMode.ScreenSpaceCamera;
			Camera worldCamera = Camera.main ?? GameObject.Find("MainCamera")?.GetComponent<Camera>();
			canvas.worldCamera = worldCamera;
			canvas.planeDistance = 1f;
			return obj;
		}
		canvas.renderMode = RenderMode.ScreenSpaceOverlay;
		return obj;
	}

	private static GameObject EnsureRectNode(Transform parent, string name)
	{
		Transform transform = parent.Find(name);
		if (transform != null)
		{
			return transform.gameObject;
		}
		GameObject obj = new GameObject(name, typeof(RectTransform));
		obj.transform.SetParent(parent, worldPositionStays: false);
		return obj;
	}

	private static T EnsureComponent<T>(GameObject go) where T : Component
	{
		T val = go.GetComponent<T>();
		if (val == null)
		{
			val = go.AddComponent<T>();
		}
		return val;
	}

	private static void EnsureSimPipelineCameraExtension(GameObject cameraGo)
	{
		if (cameraGo == null)
		{
			return;
		}
		Type type = null;
		Assembly[] assemblies = AppDomain.CurrentDomain.GetAssemblies();
		for (int i = 0; i < assemblies.Length; i++)
		{
			type = assemblies[i].GetType("UnityEngine.Pipelines.SimPipeline.CameraExtension");
			if (type != null)
			{
				break;
			}
		}
		if (!(type == null) && cameraGo.GetComponent(type) == null)
		{
			cameraGo.AddComponent(type);
		}
	}

	private void StartEnsureLuaUiContext()
	{
		if (!sUiContextInitialized && ensureLuaContextCoroutine == null)
		{
			ensureLuaContextCoroutine = StartCoroutine(EnsureLuaUiContextRoutine());
		}
	}

	private IEnumerator EnsureLuaUiContextRoutine()
	{
		int retryTotal = Mathf.Max(1, luaContextRetryCount);
		float interval = Mathf.Max(0.05f, luaContextRetryIntervalSeconds);
		string status = "unknown";
		for (int i = 1; i <= retryTotal; i++)
		{
			if (TryEnsureLuaUiContext(out status))
			{
				sUiContextInitialized = true;
				SummerRaceFightManager.SetLuaUiContextReady(ReadLuaUiContextReadyForFightManager());
				ensureLuaContextCoroutine = null;
				Debug.Log("[SummerRace][LuaBootstrap] UI route context ready: " + status);
				bool flag = validationOutGamePreset != null && validationOutGamePreset.enabled;
				ApplyValidationOutGamePresetIfNeeded(force: false);
				SummerRaceLuaUiRouteProbe summerRaceLuaUiRouteProbe = UnityEngine.Object.FindObjectOfType<SummerRaceLuaUiRouteProbe>();
				bool flag2 = suppressAutoRouteProbeWhenOutGamePresetEnabled & flag;
				if (autoRunRouteProbeAfterContextReady && summerRaceLuaUiRouteProbe != null && !flag2)
				{
					summerRaceLuaUiRouteProbe.RunSummerRaceRouteProbe();
					Debug.Log("[SummerRace][LuaBootstrap] triggered SummerRaceLuaUiRouteProbe after context ready");
				}
				else if ((autoRunRouteProbeAfterContextReady && summerRaceLuaUiRouteProbe != null) & flag2)
				{
					Debug.Log("[SummerRace][LuaBootstrap] skipped SummerRaceLuaUiRouteProbe because validation outgame preset is enabled");
				}
				yield break;
			}
			if (verboseLog && i == retryTotal)
			{
				Debug.LogWarning("[SummerRace][LuaBootstrap] UI route context not ready after retries: " + status);
			}
			yield return new WaitForSeconds(interval);
		}
		SummerRaceFightManager.SetLuaUiContextReady(ReadLuaUiContextReadyForFightManager());
		ensureLuaContextCoroutine = null;
	}

	private bool ReadLuaUiContextReadyForFightManager()
	{
		if (enableStandaloneValidationBootstrap)
		{
			return sUiContextInitialized;
		}
		return false;
	}

	private static bool TryEnsureLuaUiContext(out string status)
	{
		LuaState luaState = LuaHelper.GetLuaState();
		if (luaState == null)
		{
			status = "luaState=nil";
			return false;
		}
		EnsureSummerRaceLuaUiBootstrap(luaState);
		EnsureGlobalCallShim(luaState);
		EnsureSummerRaceValidationPresetBootstrap(luaState);
		try
		{
			luaState.DoString("function SummerRaceRouteBootstrapProbe() local uiReady = manager ~= nil and manager.ui ~= nil and manager.ui.uiMain ~= nil local cameraReady = manager ~= nil and manager.ui ~= nil and manager.ui.mainCamera ~= nil return tostring(gameContext ~= nil), tostring(GlobalCall ~= nil), tostring(uiReady), tostring(cameraReady) end", "SummerRaceLuaRuntimeBootstrap.ProbeContext.Define");
			object[] array = LuaHelper.CallFunction("SummerRaceRouteBootstrapProbe");
			string text = ((array == null || array.Length == 0) ? "false" : array[0]?.ToString());
			string text2 = ((array == null || array.Length <= 1) ? "false" : array[1]?.ToString());
			string text3 = ((array == null || array.Length <= 2) ? "false" : array[2]?.ToString());
			string text4 = ((array == null || array.Length <= 3) ? "false" : array[3]?.ToString());
			bool flag = string.Equals(text, "true", StringComparison.OrdinalIgnoreCase);
			bool flag2 = string.Equals(text2, "true", StringComparison.OrdinalIgnoreCase);
			bool flag3 = string.Equals(text3, "true", StringComparison.OrdinalIgnoreCase);
			bool flag4 = string.Equals(text4, "true", StringComparison.OrdinalIgnoreCase);
			status = $"gameContext={text}, globalCall={text2}, uiMain={text3}, cameraMain={text4}, runtimeBootstrap={sSummerRaceBootstrapInvoked}";
			if (!flag || !flag2 || !flag3 || !flag4)
			{
				if (!sLuaContextProbeLogged)
				{
					sLuaContextProbeLogged = true;
					Debug.Log("[SummerRace][LuaBootstrap] waiting UI route context: " + status);
				}
				return false;
			}
			return true;
		}
		catch (Exception ex)
		{
			status = "probe-exception=" + ex.Message;
			return false;
		}
	}

	private static void EnsureGlobalCallShim(LuaState luaState)
	{
		luaState.DoString("\nGlobalCall = GlobalCall or {}\nif type(GlobalCall.register) ~= 'function' then\n    local _eventMap = {}\n    function GlobalCall.register(name, cb)\n        _eventMap[name] = cb\n    end\n    function GlobalCall.unregister(name)\n        _eventMap[name] = nil\n    end\n    function GlobalCall.call(name, ...)\n        local cb = _eventMap[name]\n        if type(cb) == 'function' then\n            return cb(...)\n        end\n    end\nend\n", "SummerRaceLuaRuntimeBootstrap.EnsureGlobalCallShim");
	}

	private static void EnsureSummerRaceLuaUiBootstrap(LuaState luaState)
	{
		luaState.DoString("\nfunction SummerRaceValidationBootstrap()\n    -- Keep preview bootstrap close to GameMain/GameInit chain:\n    -- include -> manager.init -> GameContext(home) -> manager.uiInit -> SetMainCamera(summerRaceBattle)\n    _G.__SummerRaceStandaloneValidationBootstrap = true\n\n    local traces = {}\n    local function addTrace(key, value)\n        traces[#traces + 1] = string.format('%s=%s', tostring(key), tostring(value))\n    end\n\n    local function failBootstrap(traceKey, reason)\n        addTrace(traceKey, reason)\n        local trace = table.concat(traces, '|')\n        _G.__SummerRaceValidationBootstrapTrace = trace\n        return trace\n    end\n\n    local function requireBootstrapModule(moduleName, traceKey)\n        local okModule, moduleOrErr = pcall(require, moduleName)\n        if not okModule then\n            return false, failBootstrap(traceKey, 'err:' .. tostring(moduleOrErr))\n        end\n\n        addTrace(traceKey, 'ok')\n        return true\n    end\n\n    local includeReady, includeTrace = requireBootstrapModule('include', 'require.include')\n    if not includeReady then\n        return 'false', 'false', 'false', 'false', includeTrace\n    end\n\n    local includeModReady, includeModTrace = requireBootstrapModule('game/includeMod', 'require.includeMod')\n    if not includeModReady then\n        return 'false', 'false', 'false', 'false', includeModTrace\n    end\n\n    local function isUiFullyReady()\n        return manager ~= nil\n            and manager.managerInit == true\n            and manager.ui ~= nil\n            and manager.ui.uiMain ~= nil\n            and manager.ui.mainCamera ~= nil\n            and manager.transition ~= nil\n            and manager.timeWheel ~= nil\n    end\n\n    local function resetHalfInitializedManagerIfNeeded()\n        if manager == nil or manager.managerInit ~= true or isUiFullyReady() then\n            return false\n        end\n\n        manager.managerInit = false\n        manager.ui = nil\n        manager.tips = nil\n        manager.messageBox = nil\n        manager.loadui = nil\n        manager.effect = nil\n        manager.story = nil\n        manager.windowBar = nil\n        manager.transition = nil\n        manager.objectPool = nil\n        manager.commonItemPool = nil\n        manager.classPool = nil\n        manager.matrixPop = nil\n        manager.video = nil\n        manager.timeWheel = nil\n        return true\n    end\n\n    if _G.__SummerRaceValidationCoreInit ~= true then\n        if manager and manager.init then\n            local okInit, errInit = pcall(manager.init)\n            addTrace('manager.init', okInit)\n            if okInit then\n                _G.__SummerRaceValidationCoreInit = true\n            else\n                addTrace('manager.init.err', errInit)\n            end\n        else\n            addTrace('manager.init.missing', true)\n        end\n    end\n\n    local actionIncludeReady, actionTrace = requireBootstrapModule('game/action/ActionInclude', 'require.actionInclude')\n    if not actionIncludeReady then\n        return 'false', 'false', 'false', 'false', actionTrace\n    end\n\n    local dataIncludeReady, dataTrace = requireBootstrapModule('game/data/DataInclude', 'require.dataInclude')\n    if not dataIncludeReady then\n        return 'false', 'false', 'false', 'false', dataTrace\n    end\n\n    local RoutesConfig = import('game.RoutesConfig')\n    local GameContext = import('game.GameContext')\n    if gameContext == nil then\n        gameContext = GameContext.New(RoutesConfig, {'home'})\n        addTrace('gameContext.created', gameContext ~= nil)\n        if gameContext and gameContext.RegistPreLoadFunc and ViewTools and ViewTools.PreDealWithAsset then\n            local okPreload, errPreload = pcall(function()\n                gameContext:RegistPreLoadFunc(ViewTools.PreDealWithAsset)\n            end)\n            addTrace('gameContext.preloadReg', okPreload)\n            if not okPreload then\n                addTrace('gameContext.preloadReg.err', errPreload)\n            end\n        end\n    end\n\n    if gameContext and gameContext.SetSystemLayer then\n        local okLayer, errLayer = pcall(function()\n            gameContext:SetSystemLayer('home')\n        end)\n        addTrace('gameContext.setLayerHome', okLayer)\n        if not okLayer then\n            addTrace('gameContext.setLayerHome.err', errLayer)\n        end\n    end\n\n    local didResetHalfInit = resetHalfInitializedManagerIfNeeded()\n    addTrace('manager.halfReset', didResetHalfInit)\n\n    if not isUiFullyReady() then\n        if manager and manager.uiInit then\n            local okUi, errUi = pcall(manager.uiInit)\n            addTrace('manager.uiInit', okUi)\n            if not okUi then\n                addTrace('manager.uiInit.err', errUi)\n                if manager then\n                    manager.managerInit = false\n                end\n            end\n        else\n            addTrace('manager.uiInit.missing', true)\n        end\n    end\n\n    if manager and manager.uiTime and manager.uiTime.StartUITimer then\n        if manager.uiTime.timer_ == nil then\n            local okUiTime, errUiTime = pcall(function()\n                manager.uiTime:StartUITimer()\n            end)\n            addTrace('manager.uiTime.start', okUiTime)\n            if not okUiTime then\n                addTrace('manager.uiTime.start.err', errUiTime)\n            end\n        else\n            addTrace('manager.uiTime.start', 'skip_existing')\n        end\n    else\n        addTrace('manager.uiTime.start', 'missing')\n    end\n\n    if gameContext and gameContext.SetActions then\n        local okActions, errActions = pcall(function()\n            -- Preview validation path: avoid transition/load-scene deadlock so route handlers can instantiate deterministically.\n            gameContext:SetActions(nil, nil)\n        end)\n        addTrace('gameContext.setActionsDefault', okActions)\n        if not okActions then\n            addTrace('gameContext.setActionsDefault.err', errActions)\n        end\n    end\n\n    if manager and manager.ui and manager.ui.SetMainCamera then\n        local okCamera, errCamera = pcall(function()\n            manager.ui:SetMainCamera('summerRaceBattle')\n        end)\n        addTrace('manager.setMainCamera.summerRaceBattle', okCamera)\n        if not okCamera then\n            addTrace('manager.setMainCamera.err', errCamera)\n        end\n    end\n\n    local okGlobalCall, globalCall = pcall(require, 'library/GlobalCall')\n    addTrace('globalCall.require', okGlobalCall)\n    if okGlobalCall and type(globalCall) == 'table' then\n        GlobalCall = globalCall\n    end\n\n    local uiReady = isUiFullyReady()\n    _G.__SummerRaceValidationManagerInit = uiReady and true or false\n    addTrace('manager.uiReady', uiReady)\n    addTrace('manager.initFlag', _G.__SummerRaceValidationManagerInit == true)\n\n    local trace = table.concat(traces, '|')\n    _G.__SummerRaceValidationBootstrapTrace = trace\n    return tostring(gameContext ~= nil), tostring(GlobalCall ~= nil), tostring(manager ~= nil and manager.ui ~= nil and manager.ui.uiMain ~= nil), tostring(uiReady), trace\nend\n", "SummerRaceLuaRuntimeBootstrap.ValidationBootstrap.Define");
		object[] array = LuaHelper.CallFunction("SummerRaceValidationBootstrap");
		if (array != null && array.Length != 0)
		{
			string text = ((array.Length == 0) ? "nil" : array[0]?.ToString());
			string text2 = ((array.Length <= 1) ? "nil" : array[1]?.ToString());
			string text3 = ((array.Length <= 2) ? "nil" : array[2]?.ToString());
			string text4 = ((array.Length <= 3) ? "nil" : array[3]?.ToString());
			string text5 = ((array.Length <= 4) ? "nil" : array[4]?.ToString());
			Debug.Log("[SummerRace][LuaBootstrap] validation bootstrap result: gameContext=" + text + ", globalCall=" + text2 + ", uiMain=" + text3 + ", uiReady=" + text4 + ", trace=" + text5);
		}
		sSummerRaceBootstrapInvoked = true;
	}

	private bool ApplyValidationOutGamePresetIfNeeded(bool force)
	{
		if (!enableStandaloneValidationBootstrap)
		{
			return false;
		}
		if (validationOutGamePreset == null || !validationOutGamePreset.enabled)
		{
			return false;
		}
		if (!force && (!autoApplyValidationOutGamePresetAfterContextReady || validationOutGamePresetApplied))
		{
			return false;
		}
		LuaState luaState = LuaHelper.GetLuaState();
		if (luaState == null)
		{
			Debug.LogWarning("[SummerRace][LuaBootstrap] LuaState missing while applying validation outgame preset.");
			return false;
		}
		EnsureSummerRaceValidationPresetBootstrap(luaState);
		string text = JsonUtility.ToJson(BuildValidationOutGamePresetPayload(validationOutGamePreset));
		LuaFunction function = luaState.GetFunction("SummerRaceValidationApplyOutGamePreset", beLogMiss: false);
		if (function == null)
		{
			if (verboseLog | force)
			{
				Debug.LogWarning("[SummerRace][LuaBootstrap] validation outgame preset function is not available yet.");
			}
			return false;
		}
		object[] array = null;
		try
		{
			array = function.LazyCall(text);
		}
		catch (Exception ex)
		{
			Debug.LogWarning("[SummerRace][LuaBootstrap] validation outgame preset call failed: " + ex.Message);
			return false;
		}
		bool flag = IsLuaTrue((array != null && array.Length != 0) ? array[0] : null);
		string text2 = ((array == null || array.Length <= 1) ? "nil" : array[1]?.ToString());
		if (flag)
		{
			validationOutGamePresetApplied = true;
		}
		Debug.Log("[SummerRace][LuaBootstrap] validation outgame preset applied=" + flag + " trace=" + text2);
		return flag;
	}

	private static ValidationOutGamePresetPayload BuildValidationOutGamePresetPayload(ValidationOutGamePreset preset)
	{
		return new ValidationOutGamePresetPayload
		{
			launchPreset = ToLuaLaunchPresetKey(preset?.launchPreset ?? ValidationBattleFlowPreset.ChampionshipFromCfg),
			stageIdOverride = ((preset != null && !string.IsNullOrWhiteSpace(preset.stageIdOverride)) ? preset.stageIdOverride.Trim() : string.Empty),
			autoEnterBattle = (preset?.autoEnterBattle ?? true),
			source = ((preset != null && !string.IsNullOrWhiteSpace(preset.source)) ? preset.source.Trim() : "validationBootstrap")
		};
	}

	private static bool IsLuaTrue(object value)
	{
		if (value is bool)
		{
			return (bool)value;
		}
		if (value is string a)
		{
			return string.Equals(a, "true", StringComparison.OrdinalIgnoreCase);
		}
		return false;
	}

	private static string ToLuaLaunchPresetKey(ValidationBattleFlowPreset launchPreset)
	{
		return launchPreset switch
		{
			ValidationBattleFlowPreset.ChampionshipFromCfg => "championship_cfg", 
			ValidationBattleFlowPreset.SurvivalFromCfg => "survival_cfg", 
			ValidationBattleFlowPreset.DuelFromCfg => "duel_cfg", 
			ValidationBattleFlowPreset.Challenge => "challenge", 
			_ => "none", 
		};
	}

	private static void EnsureSummerRaceValidationPresetBootstrap(LuaState luaState)
	{
		luaState.DoString("\nfunction SummerRaceValidationApplyOutGamePreset(configJson)\n    local traces = {}\n    local function addTrace(key, value)\n        traces[#traces + 1] = string.format('%s=%s', tostring(key), tostring(value))\n    end\n\n    local okJson, cjson = pcall(require, 'cjson')\n    if not okJson or type(cjson) ~= 'table' or type(cjson.decode) ~= 'function' then\n        return false, 'cjson-missing'\n    end\n\n    local okDecode, cfg = pcall(cjson.decode, configJson or '{}')\n    if not okDecode or type(cfg) ~= 'table' then\n        return false, 'decode-failed:' .. tostring(cfg)\n    end\n\n    local action = rawget(_G, 'SummerRaceAction')\n    if type(action) ~= 'table' then\n        return false, 'action-missing:SummerRaceAction'\n    end\n\n    local okData, data = pcall(import, 'game.data.ActivitySubmodule.SummerRaceData')\n    if not okData or type(data) ~= 'table' then\n        return false, 'data-missing:' .. tostring(data)\n    end\n\n    local launchPreset = tostring(cfg.launchPreset or 'none')\n    local stageIdOverride = cfg.stageIdOverride ~= nil and tostring(cfg.stageIdOverride) or ''\n    local autoEnterBattle = cfg.autoEnterBattle ~= false\n    local source = tostring(cfg.source or 'validationBootstrap')\n    local tournamentTab = 'normal'\n    local stageId = ''\n\n    local function finalize(ok, routeTag)\n        addTrace('route', routeTag)\n        return ok == true, table.concat(traces, '|')\n    end\n\n    local function setTournamentTabValue(tabValue)\n        if type(data.SetTournamentTab) ~= 'function' or tabValue == nil or tabValue == '' then\n            return\n        end\n\n        local okTab, tabResult = pcall(function()\n            return data:SetTournamentTab(tabValue, true)\n        end)\n        addTrace('setTab', okTab and tostring(tabResult) or ('err:' .. tostring(tabResult)))\n    end\n\n    local function setStageIdValue(stageValue)\n        if type(data.SetCurrentStageId) ~= 'function' or stageValue == nil or stageValue == '' or stageValue == '0' then\n            return\n        end\n\n        local okStage, stageResult = pcall(function()\n            return data:SetCurrentStageId(stageValue, true)\n        end)\n        addTrace('setStage', okStage and tostring(stageResult) or ('err:' .. tostring(stageResult)))\n    end\n\n    local function resolveFirstStageIdForTab(tabValue)\n        local okModel, pageModel = pcall(function()\n            return data:GetTournamentPageModel()\n        end)\n        if not okModel or type(pageModel) ~= 'table' then\n            addTrace('resolveStage.pageModel', okModel and 'invalid' or ('err:' .. tostring(pageModel)))\n            return ''\n        end\n\n        local stageNodes = type(pageModel.stageNodes) == 'table' and pageModel.stageNodes or {}\n        for i = 1, #stageNodes do\n            local node = stageNodes[i]\n            if type(node) == 'table' and node.isSelected == true and node.stageId ~= nil then\n                return tostring(node.stageId)\n            end\n        end\n\n        if stageNodes[1] ~= nil and stageNodes[1].stageId ~= nil then\n            return tostring(stageNodes[1].stageId)\n        end\n\n        addTrace('resolveStage.empty', tostring(tabValue))\n        return ''\n    end\n\n    local function runCfgBattleFlow()\n        local presetTabMap = {\n            championship_cfg = 'normal',\n            survival_cfg = 'survival',\n            duel_cfg = 'duel'\n        }\n\n        if launchPreset == 'challenge' then\n            if stageIdOverride ~= '' and stageIdOverride ~= '0' then\n                stageId = stageIdOverride\n                addTrace('challengeStage', stageId)\n            end\n\n            if autoEnterBattle then\n                local okEnterChallenge, resultEnterChallenge = pcall(function()\n                    return action.EnterChallengeBattle(source, stageId ~= '' and stageId or nil)\n                end)\n                addTrace('autoEnterBattle', okEnterChallenge and tostring(resultEnterChallenge ~= false) or ('err:' .. tostring(resultEnterChallenge)))\n                return finalize(okEnterChallenge and resultEnterChallenge ~= false, 'cfg_challenge_battle_direct')\n            end\n\n            local okOpenChallenge, resultOpenChallenge = pcall(function()\n                return action.OpenChallengeView()\n            end)\n            if not okOpenChallenge or resultOpenChallenge == false then\n                return finalize(false, 'cfg_challenge_open')\n            end\n\n            return finalize(true, 'cfg_challenge')\n        end\n\n        local resolvedTab = presetTabMap[launchPreset]\n        if resolvedTab == nil then\n            return nil\n        end\n\n        tournamentTab = resolvedTab\n        setTournamentTabValue(tournamentTab)\n\n        local resolvedStageId = stageIdOverride\n        if resolvedStageId == '' or resolvedStageId == '0' then\n            resolvedStageId = resolveFirstStageIdForTab(tournamentTab)\n        end\n        if resolvedStageId == '' or resolvedStageId == '0' then\n            addTrace('cfgStageMissing', launchPreset)\n            return finalize(false, 'cfg_stage_missing')\n        end\n\n        stageId = resolvedStageId\n        setStageIdValue(stageId)\n\n        if autoEnterBattle then\n            local okEnterStage, resultEnterStage = pcall(function()\n                return action.EnterStageBattle(stageId, source)\n            end)\n            addTrace('autoEnterBattle', okEnterStage and tostring(resultEnterStage ~= false) or ('err:' .. tostring(resultEnterStage)))\n            return finalize(okEnterStage and resultEnterStage ~= false, 'cfg_stage_battle_direct')\n        end\n\n        local okOpenTournament, resultOpenTournament = pcall(function()\n            return action.OpenTournamentView(tournamentTab)\n        end)\n        if not okOpenTournament or resultOpenTournament == false then\n            return finalize(false, 'cfg_tournament')\n        end\n\n        local okOpenStageDetail, resultOpenStageDetail = pcall(function()\n            return action.OpenStageDetailView(stageId)\n        end)\n        if not okOpenStageDetail or resultOpenStageDetail == false then\n            return finalize(false, 'cfg_stage_detail')\n        end\n\n        return finalize(true, 'cfg_stage_detail')\n    end\n\n    if launchPreset ~= 'none' then\n        local battleFlowOk, battleFlowTrace = runCfgBattleFlow()\n        if battleFlowOk ~= nil then\n            return battleFlowOk, battleFlowTrace\n        end\n    end\n\n    return finalize(false, 'battle_flow_missing')\nend\n", "SummerRaceLuaRuntimeBootstrap.ValidationOutGamePreset.Define");
	}
}
