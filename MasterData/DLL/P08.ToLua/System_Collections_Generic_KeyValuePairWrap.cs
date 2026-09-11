using System;
using System.Collections.Generic;
using LuaInterface;

public class System_Collections_Generic_KeyValuePairWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(KeyValuePair<, >), null, "KeyValuePair");
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Key", get_Key, null);
		L.RegVar("Value", get_Value, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Key(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			object obj2 = LuaMethodCache.CallSingleMethod("get_Key", obj);
			ToLua.Push(L, obj2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Key on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Value(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			object obj2 = LuaMethodCache.CallSingleMethod("get_Value", obj);
			ToLua.Push(L, obj2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Value on a nil value");
		}
	}
}
