using System;
using System.Collections.Generic;
using LuaInterface;

public class VoicePackageManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(VoicePackageManager), typeof(object));
		L.RegFunction("Init", Init);
		L.RegFunction("GetMainDownloadUrl", GetMainDownloadUrl);
		L.RegFunction("InitVoicePackageInfo", InitVoicePackageInfo);
		L.RegFunction("GetVoicePackageVersion", GetVoicePackageVersion);
		L.RegFunction("InitInPackageVoiceInfo", InitInPackageVoiceInfo);
		L.RegFunction("GetPackageSize", GetPackageSize);
		L.RegFunction("UpdateDownloadedList", UpdateDownloadedList);
		L.RegFunction("GetDownLoadPackage", GetDownLoadPackage);
		L.RegFunction("GetValidPackage", GetValidPackage);
		L.RegFunction("IsHavePackage", IsHavePackage);
		L.RegFunction("StartDownLoadPackage", StartDownLoadPackage);
		L.RegFunction("InsertDownloadedPackage", InsertDownloadedPackage);
		L.RegFunction("DeleteDownLoadPackage", DeleteDownLoadPackage);
		L.RegFunction("DownloadPackage", DownloadPackage);
		L.RegFunction("UpdateDownloading", UpdateDownloading);
		L.RegFunction("GetDownloadInfo", GetDownloadInfo);
		L.RegFunction("IsDownloading", IsDownloading);
		L.RegFunction("IsSucceed", IsSucceed);
		L.RegFunction("IsFailed", IsFailed);
		L.RegFunction("IsCanceling", IsCanceling);
		L.RegFunction("IsCanceled", IsCanceled);
		L.RegFunction("DownloadCancel", DownloadCancel);
		L.RegFunction("DownloadShutdown", DownloadShutdown);
		L.RegFunction("New", _CreateVoicePackageManager);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("downloadUrl", get_downloadUrl, null);
		L.RegVar("appVersion", get_appVersion, null);
		L.RegVar("resVersion", get_resVersion, null);
		L.RegVar("retryDownloadUrl", get_retryDownloadUrl, null);
		L.RegVar("Instance", get_Instance, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateVoicePackageManager(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				VoicePackageManager o = new VoicePackageManager();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: VoicePackageManager.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Init(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			VoicePackageManager obj = (VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1);
			string pDownloadUrl = ToLua.CheckString(L, 2);
			string pAppVersion = ToLua.CheckString(L, 3);
			string pResVersion = ToLua.CheckString(L, 4);
			string pDefAbbr = ToLua.CheckString(L, 5);
			obj.Init(pDownloadUrl, pAppVersion, pResVersion, pDefAbbr);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMainDownloadUrl(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string mainDownloadUrl = ((VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1)).GetMainDownloadUrl();
			LuaDLL.lua_pushstring(L, mainDownloadUrl);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitVoicePackageInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VoicePackageManager obj = (VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1);
			VoicePackageList pVoicePackageList = (VoicePackageList)ToLua.CheckObject<VoicePackageList>(L, 2);
			obj.InitVoicePackageInfo(pVoicePackageList);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetVoicePackageVersion(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VoicePackageManager obj = (VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1);
			string abbr = ToLua.CheckString(L, 2);
			int voicePackageVersion = obj.GetVoicePackageVersion(abbr);
			LuaDLL.lua_pushinteger(L, voicePackageVersion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitInPackageVoiceInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VoicePackageManager obj = (VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1);
			VoicePackageList pVoicePackageList = (VoicePackageList)ToLua.CheckObject<VoicePackageList>(L, 2);
			obj.InitInPackageVoiceInfo(pVoicePackageList);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPackageSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VoicePackageManager obj = (VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1);
			string abbr = ToLua.CheckString(L, 2);
			float packageSize = obj.GetPackageSize(abbr);
			LuaDLL.lua_pushnumber(L, packageSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateDownloadedList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1)).UpdateDownloadedList();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDownLoadPackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			List<string> downLoadPackage = ((VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1)).GetDownLoadPackage();
			ToLua.PushSealed(L, downLoadPackage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetValidPackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string validPackage = ((VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1)).GetValidPackage();
			LuaDLL.lua_pushstring(L, validPackage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsHavePackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VoicePackageManager obj = (VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1);
			string flag = ToLua.CheckString(L, 2);
			bool value = obj.IsHavePackage(flag);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartDownLoadPackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VoicePackageManager obj = (VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1);
			string flag = ToLua.CheckString(L, 2);
			obj.StartDownLoadPackage(flag);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InsertDownloadedPackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VoicePackageManager obj = (VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1);
			string flag = ToLua.CheckString(L, 2);
			obj.InsertDownloadedPackage(flag);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeleteDownLoadPackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VoicePackageManager obj = (VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1);
			string flag = ToLua.CheckString(L, 2);
			obj.DeleteDownLoadPackage(flag);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DownloadPackage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VoicePackageManager obj = (VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1);
			string abbr = ToLua.CheckString(L, 2);
			obj.DownloadPackage(abbr);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateDownloading(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int n = ((VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1)).UpdateDownloading();
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDownloadInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VoicePackageManager obj = (VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1);
			int step = (int)LuaDLL.luaL_checknumber(L, 2);
			string downloadInfo = obj.GetDownloadInfo(step);
			LuaDLL.lua_pushstring(L, downloadInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsDownloading(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VoicePackageManager obj = (VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1);
			int step = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.IsDownloading(step);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsSucceed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VoicePackageManager obj = (VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1);
			int step = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.IsSucceed(step);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsFailed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VoicePackageManager obj = (VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1);
			int step = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.IsFailed(step);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsCanceling(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VoicePackageManager obj = (VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1);
			int step = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.IsCanceling(step);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsCanceled(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			VoicePackageManager obj = (VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1);
			int step = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.IsCanceled(step);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DownloadCancel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1)).DownloadCancel();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DownloadShutdown(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((VoicePackageManager)ToLua.CheckObject<VoicePackageManager>(L, 1)).DownloadShutdown();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_downloadUrl(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string downloadUrl = ((VoicePackageManager)obj).downloadUrl;
			LuaDLL.lua_pushstring(L, downloadUrl);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index downloadUrl on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_appVersion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string appVersion = ((VoicePackageManager)obj).appVersion;
			LuaDLL.lua_pushstring(L, appVersion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index appVersion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_resVersion(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string resVersion = ((VoicePackageManager)obj).resVersion;
			LuaDLL.lua_pushstring(L, resVersion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resVersion on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_retryDownloadUrl(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string[] retryDownloadUrl = ((VoicePackageManager)obj).retryDownloadUrl;
			ToLua.Push(L, retryDownloadUrl);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index retryDownloadUrl on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, VoicePackageManager.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
