using System;
using System.Collections;
using System.Collections.ObjectModel;
using LuaInterface;

public class System_Collections_ObjectModel_ReadOnlyCollectionWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ReadOnlyCollection<>), typeof(object), "ReadOnlyCollection");
		L.RegFunction("Contains", Contains);
		L.RegFunction("CopyTo", CopyTo);
		L.RegFunction("GetEnumerator", GetEnumerator);
		L.RegFunction("IndexOf", IndexOf);
		L.RegFunction(".geti", get_Item);
		L.RegFunction("get_Item", get_Item);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Count", get_Count, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Contains(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(ReadOnlyCollection<>), out ArgType);
			object obj2 = ToLua.CheckVarObject(L, 2, ArgType);
			bool value = (bool)LuaMethodCache.CallSingleMethod("Contains", obj, obj2);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
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
			object obj = ToLua.CheckGenericObject(L, 1, typeof(ReadOnlyCollection<>), out ArgType);
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
			object obj = ToLua.CheckGenericObject(L, 1, typeof(ReadOnlyCollection<>));
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
	private static int IndexOf(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(ReadOnlyCollection<>), out ArgType);
			object obj2 = ToLua.CheckVarObject(L, 2, ArgType);
			int n = (int)LuaMethodCache.CallSingleMethod("IndexOf", obj, obj2);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Item(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(ReadOnlyCollection<>));
			int num = (int)LuaDLL.luaL_checknumber(L, 2);
			int n = (int)LuaMethodCache.CallSingleMethod("get_Item", obj, num);
			LuaDLL.lua_pushinteger(L, n);
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
