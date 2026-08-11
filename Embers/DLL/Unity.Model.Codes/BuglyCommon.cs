using System;
using System.Collections.Generic;
using UnityEngine;

public class BuglyCommon
{
	private static int _crashReporterType = 1;

	private static bool _debugMode = false;

	private static Func<Dictionary<string, string>> _LogCallbackExtrasHandler;

	private static int _crashReproterLogLevel = 0;

	private static string[] _pluginArray = new string[0];

	private static bool _isInit = false;

	private const string GAME_AGENT_CLASS = "com.tencent.bugly.agent.GameAgentPro";

	private const int TYPE_U_3D_CRASH = 4;

	private const int GAME_TYPE_UNITY = 2;

	private static bool _hasSetGameType = false;

	private static AndroidJavaClass _gameAgentClass = null;

	private static string _appVersion = "";

	private static string _buildNum = "";

	private static string _uniqueId = "";

	private static string _userId = "";

	private static string _deviceModel = "";

	private static string _appVersionType = "Unknown";

	private static string _appChannel = "";

	private static int _logLevel = 0;

	public static int BuglyCrashReporterLogLevel
	{
		get
		{
			return _crashReproterLogLevel;
		}
		set
		{
			_crashReproterLogLevel = value;
		}
	}

	public static string[] BuglyPluginArray
	{
		get
		{
			return _pluginArray;
		}
		set
		{
			_pluginArray = value;
		}
	}

	public static bool BuglyDebugMode
	{
		get
		{
			return _debugMode;
		}
		set
		{
			_debugMode = value;
		}
	}

	public static Func<Dictionary<string, string>> BuglyLogCallbackExtrasHandler
	{
		get
		{
			return _LogCallbackExtrasHandler;
		}
		set
		{
			_LogCallbackExtrasHandler = value;
		}
	}

	private static AndroidJavaClass gameAgent
	{
		get
		{
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0016: Expected O, but got Unknown
			if (_gameAgentClass == null)
			{
				_gameAgentClass = new AndroidJavaClass("com.tencent.bugly.agent.GameAgentPro");
			}
			if (_hasSetGameType)
			{
				return _gameAgentClass;
			}
			((AndroidJavaObject)_gameAgentClass).CallStatic("setGameType", new object[1] { 2 });
			_hasSetGameType = true;
			return _gameAgentClass;
		}
	}

	public static void InitBuglyAgent(string appId, string appKey)
	{
		InitBuglySDK(appId, appKey);
	}

	public static void SetBuglyUserId(string userId)
	{
		SetUserId(userId);
	}

	public static void SetBuglyDeviceId(string deviceId)
	{
		SetDeviceId(deviceId);
	}

	public static void SetBuglyAdditionalAttachmentPaths(string[] pathArray)
	{
		SetAdditionalAttachmentPaths(pathArray);
	}

	public static void SetBuglyCrashHandlerListener(BuglyCallback.ListenerAdapter listener)
	{
		SetCrashHandlerListener(listener);
	}

	public static void AddBuglyKeyAndValueInScene(string key, string value)
	{
		AddKeyAndValueInScene(key, value);
	}

	public static void ConfigBuglyDefaultBeforeInit(string channel, string version, string buildNum, string user, string model)
	{
		ConfigDefaultBeforeInit(channel, version, buildNum, user, model);
	}

	public static void LogBuglyRecord(LogSeverity level, string format, params object[] args)
	{
		LogRecord(level, string.Format(format, args));
	}

	public static void SetSDKUnityVersion()
	{
		SetUnityVersion();
	}

	public static void ReportBuglyException(int type, string name, string reason, string stackTrace, bool quitProgram)
	{
		ReportException(type, name, reason, stackTrace, quitProgram);
	}

	public static void SetBuglyReporterType(int type)
	{
		_crashReporterType = type;
	}

	public static void BuglySetLogLevel(int logLevel)
	{
		SetLogLevel(logLevel);
	}

	public static void BuglyStartInspectLeakObj(AndroidJavaObject javaObject)
	{
		StartInspectLeakObj(javaObject);
	}

	public static void BuglyLaunchAddTag(string tag)
	{
		LaunchAddTag(tag);
	}

	public static void BuglyLaunchSpanStart(string spanName, string parentSpanName)
	{
		LaunchSpanStart(spanName, parentSpanName);
	}

	public static void BuglyLaunchSpanEnd(string spanName)
	{
		LaunchSpanEnd(spanName);
	}

	public static void BuglyReportAppFullLaunch()
	{
		ReportAppFullLaunch();
	}

