using System;
using System.Collections.Generic;
using BilliardGame;
using LuaInterface;

public class BilliardGame_BilliardGameExchangeDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(BilliardGameExchangeData), typeof(object));
		L.RegFunction("OnGameOver", OnGameOver);
		L.RegFunction("OnUseSkill", OnUseSkill);
		L.RegFunction("OnPotDamage", OnPotDamage);
		L.RegFunction("OnPotRegeneration", OnPotRegeneration);
		L.RegFunction("New", _CreateBilliardGame_BilliardGameExchangeData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("stageID", get_stageID, set_stageID);
		L.RegVar("hard", get_hard, set_hard);
		L.RegVar("result", get_result, set_result);
		L.RegVar("start_seconds", get_start_seconds, set_start_seconds);
		L.RegVar("use_seconds", get_use_seconds, set_use_seconds);
		L.RegVar("heroInfoList", get_heroInfoList, set_heroInfoList);
		L.RegVar("monsterInfoList", get_monsterInfoList, set_monsterInfoList);
		L.RegVar("potHp", get_potHp, set_potHp);
		L.RegVar("potDamage", get_potDamage, set_potDamage);
		L.RegVar("potRegeneration", get_potRegeneration, set_potRegeneration);
		L.RegVar("roundNum", get_roundNum, set_roundNum);
		L.RegVar("skillList", get_skillList, set_skillList);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateBilliardGame_BilliardGameExchangeData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 2)
			{
				int stageID = (int)LuaDLL.luaL_checknumber(L, 1);
				int hard = (int)LuaDLL.luaL_checknumber(L, 2);
				BilliardGameExchangeData o = new BilliardGameExchangeData(stageID, hard);
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: BilliardGame.BilliardGameExchangeData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnGameOver(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 7);
			BilliardGameExchangeData obj = (BilliardGameExchangeData)ToLua.CheckObject<BilliardGameExchangeData>(L, 1);
			int result = (int)LuaDLL.luaL_checknumber(L, 2);
			int now_seconds = (int)LuaDLL.luaL_checknumber(L, 3);
			int start_seconds = (int)LuaDLL.luaL_checknumber(L, 4);
			List<BilliardHeroOrMonsterData> heroList = (List<BilliardHeroOrMonsterData>)ToLua.CheckObject(L, 5, typeof(List<BilliardHeroOrMonsterData>));
			List<BilliardHeroOrMonsterData> monsterList = (List<BilliardHeroOrMonsterData>)ToLua.CheckObject(L, 6, typeof(List<BilliardHeroOrMonsterData>));
			int roundNum = (int)LuaDLL.luaL_checknumber(L, 7);
			obj.OnGameOver(result, now_seconds, start_seconds, heroList, monsterList, roundNum);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnUseSkill(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			BilliardGameExchangeData obj = (BilliardGameExchangeData)ToLua.CheckObject<BilliardGameExchangeData>(L, 1);
			int skillID = (int)LuaDLL.luaL_checknumber(L, 2);
			bool isAddNum = LuaDLL.luaL_checkboolean(L, 3);
			obj.OnUseSkill(skillID, isAddNum);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPotDamage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			BilliardGameExchangeData obj = (BilliardGameExchangeData)ToLua.CheckObject<BilliardGameExchangeData>(L, 1);
			int damage = (int)LuaDLL.luaL_checknumber(L, 2);
			int hp = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.OnPotDamage(damage, hp);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPotRegeneration(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			BilliardGameExchangeData obj = (BilliardGameExchangeData)ToLua.CheckObject<BilliardGameExchangeData>(L, 1);
			int regeneration = (int)LuaDLL.luaL_checknumber(L, 2);
			int hp = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.OnPotRegeneration(regeneration, hp);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stageID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int stageID = ((BilliardGameExchangeData)obj).stageID;
			LuaDLL.lua_pushinteger(L, stageID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hard(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int hard = ((BilliardGameExchangeData)obj).hard;
			LuaDLL.lua_pushinteger(L, hard);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hard on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_result(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int result = ((BilliardGameExchangeData)obj).result;
			LuaDLL.lua_pushinteger(L, result);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index result on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_start_seconds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int start_seconds = ((BilliardGameExchangeData)obj).start_seconds;
			LuaDLL.lua_pushinteger(L, start_seconds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index start_seconds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_use_seconds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int use_seconds = ((BilliardGameExchangeData)obj).use_seconds;
			LuaDLL.lua_pushinteger(L, use_seconds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index use_seconds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_heroInfoList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<BilliardHeroOrMonsterData> heroInfoList = ((BilliardGameExchangeData)obj).heroInfoList;
			ToLua.PushSealed(L, heroInfoList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index heroInfoList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_monsterInfoList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<BilliardHeroOrMonsterData> monsterInfoList = ((BilliardGameExchangeData)obj).monsterInfoList;
			ToLua.PushSealed(L, monsterInfoList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index monsterInfoList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_potHp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int potHp = ((BilliardGameExchangeData)obj).potHp;
			LuaDLL.lua_pushinteger(L, potHp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index potHp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_potDamage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int potDamage = ((BilliardGameExchangeData)obj).potDamage;
			LuaDLL.lua_pushinteger(L, potDamage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index potDamage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_potRegeneration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int potRegeneration = ((BilliardGameExchangeData)obj).potRegeneration;
			LuaDLL.lua_pushinteger(L, potRegeneration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index potRegeneration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_roundNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int roundNum = ((BilliardGameExchangeData)obj).roundNum;
			LuaDLL.lua_pushinteger(L, roundNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index roundNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skillList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<UseSkillData> skillList = ((BilliardGameExchangeData)obj).skillList;
			ToLua.PushSealed(L, skillList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stageID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BilliardGameExchangeData obj2 = (BilliardGameExchangeData)obj;
			int stageID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.stageID = stageID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hard(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BilliardGameExchangeData obj2 = (BilliardGameExchangeData)obj;
			int hard = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.hard = hard;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hard on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_result(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BilliardGameExchangeData obj2 = (BilliardGameExchangeData)obj;
			int result = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.result = result;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index result on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_start_seconds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BilliardGameExchangeData obj2 = (BilliardGameExchangeData)obj;
			int start_seconds = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.start_seconds = start_seconds;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index start_seconds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_use_seconds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BilliardGameExchangeData obj2 = (BilliardGameExchangeData)obj;
			int use_seconds = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.use_seconds = use_seconds;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index use_seconds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_heroInfoList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BilliardGameExchangeData obj2 = (BilliardGameExchangeData)obj;
			List<BilliardHeroOrMonsterData> heroInfoList = (List<BilliardHeroOrMonsterData>)ToLua.CheckObject(L, 2, typeof(List<BilliardHeroOrMonsterData>));
			obj2.heroInfoList = heroInfoList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index heroInfoList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_monsterInfoList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BilliardGameExchangeData obj2 = (BilliardGameExchangeData)obj;
			List<BilliardHeroOrMonsterData> monsterInfoList = (List<BilliardHeroOrMonsterData>)ToLua.CheckObject(L, 2, typeof(List<BilliardHeroOrMonsterData>));
			obj2.monsterInfoList = monsterInfoList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index monsterInfoList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_potHp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BilliardGameExchangeData obj2 = (BilliardGameExchangeData)obj;
			int potHp = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.potHp = potHp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index potHp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_potDamage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BilliardGameExchangeData obj2 = (BilliardGameExchangeData)obj;
			int potDamage = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.potDamage = potDamage;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index potDamage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_potRegeneration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BilliardGameExchangeData obj2 = (BilliardGameExchangeData)obj;
			int potRegeneration = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.potRegeneration = potRegeneration;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index potRegeneration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_roundNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BilliardGameExchangeData obj2 = (BilliardGameExchangeData)obj;
			int roundNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.roundNum = roundNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index roundNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skillList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BilliardGameExchangeData obj2 = (BilliardGameExchangeData)obj;
			List<UseSkillData> skillList = (List<UseSkillData>)ToLua.CheckObject(L, 2, typeof(List<UseSkillData>));
			obj2.skillList = skillList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillList on a nil value");
		}
	}
}
