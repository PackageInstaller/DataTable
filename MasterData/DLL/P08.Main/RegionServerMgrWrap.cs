using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using YSGMCore;

public class RegionServerMgrWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RegionServerMgr), typeof(MonoBehaviour));
		L.RegFunction("GetRegionServerInfoList", GetRegionServerInfoList);
		L.RegFunction("GetRegionServerInfo", GetRegionServerInfo);
		L.RegFunction("UpdateRegionServerInfo", UpdateRegionServerInfo);
		L.RegFunction("ServerInfoCallback", ServerInfoCallback);
		L.RegFunction("UpdateClintConfigs", UpdateClintConfigs);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("instance", get_instance, null);
		L.EndClass();
	}

	[LuaInterface.MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRegionServerInfoList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			List<RegionServerInfo> regionServerInfoList = ((RegionServerMgr)ToLua.CheckObject<RegionServerMgr>(L, 1)).GetRegionServerInfoList();
			ToLua.PushSealed(L, regionServerInfoList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[LuaInterface.MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRegionServerInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RegionServerMgr obj = (RegionServerMgr)ToLua.CheckObject<RegionServerMgr>(L, 1);
			string serverId = ToLua.CheckString(L, 2);
			RegionServerInfo regionServerInfo = obj.GetRegionServerInfo(serverId);
			ToLua.PushObject(L, regionServerInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[LuaInterface.MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateRegionServerInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RegionServerMgr obj = (RegionServerMgr)ToLua.CheckObject<RegionServerMgr>(L, 1);
			string token = ToLua.CheckString(L, 2);
			Action<bool, string> callback = (Action<bool, string>)ToLua.CheckDelegate<Action<bool, string>>(L, 3);
			obj.UpdateRegionServerInfo(token, callback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[LuaInterface.MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ServerInfoCallback(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			RegionServerMgr obj = (RegionServerMgr)ToLua.CheckObject<RegionServerMgr>(L, 1);
			int errorCode = (int)LuaDLL.luaL_checknumber(L, 2);
			string errorMsg = ToLua.CheckString(L, 3);
			List<GateWayInfo> infoList = (List<GateWayInfo>)ToLua.CheckObject(L, 4, typeof(List<GateWayInfo>));
			obj.ServerInfoCallback(errorCode, errorMsg, infoList);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[LuaInterface.MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateClintConfigs(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RegionServerMgr obj = (RegionServerMgr)ToLua.CheckObject<RegionServerMgr>(L, 1);
			string serverId = ToLua.CheckString(L, 2);
			obj.UpdateClintConfigs(serverId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[LuaInterface.MonoPInvokeCallback(typeof(LuaCSFunction))]
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

	[LuaInterface.MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, RegionServerMgr.instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
