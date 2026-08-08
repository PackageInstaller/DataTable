using System;
using LuaInterface;

public class RegionServerUserInfoWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RegionServerUserInfo), typeof(object));
		L.RegFunction("New", _CreateRegionServerUserInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("uid", get_uid, set_uid);
		L.RegVar("currentLevel", get_currentLevel, set_currentLevel);
		L.RegVar("nickName", get_nickName, set_nickName);
		L.RegVar("lastLoginTime", get_lastLoginTime, set_lastLoginTime);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateRegionServerUserInfo(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				RegionServerUserInfo o = new RegionServerUserInfo();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: RegionServerUserInfo.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string uid = ((RegionServerUserInfo)obj).uid;
			LuaDLL.lua_pushstring(L, uid);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uid on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_currentLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int currentLevel = ((RegionServerUserInfo)obj).currentLevel;
			LuaDLL.lua_pushinteger(L, currentLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nickName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string nickName = ((RegionServerUserInfo)obj).nickName;
			LuaDLL.lua_pushstring(L, nickName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nickName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastLoginTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string lastLoginTime = ((RegionServerUserInfo)obj).lastLoginTime;
			LuaDLL.lua_pushstring(L, lastLoginTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastLoginTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RegionServerUserInfo obj2 = (RegionServerUserInfo)obj;
			string uid = ToLua.CheckString(L, 2);
			obj2.uid = uid;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uid on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_currentLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RegionServerUserInfo obj2 = (RegionServerUserInfo)obj;
			int currentLevel = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.currentLevel = currentLevel;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nickName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RegionServerUserInfo obj2 = (RegionServerUserInfo)obj;
			string nickName = ToLua.CheckString(L, 2);
			obj2.nickName = nickName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nickName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastLoginTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RegionServerUserInfo obj2 = (RegionServerUserInfo)obj;
			string lastLoginTime = ToLua.CheckString(L, 2);
			obj2.lastLoginTime = lastLoginTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastLoginTime on a nil value");
		}
	}
}
