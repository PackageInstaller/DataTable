using System;
using LuaInterface;
using UnityEngine;

public class TextExtensionWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TextExtension), typeof(MonoBehaviour));
		L.RegFunction("SetText", SetText);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("suffix", get_suffix, set_suffix);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetText(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			TextExtension obj = (TextExtension)ToLua.CheckObject<TextExtension>(L, 1);
			string text = ToLua.CheckString(L, 2);
			obj.SetText(text);
			return 0;
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
	private static int get_suffix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string suffix = ((TextExtension)obj).suffix;
			LuaDLL.lua_pushstring(L, suffix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index suffix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_suffix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TextExtension obj2 = (TextExtension)obj;
			string suffix = ToLua.CheckString(L, 2);
			obj2.suffix = suffix;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index suffix on a nil value");
		}
	}
}
