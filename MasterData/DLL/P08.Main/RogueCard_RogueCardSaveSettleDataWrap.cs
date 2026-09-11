using System;
using System.Collections.Generic;
using LuaInterface;
using RogueCard;

public class RogueCard_RogueCardSaveSettleDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RogueCardSaveSettleData), typeof(object));
		L.RegFunction("New", _CreateRogueCard_RogueCardSaveSettleData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("hand_type_use_num", get_hand_type_use_num, set_hand_type_use_num);
		L.RegVar("hand_type_contain_num", get_hand_type_contain_num, set_hand_type_contain_num);
		L.RegVar("use_item_id", get_use_item_id, set_use_item_id);
		L.RegVar("enhance_id", get_enhance_id, set_enhance_id);
		L.RegVar("weal_woe_id", get_weal_woe_id, set_weal_woe_id);
		L.RegVar("most_hand_type", get_most_hand_type, set_most_hand_type);
		L.RegVar("round", get_round, set_round);
		L.RegVar("max_score", get_max_score, set_max_score);
		L.RegVar("use_card_num", get_use_card_num, set_use_card_num);
		L.RegVar("discard_num", get_discard_num, set_discard_num);
		L.RegVar("black_wu_chang_num", get_black_wu_chang_num, set_black_wu_chang_num);
		L.RegVar("white_wu_chang_num", get_white_wu_chang_num, set_white_wu_chang_num);
		L.RegVar("gain_gold_num", get_gain_gold_num, set_gain_gold_num);
		L.RegVar("score", get_score, set_score);
		L.RegVar("use_gold_num", get_use_gold_num, set_use_gold_num);
		L.RegVar("gain_joker_num", get_gain_joker_num, set_gain_joker_num);
		L.RegVar("use_a_num", get_use_a_num, set_use_a_num);
		L.RegVar("use_enhance_num", get_use_enhance_num, set_use_enhance_num);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateRogueCard_RogueCardSaveSettleData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				RogueCardSaveSettleData o = new RogueCardSaveSettleData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: RogueCard.RogueCardSaveSettleData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hand_type_use_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> hand_type_use_num = ((RogueCardSaveSettleData)obj).hand_type_use_num;
			ToLua.PushSealed(L, hand_type_use_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hand_type_use_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hand_type_contain_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> hand_type_contain_num = ((RogueCardSaveSettleData)obj).hand_type_contain_num;
			ToLua.PushSealed(L, hand_type_contain_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hand_type_contain_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_use_item_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> use_item_id = ((RogueCardSaveSettleData)obj).use_item_id;
			ToLua.PushSealed(L, use_item_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index use_item_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enhance_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> enhance_id = ((RogueCardSaveSettleData)obj).enhance_id;
			ToLua.PushSealed(L, enhance_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhance_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_weal_woe_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> weal_woe_id = ((RogueCardSaveSettleData)obj).weal_woe_id;
			ToLua.PushSealed(L, weal_woe_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index weal_woe_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_most_hand_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int most_hand_type = ((RogueCardSaveSettleData)obj).most_hand_type;
			LuaDLL.lua_pushinteger(L, most_hand_type);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index most_hand_type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_round(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int round = ((RogueCardSaveSettleData)obj).round;
			LuaDLL.lua_pushinteger(L, round);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index round on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_max_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int max_score = ((RogueCardSaveSettleData)obj).max_score;
			LuaDLL.lua_pushinteger(L, max_score);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index max_score on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_use_card_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int use_card_num = ((RogueCardSaveSettleData)obj).use_card_num;
			LuaDLL.lua_pushinteger(L, use_card_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index use_card_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_discard_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int discard_num = ((RogueCardSaveSettleData)obj).discard_num;
			LuaDLL.lua_pushinteger(L, discard_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index discard_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_black_wu_chang_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int black_wu_chang_num = ((RogueCardSaveSettleData)obj).black_wu_chang_num;
			LuaDLL.lua_pushinteger(L, black_wu_chang_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index black_wu_chang_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_white_wu_chang_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int white_wu_chang_num = ((RogueCardSaveSettleData)obj).white_wu_chang_num;
			LuaDLL.lua_pushinteger(L, white_wu_chang_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index white_wu_chang_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gain_gold_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int gain_gold_num = ((RogueCardSaveSettleData)obj).gain_gold_num;
			LuaDLL.lua_pushinteger(L, gain_gold_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gain_gold_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int score = ((RogueCardSaveSettleData)obj).score;
			LuaDLL.lua_pushinteger(L, score);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index score on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_use_gold_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int use_gold_num = ((RogueCardSaveSettleData)obj).use_gold_num;
			LuaDLL.lua_pushinteger(L, use_gold_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index use_gold_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gain_joker_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int gain_joker_num = ((RogueCardSaveSettleData)obj).gain_joker_num;
			LuaDLL.lua_pushinteger(L, gain_joker_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gain_joker_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_use_a_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int use_a_num = ((RogueCardSaveSettleData)obj).use_a_num;
			LuaDLL.lua_pushinteger(L, use_a_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index use_a_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_use_enhance_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int use_enhance_num = ((RogueCardSaveSettleData)obj).use_enhance_num;
			LuaDLL.lua_pushinteger(L, use_enhance_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index use_enhance_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hand_type_use_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			List<int> hand_type_use_num = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.hand_type_use_num = hand_type_use_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hand_type_use_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hand_type_contain_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			List<int> hand_type_contain_num = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.hand_type_contain_num = hand_type_contain_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hand_type_contain_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_use_item_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			List<int> use_item_id = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.use_item_id = use_item_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index use_item_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enhance_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			List<int> enhance_id = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.enhance_id = enhance_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enhance_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_weal_woe_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			List<int> weal_woe_id = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.weal_woe_id = weal_woe_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index weal_woe_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_most_hand_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			int most_hand_type = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.most_hand_type = most_hand_type;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index most_hand_type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_round(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
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
	private static int set_max_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			int max_score = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.max_score = max_score;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index max_score on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_use_card_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			int use_card_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.use_card_num = use_card_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index use_card_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_discard_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			int discard_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.discard_num = discard_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index discard_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_black_wu_chang_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			int black_wu_chang_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.black_wu_chang_num = black_wu_chang_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index black_wu_chang_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_white_wu_chang_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			int white_wu_chang_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.white_wu_chang_num = white_wu_chang_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index white_wu_chang_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gain_gold_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			int gain_gold_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.gain_gold_num = gain_gold_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gain_gold_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			int score = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.score = score;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index score on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_use_gold_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			int use_gold_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.use_gold_num = use_gold_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index use_gold_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gain_joker_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			int gain_joker_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.gain_joker_num = gain_joker_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gain_joker_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_use_a_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			int use_a_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.use_a_num = use_a_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index use_a_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_use_enhance_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData obj2 = (RogueCardSaveSettleData)obj;
			int use_enhance_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.use_enhance_num = use_enhance_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index use_enhance_num on a nil value");
		}
	}
}
