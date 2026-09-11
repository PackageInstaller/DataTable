using System;
using System.Collections.Generic;
using LuaInterface;
using Pinball.Runtime;
using UnityEngine;

public class Pinball_Runtime_StageDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(StageData), typeof(ScriptableObject));
		L.RegFunction("New", _CreatePinball_Runtime_StageData);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("polygonBlocks", get_polygonBlocks, set_polygonBlocks);
		L.RegVar("excludePolygonBlocks", get_excludePolygonBlocks, set_excludePolygonBlocks);
		L.RegVar("stageId", get_stageId, set_stageId);
		L.RegVar("resBlockNum", get_resBlockNum, set_resBlockNum);
		L.RegVar("isDebateStage", get_isDebateStage, set_isDebateStage);
		L.RegVar("isBossStage", get_isBossStage, set_isBossStage);
		L.RegVar("hasDebateStage", get_hasDebateStage, set_hasDebateStage);
		L.RegVar("debateStageData", get_debateStageData, set_debateStageData);
		L.RegVar("debateStageDamageTrigger", get_debateStageDamageTrigger, set_debateStageDamageTrigger);
		L.RegVar("overflowDamageTransFac", get_overflowDamageTransFac, set_overflowDamageTransFac);
		L.RegVar("baseOverTimes", get_baseOverTimes, set_baseOverTimes);
		L.RegVar("baseSpareTimes", get_baseSpareTimes, set_baseSpareTimes);
		L.RegVar("baseHighValueWordValue", get_baseHighValueWordValue, set_baseHighValueWordValue);
		L.RegVar("baseremainHp", get_baseremainHp, set_baseremainHp);
		L.RegVar("baseExplosionLength", get_baseExplosionLength, set_baseExplosionLength);
		L.RegVar("baseExitPortalCD", get_baseExitPortalCD, set_baseExitPortalCD);
		L.RegVar("debateRoundLimit", get_debateRoundLimit, set_debateRoundLimit);
		L.RegVar("debateFinishCount", get_debateFinishCount, set_debateFinishCount);
		L.RegVar("supplementTriggerNumber", get_supplementTriggerNumber, set_supplementTriggerNumber);
		L.RegVar("supplementMaxNumber", get_supplementMaxNumber, set_supplementMaxNumber);
		L.RegVar("debateDescription", get_debateDescription, set_debateDescription);
		L.RegVar("debateSuccessDesc", get_debateSuccessDesc, set_debateSuccessDesc);
		L.RegVar("bubbleIDList", get_bubbleIDList, set_bubbleIDList);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreatePinball_Runtime_StageData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				StageData obj = new StageData();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: Pinball.Runtime.StageData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
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
	private static int get_polygonBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<PolygonBlockData> polygonBlocks = ((StageData)obj).polygonBlocks;
			ToLua.PushSealed(L, polygonBlocks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index polygonBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_excludePolygonBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<RandomPolygon> excludePolygonBlocks = ((StageData)obj).excludePolygonBlocks;
			ToLua.PushSealed(L, excludePolygonBlocks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index excludePolygonBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stageId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int stageId = ((StageData)obj).stageId;
			LuaDLL.lua_pushinteger(L, stageId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_resBlockNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int resBlockNum = ((StageData)obj).resBlockNum;
			LuaDLL.lua_pushinteger(L, resBlockNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resBlockNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isDebateStage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isDebateStage = ((StageData)obj).isDebateStage;
			LuaDLL.lua_pushboolean(L, isDebateStage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isDebateStage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isBossStage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isBossStage = ((StageData)obj).isBossStage;
			LuaDLL.lua_pushboolean(L, isBossStage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isBossStage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasDebateStage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hasDebateStage = ((StageData)obj).hasDebateStage;
			LuaDLL.lua_pushboolean(L, hasDebateStage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasDebateStage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_debateStageData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData debateStageData = ((StageData)obj).debateStageData;
			ToLua.Push(L, debateStageData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateStageData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_debateStageDamageTrigger(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float debateStageDamageTrigger = ((StageData)obj).debateStageDamageTrigger;
			LuaDLL.lua_pushnumber(L, debateStageDamageTrigger);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateStageDamageTrigger on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_overflowDamageTransFac(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float overflowDamageTransFac = ((StageData)obj).overflowDamageTransFac;
			LuaDLL.lua_pushnumber(L, overflowDamageTransFac);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index overflowDamageTransFac on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_baseOverTimes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int baseOverTimes = ((StageData)obj).baseOverTimes;
			LuaDLL.lua_pushinteger(L, baseOverTimes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index baseOverTimes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_baseSpareTimes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int baseSpareTimes = ((StageData)obj).baseSpareTimes;
			LuaDLL.lua_pushinteger(L, baseSpareTimes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index baseSpareTimes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_baseHighValueWordValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int baseHighValueWordValue = ((StageData)obj).baseHighValueWordValue;
			LuaDLL.lua_pushinteger(L, baseHighValueWordValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index baseHighValueWordValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_baseremainHp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int baseremainHp = ((StageData)obj).baseremainHp;
			LuaDLL.lua_pushinteger(L, baseremainHp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index baseremainHp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_baseExplosionLength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int baseExplosionLength = ((StageData)obj).baseExplosionLength;
			LuaDLL.lua_pushinteger(L, baseExplosionLength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index baseExplosionLength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_baseExitPortalCD(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int baseExitPortalCD = ((StageData)obj).baseExitPortalCD;
			LuaDLL.lua_pushinteger(L, baseExitPortalCD);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index baseExitPortalCD on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_debateRoundLimit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int debateRoundLimit = ((StageData)obj).debateRoundLimit;
			LuaDLL.lua_pushinteger(L, debateRoundLimit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateRoundLimit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_debateFinishCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int debateFinishCount = ((StageData)obj).debateFinishCount;
			LuaDLL.lua_pushinteger(L, debateFinishCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateFinishCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supplementTriggerNumber(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int supplementTriggerNumber = ((StageData)obj).supplementTriggerNumber;
			LuaDLL.lua_pushinteger(L, supplementTriggerNumber);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index supplementTriggerNumber on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_supplementMaxNumber(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int supplementMaxNumber = ((StageData)obj).supplementMaxNumber;
			LuaDLL.lua_pushinteger(L, supplementMaxNumber);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index supplementMaxNumber on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_debateDescription(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string debateDescription = ((StageData)obj).debateDescription;
			LuaDLL.lua_pushstring(L, debateDescription);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateDescription on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_debateSuccessDesc(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string debateSuccessDesc = ((StageData)obj).debateSuccessDesc;
			LuaDLL.lua_pushstring(L, debateSuccessDesc);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateSuccessDesc on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bubbleIDList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] bubbleIDList = ((StageData)obj).bubbleIDList;
			ToLua.Push(L, bubbleIDList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bubbleIDList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_polygonBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			List<PolygonBlockData> polygonBlocks = (List<PolygonBlockData>)ToLua.CheckObject(L, 2, typeof(List<PolygonBlockData>));
			obj2.polygonBlocks = polygonBlocks;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index polygonBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_excludePolygonBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			List<RandomPolygon> excludePolygonBlocks = (List<RandomPolygon>)ToLua.CheckObject(L, 2, typeof(List<RandomPolygon>));
			obj2.excludePolygonBlocks = excludePolygonBlocks;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index excludePolygonBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stageId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			int stageId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.stageId = stageId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_resBlockNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			int resBlockNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.resBlockNum = resBlockNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resBlockNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isDebateStage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			bool isDebateStage = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isDebateStage = isDebateStage;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isDebateStage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isBossStage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			bool isBossStage = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isBossStage = isBossStage;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isBossStage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hasDebateStage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			bool hasDebateStage = LuaDLL.luaL_checkboolean(L, 2);
			obj2.hasDebateStage = hasDebateStage;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasDebateStage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_debateStageData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			StageData debateStageData = (StageData)ToLua.CheckObject<StageData>(L, 2);
			obj2.debateStageData = debateStageData;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateStageData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_debateStageDamageTrigger(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			float debateStageDamageTrigger = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.debateStageDamageTrigger = debateStageDamageTrigger;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateStageDamageTrigger on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_overflowDamageTransFac(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			float overflowDamageTransFac = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.overflowDamageTransFac = overflowDamageTransFac;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index overflowDamageTransFac on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_baseOverTimes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			int baseOverTimes = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.baseOverTimes = baseOverTimes;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index baseOverTimes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_baseSpareTimes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			int baseSpareTimes = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.baseSpareTimes = baseSpareTimes;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index baseSpareTimes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_baseHighValueWordValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			int baseHighValueWordValue = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.baseHighValueWordValue = baseHighValueWordValue;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index baseHighValueWordValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_baseremainHp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			int baseremainHp = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.baseremainHp = baseremainHp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index baseremainHp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_baseExplosionLength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			int baseExplosionLength = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.baseExplosionLength = baseExplosionLength;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index baseExplosionLength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_baseExitPortalCD(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			int baseExitPortalCD = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.baseExitPortalCD = baseExitPortalCD;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index baseExitPortalCD on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_debateRoundLimit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			int debateRoundLimit = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.debateRoundLimit = debateRoundLimit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateRoundLimit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_debateFinishCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			int debateFinishCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.debateFinishCount = debateFinishCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateFinishCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_supplementTriggerNumber(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			int supplementTriggerNumber = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.supplementTriggerNumber = supplementTriggerNumber;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index supplementTriggerNumber on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_supplementMaxNumber(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			int supplementMaxNumber = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.supplementMaxNumber = supplementMaxNumber;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index supplementMaxNumber on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_debateDescription(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			string debateDescription = ToLua.CheckString(L, 2);
			obj2.debateDescription = debateDescription;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateDescription on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_debateSuccessDesc(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			string debateSuccessDesc = ToLua.CheckString(L, 2);
			obj2.debateSuccessDesc = debateSuccessDesc;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateSuccessDesc on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bubbleIDList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData obj2 = (StageData)obj;
			int[] bubbleIDList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.bubbleIDList = bubbleIDList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bubbleIDList on a nil value");
		}
	}
}
