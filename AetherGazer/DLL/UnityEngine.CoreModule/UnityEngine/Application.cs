using System;
using System.Collections;
using System.ComponentModel;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading;
using UnityEngine.Bindings;
using UnityEngine.Diagnostics;
using UnityEngine.Events;
using UnityEngine.Rendering;
using UnityEngine.SceneManagement;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Application/ApplicationInfo.h")]
[NativeHeader("Runtime/Misc/BuildSettings.h")]
[NativeHeader("Runtime/Network/NetworkUtility.h")]
[NativeHeader("Runtime/Input/InputManager.h")]
[NativeHeader("Runtime/File/ApplicationSpecificPersistentDataPath.h")]
[NativeHeader("Runtime/Export/Application/Application.bindings.h")]
[NativeHeader("Runtime/Application/AdsIdHandler.h")]
[NativeHeader("Runtime/BaseClasses/IsPlaying.h")]
[NativeHeader("Runtime/Input/TargetFrameRate.h")]
[NativeHeader("Runtime/Input/GetInput.h")]
[NativeHeader("Runtime/Misc/Player.h")]
[NativeHeader("Runtime/Utilities/URLUtility.h")]
[NativeHeader("Runtime/Misc/SystemInfo.h")]
[NativeHeader("Runtime/Logging/LogSystem.h")]
[NativeHeader("Runtime/PreloadManager/LoadSceneOperation.h")]
[NativeHeader("Runtime/PreloadManager/PreloadManager.h")]
[NativeHeader("Runtime/Misc/PlayerSettings.h")]
[NativeHeader("Runtime/Utilities/Argv.h")]
public class Application
{
	public delegate void AdvertisingIdentifierCallback(string advertisingId, bool trackingEnabled, string errorMsg);

	public delegate void LowMemoryCallback();

	public delegate void MemoryUsageChangedCallback(in ApplicationMemoryUsageChange usage);

	public delegate void LogCallback(string condition, string stackTrace, LogType type);

	private static LogCallback s_LogCallbackHandler;

	private static LogCallback s_LogCallbackHandlerThreaded;

	internal static AdvertisingIdentifierCallback OnAdvertisingIdentifierCallback;

	private static CancellationTokenSource s_currentCancellationTokenSource = new CancellationTokenSource();

	private static volatile LogCallback s_RegisterLogCallbackDeprecated;

