using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

public class UnityEngine_Pipelines_SimPipeline_CanvasAdditionWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CanvasAddition), typeof(MonoBehaviour));
		L.RegFunction("RotateScreen", RotateScreen);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("referenceResolution", get_referenceResolution, set_referenceResolution);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RotateScreen(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CanvasAddition obj = (CanvasAddition)ToLua.CheckObject<CanvasAddition>(L, 1);
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
	private static int get_referenceResolution(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Resolution referenceResolution = ((CanvasAddition)obj).referenceResolution;
			ToLua.PushValue(L, referenceResolution);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index referenceResolution on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_referenceResolution(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CanvasAddition obj2 = (CanvasAddition)obj;
			Resolution referenceResolution = StackTraits<Resolution>.Check(L, 2);
			obj2.referenceResolution = referenceResolution;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index referenceResolution on a nil value");
		}
	}
}
