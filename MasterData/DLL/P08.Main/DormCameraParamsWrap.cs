using System;
using LuaInterface;
using UnityEngine;

public class DormCameraParamsWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DormCameraParams), typeof(object));
		L.RegFunction("New", _CreateDormCameraParams);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("value", get_value, set_value);
		L.RegVar("topRig", get_topRig, set_topRig);
		L.RegVar("middleRig", get_middleRig, set_middleRig);
		L.RegVar("bottomRig", get_bottomRig, set_bottomRig);
		L.RegVar("topRigInterval", get_topRigInterval, set_topRigInterval);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateDormCameraParams(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				DormCameraParams o = new DormCameraParams();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: DormCameraParams.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_value(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 value = ((DormCameraParams)obj).value;
			ToLua.Push(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index value on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_topRig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 topRig = ((DormCameraParams)obj).topRig;
			ToLua.Push(L, topRig);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index topRig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_middleRig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 middleRig = ((DormCameraParams)obj).middleRig;
			ToLua.Push(L, middleRig);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index middleRig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bottomRig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 bottomRig = ((DormCameraParams)obj).bottomRig;
			ToLua.Push(L, bottomRig);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bottomRig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_topRigInterval(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 topRigInterval = ((DormCameraParams)obj).topRigInterval;
			ToLua.Push(L, topRigInterval);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index topRigInterval on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_value(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DormCameraParams obj2 = (DormCameraParams)obj;
			Vector2 value = ToLua.ToVector2(L, 2);
			obj2.value = value;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index value on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_topRig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DormCameraParams obj2 = (DormCameraParams)obj;
			Vector2 topRig = ToLua.ToVector2(L, 2);
			obj2.topRig = topRig;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index topRig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_middleRig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DormCameraParams obj2 = (DormCameraParams)obj;
			Vector2 middleRig = ToLua.ToVector2(L, 2);
			obj2.middleRig = middleRig;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index middleRig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bottomRig(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DormCameraParams obj2 = (DormCameraParams)obj;
			Vector2 bottomRig = ToLua.ToVector2(L, 2);
			obj2.bottomRig = bottomRig;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bottomRig on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_topRigInterval(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DormCameraParams obj2 = (DormCameraParams)obj;
			Vector2 topRigInterval = ToLua.ToVector2(L, 2);
			obj2.topRigInterval = topRigInterval;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index topRigInterval on a nil value");
		}
	}
}
