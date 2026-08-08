using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class UnityEngine_UI_LayoutUtilityWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("LayoutUtility");
		L.RegFunction("GetMinSize", GetMinSize);
		L.RegFunction("GetPreferredSize", GetPreferredSize);
		L.RegFunction("GetFlexibleSize", GetFlexibleSize);
		L.RegFunction("GetMinWidth", GetMinWidth);
		L.RegFunction("GetPreferredWidth", GetPreferredWidth);
		L.RegFunction("GetFlexibleWidth", GetFlexibleWidth);
		L.RegFunction("GetMinHeight", GetMinHeight);
		L.RegFunction("GetPreferredHeight", GetPreferredHeight);
		L.RegFunction("GetFlexibleHeight", GetFlexibleHeight);
		L.RegFunction("GetLayoutProperty", GetLayoutProperty);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMinSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform rect = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			int axis = (int)LuaDLL.luaL_checknumber(L, 2);
			float minSize = LayoutUtility.GetMinSize(rect, axis);
			LuaDLL.lua_pushnumber(L, minSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPreferredSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform rect = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			int axis = (int)LuaDLL.luaL_checknumber(L, 2);
			float preferredSize = LayoutUtility.GetPreferredSize(rect, axis);
			LuaDLL.lua_pushnumber(L, preferredSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFlexibleSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform rect = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			int axis = (int)LuaDLL.luaL_checknumber(L, 2);
			float flexibleSize = LayoutUtility.GetFlexibleSize(rect, axis);
			LuaDLL.lua_pushnumber(L, flexibleSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMinWidth(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float minWidth = LayoutUtility.GetMinWidth((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform)));
			LuaDLL.lua_pushnumber(L, minWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPreferredWidth(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float preferredWidth = LayoutUtility.GetPreferredWidth((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform)));
			LuaDLL.lua_pushnumber(L, preferredWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFlexibleWidth(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float flexibleWidth = LayoutUtility.GetFlexibleWidth((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform)));
			LuaDLL.lua_pushnumber(L, flexibleWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMinHeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float minHeight = LayoutUtility.GetMinHeight((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform)));
			LuaDLL.lua_pushnumber(L, minHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPreferredHeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float preferredHeight = LayoutUtility.GetPreferredHeight((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform)));
			LuaDLL.lua_pushnumber(L, preferredHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFlexibleHeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float flexibleHeight = LayoutUtility.GetFlexibleHeight((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform)));
			LuaDLL.lua_pushnumber(L, flexibleHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLayoutProperty(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				RectTransform rect2 = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
				Func<ILayoutElement, float> property2 = (Func<ILayoutElement, float>)ToLua.CheckDelegate<Func<ILayoutElement, float>>(L, 2);
				float defaultValue2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float layoutProperty2 = LayoutUtility.GetLayoutProperty(rect2, property2, defaultValue2);
				LuaDLL.lua_pushnumber(L, layoutProperty2);
				return 1;
			}
			case 4:
			{
				RectTransform rect = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
				Func<ILayoutElement, float> property = (Func<ILayoutElement, float>)ToLua.CheckDelegate<Func<ILayoutElement, float>>(L, 2);
				float defaultValue = (float)LuaDLL.luaL_checknumber(L, 3);
				ILayoutElement source = null;
				float layoutProperty = LayoutUtility.GetLayoutProperty(rect, property, defaultValue, out source);
				LuaDLL.lua_pushnumber(L, layoutProperty);
				ToLua.PushObject(L, source);
				return 2;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.UI.LayoutUtility.GetLayoutProperty");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
