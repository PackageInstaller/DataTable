using System;
using System.Collections;
using LuaInterface;

public class System_Collections_IEnumeratorWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(IEnumerator), null);
		L.RegFunction("MoveNext", MoveNext);
		L.RegFunction("Reset", Reset);
		L.RegVar("Current", get_Current, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveNext(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ToLua.CheckIter(L, 1).MoveNext();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Reset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ToLua.CheckIter(L, 1).Reset();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Current(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			object current = ((IEnumerator)obj).Current;
			ToLua.Push(L, current);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Current on a nil value");
		}
	}
}
