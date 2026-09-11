using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UnityEngine_UI_LayoutElementWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LayoutElement), typeof(UIBehaviour));
		L.RegFunction("CalculateLayoutInputHorizontal", CalculateLayoutInputHorizontal);
		L.RegFunction("CalculateLayoutInputVertical", CalculateLayoutInputVertical);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("ignoreLayout", get_ignoreLayout, set_ignoreLayout);
		L.RegVar("minWidth", get_minWidth, set_minWidth);
		L.RegVar("minHeight", get_minHeight, set_minHeight);
		L.RegVar("preferredWidth", get_preferredWidth, set_preferredWidth);
		L.RegVar("preferredHeight", get_preferredHeight, set_preferredHeight);
		L.RegVar("flexibleWidth", get_flexibleWidth, set_flexibleWidth);
		L.RegVar("flexibleHeight", get_flexibleHeight, set_flexibleHeight);
		L.RegVar("layoutPriority", get_layoutPriority, set_layoutPriority);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalculateLayoutInputHorizontal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LayoutElement)ToLua.CheckObject<LayoutElement>(L, 1)).CalculateLayoutInputHorizontal();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalculateLayoutInputVertical(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LayoutElement)ToLua.CheckObject<LayoutElement>(L, 1)).CalculateLayoutInputVertical();
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
	private static int get_ignoreLayout(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool ignoreLayout = ((LayoutElement)obj).ignoreLayout;
			LuaDLL.lua_pushboolean(L, ignoreLayout);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignoreLayout on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_minWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float minWidth = ((LayoutElement)obj).minWidth;
			LuaDLL.lua_pushnumber(L, minWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_minHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float minHeight = ((LayoutElement)obj).minHeight;
			LuaDLL.lua_pushnumber(L, minHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_preferredWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float preferredWidth = ((LayoutElement)obj).preferredWidth;
			LuaDLL.lua_pushnumber(L, preferredWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index preferredWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_preferredHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float preferredHeight = ((LayoutElement)obj).preferredHeight;
			LuaDLL.lua_pushnumber(L, preferredHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index preferredHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_flexibleWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float flexibleWidth = ((LayoutElement)obj).flexibleWidth;
			LuaDLL.lua_pushnumber(L, flexibleWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index flexibleWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_flexibleHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float flexibleHeight = ((LayoutElement)obj).flexibleHeight;
			LuaDLL.lua_pushnumber(L, flexibleHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index flexibleHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_layoutPriority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int layoutPriority = ((LayoutElement)obj).layoutPriority;
			LuaDLL.lua_pushinteger(L, layoutPriority);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index layoutPriority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ignoreLayout(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LayoutElement obj2 = (LayoutElement)obj;
			bool ignoreLayout = LuaDLL.luaL_checkboolean(L, 2);
			obj2.ignoreLayout = ignoreLayout;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignoreLayout on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_minWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LayoutElement obj2 = (LayoutElement)obj;
			float minWidth = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.minWidth = minWidth;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_minHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LayoutElement obj2 = (LayoutElement)obj;
			float minHeight = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.minHeight = minHeight;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_preferredWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LayoutElement obj2 = (LayoutElement)obj;
			float preferredWidth = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.preferredWidth = preferredWidth;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index preferredWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_preferredHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LayoutElement obj2 = (LayoutElement)obj;
			float preferredHeight = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.preferredHeight = preferredHeight;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index preferredHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_flexibleWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LayoutElement obj2 = (LayoutElement)obj;
			float flexibleWidth = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.flexibleWidth = flexibleWidth;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index flexibleWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_flexibleHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LayoutElement obj2 = (LayoutElement)obj;
			float flexibleHeight = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.flexibleHeight = flexibleHeight;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index flexibleHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_layoutPriority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LayoutElement obj2 = (LayoutElement)obj;
			int layoutPriority = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.layoutPriority = layoutPriority;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index layoutPriority on a nil value");
		}
	}
}
