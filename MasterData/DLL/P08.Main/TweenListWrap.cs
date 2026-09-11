using System;
using System.Collections.Generic;
using LuaInterface;

public class TweenListWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TweenList), typeof(object));
		L.RegFunction("New", _CreateTweenList);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("name", get_name, set_name);
		L.RegVar("tweenList", get_tweenList, set_tweenList);
		L.RegVar("tweenJson", get_tweenJson, set_tweenJson);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateTweenList(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				TweenList o = new TweenList();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: TweenList.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string name = ((TweenList)obj).name;
			LuaDLL.lua_pushstring(L, name);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tweenList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<TweenNode> tweenList = ((TweenList)obj).tweenList;
			ToLua.PushSealed(L, tweenList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tweenList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tweenJson(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string tweenJson = ((TweenList)obj).tweenJson;
			LuaDLL.lua_pushstring(L, tweenJson);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tweenJson on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TweenList obj2 = (TweenList)obj;
			string name = ToLua.CheckString(L, 2);
			obj2.name = name;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tweenList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TweenList obj2 = (TweenList)obj;
			List<TweenNode> tweenList = (List<TweenNode>)ToLua.CheckObject(L, 2, typeof(List<TweenNode>));
			obj2.tweenList = tweenList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tweenList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tweenJson(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TweenList obj2 = (TweenList)obj;
			string tweenJson = ToLua.CheckString(L, 2);
			obj2.tweenJson = tweenJson;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tweenJson on a nil value");
		}
	}
}
