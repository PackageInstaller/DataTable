using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Events;

public class UnityEngine_ApplicationWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("Application");
		L.RegFunction("Quit", Quit);
		L.RegFunction("Unload", Unload);
		L.RegFunction("CanStreamedLevelBeLoaded", CanStreamedLevelBeLoaded);
		L.RegFunction("IsPlaying", IsPlaying);
		L.RegFunction("GetBuildTags", GetBuildTags);
		L.RegFunction("SetBuildTags", SetBuildTags);
		L.RegFunction("HasProLicense", HasProLicense);
		L.RegFunction("RequestAdvertisingIdentifierAsync", RequestAdvertisingIdentifierAsync);
		L.RegFunction("OpenURL", OpenURL);
		L.RegFunction("GetStackTraceLogType", GetStackTraceLogType);
		L.RegFunction("SetStackTraceLogType", SetStackTraceLogType);
		L.RegFunction("RequestUserAuthorization", RequestUserAuthorization);
		L.RegFunction("HasUserAuthorization", HasUserAuthorization);
		L.RegVar("isPlaying", get_isPlaying, null);
		L.RegVar("isFocused", get_isFocused, null);
		L.RegVar("platform", get_platform, null);
		L.RegVar("buildGUID", get_buildGUID, null);
		L.RegVar("isMobilePlatform", get_isMobilePlatform, null);
		L.RegVar("isConsolePlatform", get_isConsolePlatform, null);
		L.RegVar("runInBackground", get_runInBackground, set_runInBackground);
		L.RegVar("isBatchMode", get_isBatchMode, null);
		L.RegVar("dataPath", get_dataPath, null);
		L.RegVar("streamingAssetsPath", get_streamingAssetsPath, null);
		L.RegVar("persistentDataPath", get_persistentDataPath, null);
		L.RegVar("temporaryCachePath", get_temporaryCachePath, null);
		L.RegVar("absoluteURL", get_absoluteURL, null);
		L.RegVar("unityVersion", get_unityVersion, null);
		L.RegVar("version", get_version, null);
		L.RegVar("installerName", get_installerName, null);
		L.RegVar("identifier", get_identifier, null);
		L.RegVar("installMode", get_installMode, null);
		L.RegVar("sandboxType", get_sandboxType, null);
		L.RegVar("productName", get_productName, null);
		L.RegVar("companyName", get_companyName, null);
		L.RegVar("cloudProjectId", get_cloudProjectId, null);
		L.RegVar("targetFrameRate", get_targetFrameRate, set_targetFrameRate);
		L.RegVar("systemLanguage", get_systemLanguage, null);
		L.RegVar("consoleLogPath", get_consoleLogPath, null);
		L.RegVar("backgroundLoadingPriority", get_backgroundLoadingPriority, set_backgroundLoadingPriority);
		L.RegVar("internetReachability", get_internetReachability, null);
		L.RegVar("genuine", get_genuine, null);
		L.RegVar("genuineCheckAvailable", get_genuineCheckAvailable, null);
		L.RegVar("isEditor", get_isEditor, null);
		L.RegVar("lowMemory", get_lowMemory, set_lowMemory);
		L.RegVar("logMessageReceived", get_logMessageReceived, set_logMessageReceived);
		L.RegVar("logMessageReceivedThreaded", get_logMessageReceivedThreaded, set_logMessageReceivedThreaded);
		L.RegVar("onBeforeRender", get_onBeforeRender, set_onBeforeRender);
		L.RegVar("wantsToQuit", get_wantsToQuit, set_wantsToQuit);
		L.RegVar("quitting", get_quitting, set_quitting);
		L.RegFunction("AdvertisingIdentifierCallback", UnityEngine_Application_AdvertisingIdentifierCallback);
		L.RegFunction("LogCallback", UnityEngine_Application_LogCallback);
		L.RegFunction("LowMemoryCallback", UnityEngine_Application_LowMemoryCallback);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Quit(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
				Application.Quit();
				return 0;
			case 1:
				Application.Quit((int)LuaDLL.luaL_checknumber(L, 1));
				return 0;
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Application.Quit");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Unload(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Application.Unload();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CanStreamedLevelBeLoaded(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				bool value = Application.CanStreamedLevelBeLoaded(ToLua.ToString(L, 1));
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				bool value2 = Application.CanStreamedLevelBeLoaded((int)LuaDLL.lua_tonumber(L, 1));
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Application.CanStreamedLevelBeLoaded");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsPlaying(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = Application.IsPlaying((UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBuildTags(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string[] buildTags = Application.GetBuildTags();
			ToLua.Push(L, buildTags);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBuildTags(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Application.SetBuildTags(ToLua.CheckStringArray(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasProLicense(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = Application.HasProLicense();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestAdvertisingIdentifierAsync(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = Application.RequestAdvertisingIdentifierAsync((Application.AdvertisingIdentifierCallback)ToLua.CheckDelegate<Application.AdvertisingIdentifierCallback>(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OpenURL(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Application.OpenURL(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetStackTraceLogType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			StackTraceLogType stackTraceLogType = Application.GetStackTraceLogType((LogType)ToLua.CheckObject(L, 1, typeof(LogType)));
			ToLua.Push(L, stackTraceLogType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetStackTraceLogType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LogType logType = (LogType)ToLua.CheckObject(L, 1, typeof(LogType));
			StackTraceLogType stackTraceType = (StackTraceLogType)ToLua.CheckObject(L, 2, typeof(StackTraceLogType));
			Application.SetStackTraceLogType(logType, stackTraceType);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestUserAuthorization(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			AsyncOperation o = Application.RequestUserAuthorization((UserAuthorization)ToLua.CheckObject(L, 1, typeof(UserAuthorization)));
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasUserAuthorization(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = Application.HasUserAuthorization((UserAuthorization)ToLua.CheckObject(L, 1, typeof(UserAuthorization)));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isPlaying(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Application.isPlaying);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isFocused(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Application.isFocused);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_platform(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Application.platform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_buildGUID(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Application.buildGUID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isMobilePlatform(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Application.isMobilePlatform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isConsolePlatform(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Application.isConsolePlatform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_runInBackground(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Application.runInBackground);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isBatchMode(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Application.isBatchMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dataPath(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Application.dataPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_streamingAssetsPath(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Application.streamingAssetsPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_persistentDataPath(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Application.persistentDataPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_temporaryCachePath(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Application.temporaryCachePath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_absoluteURL(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Application.absoluteURL);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_unityVersion(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Application.unityVersion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_version(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Application.version);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_installerName(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Application.installerName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_identifier(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Application.identifier);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_installMode(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Application.installMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sandboxType(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Application.sandboxType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_productName(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Application.productName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_companyName(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Application.companyName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cloudProjectId(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Application.cloudProjectId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetFrameRate(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, Application.targetFrameRate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_systemLanguage(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Application.systemLanguage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_consoleLogPath(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, Application.consoleLogPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_backgroundLoadingPriority(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Application.backgroundLoadingPriority);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_internetReachability(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Application.internetReachability);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_genuine(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Application.genuine);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_genuineCheckAvailable(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Application.genuineCheckAvailable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isEditor(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Application.isEditor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lowMemory(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(Application.LowMemoryCallback)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_logMessageReceived(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(Application.LogCallback)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_logMessageReceivedThreaded(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(Application.LogCallback)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onBeforeRender(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(UnityAction)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wantsToQuit(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(Func<bool>)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_quitting(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(Action)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_runInBackground(IntPtr L)
	{
		try
		{
			Application.runInBackground = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_targetFrameRate(IntPtr L)
	{
		try
		{
			Application.targetFrameRate = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_backgroundLoadingPriority(IntPtr L)
	{
		try
		{
			Application.backgroundLoadingPriority = (ThreadPriority)ToLua.CheckObject(L, 2, typeof(ThreadPriority));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lowMemory(IntPtr L)
	{
		try
		{
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					Application.lowMemory += (Application.LowMemoryCallback)eventObject.func;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					Application.lowMemory -= (Application.LowMemoryCallback)eventObject.func;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Application.lowMemory' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Application'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_logMessageReceived(IntPtr L)
	{
		try
		{
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					Application.logMessageReceived += (Application.LogCallback)eventObject.func;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					Application.logMessageReceived -= (Application.LogCallback)eventObject.func;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Application.logMessageReceived' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Application'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_logMessageReceivedThreaded(IntPtr L)
	{
		try
		{
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					Application.logMessageReceivedThreaded += (Application.LogCallback)eventObject.func;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					Application.logMessageReceivedThreaded -= (Application.LogCallback)eventObject.func;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Application.logMessageReceivedThreaded' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Application'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onBeforeRender(IntPtr L)
	{
		try
		{
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					Application.onBeforeRender += (UnityAction)eventObject.func;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					Application.onBeforeRender -= (UnityAction)eventObject.func;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Application.onBeforeRender' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Application'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wantsToQuit(IntPtr L)
	{
		try
		{
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					Application.wantsToQuit += (Func<bool>)eventObject.func;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					Application.wantsToQuit -= (Func<bool>)eventObject.func;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Application.wantsToQuit' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Application'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_quitting(IntPtr L)
	{
		try
		{
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					Application.quitting += (Action)eventObject.func;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					Application.quitting -= (Action)eventObject.func;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.Application.quitting' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.Application'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Application_AdvertisingIdentifierCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Application.AdvertisingIdentifierCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Application.AdvertisingIdentifierCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Application_LogCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Application.LogCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Application.LogCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Application_LowMemoryCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Application.LowMemoryCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Application.LowMemoryCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