	[Obsolete("This property is deprecated, please use LoadLevelAsync to detect if a specific scene is currently loading.")]
	public static extern bool isLoadingLevel
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetPreloadManager().IsLoadingOrQueued")]
		get;
	}

	[Obsolete("Streaming was a Unity Web Player feature, and is removed. This property is deprecated and always returns 0.")]
	public static int streamedBytes => 0;

	[Obsolete("Application.webSecurityEnabled is no longer supported, since the Unity Web Player is no longer supported by Unity", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public static bool webSecurityEnabled => false;

	public static extern bool isPlaying
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("IsWorldPlaying")]
		get;
	}

	public static extern bool isFocused
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("IsPlayerFocused")]
		get;
	}

	public static extern string buildGUID
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Application_Bindings::GetBuildGUID")]
		get;
	}

	public static extern bool runInBackground
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetPlayerSettingsRunInBackground")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("SetPlayerSettingsRunInBackground")]
		set;
	}

	public static extern bool isBatchMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("::IsBatchmode")]
		get;
	}

	internal static extern bool isTestRun
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("::IsTestRun")]
		get;
	}

	internal static extern bool isHumanControllingUs
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("::IsHumanControllingUs")]
		get;
	}

	public static extern string dataPath
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetAppDataPath", IsThreadSafe = true)]
		get;
	}

	public static extern string streamingAssetsPath
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetStreamingAssetsPath", IsThreadSafe = true)]
		get;
	}

	public static extern string persistentDataPath
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetPersistentDataPathApplicationSpecific")]
		get;
	}

	public static extern string temporaryCachePath
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetTemporaryCachePathApplicationSpecific")]
		get;
	}

	public static extern string absoluteURL
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetPlayerSettings().GetAbsoluteURL")]
		get;
	}

	public static extern string unityVersion
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Application_Bindings::GetUnityVersion", IsThreadSafe = true)]
		get;
	}

	internal static extern int unityVersionVer
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Application_Bindings::GetUnityVersionVer", IsThreadSafe = true)]
		get;
	}

	internal static extern int unityVersionMaj
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Application_Bindings::GetUnityVersionMaj", IsThreadSafe = true)]
		get;
	}

	internal static extern int unityVersionMin
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Application_Bindings::GetUnityVersionMin", IsThreadSafe = true)]
		get;
	}

	public static extern string version
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetApplicationInfo().GetVersion")]
		get;
	}

	public static extern string installerName
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetApplicationInfo().GetInstallerName")]
		get;
	}

	public static extern string identifier
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetApplicationInfo().GetApplicationIdentifier")]
		get;
	}

	public static extern ApplicationInstallMode installMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetApplicationInfo().GetInstallMode")]
		get;
	}

	public static extern ApplicationSandboxType sandboxType
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetApplicationInfo().GetSandboxType")]
		get;
	}

	public static extern string productName
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetPlayerSettings().GetProductName")]
		get;
	}

	public static extern string companyName
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetPlayerSettings().GetCompanyName")]
		get;
	}

	public static extern string cloudProjectId
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetPlayerSettings().GetCloudProjectId")]
		get;
	}

	public static extern int targetFrameRate
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetTargetFrameRate")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("SetTargetFrameRate")]
		set;
	}

	[Obsolete("Use SetStackTraceLogType/GetStackTraceLogType instead")]
	public static extern StackTraceLogType stackTraceLogType
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Application_Bindings::GetStackTraceLogType")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Application_Bindings::SetStackTraceLogType")]
		set;
	}

	public static extern string consoleLogPath
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetConsoleLogPath")]
		get;
	}

	public static extern ThreadPriority backgroundLoadingPriority
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetPreloadManager().GetThreadPriority")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetPreloadManager().SetThreadPriority")]
		set;
	}

	public static extern bool genuine
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("IsApplicationGenuine")]
		get;
	}

	public static extern bool genuineCheckAvailable
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("IsApplicationGenuineAvailable")]
		get;
	}

	internal static extern bool submitAnalytics
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetPlayerSettings().GetSubmitAnalytics")]
		get;
	}

	[Obsolete("This property is deprecated, please use SplashScreen.isFinished instead")]
	public static bool isShowingSplashScreen => !SplashScreen.isFinished;

	public static extern RuntimePlatform platform
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("systeminfo::GetRuntimePlatform", IsThreadSafe = true)]
		get;
	}

	public static bool isMobilePlatform
	{
		get
		{
			switch (platform)
			{
			case RuntimePlatform.IPhonePlayer:
			case RuntimePlatform.Android:
			case RuntimePlatform.VisionOS:
				return true;
			case RuntimePlatform.MetroPlayerX86:
			case RuntimePlatform.MetroPlayerX64:
			case RuntimePlatform.MetroPlayerARM:
				return SystemInfo.deviceType == DeviceType.Handheld;
			default:
				return false;
			}
		}
	}

	public static bool isConsolePlatform
	{
		get
		{
			RuntimePlatform runtimePlatform = platform;
			return runtimePlatform == RuntimePlatform.GameCoreXboxOne || runtimePlatform == RuntimePlatform.GameCoreXboxSeries || runtimePlatform == RuntimePlatform.PS4 || runtimePlatform == RuntimePlatform.PS5 || runtimePlatform == RuntimePlatform.Switch || runtimePlatform == RuntimePlatform.XboxOne;
		}
	}

	public static extern SystemLanguage systemLanguage
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("(SystemLanguage)systeminfo::GetSystemLanguage")]
		get;
	}

	public static extern NetworkReachability internetReachability
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GetInternetReachability")]
		get;
	}

	[Obsolete("use Application.isEditor instead")]
	public static bool isPlayer => !isEditor;

	public static CancellationToken exitCancellationToken => s_currentCancellationTokenSource.Token;

	[Obsolete("Use SceneManager.sceneCountInBuildSettings")]
	public static int levelCount => SceneManager.sceneCountInBuildSettings;

	[Obsolete("Use SceneManager to determine what scenes have been loaded")]
	public static int loadedLevel => SceneManager.GetActiveScene().buildIndex;

	[Obsolete("Use SceneManager to determine what scenes have been loaded")]
	public static string loadedLevelName => SceneManager.GetActiveScene().name;

	public static bool isEditor => false;

	public static event LowMemoryCallback lowMemory;

	public static event MemoryUsageChangedCallback memoryUsageChanged;

	public static event LogCallback logMessageReceived
	{
		add
		{
			s_LogCallbackHandler = (LogCallback)Delegate.Combine(s_LogCallbackHandler, value);
			SetLogCallbackDefined(defined: true);
		}
		remove
		{
			s_LogCallbackHandler = (LogCallback)Delegate.Remove(s_LogCallbackHandler, value);
		}
	}

	public static event LogCallback logMessageReceivedThreaded
	{
		add
		{
			s_LogCallbackHandlerThreaded = (LogCallback)Delegate.Combine(s_LogCallbackHandlerThreaded, value);
			SetLogCallbackDefined(defined: true);
		}
		remove
		{
			s_LogCallbackHandlerThreaded = (LogCallback)Delegate.Remove(s_LogCallbackHandlerThreaded, value);
		}
	}

	public static event UnityAction onBeforeRender
	{
		add
		{
			BeforeRenderHelper.RegisterCallback(value);
		}
		remove
		{
			BeforeRenderHelper.UnregisterCallback(value);
		}
	}

	public static event Action<bool> focusChanged;

	public static event Action<string> deepLinkActivated;

	public static event Func<bool> wantsToQuit;

	public static event Action quitting;

	public static event Action unloading;

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetInputManager().QuitApplication")]
	public static extern void Quit(int exitCode);

	public static void Quit()
	{
		Quit(0);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[Obsolete("CancelQuit is deprecated. Use the wantsToQuit event instead.")]
	[FreeFunction("GetInputManager().CancelQuitApplication")]
	public static extern void CancelQuit();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Application_Bindings::Unload")]
	public static extern void Unload();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UpdateMemoryUsage")]
	internal static extern void SimulateMemoryUsage(ApplicationMemoryUsage usage);

	[Obsolete("Streaming was a Unity Web Player feature, and is removed. This function is deprecated and always returns 1.0 for valid level indices.")]
	public static float GetStreamProgressForLevel(int levelIndex)
	{
		if (levelIndex >= 0 && levelIndex < SceneManager.sceneCountInBuildSettings)
		{
			return 1f;
		}
		return 0f;
	}

	[Obsolete("Streaming was a Unity Web Player feature, and is removed. This function is deprecated and always returns 1.0.")]
	public static float GetStreamProgressForLevel(string levelName)
	{
		return 1f;
	}

	public static bool CanStreamedLevelBeLoaded(int levelIndex)
	{
		return levelIndex >= 0 && levelIndex < SceneManager.sceneCountInBuildSettings;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Application_Bindings::CanStreamedLevelBeLoaded")]
	public static extern bool CanStreamedLevelBeLoaded(string levelName);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction]
	public static extern bool IsPlaying([NotNull("NullExceptionObject")] Object obj);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetBuildSettings().GetBuildTags")]
	[Obsolete("Application.GetBuildTags is no longer supported and will be removed.", false)]
	public static extern string[] GetBuildTags();

	[MethodImpl((MethodImplOptions)4096)]
	[Obsolete("Application.SetBuildTags is no longer supported and will be removed.", false)]
	[FreeFunction("GetBuildSettings().SetBuildTags")]
	public static extern void SetBuildTags(string[] buildTags);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetBuildSettings().GetHasPROVersion")]
	public static extern bool HasProLicense();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("HasARGV")]
	internal static extern bool HasARGV(string name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetFirstValueForARGV")]
	internal static extern string GetValueForARGV(string name);

	[Obsolete("Application.ExternalEval is deprecated. See https://docs.unity3d.com/Manual/webgl-interactingwithbrowserscripting.html for alternatives.")]
	public static void ExternalEval(string script)
	{
		if (script.Length > 0 && script[script.Length - 1] != ';')
		{
			script += ";";
		}
		Internal_ExternalCall(script);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Application_Bindings::ExternalCall")]
	private static extern void Internal_ExternalCall(string script);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetAdsIdHandler().RequestAdsIdAsync")]
	public static extern bool RequestAdvertisingIdentifierAsync(AdvertisingIdentifierCallback delegateMethod);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("OpenURL")]
	public static extern void OpenURL(string url);

	[Obsolete("Use UnityEngine.Diagnostics.Utils.ForceCrash")]
	public static void ForceCrash(int mode)
	{
		Utils.ForceCrash((ForcedCrashCategory)mode);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Application_Bindings::SetLogCallbackDefined")]
	private static extern void SetLogCallbackDefined(bool defined);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetStackTraceLogType")]
	public static extern StackTraceLogType GetStackTraceLogType(LogType logType);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("SetStackTraceLogType")]
	public static extern void SetStackTraceLogType(LogType logType, StackTraceLogType stackTraceType);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Application_Bindings::RequestUserAuthorization")]
	public static extern AsyncOperation RequestUserAuthorization(UserAuthorization mode);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Application_Bindings::HasUserAuthorization")]
	public static extern bool HasUserAuthorization(UserAuthorization mode);

	[RequiredByNativeCode]
	internal static void CallLowMemory(ApplicationMemoryUsage usage)
	{
		memoryUsageChanged?.Invoke(new ApplicationMemoryUsageChange(usage));
		switch (usage)
		{
		case ApplicationMemoryUsage.Unknown:
		case ApplicationMemoryUsage.Low:
		case ApplicationMemoryUsage.Medium:
		case ApplicationMemoryUsage.High:
			break;
		default:
			throw new Exception($"Unknown application memory usage: {usage}");
		case ApplicationMemoryUsage.Critical:
			lowMemory?.Invoke();
			break;
		}
	}

	[RequiredByNativeCode]
	internal static bool HasLogCallback()
	{
		return s_LogCallbackHandler != null || s_LogCallbackHandlerThreaded != null;
	}

	[RequiredByNativeCode]
	private static void CallLogCallback(string logString, string stackTrace, LogType type, bool invokedOnMainThread)
	{
		if (invokedOnMainThread)
		{
			s_LogCallbackHandler?.Invoke(logString, stackTrace, type);
		}
		s_LogCallbackHandlerThreaded?.Invoke(logString, stackTrace, type);
	}

	internal static void InvokeOnAdvertisingIdentifierCallback(string advertisingId, bool trackingEnabled)
	{
		if (OnAdvertisingIdentifierCallback != null)
		{
			OnAdvertisingIdentifierCallback(advertisingId, trackingEnabled, string.Empty);
		}
	}

	private static string ObjectToJSString(object o)
	{
		if (o == null)
		{
			return "null";
		}
		if (o is string)
		{
			string text = o.ToString().Replace("\\", "\\\\");
			text = text.Replace("\"", "\\\"");
			text = text.Replace("\n", "\\n");
			text = text.Replace("\r", "\\r");
			text = text.Replace("\0", "");
			text = text.Replace("\u2028", "");
			text = text.Replace("\u2029", "");
			return "\"" + text + "\"";
		}
		if (o is int || o is short || o is uint || o is ushort || o is byte)
		{
			return o.ToString();
		}
		if (o is float)
		{
			NumberFormatInfo numberFormat = CultureInfo.InvariantCulture.NumberFormat;
			return ((float)o).ToString(numberFormat);
		}
		if (o is double)
		{
			NumberFormatInfo numberFormat2 = CultureInfo.InvariantCulture.NumberFormat;
			return ((double)o).ToString(numberFormat2);
		}
		if (o is char)
		{
			if ((char)o == '"')
			{
				return "\"\\\"\"";
			}
			return "\"" + o.ToString() + "\"";
		}
		if (o is IList)
		{
			IList list = (IList)o;
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.Append("new Array(");
			int count = list.Count;
			for (int i = 0; i < count; i++)
			{
				if (i != 0)
				{
					stringBuilder.Append(", ");
				}
				stringBuilder.Append(ObjectToJSString(list[i]));
			}
			stringBuilder.Append(")");
			return stringBuilder.ToString();
		}
		return ObjectToJSString(o.ToString());
	}

	[Obsolete("Application.ExternalCall is deprecated. See https://docs.unity3d.com/Manual/webgl-interactingwithbrowserscripting.html for alternatives.")]
	public static void ExternalCall(string functionName, params object[] args)
	{
		Internal_ExternalCall(BuildInvocationForArguments(functionName, args));
	}

	private static string BuildInvocationForArguments(string functionName, params object[] args)
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(functionName);
		stringBuilder.Append('(');
		int num = args.Length;
		for (int i = 0; i < num; i++)
		{
			if (i != 0)
			{
				stringBuilder.Append(", ");
			}
			stringBuilder.Append(ObjectToJSString(args[i]));
		}
		stringBuilder.Append(')');
		stringBuilder.Append(';');
		return stringBuilder.ToString();
	}

	[Obsolete("Use Object.DontDestroyOnLoad instead")]
	public static void DontDestroyOnLoad(Object o)
	{
		if (o != null)
		{
			Object.DontDestroyOnLoad(o);
		}
	}

	[Obsolete("Application.CaptureScreenshot is obsolete. Use ScreenCapture.CaptureScreenshot instead (UnityUpgradable) -> [UnityEngine] UnityEngine.ScreenCapture.CaptureScreenshot(*)", true)]
	public static void CaptureScreenshot(string filename, int superSize)
	{
		throw new NotSupportedException("Application.CaptureScreenshot is obsolete. Use ScreenCapture.CaptureScreenshot instead.");
	}

	[Obsolete("Application.CaptureScreenshot is obsolete. Use ScreenCapture.CaptureScreenshot instead (UnityUpgradable) -> [UnityEngine] UnityEngine.ScreenCapture.CaptureScreenshot(*)", true)]
	public static void CaptureScreenshot(string filename)
	{
		throw new NotSupportedException("Application.CaptureScreenshot is obsolete. Use ScreenCapture.CaptureScreenshot instead.");
	}

	[RequiredByNativeCode]
	private static bool Internal_ApplicationWantsToQuit()
	{
		if (wantsToQuit != null)
		{
			Delegate[] invocationList = wantsToQuit.GetInvocationList();
			for (int i = 0; i < invocationList.Length; i++)
			{
				Func<bool> func = (Func<bool>)invocationList[i];
				try
				{
					if (!func())
					{
						return false;
					}
				}
				catch (Exception exception)
				{
					Debug.LogException(exception);
				}
			}
		}
		return true;
	}

	[RequiredByNativeCode]
	private static void Internal_ApplicationInit()
	{
		s_currentCancellationTokenSource = new CancellationTokenSource();
	}

	[RequiredByNativeCode]
	private static void Internal_ApplicationQuit()
	{
		s_currentCancellationTokenSource.Cancel();
		if (quitting != null)
		{
			quitting();
		}
	}

	[RequiredByNativeCode]
	private static void Internal_ApplicationUnload()
	{
		if (unloading != null)
		{
			unloading();
		}
	}

	[RequiredByNativeCode]
	internal static void InvokeOnBeforeRender()
	{
		BeforeRenderHelper.Invoke();
	}

	[RequiredByNativeCode]
	internal static void InvokeFocusChanged(bool focus)
	{
		if (focusChanged != null)
		{
			focusChanged(focus);
		}
	}

	[RequiredByNativeCode]
	internal static void InvokeDeepLinkActivated(string url)
	{
		if (deepLinkActivated != null)
		{
			deepLinkActivated(url);
		}
	}

	[Obsolete("Application.RegisterLogCallback is deprecated. Use Application.logMessageReceived instead.")]
	public static void RegisterLogCallback(LogCallback handler)
	{
		RegisterLogCallback(handler, threaded: false);
	}

	[Obsolete("Application.RegisterLogCallbackThreaded is deprecated. Use Application.logMessageReceivedThreaded instead.")]
	public static void RegisterLogCallbackThreaded(LogCallback handler)
	{
		RegisterLogCallback(handler, threaded: true);
	}

	private static void RegisterLogCallback(LogCallback handler, bool threaded)
	{
		if (s_RegisterLogCallbackDeprecated != null)
		{
			logMessageReceived -= s_RegisterLogCallbackDeprecated;
			logMessageReceivedThreaded -= s_RegisterLogCallbackDeprecated;
		}
		s_RegisterLogCallbackDeprecated = handler;
		if (handler != null)
		{
			if (threaded)
			{
				logMessageReceivedThreaded += handler;
			}
			else
			{
				logMessageReceived += handler;
			}
		}
	}

	[Obsolete("Use SceneManager.LoadScene")]
	public static void LoadLevel(int index)
	{
		SceneManager.LoadScene(index, LoadSceneMode.Single);
	}

	[Obsolete("Use SceneManager.LoadScene")]
	public static void LoadLevel(string name)
	{
		SceneManager.LoadScene(name, LoadSceneMode.Single);
	}

	[Obsolete("Use SceneManager.LoadScene")]
	public static void LoadLevelAdditive(int index)
	{
		SceneManager.LoadScene(index, LoadSceneMode.Additive);
	}

	[Obsolete("Use SceneManager.LoadScene")]
	public static void LoadLevelAdditive(string name)
	{
		SceneManager.LoadScene(name, LoadSceneMode.Additive);
	}

	[Obsolete("Use SceneManager.LoadSceneAsync")]
	public static AsyncOperation LoadLevelAsync(int index)
	{
		return SceneManager.LoadSceneAsync(index, LoadSceneMode.Single);
	}

	[Obsolete("Use SceneManager.LoadSceneAsync")]
	public static AsyncOperation LoadLevelAsync(string levelName)
	{
		return SceneManager.LoadSceneAsync(levelName, LoadSceneMode.Single);
	}

	[Obsolete("Use SceneManager.LoadSceneAsync")]
	public static AsyncOperation LoadLevelAdditiveAsync(int index)
	{
		return SceneManager.LoadSceneAsync(index, LoadSceneMode.Additive);
	}

	[Obsolete("Use SceneManager.LoadSceneAsync")]
	public static AsyncOperation LoadLevelAdditiveAsync(string levelName)
	{
		return SceneManager.LoadSceneAsync(levelName, LoadSceneMode.Additive);
	}

	[Obsolete("Use SceneManager.UnloadScene")]
	public static bool UnloadLevel(int index)
	{
		return SceneManager.UnloadScene(index);
	}

	[Obsolete("Use SceneManager.UnloadScene")]
	public static bool UnloadLevel(string scenePath)
	{
		return SceneManager.UnloadScene(scenePath);
	}
}
