using System;
using LuaInterface;
using UnityEngine;

public class AssetDownloadManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AssetDownloadManager), typeof(MonoBehaviour));
		L.RegFunction("Create", Create);
		L.RegFunction("Destroy", Destroy);
		L.RegFunction("InitRootUrl", InitRootUrl);
		L.RegFunction("StopAll", StopAll);
		L.RegFunction("CheckResourcesNeedDownload", CheckResourcesNeedDownload);
		L.RegFunction("CheckVoiceNeedDownload", CheckVoiceNeedDownload);
		L.RegFunction("AddResourceToDownloadQueue", AddResourceToDownloadQueue);
		L.RegFunction("AddVoiceToDownloadQueue", AddVoiceToDownloadQueue);
		L.RegFunction("Run", Run);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("configLoaded", get_configLoaded, set_configLoaded);
		L.RegVar("Instance", get_Instance, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Create(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			AssetDownloadManager.Create();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Destroy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			AssetDownloadManager.Destroy();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitRootUrl(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AssetDownloadManager)ToLua.CheckObject<AssetDownloadManager>(L, 1)).InitRootUrl();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopAll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AssetDownloadManager)ToLua.CheckObject<AssetDownloadManager>(L, 1)).StopAll();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckResourcesNeedDownload(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = AssetDownloadManager.CheckResourcesNeedDownload(ToLua.CheckStringArray(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckVoiceNeedDownload(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = AssetDownloadManager.CheckVoiceNeedDownload(ToLua.CheckStringArray(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddResourceToDownloadQueue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetDownloadManager obj = (AssetDownloadManager)ToLua.CheckObject<AssetDownloadManager>(L, 1);
			string[] paths = ToLua.CheckStringArray(L, 2);
			obj.AddResourceToDownloadQueue(paths);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddVoiceToDownloadQueue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			AssetDownloadManager obj = (AssetDownloadManager)ToLua.CheckObject<AssetDownloadManager>(L, 1);
			string[] paths = ToLua.CheckStringArray(L, 2);
			obj.AddVoiceToDownloadQueue(paths);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Run(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			AssetDownloadManager obj = (AssetDownloadManager)ToLua.CheckObject<AssetDownloadManager>(L, 1);
			Action<float> onProgressUpdate = (Action<float>)ToLua.CheckDelegate<Action<float>>(L, 2);
			Action onSuccessed = (Action)ToLua.CheckDelegate<Action>(L, 3);
			Action onFailed = (Action)ToLua.CheckDelegate<Action>(L, 4);
			obj.Run(onProgressUpdate, onSuccessed, onFailed);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_configLoaded(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool configLoaded = ((AssetDownloadManager)obj).configLoaded;
			LuaDLL.lua_pushboolean(L, configLoaded);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index configLoaded on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, AssetDownloadManager.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_configLoaded(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			AssetDownloadManager obj2 = (AssetDownloadManager)obj;
			bool configLoaded = LuaDLL.luaL_checkboolean(L, 2);
			obj2.configLoaded = configLoaded;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index configLoaded on a nil value");
		}
	}
}
