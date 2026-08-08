using System;
using LuaInterface;
using UnityEngine;
using pachinko;

public class pachinko_PaChinKoTriggerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PaChinKoTrigger), typeof(MonoBehaviour));
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("onTriggerFun", get_onTriggerFun, set_onTriggerFun);
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
	private static int get_onTriggerFun(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action onTriggerFun = ((PaChinKoTrigger)obj).onTriggerFun;
			ToLua.Push(L, onTriggerFun);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onTriggerFun on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onTriggerFun(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaChinKoTrigger obj2 = (PaChinKoTrigger)obj;
			Action onTriggerFun = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.onTriggerFun = onTriggerFun;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onTriggerFun on a nil value");
		}
	}
}
