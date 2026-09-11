using System;
using LuaInterface;
using UnityEngine;

public class ChessBoardDataForExchangeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ChessBoardDataForExchange), typeof(object));
		L.RegFunction("New", _CreateChessBoardDataForExchange);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("mapId", get_mapId, set_mapId);
		L.RegVar("MapConfig", get_MapConfig, set_MapConfig);
		L.RegVar("mapInfoS", get_mapInfoS, set_mapInfoS);
		L.RegVar("thingInfoS", get_thingInfoS, set_thingInfoS);
		L.RegVar("banDirInfoS", get_banDirInfoS, set_banDirInfoS);
		L.RegVar("NPCInfos", get_NPCInfos, set_NPCInfos);
		L.RegVar("bronPos", get_bronPos, set_bronPos);
		L.RegVar("direction", get_direction, set_direction);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateChessBoardDataForExchange(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ChessBoardDataForExchange o = new ChessBoardDataForExchange();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ChessBoardDataForExchange.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mapId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int mapId = ((ChessBoardDataForExchange)obj).mapId;
			LuaDLL.lua_pushinteger(L, mapId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MapConfig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MapConfig mapConfig = ((ChessBoardDataForExchange)obj).MapConfig;
			ToLua.PushObject(L, mapConfig);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MapConfig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mapInfoS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardGirdChangeData[] mapInfoS = ((ChessBoardDataForExchange)obj).mapInfoS;
			ToLua.Push(L, mapInfoS);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapInfoS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_thingInfoS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardThingChangeData[] thingInfoS = ((ChessBoardDataForExchange)obj).thingInfoS;
			ToLua.Push(L, thingInfoS);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingInfoS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_banDirInfoS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardBanDirChangeData[] banDirInfoS = ((ChessBoardDataForExchange)obj).banDirInfoS;
			ToLua.Push(L, banDirInfoS);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index banDirInfoS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_NPCInfos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardNPCData[] nPCInfos = ((ChessBoardDataForExchange)obj).NPCInfos;
			ToLua.Push(L, nPCInfos);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index NPCInfos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bronPos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 bronPos = ((ChessBoardDataForExchange)obj).bronPos;
			ToLua.Push(L, bronPos);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bronPos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_direction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int direction = ((ChessBoardDataForExchange)obj).direction;
			LuaDLL.lua_pushinteger(L, direction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index direction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mapId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardDataForExchange obj2 = (ChessBoardDataForExchange)obj;
			int mapId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.mapId = mapId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_MapConfig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardDataForExchange obj2 = (ChessBoardDataForExchange)obj;
			MapConfig mapConfig = (MapConfig)ToLua.CheckObject<MapConfig>(L, 2);
			obj2.MapConfig = mapConfig;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MapConfig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mapInfoS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardDataForExchange obj2 = (ChessBoardDataForExchange)obj;
			ChessBoardGirdChangeData[] mapInfoS = ToLua.CheckObjectArray<ChessBoardGirdChangeData>(L, 2);
			obj2.mapInfoS = mapInfoS;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapInfoS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_thingInfoS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardDataForExchange obj2 = (ChessBoardDataForExchange)obj;
			ChessBoardThingChangeData[] thingInfoS = ToLua.CheckObjectArray<ChessBoardThingChangeData>(L, 2);
			obj2.thingInfoS = thingInfoS;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingInfoS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_banDirInfoS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardDataForExchange obj2 = (ChessBoardDataForExchange)obj;
			ChessBoardBanDirChangeData[] banDirInfoS = ToLua.CheckObjectArray<ChessBoardBanDirChangeData>(L, 2);
			obj2.banDirInfoS = banDirInfoS;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index banDirInfoS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_NPCInfos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardDataForExchange obj2 = (ChessBoardDataForExchange)obj;
			ChessBoardNPCData[] nPCInfos = ToLua.CheckObjectArray<ChessBoardNPCData>(L, 2);
			obj2.NPCInfos = nPCInfos;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index NPCInfos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bronPos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardDataForExchange obj2 = (ChessBoardDataForExchange)obj;
			Vector2 bronPos = ToLua.ToVector2(L, 2);
			obj2.bronPos = bronPos;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bronPos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_direction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardDataForExchange obj2 = (ChessBoardDataForExchange)obj;
			int direction = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.direction = direction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index direction on a nil value");
		}
	}
}
