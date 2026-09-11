using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class RollingNumberTextWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RollingNumberText), typeof(MonoBehaviour));
		L.RegFunction("SetMaxDigits", SetMaxDigits);
		L.RegFunction("Change", Change);
		L.RegFunction("SetNumber", SetNumber);
		L.RegFunction("DoTween", DoTween);
		L.RegFunction("TestChange", TestChange);
		L.RegFunction("SetNumberImmediate", SetNumberImmediate);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("OnComplete", get_OnComplete, set_OnComplete);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMaxDigits(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RollingNumberText obj = (RollingNumberText)ToLua.CheckObject<RollingNumberText>(L, 1);
			int maxDigits = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetMaxDigits(maxDigits);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Change(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RollingNumberText obj = (RollingNumberText)ToLua.CheckObject<RollingNumberText>(L, 1);
			int num = (int)LuaDLL.luaL_checknumber(L, 2);
			int to = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.Change(num, to);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetNumber(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RollingNumberText obj = (RollingNumberText)ToLua.CheckObject<RollingNumberText>(L, 1);
			int v = (int)LuaDLL.luaL_checknumber(L, 2);
			bool isTween = LuaDLL.luaL_checkboolean(L, 3);
			obj.SetNumber(v, isTween);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DoTween(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			RollingNumberText obj = (RollingNumberText)ToLua.CheckObject<RollingNumberText>(L, 1);
			Text text = (Text)ToLua.CheckObject<Text>(L, 2);
			float endValue = (float)LuaDLL.luaL_checknumber(L, 3);
			float delay = (float)LuaDLL.luaL_checknumber(L, 4);
			obj.DoTween(text, endValue, delay);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TestChange(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RollingNumberText)ToLua.CheckObject<RollingNumberText>(L, 1)).TestChange();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetNumberImmediate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RollingNumberText obj = (RollingNumberText)ToLua.CheckObject<RollingNumberText>(L, 1);
			int numberImmediate = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetNumberImmediate(numberImmediate);
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
	private static int get_OnComplete(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action onComplete = ((RollingNumberText)obj).OnComplete;
			ToLua.Push(L, onComplete);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnComplete on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnComplete(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RollingNumberText obj2 = (RollingNumberText)obj;
			Action onComplete = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.OnComplete = onComplete;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnComplete on a nil value");
		}
	}
}
