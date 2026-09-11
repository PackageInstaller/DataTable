using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UnityEngine_UI_ContentSizeFitterWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ContentSizeFitter), typeof(UIBehaviour));
		L.RegFunction("SetLayoutHorizontal", SetLayoutHorizontal);
		L.RegFunction("SetLayoutVertical", SetLayoutVertical);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("horizontalFit", get_horizontalFit, set_horizontalFit);
		L.RegVar("verticalFit", get_verticalFit, set_verticalFit);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLayoutHorizontal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((ContentSizeFitter)ToLua.CheckObject<ContentSizeFitter>(L, 1)).SetLayoutHorizontal();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLayoutVertical(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((ContentSizeFitter)ToLua.CheckObject<ContentSizeFitter>(L, 1)).SetLayoutVertical();
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
	private static int get_horizontalFit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ContentSizeFitter.FitMode horizontalFit = ((ContentSizeFitter)obj).horizontalFit;
			ToLua.Push(L, horizontalFit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index horizontalFit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_verticalFit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ContentSizeFitter.FitMode verticalFit = ((ContentSizeFitter)obj).verticalFit;
			ToLua.Push(L, verticalFit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index verticalFit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_horizontalFit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ContentSizeFitter obj2 = (ContentSizeFitter)obj;
			ContentSizeFitter.FitMode horizontalFit = (ContentSizeFitter.FitMode)ToLua.CheckObject(L, 2, typeof(ContentSizeFitter.FitMode));
			obj2.horizontalFit = horizontalFit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index horizontalFit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_verticalFit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ContentSizeFitter obj2 = (ContentSizeFitter)obj;
			ContentSizeFitter.FitMode verticalFit = (ContentSizeFitter.FitMode)ToLua.CheckObject(L, 2, typeof(ContentSizeFitter.FitMode));
			obj2.verticalFit = verticalFit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index verticalFit on a nil value");
		}
	}
}
