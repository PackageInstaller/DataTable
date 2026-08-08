using System;
using System.Collections.Generic;
using LuaInterface;
using NetProcol;

public class StatisticsDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(StatisticsData), typeof(object));
		L.RegFunction("ToBattleResultInfo", ToBattleResultInfo);
		L.RegFunction("New", _CreateStatisticsData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("dataForLua", get_dataForLua, set_dataForLua);
		L.RegVar("currentFrameNumber", get_currentFrameNumber, set_currentFrameNumber);
		L.RegVar("deathInfos", get_deathInfos, set_deathInfos);
		L.RegVar("hurtInfos", get_hurtInfos, set_hurtInfos);
		L.RegVar("finishedAchievement", get_finishedAchievement, set_finishedAchievement);
		L.RegVar("currentAchievement", get_currentAchievement, set_currentAchievement);
		L.RegVar("choosedEffectID", get_choosedEffectID, set_choosedEffectID);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateStatisticsData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				StatisticsData o = new StatisticsData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: StatisticsData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToBattleResultInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			BattleResultInfo o = ((StatisticsData)ToLua.CheckObject<StatisticsData>(L, 1)).ToBattleResultInfo();
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dataForLua(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleResultForLua dataForLua = ((StatisticsData)obj).dataForLua;
			ToLua.PushObject(L, dataForLua);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dataForLua on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_currentFrameNumber(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			uint currentFrameNumber = ((StatisticsData)obj).currentFrameNumber;
			LuaDLL.lua_pushnumber(L, currentFrameNumber);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentFrameNumber on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deathInfos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<DeadAgent> deathInfos = ((StatisticsData)obj).deathInfos;
			ToLua.PushSealed(L, deathInfos);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deathInfos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hurtInfos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<HurtInfo> hurtInfos = ((StatisticsData)obj).hurtInfos;
			ToLua.PushSealed(L, hurtInfos);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hurtInfos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_finishedAchievement(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> finishedAchievement = ((StatisticsData)obj).finishedAchievement;
			ToLua.PushSealed(L, finishedAchievement);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index finishedAchievement on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_currentAchievement(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> currentAchievement = ((StatisticsData)obj).currentAchievement;
			ToLua.PushSealed(L, currentAchievement);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentAchievement on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_choosedEffectID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> choosedEffectID = ((StatisticsData)obj).choosedEffectID;
			ToLua.PushSealed(L, choosedEffectID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index choosedEffectID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dataForLua(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StatisticsData obj2 = (StatisticsData)obj;
			BattleResultForLua dataForLua = (BattleResultForLua)ToLua.CheckObject<BattleResultForLua>(L, 2);
			obj2.dataForLua = dataForLua;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dataForLua on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_currentFrameNumber(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StatisticsData obj2 = (StatisticsData)obj;
			uint currentFrameNumber = (uint)LuaDLL.luaL_checknumber(L, 2);
			obj2.currentFrameNumber = currentFrameNumber;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentFrameNumber on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_deathInfos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StatisticsData obj2 = (StatisticsData)obj;
			List<DeadAgent> deathInfos = (List<DeadAgent>)ToLua.CheckObject(L, 2, typeof(List<DeadAgent>));
			obj2.deathInfos = deathInfos;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deathInfos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hurtInfos(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StatisticsData obj2 = (StatisticsData)obj;
			List<HurtInfo> hurtInfos = (List<HurtInfo>)ToLua.CheckObject(L, 2, typeof(List<HurtInfo>));
			obj2.hurtInfos = hurtInfos;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hurtInfos on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_finishedAchievement(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StatisticsData obj2 = (StatisticsData)obj;
			List<int> finishedAchievement = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.finishedAchievement = finishedAchievement;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index finishedAchievement on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_currentAchievement(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StatisticsData obj2 = (StatisticsData)obj;
			List<int> currentAchievement = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.currentAchievement = currentAchievement;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index currentAchievement on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_choosedEffectID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StatisticsData obj2 = (StatisticsData)obj;
			List<int> choosedEffectID = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.choosedEffectID = choosedEffectID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index choosedEffectID on a nil value");
		}
	}
}
