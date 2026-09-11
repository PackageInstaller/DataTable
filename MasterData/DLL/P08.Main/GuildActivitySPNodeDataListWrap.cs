using System;
using System.Collections.Generic;
using LuaInterface;

public class GuildActivitySPNodeDataListWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(GuildActivitySPNodeDataList), typeof(object));
		L.RegFunction("New", _CreateGuildActivitySPNodeDataList);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("selfData", get_selfData, set_selfData);
		L.RegVar("dataList", get_dataList, set_dataList);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateGuildActivitySPNodeDataList(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				GuildActivitySPNodeDataList o = new GuildActivitySPNodeDataList();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: GuildActivitySPNodeDataList.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_selfData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPSelfData selfData = ((GuildActivitySPNodeDataList)obj).selfData;
			ToLua.PushObject(L, selfData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selfData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dataList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<GuildActivitySPNodeData> dataList = ((GuildActivitySPNodeDataList)obj).dataList;
			ToLua.PushSealed(L, dataList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dataList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_selfData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeDataList obj2 = (GuildActivitySPNodeDataList)obj;
			GuildActivitySPSelfData selfData = (GuildActivitySPSelfData)ToLua.CheckObject<GuildActivitySPSelfData>(L, 2);
			obj2.selfData = selfData;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selfData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dataList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySPNodeDataList obj2 = (GuildActivitySPNodeDataList)obj;
			List<GuildActivitySPNodeData> dataList = (List<GuildActivitySPNodeData>)ToLua.CheckObject(L, 2, typeof(List<GuildActivitySPNodeData>));
			obj2.dataList = dataList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dataList on a nil value");
		}
	}
}
