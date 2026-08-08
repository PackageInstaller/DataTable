using System;
using LuaInterface;
using UnityEngine;

public class ControllerUtilWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ControllerUtil), typeof(object));
		L.RegFunction("GetController", GetController);
		L.RegFunction("GetController2D", GetController2D);
		L.RegFunction("New", _CreateControllerUtil);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateControllerUtil(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ControllerUtil o = new ControllerUtil();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ControllerUtil.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetController(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Transform target = (Transform)ToLua.CheckObject<Transform>(L, 1);
			string conName = ToLua.CheckString(L, 2);
			Controller controller = ControllerUtil.GetController(target, conName);
			ToLua.Push(L, controller);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetController2D(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Transform target = (Transform)ToLua.CheckObject<Transform>(L, 1);
			string conName = ToLua.CheckString(L, 2);
			Controller2D controller2D = ControllerUtil.GetController2D(target, conName);
			ToLua.Push(L, controller2D);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
