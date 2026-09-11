using System;
using System.Collections.Generic;
using LuaInterface;
using RogueCard;

public class RogueCard_RogueCardResultContextWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RogueCardResultContext), typeof(object));
		L.RegFunction("New", _CreateRogueCard_RogueCardResultContext);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("handTypeUseNum", get_handTypeUseNum, set_handTypeUseNum);
		L.RegVar("handTypeContainNum", get_handTypeContainNum, set_handTypeContainNum);
		L.RegVar("useItemID", get_useItemID, set_useItemID);
		L.RegVar("enhanceID", get_enhanceID, set_enhanceID);
		L.RegVar("wealWoeID", get_wealWoeID, set_wealWoeID);
		L.RegVar("mostHandType", get_mostHandType, set_mostHandType);
		L.RegVar("round", get_round, set_round);
		L.RegVar("maxScore", get_maxScore, set_maxScore);
		L.RegVar("useCardNum", get_useCardNum, set_useCardNum);
		L.RegVar("discardNum", get_discardNum, set_discardNum);
		L.RegVar("blackWuChangNum", get_blackWuChangNum, set_blackWuChangNum);
		L.RegVar("whiteWuChangNum", get_whiteWuChangNum, set_whiteWuChangNum);
		L.RegVar("gainGoldNum", get_gainGoldNum, set_gainGoldNum);
		L.RegVar("useGoldNum", get_useGoldNum, set_useGoldNum);
		L.RegVar("gainJokerNum", get_gainJokerNum, set_gainJokerNum);
		L.RegVar("useANum", get_useANum, set_useANum);
		L.RegVar("useEnhanceNum", get_useEnhanceNum, set_useEnhanceNum);
		L.RegVar("useTime", get_useTime, set_useTime);
		L.RegVar("score", get_score, set_score);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateRogueCard_RogueCardResultContext(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				RogueCardResultContext o = new RogueCardResultContext();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: RogueCard.RogueCardResultContext.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_handTypeUseNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<HandType, int> handTypeUseNum = ((RogueCardResultContext)obj).handTypeUseNum;
			ToLua.PushSealed(L, handTypeUseNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handTypeUseNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_handTypeContainNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> handTypeContainNum = ((RogueCardResultContext)obj).handTypeContainNum;
			ToLua.PushSealed(L, handTypeContainNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handTypeContainNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useItemID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> useItemID = ((RogueCardResultContext)obj).useItemID;
			ToLua.PushSealed(L, useItemID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useItemID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enhanceID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> enhanceID = ((RogueCardResultContext)obj).enhanceID;
			ToLua.PushSealed(L, enhanceID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhanceID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wealWoeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> wealWoeID = ((RogueCardResultContext)obj).wealWoeID;
			ToLua.PushSealed(L, wealWoeID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealWoeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mostHandType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int mostHandType = ((RogueCardResultContext)obj).mostHandType;
			LuaDLL.lua_pushinteger(L, mostHandType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mostHandType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_round(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int round = ((RogueCardResultContext)obj).round;
			LuaDLL.lua_pushinteger(L, round);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index round on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int maxScore = ((RogueCardResultContext)obj).maxScore;
			LuaDLL.lua_pushinteger(L, maxScore);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useCardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int useCardNum = ((RogueCardResultContext)obj).useCardNum;
			LuaDLL.lua_pushinteger(L, useCardNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useCardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_discardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int discardNum = ((RogueCardResultContext)obj).discardNum;
			LuaDLL.lua_pushinteger(L, discardNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index discardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_blackWuChangNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int blackWuChangNum = ((RogueCardResultContext)obj).blackWuChangNum;
			LuaDLL.lua_pushinteger(L, blackWuChangNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blackWuChangNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_whiteWuChangNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int whiteWuChangNum = ((RogueCardResultContext)obj).whiteWuChangNum;
			LuaDLL.lua_pushinteger(L, whiteWuChangNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index whiteWuChangNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gainGoldNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int gainGoldNum = ((RogueCardResultContext)obj).gainGoldNum;
			LuaDLL.lua_pushinteger(L, gainGoldNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gainGoldNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useGoldNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int useGoldNum = ((RogueCardResultContext)obj).useGoldNum;
			LuaDLL.lua_pushinteger(L, useGoldNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useGoldNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gainJokerNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int gainJokerNum = ((RogueCardResultContext)obj).gainJokerNum;
			LuaDLL.lua_pushinteger(L, gainJokerNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gainJokerNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useANum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int useANum = ((RogueCardResultContext)obj).useANum;
			LuaDLL.lua_pushinteger(L, useANum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useANum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useEnhanceNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int useEnhanceNum = ((RogueCardResultContext)obj).useEnhanceNum;
			LuaDLL.lua_pushinteger(L, useEnhanceNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useEnhanceNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int useTime = ((RogueCardResultContext)obj).useTime;
			LuaDLL.lua_pushinteger(L, useTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int score = ((RogueCardResultContext)obj).score;
			LuaDLL.lua_pushinteger(L, score);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index score on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_handTypeUseNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			Dictionary<HandType, int> handTypeUseNum = (Dictionary<HandType, int>)ToLua.CheckObject(L, 2, typeof(Dictionary<HandType, int>));
			obj2.handTypeUseNum = handTypeUseNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handTypeUseNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_handTypeContainNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			List<int> handTypeContainNum = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.handTypeContainNum = handTypeContainNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index handTypeContainNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useItemID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			List<int> useItemID = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.useItemID = useItemID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useItemID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enhanceID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			List<int> enhanceID = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.enhanceID = enhanceID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhanceID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wealWoeID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			List<int> wealWoeID = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.wealWoeID = wealWoeID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wealWoeID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mostHandType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			int mostHandType = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.mostHandType = mostHandType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mostHandType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_round(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			int round = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.round = round;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index round on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxScore(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			int maxScore = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxScore = maxScore;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxScore on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useCardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			int useCardNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.useCardNum = useCardNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useCardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_discardNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			int discardNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.discardNum = discardNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index discardNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_blackWuChangNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			int blackWuChangNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.blackWuChangNum = blackWuChangNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blackWuChangNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_whiteWuChangNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			int whiteWuChangNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.whiteWuChangNum = whiteWuChangNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index whiteWuChangNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gainGoldNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			int gainGoldNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.gainGoldNum = gainGoldNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gainGoldNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useGoldNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			int useGoldNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.useGoldNum = useGoldNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useGoldNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gainJokerNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			int gainJokerNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.gainJokerNum = gainJokerNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gainJokerNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useANum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			int useANum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.useANum = useANum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useANum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useEnhanceNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			int useEnhanceNum = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.useEnhanceNum = useEnhanceNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useEnhanceNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			int useTime = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.useTime = useTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardResultContext obj2 = (RogueCardResultContext)obj;
			int score = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.score = score;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index score on a nil value");
		}
	}
}
