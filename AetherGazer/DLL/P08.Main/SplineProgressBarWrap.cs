using System;
using LuaInterface;
using UnityEngine;

public class SplineProgressBarWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SplineProgressBar), typeof(MonoBehaviour));
		L.RegFunction("GetValue", GetValue);
		L.RegFunction("SetValue", SetValue);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("spline", get_spline, set_spline);
		L.RegVar("container", get_container, set_container);
		L.RegVar("handle", get_handle, set_handle);
		L.RegVar("ProgressValue", get_ProgressValue, set_ProgressValue);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float value = ((SplineProgressBar)ToLua.CheckObject<SplineProgressBar>(L, 1)).GetValue();
			LuaDLL.lua_pushnumber(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SplineProgressBar obj = (SplineProgressBar)ToLua.CheckObject<SplineProgressBar>(L, 1);
			float value = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.SetValue(value);
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
	private static int get_spline(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BezierSpline spline = ((SplineProgressBar)obj).spline;
			ToLua.Push(L, spline);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spline on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_container(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform container = ((SplineProgressBar)obj).container;
			ToLua.PushSealed(L, container);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index container on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_handle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform handle = ((SplineProgressBar)obj).handle;
			ToLua.PushSealed(L, handle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ProgressValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float progressValue = ((SplineProgressBar)obj).ProgressValue;
			LuaDLL.lua_pushnumber(L, progressValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ProgressValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spline(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SplineProgressBar obj2 = (SplineProgressBar)obj;
			BezierSpline spline = (BezierSpline)ToLua.CheckObject<BezierSpline>(L, 2);
			obj2.spline = spline;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spline on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_container(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SplineProgressBar obj2 = (SplineProgressBar)obj;
			RectTransform container = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.container = container;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index container on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_handle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SplineProgressBar obj2 = (SplineProgressBar)obj;
			RectTransform handle = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.handle = handle;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ProgressValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SplineProgressBar obj2 = (SplineProgressBar)obj;
			float progressValue = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.ProgressValue = progressValue;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ProgressValue on a nil value");
		}
	}
}
