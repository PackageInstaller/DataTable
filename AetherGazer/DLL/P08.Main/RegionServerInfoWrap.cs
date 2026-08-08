using System;
using System.Collections.Generic;
using LuaInterface;

public class RegionServerInfoWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RegionServerInfo), typeof(object));
		L.RegFunction("New", _CreateRegionServerInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("serverId", get_serverId, set_serverId);
		L.RegVar("serverName", get_serverName, set_serverName);
		L.RegVar("env", get_env, set_env);
		L.RegVar("ip", get_ip, set_ip);
		L.RegVar("port", get_port, set_port);
		L.RegVar("newServerFlag", get_newServerFlag, set_newServerFlag);
		L.RegVar("maintain", get_maintain, set_maintain);
		L.RegVar("maintainReason", get_maintainReason, set_maintainReason);
		L.RegVar("configS", get_configS, set_configS);
		L.RegVar("gameUserInfoList", get_gameUserInfoList, set_gameUserInfoList);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateRegionServerInfo(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				RegionServerInfo o = new RegionServerInfo();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: RegionServerInfo.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_serverId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string serverId = ((RegionServerInfo)obj).serverId;
			LuaDLL.lua_pushstring(L, serverId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index serverId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_serverName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string serverName = ((RegionServerInfo)obj).serverName;
			LuaDLL.lua_pushstring(L, serverName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index serverName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_env(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string env = ((RegionServerInfo)obj).env;
			LuaDLL.lua_pushstring(L, env);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index env on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string ip = ((RegionServerInfo)obj).ip;
			LuaDLL.lua_pushstring(L, ip);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_port(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int port = ((RegionServerInfo)obj).port;
			LuaDLL.lua_pushinteger(L, port);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index port on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_newServerFlag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int newServerFlag = ((RegionServerInfo)obj).newServerFlag;
			LuaDLL.lua_pushinteger(L, newServerFlag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index newServerFlag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maintain(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool maintain = ((RegionServerInfo)obj).maintain;
			LuaDLL.lua_pushboolean(L, maintain);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maintain on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maintainReason(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string maintainReason = ((RegionServerInfo)obj).maintainReason;
			LuaDLL.lua_pushstring(L, maintainReason);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maintainReason on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_configS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<string, string> configS = ((RegionServerInfo)obj).configS;
			ToLua.PushSealed(L, configS);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index configS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gameUserInfoList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<RegionServerUserInfo> gameUserInfoList = ((RegionServerInfo)obj).gameUserInfoList;
			ToLua.PushSealed(L, gameUserInfoList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gameUserInfoList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_serverId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RegionServerInfo obj2 = (RegionServerInfo)obj;
			string serverId = ToLua.CheckString(L, 2);
			obj2.serverId = serverId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index serverId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_serverName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RegionServerInfo obj2 = (RegionServerInfo)obj;
			string serverName = ToLua.CheckString(L, 2);
			obj2.serverName = serverName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index serverName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_env(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RegionServerInfo obj2 = (RegionServerInfo)obj;
			string env = ToLua.CheckString(L, 2);
			obj2.env = env;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index env on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ip(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RegionServerInfo obj2 = (RegionServerInfo)obj;
			string ip = ToLua.CheckString(L, 2);
			obj2.ip = ip;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ip on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_port(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RegionServerInfo obj2 = (RegionServerInfo)obj;
			int port = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.port = port;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index port on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_newServerFlag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RegionServerInfo obj2 = (RegionServerInfo)obj;
			int newServerFlag = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.newServerFlag = newServerFlag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index newServerFlag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maintain(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RegionServerInfo obj2 = (RegionServerInfo)obj;
			bool maintain = LuaDLL.luaL_checkboolean(L, 2);
			obj2.maintain = maintain;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maintain on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maintainReason(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RegionServerInfo obj2 = (RegionServerInfo)obj;
			string maintainReason = ToLua.CheckString(L, 2);
			obj2.maintainReason = maintainReason;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maintainReason on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_configS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RegionServerInfo obj2 = (RegionServerInfo)obj;
			Dictionary<string, string> configS = (Dictionary<string, string>)ToLua.CheckObject(L, 2, typeof(Dictionary<string, string>));
			obj2.configS = configS;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index configS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gameUserInfoList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RegionServerInfo obj2 = (RegionServerInfo)obj;
			List<RegionServerUserInfo> gameUserInfoList = (List<RegionServerUserInfo>)ToLua.CheckObject(L, 2, typeof(List<RegionServerUserInfo>));
			obj2.gameUserInfoList = gameUserInfoList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gameUserInfoList on a nil value");
		}
	}
}
