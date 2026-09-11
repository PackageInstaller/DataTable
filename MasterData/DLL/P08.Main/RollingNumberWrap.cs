using System;
using LuaInterface;
using UnityEngine;

public class RollingNumberWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RollingNumber), typeof(MonoBehaviour));
		L.RegFunction("ScrollTo", ScrollTo);
		L.RegFunction("SetValueImmediate", SetValueImmediate);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("alignment", get_alignment, set_alignment);
		L.RegVar("font", get_font, set_font);
		L.RegVar("fontSize", get_fontSize, set_fontSize);
		L.RegVar("textColor", get_textColor, set_textColor);
		L.RegVar("singleRollDuration", get_singleRollDuration, set_singleRollDuration);
		L.RegVar("staggerDelay", get_staggerDelay, set_staggerDelay);
		L.RegVar("prewarmDigits", get_prewarmDigits, set_prewarmDigits);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ScrollTo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RollingNumber obj = (RollingNumber)ToLua.CheckObject<RollingNumber>(L, 1);
			int targetValue = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.ScrollTo(targetValue);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetValueImmediate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RollingNumber obj = (RollingNumber)ToLua.CheckObject<RollingNumber>(L, 1);
			int valueImmediate = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetValueImmediate(valueImmediate);
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
	private static int get_alignment(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RollingNumber.RollAlignment alignment = ((RollingNumber)obj).alignment;
			ToLua.Push(L, alignment);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index alignment on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_font(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Font font = ((RollingNumber)obj).font;
			ToLua.PushSealed(L, font);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index font on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fontSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int fontSize = ((RollingNumber)obj).fontSize;
			LuaDLL.lua_pushinteger(L, fontSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fontSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_textColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color textColor = ((RollingNumber)obj).textColor;
			ToLua.Push(L, textColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index textColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_singleRollDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float singleRollDuration = ((RollingNumber)obj).singleRollDuration;
			LuaDLL.lua_pushnumber(L, singleRollDuration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index singleRollDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_staggerDelay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float staggerDelay = ((RollingNumber)obj).staggerDelay;
			LuaDLL.lua_pushnumber(L, staggerDelay);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index staggerDelay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_prewarmDigits(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int prewarmDigits = ((RollingNumber)obj).prewarmDigits;
			LuaDLL.lua_pushinteger(L, prewarmDigits);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index prewarmDigits on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_alignment(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RollingNumber obj2 = (RollingNumber)obj;
			RollingNumber.RollAlignment alignment = (RollingNumber.RollAlignment)ToLua.CheckObject(L, 2, typeof(RollingNumber.RollAlignment));
			obj2.alignment = alignment;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index alignment on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_font(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RollingNumber obj2 = (RollingNumber)obj;
			Font font = (Font)ToLua.CheckObject(L, 2, typeof(Font));
			obj2.font = font;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index font on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fontSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RollingNumber obj2 = (RollingNumber)obj;
			int fontSize = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.fontSize = fontSize;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fontSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_textColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RollingNumber obj2 = (RollingNumber)obj;
			Color textColor = ToLua.ToColor(L, 2);
			obj2.textColor = textColor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index textColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_singleRollDuration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RollingNumber obj2 = (RollingNumber)obj;
			float singleRollDuration = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.singleRollDuration = singleRollDuration;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index singleRollDuration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_staggerDelay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RollingNumber obj2 = (RollingNumber)obj;
			float staggerDelay = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.staggerDelay = staggerDelay;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index staggerDelay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_prewarmDigits(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RollingNumber obj2 = (RollingNumber)obj;
			int prewarmDigits = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.prewarmDigits = prewarmDigits;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index prewarmDigits on a nil value");
		}
	}
}
