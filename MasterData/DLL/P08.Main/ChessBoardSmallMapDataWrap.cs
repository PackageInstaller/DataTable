using System;
using LuaInterface;

public class ChessBoardSmallMapDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ChessBoardSmallMapData), typeof(object));
		L.RegFunction("New", _CreateChessBoardSmallMapData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("typeIDList", get_typeIDList, set_typeIDList);
		L.RegVar("thingTypeIDList", get_thingTypeIDList, set_thingTypeIDList);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateChessBoardSmallMapData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ChessBoardSmallMapData o = new ChessBoardSmallMapData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ChessBoardSmallMapData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_typeIDList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] typeIDList = ((ChessBoardSmallMapData)obj).typeIDList;
			ToLua.Push(L, typeIDList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index typeIDList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_thingTypeIDList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] thingTypeIDList = ((ChessBoardSmallMapData)obj).thingTypeIDList;
			ToLua.Push(L, thingTypeIDList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingTypeIDList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_typeIDList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardSmallMapData obj2 = (ChessBoardSmallMapData)obj;
			int[] typeIDList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.typeIDList = typeIDList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index typeIDList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_thingTypeIDList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ChessBoardSmallMapData obj2 = (ChessBoardSmallMapData)obj;
			int[] thingTypeIDList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.thingTypeIDList = thingTypeIDList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index thingTypeIDList on a nil value");
		}
	}
}
