using System;
using LuaInterface;
using UnityEngine;

public class PinballRoleBattleDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PinballRoleBattleData), typeof(object));
		L.RegFunction("New", _CreatePinballRoleBattleData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("model", get_model, set_model);
		L.RegVar("maxHealth", get_maxHealth, set_maxHealth);
		L.RegVar("health", get_health, set_health);
		L.RegVar("attack", get_attack, set_attack);
		L.RegVar("abilityPower", get_abilityPower, set_abilityPower);
		L.RegVar("maxSkillPoint", get_maxSkillPoint, set_maxSkillPoint);
		L.RegVar("skillPoint", get_skillPoint, set_skillPoint);
		L.RegVar("skillPointRestore", get_skillPointRestore, set_skillPointRestore);
		L.RegVar("spawnOffset", get_spawnOffset, set_spawnOffset);
		L.RegVar("skillList", get_skillList, set_skillList);
		L.RegVar("actionLoop", get_actionLoop, set_actionLoop);
		L.RegVar("actionTimes", get_actionTimes, set_actionTimes);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreatePinballRoleBattleData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				PinballRoleBattleData o = new PinballRoleBattleData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: PinballRoleBattleData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_model(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string model = ((PinballRoleBattleData)obj).model;
			LuaDLL.lua_pushstring(L, model);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index model on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxHealth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float maxHealth = ((PinballRoleBattleData)obj).maxHealth;
			LuaDLL.lua_pushnumber(L, maxHealth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxHealth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_health(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float health = ((PinballRoleBattleData)obj).health;
			LuaDLL.lua_pushnumber(L, health);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index health on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_attack(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float attack = ((PinballRoleBattleData)obj).attack;
			LuaDLL.lua_pushnumber(L, attack);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index attack on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_abilityPower(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float abilityPower = ((PinballRoleBattleData)obj).abilityPower;
			LuaDLL.lua_pushnumber(L, abilityPower);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index abilityPower on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxSkillPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float maxSkillPoint = ((PinballRoleBattleData)obj).maxSkillPoint;
			LuaDLL.lua_pushnumber(L, maxSkillPoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxSkillPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skillPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float skillPoint = ((PinballRoleBattleData)obj).skillPoint;
			LuaDLL.lua_pushnumber(L, skillPoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skillPointRestore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float skillPointRestore = ((PinballRoleBattleData)obj).skillPointRestore;
			LuaDLL.lua_pushnumber(L, skillPointRestore);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillPointRestore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spawnOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 spawnOffset = ((PinballRoleBattleData)obj).spawnOffset;
			ToLua.Push(L, spawnOffset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spawnOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skillList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleSkillData[] skillList = ((PinballRoleBattleData)obj).skillList;
			ToLua.Push(L, skillList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_actionLoop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[][] actionLoop = ((PinballRoleBattleData)obj).actionLoop;
			ToLua.Push(L, actionLoop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index actionLoop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_actionTimes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int actionTimes = ((PinballRoleBattleData)obj).actionTimes;
			LuaDLL.lua_pushinteger(L, actionTimes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index actionTimes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_model(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleBattleData obj2 = (PinballRoleBattleData)obj;
			string model = ToLua.CheckString(L, 2);
			obj2.model = model;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index model on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxHealth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleBattleData obj2 = (PinballRoleBattleData)obj;
			float maxHealth = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxHealth = maxHealth;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxHealth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_health(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleBattleData obj2 = (PinballRoleBattleData)obj;
			float health = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.health = health;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index health on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_attack(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleBattleData obj2 = (PinballRoleBattleData)obj;
			float attack = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.attack = attack;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index attack on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_abilityPower(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleBattleData obj2 = (PinballRoleBattleData)obj;
			float abilityPower = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.abilityPower = abilityPower;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index abilityPower on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxSkillPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleBattleData obj2 = (PinballRoleBattleData)obj;
			float maxSkillPoint = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxSkillPoint = maxSkillPoint;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxSkillPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skillPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleBattleData obj2 = (PinballRoleBattleData)obj;
			float skillPoint = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.skillPoint = skillPoint;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skillPointRestore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleBattleData obj2 = (PinballRoleBattleData)obj;
			float skillPointRestore = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.skillPointRestore = skillPointRestore;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillPointRestore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spawnOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleBattleData obj2 = (PinballRoleBattleData)obj;
			Vector3 spawnOffset = ToLua.ToVector3(L, 2);
			obj2.spawnOffset = spawnOffset;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spawnOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skillList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleBattleData obj2 = (PinballRoleBattleData)obj;
			PinballRoleSkillData[] skillList = ToLua.CheckObjectArray<PinballRoleSkillData>(L, 2);
			obj2.skillList = skillList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_actionLoop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleBattleData obj2 = (PinballRoleBattleData)obj;
			int[][] actionLoop = ToLua.CheckObjectArray<int[]>(L, 2);
			obj2.actionLoop = actionLoop;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index actionLoop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_actionTimes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballRoleBattleData obj2 = (PinballRoleBattleData)obj;
			int actionTimes = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.actionTimes = actionTimes;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index actionTimes on a nil value");
		}
	}
}
