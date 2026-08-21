using System;
using LuaInterface;

public class TugSkillInfoWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TugSkillInfo), null);
		L.RegFunction("New", _CreateTugSkillInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("effectType", get_effectType, set_effectType);
		L.RegVar("skillType", get_skillType, set_skillType);
		L.RegVar("nowCd", get_nowCd, set_nowCd);
		L.RegVar("cd", get_cd, set_cd);
		L.RegVar("nowSpeed", get_nowSpeed, set_nowSpeed);
		L.RegVar("speed", get_speed, set_speed);
		L.RegVar("AddSpeedA", get_AddSpeedA, set_AddSpeedA);
		L.RegVar("cost", get_cost, set_cost);
		L.RegVar("isEffect", get_isEffect, set_isEffect);
		L.RegVar("mistakeSpeed", get_mistakeSpeed, set_mistakeSpeed);
		L.RegVar("mistakeAddSpeedA", get_mistakeAddSpeedA, set_mistakeAddSpeedA);
		L.RegVar("rightSpeed", get_rightSpeed, set_rightSpeed);
		L.RegVar("rightAddSpeedA", get_rightAddSpeedA, set_rightAddSpeedA);
		L.RegVar("nowQteSpeed", get_nowQteSpeed, set_nowQteSpeed);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateTugSkillInfo(IntPtr L)
	{
		ToLua.PushValue(L, default(TugSkillInfo));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_effectType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int effectType = ((TugSkillInfo)obj).effectType;
			LuaDLL.lua_pushinteger(L, effectType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index effectType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skillType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int skillType = ((TugSkillInfo)obj).skillType;
			LuaDLL.lua_pushinteger(L, skillType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nowCd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float nowCd = ((TugSkillInfo)obj).nowCd;
			LuaDLL.lua_pushnumber(L, nowCd);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nowCd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float cd = ((TugSkillInfo)obj).cd;
			LuaDLL.lua_pushnumber(L, cd);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nowSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float nowSpeed = ((TugSkillInfo)obj).nowSpeed;
			LuaDLL.lua_pushnumber(L, nowSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nowSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_speed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float speed = ((TugSkillInfo)obj).speed;
			LuaDLL.lua_pushnumber(L, speed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index speed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AddSpeedA(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float addSpeedA = ((TugSkillInfo)obj).AddSpeedA;
			LuaDLL.lua_pushnumber(L, addSpeedA);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AddSpeedA on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cost(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float cost = ((TugSkillInfo)obj).cost;
			LuaDLL.lua_pushnumber(L, cost);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cost on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isEffect = ((TugSkillInfo)obj).isEffect;
			LuaDLL.lua_pushboolean(L, isEffect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mistakeSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float mistakeSpeed = ((TugSkillInfo)obj).mistakeSpeed;
			LuaDLL.lua_pushnumber(L, mistakeSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mistakeSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mistakeAddSpeedA(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float mistakeAddSpeedA = ((TugSkillInfo)obj).mistakeAddSpeedA;
			LuaDLL.lua_pushnumber(L, mistakeAddSpeedA);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mistakeAddSpeedA on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rightSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float rightSpeed = ((TugSkillInfo)obj).rightSpeed;
			LuaDLL.lua_pushnumber(L, rightSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rightSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rightAddSpeedA(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float rightAddSpeedA = ((TugSkillInfo)obj).rightAddSpeedA;
			LuaDLL.lua_pushnumber(L, rightAddSpeedA);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rightAddSpeedA on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nowQteSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float nowQteSpeed = ((TugSkillInfo)obj).nowQteSpeed;
			LuaDLL.lua_pushnumber(L, nowQteSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nowQteSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_effectType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugSkillInfo tugSkillInfo = (TugSkillInfo)obj;
			int effectType = (int)LuaDLL.luaL_checknumber(L, 2);
			tugSkillInfo.effectType = effectType;
			ToLua.SetBack(L, 1, tugSkillInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index effectType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skillType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugSkillInfo tugSkillInfo = (TugSkillInfo)obj;
			int skillType = (int)LuaDLL.luaL_checknumber(L, 2);
			tugSkillInfo.skillType = skillType;
			ToLua.SetBack(L, 1, tugSkillInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nowCd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugSkillInfo tugSkillInfo = (TugSkillInfo)obj;
			float nowCd = (float)LuaDLL.luaL_checknumber(L, 2);
			tugSkillInfo.nowCd = nowCd;
			ToLua.SetBack(L, 1, tugSkillInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nowCd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cd(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugSkillInfo tugSkillInfo = (TugSkillInfo)obj;
			float cd = (float)LuaDLL.luaL_checknumber(L, 2);
			tugSkillInfo.cd = cd;
			ToLua.SetBack(L, 1, tugSkillInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cd on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nowSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugSkillInfo tugSkillInfo = (TugSkillInfo)obj;
			float nowSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			tugSkillInfo.nowSpeed = nowSpeed;
			ToLua.SetBack(L, 1, tugSkillInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nowSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_speed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugSkillInfo tugSkillInfo = (TugSkillInfo)obj;
			float speed = (float)LuaDLL.luaL_checknumber(L, 2);
			tugSkillInfo.speed = speed;
			ToLua.SetBack(L, 1, tugSkillInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index speed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AddSpeedA(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugSkillInfo tugSkillInfo = (TugSkillInfo)obj;
			float addSpeedA = (float)LuaDLL.luaL_checknumber(L, 2);
			tugSkillInfo.AddSpeedA = addSpeedA;
			ToLua.SetBack(L, 1, tugSkillInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AddSpeedA on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cost(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugSkillInfo tugSkillInfo = (TugSkillInfo)obj;
			float cost = (float)LuaDLL.luaL_checknumber(L, 2);
			tugSkillInfo.cost = cost;
			ToLua.SetBack(L, 1, tugSkillInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cost on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugSkillInfo tugSkillInfo = (TugSkillInfo)obj;
			bool isEffect = LuaDLL.luaL_checkboolean(L, 2);
			tugSkillInfo.isEffect = isEffect;
			ToLua.SetBack(L, 1, tugSkillInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mistakeSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugSkillInfo tugSkillInfo = (TugSkillInfo)obj;
			float mistakeSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			tugSkillInfo.mistakeSpeed = mistakeSpeed;
			ToLua.SetBack(L, 1, tugSkillInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mistakeSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mistakeAddSpeedA(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugSkillInfo tugSkillInfo = (TugSkillInfo)obj;
			float mistakeAddSpeedA = (float)LuaDLL.luaL_checknumber(L, 2);
			tugSkillInfo.mistakeAddSpeedA = mistakeAddSpeedA;
			ToLua.SetBack(L, 1, tugSkillInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mistakeAddSpeedA on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rightSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugSkillInfo tugSkillInfo = (TugSkillInfo)obj;
			float rightSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			tugSkillInfo.rightSpeed = rightSpeed;
			ToLua.SetBack(L, 1, tugSkillInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rightSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rightAddSpeedA(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugSkillInfo tugSkillInfo = (TugSkillInfo)obj;
			float rightAddSpeedA = (float)LuaDLL.luaL_checknumber(L, 2);
			tugSkillInfo.rightAddSpeedA = rightAddSpeedA;
			ToLua.SetBack(L, 1, tugSkillInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rightAddSpeedA on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nowQteSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TugSkillInfo tugSkillInfo = (TugSkillInfo)obj;
			float nowQteSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			tugSkillInfo.nowQteSpeed = nowQteSpeed;
			ToLua.SetBack(L, 1, tugSkillInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nowQteSpeed on a nil value");
		}
	}
}
