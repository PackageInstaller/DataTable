using System;
using System.Collections.Generic;
using BilliardGame.Runtime;
using LuaInterface;
using UnityEngine;

public class BilliardGame_Runtime_StageDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(StageData), typeof(ScriptableObject));
		L.RegFunction("ExchangeIndexFromPosition", ExchangeIndexFromPosition);
		L.RegFunction("ExchangePositionFromIndex", ExchangePositionFromIndex);
		L.RegFunction("New", _CreateBilliardGame_Runtime_StageData);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("stageId", get_stageId, set_stageId);
		L.RegVar("gridData", get_gridData, set_gridData);
		L.RegVar("mWidth", get_mWidth, set_mWidth);
		L.RegVar("mHeight", get_mHeight, set_mHeight);
		L.RegVar("playerBornPos", get_playerBornPos, set_playerBornPos);
		L.RegVar("monsters", get_monsters, set_monsters);
		L.RegVar("mechanisms", get_mechanisms, set_mechanisms);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateBilliardGame_Runtime_StageData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				StageData obj = new StageData();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: BilliardGame.Runtime.StageData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExchangeIndexFromPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int n = StageData.ExchangeIndexFromPosition(StackTraits<Vector3Int>.Check(L, 1));
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExchangePositionFromIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3Int v = StageData.ExchangePositionFromIndex((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
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

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stageId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int stageId = ((StageData)obj).stageId;
			LuaDLL.lua_pushinteger(L, stageId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gridData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<GridData> gridData = ((StageData)obj).gridData;
			ToLua.PushSealed(L, gridData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gridData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mWidth(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, StageData.mWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mHeight(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, StageData.mHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playerBornPos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Vector3> playerBornPos = ((StageData)obj).playerBornPos;
			ToLua.PushSealed(L, playerBornPos);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playerBornPos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_monsters(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<MonsterData> monsters = ((StageData)obj).monsters;
			ToLua.PushSealed(L, monsters);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index monsters on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mechanisms(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<MechanismData> mechanisms = ((StageData)obj).mechanisms;
			ToLua.PushSealed(L, mechanisms);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mechanisms on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stageId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			int stageId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.stageId = stageId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gridData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			List<GridData> gridData = (List<GridData>)ToLua.CheckObject(L, 2, typeof(List<GridData>));
			obj2.gridData = gridData;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gridData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mWidth(IntPtr L)
	{
		try
		{
			StageData.mWidth = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mHeight(IntPtr L)
	{
		try
		{
			StageData.mHeight = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playerBornPos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			List<Vector3> playerBornPos = (List<Vector3>)ToLua.CheckObject(L, 2, typeof(List<Vector3>));
			obj2.playerBornPos = playerBornPos;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playerBornPos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_monsters(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			List<MonsterData> monsters = (List<MonsterData>)ToLua.CheckObject(L, 2, typeof(List<MonsterData>));
			obj2.monsters = monsters;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index monsters on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mechanisms(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			List<MechanismData> mechanisms = (List<MechanismData>)ToLua.CheckObject(L, 2, typeof(List<MechanismData>));
			obj2.mechanisms = mechanisms;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mechanisms on a nil value");
		}
	}
}
