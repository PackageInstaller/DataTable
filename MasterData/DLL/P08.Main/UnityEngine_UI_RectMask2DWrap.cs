using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UnityEngine_UI_RectMask2DWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RectMask2D), typeof(UIBehaviour));
		L.RegFunction("IsRaycastLocationValid", IsRaycastLocationValid);
		L.RegFunction("PerformClipping", PerformClipping);
		L.RegFunction("UpdateClipSoftness", UpdateClipSoftness);
		L.RegFunction("AddClippable", AddClippable);
		L.RegFunction("RemoveClippable", RemoveClippable);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("padding", get_padding, set_padding);
		L.RegVar("softness", get_softness, set_softness);
		L.RegVar("canvasRect", get_canvasRect, null);
		L.RegVar("rectTransform", get_rectTransform, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsRaycastLocationValid(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RectMask2D obj = (RectMask2D)ToLua.CheckObject<RectMask2D>(L, 1);
			Vector2 sp = ToLua.ToVector2(L, 2);
			Camera eventCamera = (Camera)ToLua.CheckObject(L, 3, typeof(Camera));
			bool value = obj.IsRaycastLocationValid(sp, eventCamera);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PerformClipping(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RectMask2D)ToLua.CheckObject<RectMask2D>(L, 1)).PerformClipping();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateClipSoftness(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((RectMask2D)ToLua.CheckObject<RectMask2D>(L, 1)).UpdateClipSoftness();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddClippable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectMask2D obj = (RectMask2D)ToLua.CheckObject<RectMask2D>(L, 1);
			IClippable clippable = (IClippable)ToLua.CheckObject<IClippable>(L, 2);
			obj.AddClippable(clippable);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveClippable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectMask2D obj = (RectMask2D)ToLua.CheckObject<RectMask2D>(L, 1);
			IClippable clippable = (IClippable)ToLua.CheckObject<IClippable>(L, 2);
			obj.RemoveClippable(clippable);
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
	private static int get_padding(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector4 padding = ((RectMask2D)obj).padding;
			ToLua.Push(L, padding);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index padding on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_softness(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2Int softness = ((RectMask2D)obj).softness;
			ToLua.PushValue(L, softness);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index softness on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canvasRect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rect canvasRect = ((RectMask2D)obj).canvasRect;
			ToLua.PushValue(L, canvasRect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canvasRect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rectTransform(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform rectTransform = ((RectMask2D)obj).rectTransform;
			ToLua.PushSealed(L, rectTransform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rectTransform on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_padding(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectMask2D obj2 = (RectMask2D)obj;
			Vector4 padding = ToLua.ToVector4(L, 2);
			obj2.padding = padding;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index padding on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_softness(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectMask2D obj2 = (RectMask2D)obj;
			Vector2Int softness = StackTraits<Vector2Int>.Check(L, 2);
			obj2.softness = softness;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index softness on a nil value");
		}
	}
}
