using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_RectOffsetWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RectOffset), typeof(object));
		L.RegFunction("Add", Add);
		L.RegFunction("Remove", Remove);
		L.RegFunction("ToString", ToString);
		L.RegFunction("New", _CreateUnityEngine_RectOffset);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("left", get_left, set_left);
		L.RegVar("right", get_right, set_right);
		L.RegVar("top", get_top, set_top);
		L.RegVar("bottom", get_bottom, set_bottom);
		L.RegVar("horizontal", get_horizontal, null);
		L.RegVar("vertical", get_vertical, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_RectOffset(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
			{
				RectOffset o2 = new RectOffset();
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 4:
			{
				int left = (int)LuaDLL.luaL_checknumber(L, 1);
				int right = (int)LuaDLL.luaL_checknumber(L, 2);
				int top = (int)LuaDLL.luaL_checknumber(L, 3);
				int bottom = (int)LuaDLL.luaL_checknumber(L, 4);
				RectOffset o = new RectOffset(left, right, top, bottom);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.RectOffset.New");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Add(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectOffset obj = (RectOffset)ToLua.CheckObject<RectOffset>(L, 1);
			Rect rect = StackTraits<Rect>.Check(L, 2);
			Rect v = obj.Add(rect);
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Remove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectOffset obj = (RectOffset)ToLua.CheckObject<RectOffset>(L, 1);
			Rect rect = StackTraits<Rect>.Check(L, 2);
			Rect v = obj.Remove(rect);
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToString(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = ((RectOffset)ToLua.CheckObject<RectOffset>(L, 1)).ToString();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_left(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int left = ((RectOffset)obj).left;
			LuaDLL.lua_pushinteger(L, left);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index left on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_right(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int right = ((RectOffset)obj).right;
			LuaDLL.lua_pushinteger(L, right);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index right on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_top(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int top = ((RectOffset)obj).top;
			LuaDLL.lua_pushinteger(L, top);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index top on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bottom(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int bottom = ((RectOffset)obj).bottom;
			LuaDLL.lua_pushinteger(L, bottom);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bottom on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_horizontal(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int horizontal = ((RectOffset)obj).horizontal;
			LuaDLL.lua_pushinteger(L, horizontal);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index horizontal on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vertical(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int vertical = ((RectOffset)obj).vertical;
			LuaDLL.lua_pushinteger(L, vertical);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index vertical on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_left(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectOffset obj2 = (RectOffset)obj;
			int left = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.left = left;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index left on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_right(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectOffset obj2 = (RectOffset)obj;
			int right = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.right = right;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index right on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_top(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectOffset obj2 = (RectOffset)obj;
			int top = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.top = top;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index top on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bottom(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectOffset obj2 = (RectOffset)obj;
			int bottom = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.bottom = bottom;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bottom on a nil value");
		}
	}
}
