using System;
using LuaInterface;
using UnityEngine;

public class ChangeEffectPlaySpeedWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ChangeEffectPlaySpeed), typeof(MonoBehaviour));
		L.RegFunction("StopSpeed", StopSpeed);
		L.RegFunction("RevertSpeed", RevertSpeed);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopSpeed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((ChangeEffectPlaySpeed)ToLua.CheckObject<ChangeEffectPlaySpeed>(L, 1)).StopSpeed();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RevertSpeed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((ChangeEffectPlaySpeed)ToLua.CheckObject<ChangeEffectPlaySpeed>(L, 1)).RevertSpeed();
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
