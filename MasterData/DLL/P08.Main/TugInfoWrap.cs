using System;
using LuaInterface;

public class TugInfoWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TugInfo), null);
		L.RegFunction("New", _CreateTugInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("constSpeed", get_constSpeed, set_constSpeed);
		L.RegVar("angerStart", get_angerStart, set_angerStart);
		L.RegVar("angerAddSpeed", get_angerAddSpeed, set_angerAddSpeed);
		L.RegVar("angerMax", get_angerMax, set_angerMax);
		L.RegVar("angerDecay", get_angerDecay, set_angerDecay);
		L.RegVar("superAttackTimes", get_superAttackTimes, set_superAttackTimes);
		L.RegVar("skillASpeed", get_skillASpeed, set_skillASpeed);
		L.RegVar("skillBSpeed", get_skillBSpeed, set_skillBSpeed);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateTugInfo(IntPtr L)
	{
		ToLua.PushValue(L, default(TugInfo));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_constSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float constSpeed = ((TugInfo)obj).constSpeed;
			LuaDLL.lua_pushnumber(L, constSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index constSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_angerStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float angerStart = ((TugInfo)obj).angerStart;
			LuaDLL.lua_pushnumber(L, angerStart);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index angerStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_angerAddSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float angerAddSpeed = ((TugInfo)obj).angerAddSpeed;
			LuaDLL.lua_pushnumber(L, angerAddSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index angerAddSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_angerMax(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float angerMax = ((TugInfo)obj).angerMax;
			LuaDLL.lua_pushnumber(L, angerMax);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index angerMax on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_angerDecay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float angerDecay = ((TugInfo)obj).angerDecay;
			LuaDLL.lua_pushnumber(L, angerDecay);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index angerDecay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_superAttackTimes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int superAttackTimes = ((TugInfo)obj).superAttackTimes;
			LuaDLL.lua_pushinteger(L, superAttackTimes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index superAttackTimes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skillASpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float skillASpeed = ((TugInfo)obj).skillASpeed;
			LuaDLL.lua_pushnumber(L, skillASpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillASpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skillBSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float skillBSpeed = ((TugInfo)obj).skillBSpeed;
			LuaDLL.lua_pushnumber(L, skillBSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillBSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_constSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugInfo tugInfo = (TugInfo)obj;
			float constSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			tugInfo.constSpeed = constSpeed;
			ToLua.SetBack(L, 1, tugInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index constSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_angerStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugInfo tugInfo = (TugInfo)obj;
			float angerStart = (float)LuaDLL.luaL_checknumber(L, 2);
			tugInfo.angerStart = angerStart;
			ToLua.SetBack(L, 1, tugInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index angerStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_angerAddSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugInfo tugInfo = (TugInfo)obj;
			float angerAddSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			tugInfo.angerAddSpeed = angerAddSpeed;
			ToLua.SetBack(L, 1, tugInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index angerAddSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_angerMax(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugInfo tugInfo = (TugInfo)obj;
			float angerMax = (float)LuaDLL.luaL_checknumber(L, 2);
			tugInfo.angerMax = angerMax;
			ToLua.SetBack(L, 1, tugInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index angerMax on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_angerDecay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugInfo tugInfo = (TugInfo)obj;
			float angerDecay = (float)LuaDLL.luaL_checknumber(L, 2);
			tugInfo.angerDecay = angerDecay;
			ToLua.SetBack(L, 1, tugInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index angerDecay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_superAttackTimes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugInfo tugInfo = (TugInfo)obj;
			int superAttackTimes = (int)LuaDLL.luaL_checknumber(L, 2);
			tugInfo.superAttackTimes = superAttackTimes;
			ToLua.SetBack(L, 1, tugInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index superAttackTimes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skillASpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugInfo tugInfo = (TugInfo)obj;
			float skillASpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			tugInfo.skillASpeed = skillASpeed;
			ToLua.SetBack(L, 1, tugInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillASpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skillBSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugInfo tugInfo = (TugInfo)obj;
			float skillBSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			tugInfo.skillBSpeed = skillBSpeed;
			ToLua.SetBack(L, 1, tugInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillBSpeed on a nil value");
		}
	}
}
