using System;
using LuaInterface;

public class SkuldPuzzleConditionDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SkuldPuzzleConditionData), typeof(object));
		L.RegFunction("New", _CreateSkuldPuzzleConditionData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("conditionType", get_conditionType, set_conditionType);
		L.RegVar("aimCount", get_aimCount, set_aimCount);
		L.RegVar("aimList", get_aimList, set_aimList);
		L.RegVar("chipID", get_chipID, set_chipID);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateSkuldPuzzleConditionData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				SkuldPuzzleConditionData o = new SkuldPuzzleConditionData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: SkuldPuzzleConditionData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_conditionType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int conditionType = ((SkuldPuzzleConditionData)obj).conditionType;
			LuaDLL.lua_pushinteger(L, conditionType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index conditionType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_aimCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int aimCount = ((SkuldPuzzleConditionData)obj).aimCount;
			LuaDLL.lua_pushinteger(L, aimCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index aimCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_aimList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] aimList = ((SkuldPuzzleConditionData)obj).aimList;
			ToLua.Push(L, aimList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index aimList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_chipID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int chipID = ((SkuldPuzzleConditionData)obj).chipID;
			LuaDLL.lua_pushinteger(L, chipID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index chipID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_conditionType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkuldPuzzleConditionData obj2 = (SkuldPuzzleConditionData)obj;
			int conditionType = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.conditionType = conditionType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index conditionType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_aimCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkuldPuzzleConditionData obj2 = (SkuldPuzzleConditionData)obj;
			int aimCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.aimCount = aimCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index aimCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_aimList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkuldPuzzleConditionData obj2 = (SkuldPuzzleConditionData)obj;
			int[] aimList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.aimList = aimList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index aimList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_chipID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkuldPuzzleConditionData obj2 = (SkuldPuzzleConditionData)obj;
			int chipID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.chipID = chipID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index chipID on a nil value");
		}
	}
}
