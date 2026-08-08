using System;
using LuaInterface;

public class LuaForSplashWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LuaForSplash), typeof(object));
		L.RegFunction("OnLoginSuccess", OnLoginSuccess);
		L.RegFunction("UpdateVersionInfo", UpdateVersionInfo);
		L.RegFunction("GetIsMaintainByGMSDK", GetIsMaintainByGMSDK);
		L.RegFunction("GetVersionName", GetVersionName);
		L.RegFunction("GetClientVersion", GetClientVersion);
		L.RegFunction("GetResourceVersion", GetResourceVersion);
		L.RegFunction("GetResourceVersionName", GetResourceVersionName);
		L.RegFunction("GetFreeDiskSpace", GetFreeDiskSpace);
		L.RegFunction("New", _CreateLuaForSplash);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("interAssetHashs", get_interAssetHashs, set_interAssetHashs);
		L.RegVar("outerAssetHashs", get_outerAssetHashs, set_outerAssetHashs);
		L.RegVar("clientVersion", get_clientVersion, set_clientVersion);
		L.RegVar("resourceVersion", get_resourceVersion, set_resourceVersion);
		L.RegVar("versionName", get_versionName, set_versionName);
		L.RegVar("gateWayUrl", get_gateWayUrl, set_gateWayUrl);
		L.RegVar("OnLogin", get_OnLogin, set_OnLogin);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateLuaForSplash(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				LuaForSplash o = new LuaForSplash();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: LuaForSplash.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnLoginSuccess(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int channelId2 = (int)LuaDLL.luaL_checknumber(L, 1);
				string platformAccount2 = ToLua.CheckString(L, 2);
				string roleId2 = ToLua.CheckString(L, 3);
				LuaForSplash.OnLoginSuccess(channelId2, platformAccount2, roleId2);
				return 0;
			}
			case 4:
			{
				int channelId = (int)LuaDLL.luaL_checknumber(L, 1);
				string platformAccount = ToLua.CheckString(L, 2);
				string roleId = ToLua.CheckString(L, 3);
				int worldId = (int)LuaDLL.luaL_checknumber(L, 4);
				LuaForSplash.OnLoginSuccess(channelId, platformAccount, roleId, worldId);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaForSplash.OnLoginSuccess");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateVersionInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaForSplash.UpdateVersionInfo();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIsMaintainByGMSDK(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaForSplash.GetIsMaintainByGMSDK((Action<bool, string>)ToLua.CheckDelegate<Action<bool, string>>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetVersionName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string versionName = LuaForSplash.GetVersionName();
			LuaDLL.lua_pushstring(L, versionName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetClientVersion(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int clientVersion = LuaForSplash.GetClientVersion();
			LuaDLL.lua_pushinteger(L, clientVersion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetResourceVersion(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int resourceVersion = LuaForSplash.GetResourceVersion();
			LuaDLL.lua_pushinteger(L, resourceVersion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetResourceVersionName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string resourceVersionName = LuaForSplash.GetResourceVersionName();
			LuaDLL.lua_pushstring(L, resourceVersionName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFreeDiskSpace(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int freeDiskSpace = LuaForSplash.GetFreeDiskSpace();
			LuaDLL.lua_pushinteger(L, freeDiskSpace);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_interAssetHashs(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, LuaForSplash.interAssetHashs);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_outerAssetHashs(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, LuaForSplash.outerAssetHashs);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clientVersion(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, LuaForSplash.clientVersion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_resourceVersion(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, LuaForSplash.resourceVersion);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_versionName(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaForSplash.versionName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gateWayUrl(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaForSplash.gateWayUrl);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnLogin(IntPtr L)
	{
		try
		{
			ToLua.Push(L, LuaForSplash.OnLogin);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_interAssetHashs(IntPtr L)
	{
		try
		{
			LuaForSplash.interAssetHashs = (AssetHashList)ToLua.CheckObject<AssetHashList>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_outerAssetHashs(IntPtr L)
	{
		try
		{
			LuaForSplash.outerAssetHashs = (AssetHashList)ToLua.CheckObject<AssetHashList>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_clientVersion(IntPtr L)
	{
		try
		{
			LuaForSplash.clientVersion = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_resourceVersion(IntPtr L)
	{
		try
		{
			LuaForSplash.resourceVersion = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_versionName(IntPtr L)
	{
		try
		{
			LuaForSplash.versionName = ToLua.CheckString(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gateWayUrl(IntPtr L)
	{
		try
		{
			LuaForSplash.gateWayUrl = ToLua.CheckString(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnLogin(IntPtr L)
	{
		try
		{
			LuaForSplash.OnLogin = (Action<int, string, string, int>)ToLua.CheckDelegate<Action<int, string, string, int>>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
