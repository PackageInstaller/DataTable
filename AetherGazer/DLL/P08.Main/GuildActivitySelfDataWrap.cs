using System;
using System.Collections.Generic;
using LuaInterface;

public class GuildActivitySelfDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(GuildActivitySelfData), typeof(object));
		L.RegFunction("New", _CreateGuildActivitySelfData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("mapCount", get_mapCount, set_mapCount);
		L.RegVar("benchmark_time", get_benchmark_time, set_benchmark_time);
		L.RegVar("bossIdList", get_bossIdList, set_bossIdList);
		L.RegVar("maxNodeId", get_maxNodeId, set_maxNodeId);
		L.RegVar("curNode", get_curNode, set_curNode);
		L.RegVar("coinRefreshMinutes", get_coinRefreshMinutes, set_coinRefreshMinutes);
		L.RegVar("myLastReceiveTimestamp", get_myLastReceiveTimestamp, set_myLastReceiveTimestamp);
		L.RegVar("spawnNodeIdList", get_spawnNodeIdList, set_spawnNodeIdList);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateGuildActivitySelfData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				GuildActivitySelfData o = new GuildActivitySelfData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: GuildActivitySelfData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mapCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int mapCount = ((GuildActivitySelfData)obj).mapCount;
			LuaDLL.lua_pushinteger(L, mapCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_benchmark_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int benchmark_time = ((GuildActivitySelfData)obj).benchmark_time;
			LuaDLL.lua_pushinteger(L, benchmark_time);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index benchmark_time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bossIdList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> bossIdList = ((GuildActivitySelfData)obj).bossIdList;
			ToLua.PushSealed(L, bossIdList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bossIdList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxNodeId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int maxNodeId = ((GuildActivitySelfData)obj).maxNodeId;
			LuaDLL.lua_pushinteger(L, maxNodeId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxNodeId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_curNode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int curNode = ((GuildActivitySelfData)obj).curNode;
			LuaDLL.lua_pushinteger(L, curNode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curNode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_coinRefreshMinutes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int coinRefreshMinutes = ((GuildActivitySelfData)obj).coinRefreshMinutes;
			LuaDLL.lua_pushinteger(L, coinRefreshMinutes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index coinRefreshMinutes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_myLastReceiveTimestamp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int myLastReceiveTimestamp = ((GuildActivitySelfData)obj).myLastReceiveTimestamp;
			LuaDLL.lua_pushinteger(L, myLastReceiveTimestamp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index myLastReceiveTimestamp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spawnNodeIdList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> spawnNodeIdList = ((GuildActivitySelfData)obj).spawnNodeIdList;
			ToLua.PushSealed(L, spawnNodeIdList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spawnNodeIdList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mapCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySelfData obj2 = (GuildActivitySelfData)obj;
			int mapCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.mapCount = mapCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_benchmark_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySelfData obj2 = (GuildActivitySelfData)obj;
			int benchmark_time = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.benchmark_time = benchmark_time;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index benchmark_time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bossIdList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySelfData obj2 = (GuildActivitySelfData)obj;
			List<int> bossIdList = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.bossIdList = bossIdList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bossIdList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxNodeId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySelfData obj2 = (GuildActivitySelfData)obj;
			int maxNodeId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxNodeId = maxNodeId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxNodeId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_curNode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySelfData obj2 = (GuildActivitySelfData)obj;
			int curNode = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.curNode = curNode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curNode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_coinRefreshMinutes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySelfData obj2 = (GuildActivitySelfData)obj;
			int coinRefreshMinutes = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.coinRefreshMinutes = coinRefreshMinutes;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index coinRefreshMinutes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_myLastReceiveTimestamp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySelfData obj2 = (GuildActivitySelfData)obj;
			int myLastReceiveTimestamp = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.myLastReceiveTimestamp = myLastReceiveTimestamp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index myLastReceiveTimestamp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spawnNodeIdList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySelfData obj2 = (GuildActivitySelfData)obj;
			List<int> spawnNodeIdList = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.spawnNodeIdList = spawnNodeIdList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spawnNodeIdList on a nil value");
		}
	}
}
