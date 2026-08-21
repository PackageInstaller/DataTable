using System;
using LuaInterface;

public class PinballDataForExchangeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PinballDataForExchange), typeof(object));
		L.RegFunction("New", _CreatePinballDataForExchange);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("playerData", get_playerData, set_playerData);
		L.RegVar("enemyDataList", get_enemyDataList, set_enemyDataList);
		L.RegVar("mapData", get_mapData, set_mapData);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreatePinballDataForExchange(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				PinballDataForExchange o = new PinballDataForExchange();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: PinballDataForExchange.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playerData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleBattleData playerData = ((PinballDataForExchange)obj).playerData;
			ToLua.PushObject(L, playerData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playerData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enemyDataList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleBattleData[][] enemyDataList = ((PinballDataForExchange)obj).enemyDataList;
			ToLua.Push(L, enemyDataList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enemyDataList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mapData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData mapData = ((PinballDataForExchange)obj).mapData;
			ToLua.PushObject(L, mapData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playerData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballDataForExchange obj2 = (PinballDataForExchange)obj;
			PinballRoleBattleData playerData = (PinballRoleBattleData)ToLua.CheckObject<PinballRoleBattleData>(L, 2);
			obj2.playerData = playerData;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playerData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enemyDataList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballDataForExchange obj2 = (PinballDataForExchange)obj;
			PinballRoleBattleData[][] enemyDataList = ToLua.CheckObjectArray<PinballRoleBattleData[]>(L, 2);
			obj2.enemyDataList = enemyDataList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enemyDataList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mapData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballDataForExchange obj2 = (PinballDataForExchange)obj;
			PinballMapGenerateData mapData = (PinballMapGenerateData)ToLua.CheckObject<PinballMapGenerateData>(L, 2);
			obj2.mapData = mapData;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapData on a nil value");
		}
	}
}
