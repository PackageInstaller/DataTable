using System;
using BilliardGame.Runtime;
using LuaInterface;

public class BilliardGame_Runtime_GridDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(GridData), null);
		L.RegFunction("New", _CreateBilliardGame_Runtime_GridData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Friction", get_Friction, set_Friction);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateBilliardGame_Runtime_GridData(IntPtr L)
	{
		ToLua.PushValue(L, default(GridData));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Friction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float friction = ((GridData)obj).Friction;
			LuaDLL.lua_pushnumber(L, friction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Friction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Friction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GridData gridData = (GridData)obj;
			float friction = (float)LuaDLL.luaL_checknumber(L, 2);
			gridData.Friction = friction;
			ToLua.SetBack(L, 1, gridData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Friction on a nil value");
		}
	}
}
