using System;
using LuaInterface;
using UnityEngine;

public class ChessDataForExchangeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ChessDataForExchange), typeof(object));
		L.RegFunction("New", _CreateChessDataForExchange);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("mapId", get_mapId, set_mapId);
		L.RegVar("GridConfig", get_GridConfig, set_GridConfig);
		L.RegVar("MapConfig", get_MapConfig, set_MapConfig);
		L.RegVar("mapInfoS", get_mapInfoS, set_mapInfoS);
		L.RegVar("bronPos", get_bronPos, set_bronPos);
		L.RegVar("direction", get_direction, set_direction);
		L.RegVar("fogInfo", get_fogInfo, set_fogInfo);
		L.RegVar("cacheAssetS", get_cacheAssetS, set_cacheAssetS);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateChessDataForExchange(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ChessDataForExchange o = new ChessDataForExchange();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ChessDataForExchange.New");
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
			int mapId = ((ChessDataForExchange)obj).mapId;
			LuaDLL.lua_pushinteger(L, mapId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GridConfig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridConfig[] gridConfig = ((ChessDataForExchange)obj).GridConfig;
			ToLua.Push(L, gridConfig);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GridConfig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MapConfig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MapConfig mapConfig = ((ChessDataForExchange)obj).MapConfig;
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
			GridChangeData[] mapInfoS = ((ChessDataForExchange)obj).mapInfoS;
			ToLua.Push(L, mapInfoS);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapInfoS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bronPos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 bronPos = ((ChessDataForExchange)obj).bronPos;
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
			int direction = ((ChessDataForExchange)obj).direction;
			LuaDLL.lua_pushinteger(L, direction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index direction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fogInfo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool[] fogInfo = ((ChessDataForExchange)obj).fogInfo;
			ToLua.Push(L, fogInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogInfo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cacheAssetS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CacheAssetInfo[] cacheAssetS = ((ChessDataForExchange)obj).cacheAssetS;
			ToLua.Push(L, cacheAssetS);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cacheAssetS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mapId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessDataForExchange obj2 = (ChessDataForExchange)obj;
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
	private static int set_GridConfig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessDataForExchange obj2 = (ChessDataForExchange)obj;
			GridConfig[] gridConfig = ToLua.CheckObjectArray<GridConfig>(L, 2);
			obj2.GridConfig = gridConfig;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GridConfig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_MapConfig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessDataForExchange obj2 = (ChessDataForExchange)obj;
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
			ChessDataForExchange obj2 = (ChessDataForExchange)obj;
			GridChangeData[] mapInfoS = ToLua.CheckObjectArray<GridChangeData>(L, 2);
			obj2.mapInfoS = mapInfoS;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapInfoS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bronPos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessDataForExchange obj2 = (ChessDataForExchange)obj;
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
			ChessDataForExchange obj2 = (ChessDataForExchange)obj;
			int direction = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.direction = direction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index direction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fogInfo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessDataForExchange obj2 = (ChessDataForExchange)obj;
			bool[] fogInfo = ToLua.CheckBoolArray(L, 2);
			obj2.fogInfo = fogInfo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fogInfo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cacheAssetS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessDataForExchange obj2 = (ChessDataForExchange)obj;
			CacheAssetInfo[] cacheAssetS = ToLua.CheckObjectArray<CacheAssetInfo>(L, 2);
			obj2.cacheAssetS = cacheAssetS;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cacheAssetS on a nil value");
		}
	}
}
