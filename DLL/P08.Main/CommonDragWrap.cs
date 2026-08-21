using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;

public class CommonDragWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CommonDrag), typeof(MonoBehaviour));
		L.RegFunction("OnPointerDown", OnPointerDown);
		L.RegFunction("OnDrag", OnDrag);
		L.RegFunction("OnPointerUp", OnPointerUp);
		L.RegFunction("OnEndDrag", OnEndDrag);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("clampPosInCanvas", get_clampPosInCanvas, set_clampPosInCanvas);
		L.RegVar("canvas", get_canvas, set_canvas);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerDown(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CommonDrag obj = (CommonDrag)ToLua.CheckObject<CommonDrag>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerDown(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CommonDrag obj = (CommonDrag)ToLua.CheckObject<CommonDrag>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnDrag(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerUp(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CommonDrag obj = (CommonDrag)ToLua.CheckObject<CommonDrag>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerUp(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnEndDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CommonDrag obj = (CommonDrag)ToLua.CheckObject<CommonDrag>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnEndDrag(eventData);
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
	private static int get_clampPosInCanvas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool clampPosInCanvas = ((CommonDrag)obj).clampPosInCanvas;
			LuaDLL.lua_pushboolean(L, clampPosInCanvas);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clampPosInCanvas on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canvas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform canvas = ((CommonDrag)obj).canvas;
			ToLua.PushSealed(L, canvas);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canvas on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_clampPosInCanvas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CommonDrag obj2 = (CommonDrag)obj;
			bool clampPosInCanvas = LuaDLL.luaL_checkboolean(L, 2);
			obj2.clampPosInCanvas = clampPosInCanvas;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index clampPosInCanvas on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_canvas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CommonDrag obj2 = (CommonDrag)obj;
			RectTransform canvas = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.canvas = canvas;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canvas on a nil value");
		}
	}
}
