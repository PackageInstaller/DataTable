using System;
using LuaInterface;
using UnityEngine;

public class DynamicBoneHelperWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DynamicBoneHelper), typeof(MonoBehaviour));
		L.RegFunction("EnableDynamicBoneGlobal", EnableDynamicBoneGlobal);
		L.RegFunction("EnableDynamicBone", EnableDynamicBone);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnableDynamicBoneGlobal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			DynamicBoneHelper obj = (DynamicBoneHelper)ToLua.CheckObject<DynamicBoneHelper>(L, 1);
			bool enable = LuaDLL.luaL_checkboolean(L, 2);
			bool onlyByGlobal = LuaDLL.luaL_checkboolean(L, 3);
			obj.EnableDynamicBoneGlobal(enable, onlyByGlobal);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnableDynamicBone(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DynamicBoneHelper obj = (DynamicBoneHelper)ToLua.CheckObject<DynamicBoneHelper>(L, 1);
			bool enable = LuaDLL.luaL_checkboolean(L, 2);
			obj.EnableDynamicBone(enable);
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
