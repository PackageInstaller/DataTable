using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

public class UnityEngine_Pipelines_SimPipeline_CanvasManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CanvasManager), typeof(object));
		L.RegFunction("RotateScreen", RotateScreen);
		L.RegFunction("GetUIResolution", GetUIResolution);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Instance", get_Instance, null);
		L.RegVar("uiCamera", get_uiCamera, null);
		L.RegVar("uiDistance", get_uiDistance, set_uiDistance);
		L.RegVar("canvasPosition", get_canvasPosition, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RotateScreen(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CanvasManager obj = (CanvasManager)ToLua.CheckObject(L, 1, typeof(CanvasManager));
			bool isPortrait = LuaDLL.luaL_checkboolean(L, 2);
			obj.RotateScreen(isPortrait);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetUIResolution(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CanvasManager obj = (CanvasManager)ToLua.CheckObject(L, 1, typeof(CanvasManager));
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			CanvasAddition uIResolution = obj.GetUIResolution(index);
			ToLua.Push(L, uIResolution);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, CanvasManager.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uiCamera(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Camera uiCamera = ((CanvasManager)obj).uiCamera;
			ToLua.PushSealed(L, uiCamera);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiCamera on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uiDistance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float uiDistance = ((CanvasManager)obj).uiDistance;
			LuaDLL.lua_pushnumber(L, uiDistance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiDistance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canvasPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 canvasPosition = ((CanvasManager)obj).canvasPosition;
			ToLua.Push(L, canvasPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canvasPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uiDistance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CanvasManager obj2 = (CanvasManager)obj;
			float uiDistance = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.uiDistance = uiDistance;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uiDistance on a nil value");
		}
	}
}
