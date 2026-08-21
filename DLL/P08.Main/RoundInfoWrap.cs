using System;
using LuaInterface;

public class RoundInfoWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RoundInfo), typeof(object));
		L.RegFunction("New", _CreateRoundInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("sequence_id", get_sequence_id, set_sequence_id);
		L.RegVar("is_special", get_is_special, set_is_special);
		L.RegVar("battle_times", get_battle_times, set_battle_times);
		L.RegVar("hit_num", get_hit_num, set_hit_num);
		L.RegVar("remove_num", get_remove_num, set_remove_num);
		L.RegVar("activeSkillUseCount", get_activeSkillUseCount, set_activeSkillUseCount);
		L.RegVar("enemyHurt", get_enemyHurt, set_enemyHurt);
		L.RegVar("affectHurt", get_affectHurt, set_affectHurt);
		L.RegVar("leftEnemyCount", get_leftEnemyCount, set_leftEnemyCount);
		L.RegVar("leftEnemyWaveHp", get_leftEnemyWaveHp, set_leftEnemyWaveHp);
		L.RegVar("leftPlayerHp", get_leftPlayerHp, set_leftPlayerHp);
		L.RegVar("debateProgress", get_debateProgress, set_debateProgress);
		L.RegVar("debateResult", get_debateResult, set_debateResult);
		L.RegVar("useSceond", get_useSceond, set_useSceond);
		L.RegVar("startTime", get_startTime, set_startTime);
		L.RegVar("different_skill_num", get_different_skill_num, set_different_skill_num);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateRoundInfo(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				RoundInfo o = new RoundInfo();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: RoundInfo.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sequence_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int sequence_id = ((RoundInfo)obj).sequence_id;
			LuaDLL.lua_pushinteger(L, sequence_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sequence_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_is_special(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool is_special = ((RoundInfo)obj).is_special;
			LuaDLL.lua_pushboolean(L, is_special);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index is_special on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_battle_times(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int battle_times = ((RoundInfo)obj).battle_times;
			LuaDLL.lua_pushinteger(L, battle_times);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index battle_times on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hit_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int hit_num = ((RoundInfo)obj).hit_num;
			LuaDLL.lua_pushinteger(L, hit_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hit_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_remove_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int remove_num = ((RoundInfo)obj).remove_num;
			LuaDLL.lua_pushinteger(L, remove_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index remove_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_activeSkillUseCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] activeSkillUseCount = ((RoundInfo)obj).activeSkillUseCount;
			ToLua.Push(L, activeSkillUseCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index activeSkillUseCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enemyHurt(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int enemyHurt = ((RoundInfo)obj).enemyHurt;
			LuaDLL.lua_pushinteger(L, enemyHurt);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enemyHurt on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_affectHurt(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int affectHurt = ((RoundInfo)obj).affectHurt;
			LuaDLL.lua_pushinteger(L, affectHurt);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index affectHurt on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_leftEnemyCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int leftEnemyCount = ((RoundInfo)obj).leftEnemyCount;
			LuaDLL.lua_pushinteger(L, leftEnemyCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index leftEnemyCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_leftEnemyWaveHp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int leftEnemyWaveHp = ((RoundInfo)obj).leftEnemyWaveHp;
			LuaDLL.lua_pushinteger(L, leftEnemyWaveHp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index leftEnemyWaveHp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_leftPlayerHp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int leftPlayerHp = ((RoundInfo)obj).leftPlayerHp;
			LuaDLL.lua_pushinteger(L, leftPlayerHp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index leftPlayerHp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_debateProgress(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float debateProgress = ((RoundInfo)obj).debateProgress;
			LuaDLL.lua_pushnumber(L, debateProgress);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateProgress on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_debateResult(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int debateResult = ((RoundInfo)obj).debateResult;
			LuaDLL.lua_pushinteger(L, debateResult);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateResult on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useSceond(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float useSceond = ((RoundInfo)obj).useSceond;
			LuaDLL.lua_pushnumber(L, useSceond);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useSceond on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float startTime = ((RoundInfo)obj).startTime;
			LuaDLL.lua_pushnumber(L, startTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_different_skill_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int different_skill_num = ((RoundInfo)obj).different_skill_num;
			LuaDLL.lua_pushinteger(L, different_skill_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index different_skill_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sequence_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoundInfo obj2 = (RoundInfo)obj;
			int sequence_id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.sequence_id = sequence_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sequence_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_is_special(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoundInfo obj2 = (RoundInfo)obj;
			bool is_special = LuaDLL.luaL_checkboolean(L, 2);
			obj2.is_special = is_special;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index is_special on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_battle_times(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoundInfo obj2 = (RoundInfo)obj;
			int battle_times = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.battle_times = battle_times;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index battle_times on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hit_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoundInfo obj2 = (RoundInfo)obj;
			int hit_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.hit_num = hit_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hit_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_remove_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoundInfo obj2 = (RoundInfo)obj;
			int remove_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.remove_num = remove_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index remove_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_activeSkillUseCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoundInfo obj2 = (RoundInfo)obj;
			int[] activeSkillUseCount = ToLua.CheckNumberArray<int>(L, 2);
			obj2.activeSkillUseCount = activeSkillUseCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index activeSkillUseCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enemyHurt(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoundInfo obj2 = (RoundInfo)obj;
			int enemyHurt = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.enemyHurt = enemyHurt;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enemyHurt on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_affectHurt(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoundInfo obj2 = (RoundInfo)obj;
			int affectHurt = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.affectHurt = affectHurt;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index affectHurt on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_leftEnemyCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoundInfo obj2 = (RoundInfo)obj;
			int leftEnemyCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.leftEnemyCount = leftEnemyCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index leftEnemyCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_leftEnemyWaveHp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoundInfo obj2 = (RoundInfo)obj;
			int leftEnemyWaveHp = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.leftEnemyWaveHp = leftEnemyWaveHp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index leftEnemyWaveHp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_leftPlayerHp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoundInfo obj2 = (RoundInfo)obj;
			int leftPlayerHp = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.leftPlayerHp = leftPlayerHp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index leftPlayerHp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_debateProgress(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoundInfo obj2 = (RoundInfo)obj;
			float debateProgress = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.debateProgress = debateProgress;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateProgress on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_debateResult(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoundInfo obj2 = (RoundInfo)obj;
			int debateResult = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.debateResult = debateResult;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateResult on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useSceond(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoundInfo obj2 = (RoundInfo)obj;
			float useSceond = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.useSceond = useSceond;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useSceond on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoundInfo obj2 = (RoundInfo)obj;
			float startTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.startTime = startTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_different_skill_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoundInfo obj2 = (RoundInfo)obj;
			int different_skill_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.different_skill_num = different_skill_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index different_skill_num on a nil value");
		}
	}
}
