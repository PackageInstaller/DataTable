using System;
using LuaInterface;
using UnityEngine;

public class QWorldUIWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QWorldUI), typeof(MonoBehaviour));
		L.RegFunction("SetCameraControlActive", SetCameraControlActive);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("bubbleCanvas", get_bubbleCanvas, set_bubbleCanvas);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCameraControlActive(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldUI obj = (QWorldUI)ToLua.CheckObject<QWorldUI>(L, 1);
			bool cameraControlActive = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetCameraControlActive(cameraControlActive);
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
	private static int get_bubbleCanvas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform bubbleCanvas = ((QWorldUI)obj).bubbleCanvas;
			ToLua.PushSealed(L, bubbleCanvas);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bubbleCanvas on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bubbleCanvas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldUI obj2 = (QWorldUI)obj;
			RectTransform bubbleCanvas = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.bubbleCanvas = bubbleCanvas;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bubbleCanvas on a nil value");
		}
	}
}
