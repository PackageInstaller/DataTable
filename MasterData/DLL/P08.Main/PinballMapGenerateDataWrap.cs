using System;
using LuaInterface;
using Pinball.Runtime;

public class PinballMapGenerateDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PinballMapGenerateData), typeof(object));
		L.RegFunction("New", _CreatePinballMapGenerateData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("stageIDList", get_stageIDList, set_stageIDList);
		L.RegVar("blockNumberStart", get_blockNumberStart, set_blockNumberStart);
		L.RegVar("blockRowStartU", get_blockRowStartU, set_blockRowStartU);
		L.RegVar("blockRowStartB", get_blockRowStartB, set_blockRowStartB);
		L.RegVar("blockTypeWeight", get_blockTypeWeight, set_blockTypeWeight);
		L.RegVar("blockNumberRound", get_blockNumberRound, set_blockNumberRound);
		L.RegVar("gainBallItemLimit", get_gainBallItemLimit, set_gainBallItemLimit);
		L.RegVar("maxAffectBlocks", get_maxAffectBlocks, set_maxAffectBlocks);
		L.RegVar("maxProtectBlocks", get_maxProtectBlocks, set_maxProtectBlocks);
		L.RegVar("challengeRound", get_challengeRound, set_challengeRound);
		L.RegVar("backGroundSprite", get_backGroundSprite, set_backGroundSprite);
		L.RegVar("debateOverflowDamageToSkillPointRate", get_debateOverflowDamageToSkillPointRate, set_debateOverflowDamageToSkillPointRate);
		L.RegVar("debateSuccessScore", get_debateSuccessScore, set_debateSuccessScore);
		L.RegVar("debateLoseScore", get_debateLoseScore, set_debateLoseScore);
		L.RegVar("stageData", get_stageData, set_stageData);
		L.RegVar("Map", get_Map, set_Map);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreatePinballMapGenerateData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				PinballMapGenerateData o = new PinballMapGenerateData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: PinballMapGenerateData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stageIDList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] stageIDList = ((PinballMapGenerateData)obj).stageIDList;
			ToLua.Push(L, stageIDList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageIDList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_blockNumberStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int blockNumberStart = ((PinballMapGenerateData)obj).blockNumberStart;
			LuaDLL.lua_pushinteger(L, blockNumberStart);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blockNumberStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_blockRowStartU(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int blockRowStartU = ((PinballMapGenerateData)obj).blockRowStartU;
			LuaDLL.lua_pushinteger(L, blockRowStartU);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blockRowStartU on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_blockRowStartB(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int blockRowStartB = ((PinballMapGenerateData)obj).blockRowStartB;
			LuaDLL.lua_pushinteger(L, blockRowStartB);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blockRowStartB on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_blockTypeWeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] blockTypeWeight = ((PinballMapGenerateData)obj).blockTypeWeight;
			ToLua.Push(L, blockTypeWeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blockTypeWeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_blockNumberRound(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] blockNumberRound = ((PinballMapGenerateData)obj).blockNumberRound;
			ToLua.Push(L, blockNumberRound);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blockNumberRound on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gainBallItemLimit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int gainBallItemLimit = ((PinballMapGenerateData)obj).gainBallItemLimit;
			LuaDLL.lua_pushinteger(L, gainBallItemLimit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gainBallItemLimit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxAffectBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int maxAffectBlocks = ((PinballMapGenerateData)obj).maxAffectBlocks;
			LuaDLL.lua_pushinteger(L, maxAffectBlocks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxAffectBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxProtectBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int maxProtectBlocks = ((PinballMapGenerateData)obj).maxProtectBlocks;
			LuaDLL.lua_pushinteger(L, maxProtectBlocks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxProtectBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_challengeRound(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int challengeRound = ((PinballMapGenerateData)obj).challengeRound;
			LuaDLL.lua_pushinteger(L, challengeRound);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index challengeRound on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_backGroundSprite(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string backGroundSprite = ((PinballMapGenerateData)obj).backGroundSprite;
			LuaDLL.lua_pushstring(L, backGroundSprite);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index backGroundSprite on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_debateOverflowDamageToSkillPointRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float debateOverflowDamageToSkillPointRate = ((PinballMapGenerateData)obj).debateOverflowDamageToSkillPointRate;
			LuaDLL.lua_pushnumber(L, debateOverflowDamageToSkillPointRate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateOverflowDamageToSkillPointRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_debateSuccessScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int debateSuccessScore = ((PinballMapGenerateData)obj).debateSuccessScore;
			LuaDLL.lua_pushinteger(L, debateSuccessScore);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateSuccessScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_debateLoseScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float debateLoseScore = ((PinballMapGenerateData)obj).debateLoseScore;
			LuaDLL.lua_pushnumber(L, debateLoseScore);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateLoseScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stageData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StageData stageData = ((PinballMapGenerateData)obj).stageData;
			ToLua.Push(L, stageData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Map(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int map = ((PinballMapGenerateData)obj).Map;
			LuaDLL.lua_pushinteger(L, map);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Map on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stageIDList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData obj2 = (PinballMapGenerateData)obj;
			int[] stageIDList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.stageIDList = stageIDList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageIDList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_blockNumberStart(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData obj2 = (PinballMapGenerateData)obj;
			int blockNumberStart = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.blockNumberStart = blockNumberStart;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blockNumberStart on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_blockRowStartU(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData obj2 = (PinballMapGenerateData)obj;
			int blockRowStartU = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.blockRowStartU = blockRowStartU;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blockRowStartU on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_blockRowStartB(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData obj2 = (PinballMapGenerateData)obj;
			int blockRowStartB = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.blockRowStartB = blockRowStartB;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blockRowStartB on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_blockTypeWeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData obj2 = (PinballMapGenerateData)obj;
			int[] blockTypeWeight = ToLua.CheckNumberArray<int>(L, 2);
			obj2.blockTypeWeight = blockTypeWeight;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blockTypeWeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_blockNumberRound(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData obj2 = (PinballMapGenerateData)obj;
			int[] blockNumberRound = ToLua.CheckNumberArray<int>(L, 2);
			obj2.blockNumberRound = blockNumberRound;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blockNumberRound on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gainBallItemLimit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData obj2 = (PinballMapGenerateData)obj;
			int gainBallItemLimit = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.gainBallItemLimit = gainBallItemLimit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gainBallItemLimit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxAffectBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData obj2 = (PinballMapGenerateData)obj;
			int maxAffectBlocks = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxAffectBlocks = maxAffectBlocks;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxAffectBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxProtectBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData obj2 = (PinballMapGenerateData)obj;
			int maxProtectBlocks = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxProtectBlocks = maxProtectBlocks;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxProtectBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_challengeRound(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData obj2 = (PinballMapGenerateData)obj;
			int challengeRound = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.challengeRound = challengeRound;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index challengeRound on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_backGroundSprite(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData obj2 = (PinballMapGenerateData)obj;
			string backGroundSprite = ToLua.CheckString(L, 2);
			obj2.backGroundSprite = backGroundSprite;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index backGroundSprite on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_debateOverflowDamageToSkillPointRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData obj2 = (PinballMapGenerateData)obj;
			float debateOverflowDamageToSkillPointRate = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.debateOverflowDamageToSkillPointRate = debateOverflowDamageToSkillPointRate;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateOverflowDamageToSkillPointRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_debateSuccessScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData obj2 = (PinballMapGenerateData)obj;
			int debateSuccessScore = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.debateSuccessScore = debateSuccessScore;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateSuccessScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_debateLoseScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData obj2 = (PinballMapGenerateData)obj;
			float debateLoseScore = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.debateLoseScore = debateLoseScore;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index debateLoseScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stageData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData obj2 = (PinballMapGenerateData)obj;
			StageData stageData = (StageData)ToLua.CheckObject<StageData>(L, 2);
			obj2.stageData = stageData;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Map(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PinballMapGenerateData obj2 = (PinballMapGenerateData)obj;
			int map = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.Map = map;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Map on a nil value");
		}
	}
}
