using System;
using System.Collections.Generic;
using Brent.UI.UIInjection;
using LuaInterface;
using UnityEngine;

public class Brent_UI_UIInjection_UIInjectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UIInject), typeof(MonoBehaviour));
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Injections", get_Injections, set_Injections);
		L.EndClass();
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
	private static int get_Injections(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Injection> injections = ((UIInject)obj).Injections;
			ToLua.PushSealed(L, injections);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Injections on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Injections(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIInject obj2 = (UIInject)obj;
			List<Injection> injections = (List<Injection>)ToLua.CheckObject(L, 2, typeof(List<Injection>));
			obj2.Injections = injections;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Injections on a nil value");
		}
	}
}