	private static void InitBuglySDK(string appId, string appKey)
	{
		try
		{
			if (_isInit)
			{
				Debug.Log("Bugly has init, return.");
				return;
			}
			((AndroidJavaObject)gameAgent).CallStatic("initAgent", new object[12]
			{
				appId, appKey, _appVersion, _buildNum, _uniqueId, _userId, _deviceModel, _appVersionType, _appChannel, BuglyDebugMode,
				_logLevel, BuglyPluginArray
			});
			_isInit = true;
			Debug.Log("Bugly init success");
		}
		catch (Exception ex)
		{
			Debug.Log("Bugly init failed");
			Debug.Log(ex.ToString());
		}
	}

	private static void SetUserId(string userId)
	{
		try
		{
			_userId = userId;
			if (_isInit)
			{
				((AndroidJavaObject)gameAgent).CallStatic("updateUserIdAgent", new object[1] { userId });
			}
		}
		catch (Exception ex)
		{
			Console.WriteLine("Exception: " + ex.Message);
		}
	}

	private static void SetDeviceId(string deviceId)
	{
		try
		{
			_uniqueId = deviceId;
			if (_isInit)
			{
				((AndroidJavaObject)gameAgent).CallStatic("updateUniqueIdAgent", new object[1] { deviceId });
			}
		}
		catch (Exception ex)
		{
			Console.WriteLine("Exception: " + ex.Message);
		}
	}

	private static void SetAdditionalAttachmentPaths(string[] pathArray)
	{
		try
		{
			((AndroidJavaObject)gameAgent).CallStatic<string>("setAdditionalAttachmentPathsAgent", pathArray);
		}
		catch (Exception ex)
		{
			Console.WriteLine("Exception: " + ex.Message);
		}
	}

	private static void SetCrashHandlerListener(BuglyCallback.ListenerAdapter listener)
	{
		try
		{
			((AndroidJavaObject)gameAgent).CallStatic("setCrashHandlerListenerAgent", new object[1] { listener });
		}
		catch (Exception ex)
		{
			Console.WriteLine("Exception: " + ex.Message);
		}
	}

	private static void AddKeyAndValueInScene(string key, string value)
	{
		try
		{
			((AndroidJavaObject)gameAgent).CallStatic("putUserDataAgent", new object[2] { key, value });
		}
		catch (Exception ex)
		{
			Console.WriteLine("Exception: " + ex.Message);
		}
	}

	private static void ConfigDefaultBeforeInit(string channel, string version, string buildNum, string user, string model)
	{
		_appChannel = channel;
		_appVersion = version;
		_buildNum = buildNum;
		_userId = user;
		_deviceModel = model;
	}

	private static void LogRecord(LogSeverity level, string message)
	{
	}

	private static void SetUnityVersion()
	{
	}

	private static void ReportException(int type, string errorName, string errorMsg, string stackTrace, bool quitProgram)
	{
		try
		{
			((AndroidJavaObject)gameAgent).CallStatic("postExceptionAgent", new object[5] { 4, errorName, errorMsg, stackTrace, quitProgram });
		}
		catch (Exception ex)
		{
			Console.WriteLine("Exception: " + ex.Message);
		}
	}

	private static void SetLogLevel(int logLevel)
	{
		try
		{
			((AndroidJavaObject)gameAgent).CallStatic("updateLogLevelAgent", new object[1] { logLevel });
		}
		catch (Exception ex)
		{
			Console.WriteLine("Exception: " + ex.Message);
		}
	}

	private static void StartInspectLeakObj(AndroidJavaObject javaObject)
	{
		try
		{
			((AndroidJavaObject)gameAgent).CallStatic("startInspectLeakObjAgent", new object[1] { javaObject });
		}
		catch (Exception ex)
		{
			Console.WriteLine("Exception: " + ex.Message);
		}
	}

	private static void LaunchAddTag(string tag)
	{
		try
		{
			((AndroidJavaObject)gameAgent).CallStatic("launchAddTagAgent", new object[1] { tag });
		}
		catch (Exception ex)
		{
			Console.WriteLine("Exception: " + ex.Message);
		}
	}

	private static void LaunchSpanStart(string spanName, string parentSpanName)
	{
		try
		{
			((AndroidJavaObject)gameAgent).CallStatic("launchSpanStartAgent", new object[2] { spanName, parentSpanName });
		}
		catch (Exception ex)
		{
			Console.WriteLine("Exception: " + ex.Message);
		}
	}

	private static void LaunchSpanEnd(string spanName)
	{
		try
		{
			((AndroidJavaObject)gameAgent).CallStatic("launchSpanEndAgent", new object[1] { spanName });
		}
		catch (Exception ex)
		{
			Console.WriteLine("Exception: " + ex.Message);
		}
	}

	private static void ReportAppFullLaunch()
	{
		try
		{
			((AndroidJavaObject)gameAgent).CallStatic("reportAppFullLaunchAgent", Array.Empty<object>());
		}
		catch (Exception ex)
		{
			Console.WriteLine("Exception: " + ex.Message);
		}
	}
}
