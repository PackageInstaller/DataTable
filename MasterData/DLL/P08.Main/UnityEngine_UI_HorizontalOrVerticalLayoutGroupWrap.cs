using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class UnityEngine_UI_HorizontalOrVerticalLayoutGroupWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(HorizontalOrVerticalLayoutGroup), typeof(LayoutGroup));
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("spacing", get_spacing, set_spacing);
		L.RegVar("childForceExpandWidth", get_childForceExpandWidth, set_childForceExpandWidth);
		L.RegVar("childForceExpandHeight", get_childForceExpandHeight, set_childForceExpandHeight);
		L.RegVar("childControlWidth", get_childControlWidth, set_childControlWidth);
		L.RegVar("childControlHeight", get_childControlHeight, set_childControlHeight);
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
	private static int get_spacing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float spacing = ((HorizontalOrVerticalLayoutGroup)obj).spacing;
			LuaDLL.lua_pushnumber(L, spacing);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spacing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_childForceExpandWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool childForceExpandWidth = ((HorizontalOrVerticalLayoutGroup)obj).childForceExpandWidth;
			LuaDLL.lua_pushboolean(L, childForceExpandWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index childForceExpandWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_childForceExpandHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool childForceExpandHeight = ((HorizontalOrVerticalLayoutGroup)obj).childForceExpandHeight;
			LuaDLL.lua_pushboolean(L, childForceExpandHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index childForceExpandHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_childControlWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool childControlWidth = ((HorizontalOrVerticalLayoutGroup)obj).childControlWidth;
			LuaDLL.lua_pushboolean(L, childControlWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index childControlWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_childControlHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool childControlHeight = ((HorizontalOrVerticalLayoutGroup)obj).childControlHeight;
			LuaDLL.lua_pushboolean(L, childControlHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index childControlHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spacing(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HorizontalOrVerticalLayoutGroup obj2 = (HorizontalOrVerticalLayoutGroup)obj;
			float spacing = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.spacing = spacing;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spacing on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_childForceExpandWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HorizontalOrVerticalLayoutGroup obj2 = (HorizontalOrVerticalLayoutGroup)obj;
			bool childForceExpandWidth = LuaDLL.luaL_checkboolean(L, 2);
			obj2.childForceExpandWidth = childForceExpandWidth;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index childForceExpandWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_childForceExpandHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HorizontalOrVerticalLayoutGroup obj2 = (HorizontalOrVerticalLayoutGroup)obj;
			bool childForceExpandHeight = LuaDLL.luaL_checkboolean(L, 2);
			obj2.childForceExpandHeight = childForceExpandHeight;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index childForceExpandHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_childControlWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HorizontalOrVerticalLayoutGroup obj2 = (HorizontalOrVerticalLayoutGroup)obj;
			bool childControlWidth = LuaDLL.luaL_checkboolean(L, 2);
			obj2.childControlWidth = childControlWidth;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index childControlWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_childControlHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			HorizontalOrVerticalLayoutGroup obj2 = (HorizontalOrVerticalLayoutGroup)obj;
			bool childControlHeight = LuaDLL.luaL_checkboolean(L, 2);
			obj2.childControlHeight = childControlHeight;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index childControlHeight on a nil value");
		}
	}
}
