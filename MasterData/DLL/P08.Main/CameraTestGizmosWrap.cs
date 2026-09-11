using System;
using LuaInterface;
using UnityEngine;

public class CameraTestGizmosWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CameraTestGizmos), typeof(MonoBehaviour));
		L.RegFunction("SetCamera", SetCamera);
		L.RegFunction("SetLookUp", SetLookUp);
		L.RegFunction("SetDistance", SetDistance);
		L.RegFunction("AddPoint", AddPoint);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCamera(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CameraTestGizmos obj = (CameraTestGizmos)ToLua.CheckObject<CameraTestGizmos>(L, 1);
			GameObject camera = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj.SetCamera(camera);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLookUp(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CameraTestGizmos obj = (CameraTestGizmos)ToLua.CheckObject<CameraTestGizmos>(L, 1);
			GameObject lookUp = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj.SetLookUp(lookUp);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDistance(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CameraTestGizmos obj = (CameraTestGizmos)ToLua.CheckObject<CameraTestGizmos>(L, 1);
			double distance = LuaDLL.luaL_checknumber(L, 2);
			obj.SetDistance(distance);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CameraTestGizmos obj = (CameraTestGizmos)ToLua.CheckObject<CameraTestGizmos>(L, 1);
			Vector3 point = ToLua.ToVector3(L, 2);
			obj.AddPoint(point);
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
}
