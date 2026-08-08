using System;
using LuaInterface;

public class SkuldPuzzleConditionDataListWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SkuldPuzzleConditionDataList), typeof(object));
		L.RegFunction("New", _CreateSkuldPuzzleConditionDataList);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("conditonList", get_conditonList, set_conditonList);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateSkuldPuzzleConditionDataList(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				SkuldPuzzleConditionDataList o = new SkuldPuzzleConditionDataList();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: SkuldPuzzleConditionDataList.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_conditonList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkuldPuzzleConditionData[] conditonList = ((SkuldPuzzleConditionDataList)obj).conditonList;
			ToLua.Push(L, conditonList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index conditonList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_conditonList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkuldPuzzleConditionDataList obj2 = (SkuldPuzzleConditionDataList)obj;
			SkuldPuzzleConditionData[] conditonList = ToLua.CheckObjectArray<SkuldPuzzleConditionData>(L, 2);
			obj2.conditonList = conditonList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index conditonList on a nil value");
		}
	}
}
