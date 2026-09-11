using System;
using System.Collections.Generic;
using LuaInterface;

public class BattleResultForLuaWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(BattleResultForLua), typeof(object));
		L.RegFunction("New", _CreateBattleResultForLua);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("battleId", get_battleId, set_battleId);
		L.RegVar("Result", get_Result, set_Result);
		L.RegVar("battleTime", get_battleTime, set_battleTime);
		L.RegVar("totalDeadNum", get_totalDeadNum, set_totalDeadNum);
		L.RegVar("totalHittedNum", get_totalHittedNum, set_totalHittedNum);
		L.RegVar("injuredNum", get_injuredNum, set_injuredNum);
		L.RegVar("fallDownNum", get_fallDownNum, set_fallDownNum);
		L.RegVar("knockoutNum", get_knockoutNum, set_knockoutNum);
		L.RegVar("qteExecuteCount", get_qteExecuteCount, set_qteExecuteCount);
		L.RegVar("loadMilliseconds", get_loadMilliseconds, set_loadMilliseconds);
		L.RegVar("resurrectTimes", get_resurrectTimes, set_resurrectTimes);
		L.RegVar("currentHP", get_currentHP, set_currentHP);
		L.RegVar("currentHPHero", get_currentHPHero, set_currentHPHero);
		L.RegVar("MaxHP", get_MaxHP, set_MaxHP);
		L.RegVar("items", get_items, set_items);
		L.RegVar("recordDatas", get_recordDatas, set_recordDatas);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateBattleResultForLua(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				BattleResultForLua o = new BattleResultForLua();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: BattleResultForLua.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_battleId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long battleId = ((BattleResultForLua)obj).battleId;
			LuaDLL.tolua_pushint64(L, battleId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index battleId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Result(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool result = ((BattleResultForLua)obj).Result;
			LuaDLL.lua_pushboolean(L, result);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Result on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_battleTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float battleTime = ((BattleResultForLua)obj).battleTime;
			LuaDLL.lua_pushnumber(L, battleTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index battleTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_totalDeadNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int totalDeadNum = ((BattleResultForLua)obj).totalDeadNum;
			LuaDLL.lua_pushinteger(L, totalDeadNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index totalDeadNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_totalHittedNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int totalHittedNum = ((BattleResultForLua)obj).totalHittedNum;
			LuaDLL.lua_pushinteger(L, totalHittedNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index totalHittedNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_injuredNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long injuredNum = ((BattleResultForLua)obj).injuredNum;
			LuaDLL.tolua_pushint64(L, injuredNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index injuredNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_fallDownNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int fallDownNum = ((BattleResultForLua)obj).fallDownNum;
			LuaDLL.lua_pushinteger(L, fallDownNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fallDownNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_knockoutNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int knockoutNum = ((BattleResultForLua)obj).knockoutNum;
			LuaDLL.lua_pushinteger(L, knockoutNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index knockoutNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_qteExecuteCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int qteExecuteCount = ((BattleResultForLua)obj).qteExecuteCount;
			LuaDLL.lua_pushinteger(L, qteExecuteCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index qteExecuteCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loadMilliseconds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int loadMilliseconds = ((BattleResultForLua)obj).loadMilliseconds;
			LuaDLL.lua_pushinteger(L, loadMilliseconds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loadMilliseconds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_resurrectTimes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int resurrectTimes = ((BattleResultForLua)obj).resurrectTimes;
			LuaDLL.lua_pushinteger(L, resurrectTimes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resurrectTimes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_currentHP(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<long> currentHP = ((BattleResultForLua)obj).currentHP;
			ToLua.PushSealed(L, currentHP);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentHP on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_currentHPHero(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> currentHPHero = ((BattleResultForLua)obj).currentHPHero;
			ToLua.PushSealed(L, currentHPHero);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentHPHero on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MaxHP(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<long> maxHP = ((BattleResultForLua)obj).MaxHP;
			ToLua.PushSealed(L, maxHP);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MaxHP on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_items(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<int, int> items = ((BattleResultForLua)obj).items;
			ToLua.PushSealed(L, items);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index items on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_recordDatas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<int, int> recordDatas = ((BattleResultForLua)obj).recordDatas;
			ToLua.PushSealed(L, recordDatas);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index recordDatas on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_battleId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua obj2 = (BattleResultForLua)obj;
			long battleId = LuaDLL.tolua_checkint64(L, 2);
			obj2.battleId = battleId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index battleId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Result(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua obj2 = (BattleResultForLua)obj;
			bool result = LuaDLL.luaL_checkboolean(L, 2);
			obj2.Result = result;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Result on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_battleTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua obj2 = (BattleResultForLua)obj;
			float battleTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.battleTime = battleTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index battleTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_totalDeadNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua obj2 = (BattleResultForLua)obj;
			int totalDeadNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.totalDeadNum = totalDeadNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index totalDeadNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_totalHittedNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua obj2 = (BattleResultForLua)obj;
			int totalHittedNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.totalHittedNum = totalHittedNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index totalHittedNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_injuredNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua obj2 = (BattleResultForLua)obj;
			long injuredNum = LuaDLL.tolua_checkint64(L, 2);
			obj2.injuredNum = injuredNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index injuredNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_fallDownNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua obj2 = (BattleResultForLua)obj;
			int fallDownNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.fallDownNum = fallDownNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index fallDownNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_knockoutNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua obj2 = (BattleResultForLua)obj;
			int knockoutNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.knockoutNum = knockoutNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index knockoutNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_qteExecuteCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua obj2 = (BattleResultForLua)obj;
			int qteExecuteCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.qteExecuteCount = qteExecuteCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index qteExecuteCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_loadMilliseconds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua obj2 = (BattleResultForLua)obj;
			int loadMilliseconds = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.loadMilliseconds = loadMilliseconds;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loadMilliseconds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_resurrectTimes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua obj2 = (BattleResultForLua)obj;
			int resurrectTimes = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.resurrectTimes = resurrectTimes;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resurrectTimes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_currentHP(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua obj2 = (BattleResultForLua)obj;
			List<long> currentHP = (List<long>)ToLua.CheckObject(L, 2, typeof(List<long>));
			obj2.currentHP = currentHP;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentHP on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_currentHPHero(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua obj2 = (BattleResultForLua)obj;
			List<int> currentHPHero = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.currentHPHero = currentHPHero;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentHPHero on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_MaxHP(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua obj2 = (BattleResultForLua)obj;
			List<long> maxHP = (List<long>)ToLua.CheckObject(L, 2, typeof(List<long>));
			obj2.MaxHP = maxHP;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MaxHP on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_items(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua obj2 = (BattleResultForLua)obj;
			Dictionary<int, int> items = (Dictionary<int, int>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, int>));
			obj2.items = items;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index items on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_recordDatas(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua obj2 = (BattleResultForLua)obj;
			Dictionary<int, int> recordDatas = (Dictionary<int, int>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, int>));
			obj2.recordDatas = recordDatas;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index recordDatas on a nil value");
		}
	}
}
