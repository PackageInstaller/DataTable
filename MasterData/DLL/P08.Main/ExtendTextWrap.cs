using System;
using LuaInterface;
using UnityEngine;

public class ExtendTextWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ExtendText), typeof(MonoBehaviour));
		L.RegFunction("SetText", SetText);
		L.RegFunction("Show", Show);
		L.RegFunction("Hide", Hide);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetText(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ExtendText obj = (ExtendText)ToLua.CheckObject<ExtendText>(L, 1);
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
	private static int Show(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((ExtendText)ToLua.CheckObject<ExtendText>(L, 1)).Show();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Hide(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((ExtendText)ToLua.CheckObject<ExtendText>(L, 1)).Hide();
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
}
