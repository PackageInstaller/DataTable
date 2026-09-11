using System;
using System.Collections;
using System.Collections.Generic;
using LuaInterface;

public class System_Collections_Generic_Dictionary_KeyCollectionWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Dictionary<, >.KeyCollection), typeof(object), "KeyCollection");
		L.RegFunction("CopyTo", CopyTo);
		L.RegFunction("GetEnumerator", GetEnumerator);
		L.RegFunction("New", _CreateSystem_Collections_Generic_Dictionary_KeyCollection);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Count", get_Count, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateSystem_Collections_Generic_Dictionary_KeyCollection(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 1)
			{
				object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >));
				object o = Activator.CreateInstance(obj.GetType().GetNestedType("KeyCollection"), obj);
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: System.Collections.Generic.Dictionary.KeyCollection.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CopyTo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >.KeyCollection), out ArgType);
			object obj2 = ToLua.CheckObject(L, 2, ArgType.MakeArrayType());
			int num = (int)LuaDLL.luaL_checknumber(L, 3);
			LuaMethodCache.CallSingleMethod("CopyTo", obj, obj2, num);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetEnumerator(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >.KeyCollection));
			IEnumerator iter = (IEnumerator)LuaMethodCache.CallSingleMethod("GetEnumerator", obj);
			ToLua.Push(L, iter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Count(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int n = (int)LuaMethodCache.CallSingleMethod("get_Count", obj);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Count on a nil value");
		}
	}
}
