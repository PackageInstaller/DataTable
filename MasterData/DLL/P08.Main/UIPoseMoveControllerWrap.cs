using System;
using LuaInterface;
using UnityEngine;

public class UIPoseMoveControllerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UIPoseMoveController), typeof(MonoBehaviour));
		L.RegFunction("UpdateDict", UpdateDict);
		L.RegFunction("GetInitPosition", GetInitPosition);
		L.RegFunction("GetInitRotation", GetInitRotation);
		L.RegFunction("GetCameraPosition", GetCameraPosition);
		L.RegFunction("GetCameraRotation", GetCameraRotation);
		L.RegFunction("GetCameraFOV", GetCameraFOV);
		L.RegFunction("GetTweenTime", GetTweenTime);
		L.RegFunction("PlayAction", PlayAction);
		L.RegFunction("SetLastKey", SetLastKey);
		L.RegFunction("TryPlayAction", TryPlayAction);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("UIPoseMoveDataRoot", get_UIPoseMoveDataRoot, set_UIPoseMoveDataRoot);
		L.RegVar("mPreviewIndex", get_mPreviewIndex, set_mPreviewIndex);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateDict(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UIPoseMoveController)ToLua.CheckObject<UIPoseMoveController>(L, 1)).UpdateDict();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetInitPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 initPosition = ((UIPoseMoveController)ToLua.CheckObject<UIPoseMoveController>(L, 1)).GetInitPosition();
			ToLua.Push(L, initPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetInitRotation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 initRotation = ((UIPoseMoveController)ToLua.CheckObject<UIPoseMoveController>(L, 1)).GetInitRotation();
			ToLua.Push(L, initRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCameraPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 cameraPosition = ((UIPoseMoveController)ToLua.CheckObject<UIPoseMoveController>(L, 1)).GetCameraPosition();
			ToLua.Push(L, cameraPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCameraRotation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 cameraRotation = ((UIPoseMoveController)ToLua.CheckObject<UIPoseMoveController>(L, 1)).GetCameraRotation();
			ToLua.Push(L, cameraRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCameraFOV(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float cameraFOV = ((UIPoseMoveController)ToLua.CheckObject<UIPoseMoveController>(L, 1)).GetCameraFOV();
			LuaDLL.lua_pushnumber(L, cameraFOV);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTweenTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float tweenTime = ((UIPoseMoveController)ToLua.CheckObject<UIPoseMoveController>(L, 1)).GetTweenTime();
			LuaDLL.lua_pushnumber(L, tweenTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayAction(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIPoseMoveController obj = (UIPoseMoveController)ToLua.CheckObject<UIPoseMoveController>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.PlayAction(index);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLastKey(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIPoseMoveController obj = (UIPoseMoveController)ToLua.CheckObject<UIPoseMoveController>(L, 1);
			string lastKey = ToLua.CheckString(L, 2);
			obj.SetLastKey(lastKey);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TryPlayAction(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIPoseMoveController obj = (UIPoseMoveController)ToLua.CheckObject<UIPoseMoveController>(L, 1);
			string key = ToLua.CheckString(L, 2);
			bool value = obj.TryPlayAction(key);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
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
	private static int get_UIPoseMoveDataRoot(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIPoseMoveDataRoot uIPoseMoveDataRoot = ((UIPoseMoveController)obj).UIPoseMoveDataRoot;
			ToLua.Push(L, uIPoseMoveDataRoot);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index UIPoseMoveDataRoot on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mPreviewIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int mPreviewIndex = ((UIPoseMoveController)obj).mPreviewIndex;
			LuaDLL.lua_pushinteger(L, mPreviewIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mPreviewIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_UIPoseMoveDataRoot(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIPoseMoveController obj2 = (UIPoseMoveController)obj;
			UIPoseMoveDataRoot uIPoseMoveDataRoot = (UIPoseMoveDataRoot)ToLua.CheckObject<UIPoseMoveDataRoot>(L, 2);
			obj2.UIPoseMoveDataRoot = uIPoseMoveDataRoot;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index UIPoseMoveDataRoot on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mPreviewIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIPoseMoveController obj2 = (UIPoseMoveController)obj;
			int mPreviewIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.mPreviewIndex = mPreviewIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mPreviewIndex on a nil value");
		}
	}
}
