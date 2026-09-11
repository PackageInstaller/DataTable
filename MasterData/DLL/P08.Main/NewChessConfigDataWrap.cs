using System;
using LuaInterface;

public class NewChessConfigDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(NewChessConfigData), typeof(object));
		L.RegFunction("New", _CreateNewChessConfigData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("GridConfig", get_GridConfig, set_GridConfig);
		L.RegVar("ThingConfig", get_ThingConfig, set_ThingConfig);
		L.RegVar("ConveyorIDList", get_ConveyorIDList, set_ConveyorIDList);
		L.RegVar("ReverseConveyorIDList", get_ReverseConveyorIDList, set_ReverseConveyorIDList);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateNewChessConfigData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				NewChessConfigData o = new NewChessConfigData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: NewChessConfigData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GridConfig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewGridConfig[] gridConfig = ((NewChessConfigData)obj).GridConfig;
			ToLua.Push(L, gridConfig);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GridConfig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ThingConfig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewWarChessThingConfig[] thingConfig = ((NewChessConfigData)obj).ThingConfig;
			ToLua.Push(L, thingConfig);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ThingConfig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ConveyorIDList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] conveyorIDList = ((NewChessConfigData)obj).ConveyorIDList;
			ToLua.Push(L, conveyorIDList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ConveyorIDList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ReverseConveyorIDList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] reverseConveyorIDList = ((NewChessConfigData)obj).ReverseConveyorIDList;
			ToLua.Push(L, reverseConveyorIDList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ReverseConveyorIDList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_GridConfig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewChessConfigData obj2 = (NewChessConfigData)obj;
			NewGridConfig[] gridConfig = ToLua.CheckObjectArray<NewGridConfig>(L, 2);
			obj2.GridConfig = gridConfig;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GridConfig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ThingConfig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewChessConfigData obj2 = (NewChessConfigData)obj;
			NewWarChessThingConfig[] thingConfig = ToLua.CheckObjectArray<NewWarChessThingConfig>(L, 2);
			obj2.ThingConfig = thingConfig;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ThingConfig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ConveyorIDList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewChessConfigData obj2 = (NewChessConfigData)obj;
			int[] conveyorIDList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.ConveyorIDList = conveyorIDList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ConveyorIDList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ReverseConveyorIDList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			NewChessConfigData obj2 = (NewChessConfigData)obj;
			int[] reverseConveyorIDList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.ReverseConveyorIDList = reverseConveyorIDList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ReverseConveyorIDList on a nil value");
		}
	}
}
