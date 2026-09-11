using System;
using LuaInterface;
using RogoDigital.Lipsync;
using UnityEngine;

public class RogoDigital_Lipsync_BlendSystemUserWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(BlendSystemUser), typeof(MonoBehaviour));
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("blendSystem", get_blendSystem, set_blendSystem);
		L.EndClass();
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
	private static int get_blendSystem(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BlendSystem blendSystem = ((BlendSystemUser)obj).blendSystem;
			ToLua.Push(L, blendSystem);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blendSystem on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_blendSystem(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BlendSystemUser obj2 = (BlendSystemUser)obj;
			BlendSystem blendSystem = (BlendSystem)ToLua.CheckObject<BlendSystem>(L, 2);
			obj2.blendSystem = blendSystem;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blendSystem on a nil value");
		}
	}
}
