using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class TweenManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TweenManager), typeof(MonoBehaviour));
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("tweenS", get_tweenS, set_tweenS);
		L.RegVar("luaPlayFuc", get_luaPlayFuc, set_luaPlayFuc);
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
	private static int get_tweenS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<TweenList> tweenS = ((TweenManager)obj).tweenS;
			ToLua.PushSealed(L, tweenS);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tweenS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_luaPlayFuc(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<string> luaPlayFuc = ((TweenManager)obj).luaPlayFuc;
			ToLua.Push(L, luaPlayFuc);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index luaPlayFuc on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tweenS(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TweenManager obj2 = (TweenManager)obj;
			List<TweenList> tweenS = (List<TweenList>)ToLua.CheckObject(L, 2, typeof(List<TweenList>));
			obj2.tweenS = tweenS;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tweenS on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_luaPlayFuc(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TweenManager obj2 = (TweenManager)obj;
			Action<string> luaPlayFuc = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 2);
			obj2.luaPlayFuc = luaPlayFuc;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index luaPlayFuc on a nil value");
		}
	}
}
