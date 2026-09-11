using System;
using System.Collections.Generic;
using LuaInterface;
using RogueCard;

public class RogueCard_RogueCardSaveDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(RogueCardSaveData), typeof(object));
		L.RegFunction("New", _CreateRogueCard_RogueCardSaveData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("cur_state", get_cur_state, set_cur_state);
		L.RegVar("record_items", get_record_items, set_record_items);
		L.RegVar("global_attr_dic", get_global_attr_dic, set_global_attr_dic);
		L.RegVar("difficulty", get_difficulty, set_difficulty);
		L.RegVar("stage_id", get_stage_id, set_stage_id);
		L.RegVar("cur_round", get_cur_round, set_cur_round);
		L.RegVar("cur_stage_state", get_cur_stage_state, set_cur_stage_state);
		L.RegVar("hand_type_level", get_hand_type_level, set_hand_type_level);
		L.RegVar("gold", get_gold, set_gold);
		L.RegVar("random_seed", get_random_seed, set_random_seed);
		L.RegVar("deck_id", get_deck_id, set_deck_id);
		L.RegVar("deck_cards", get_deck_cards, set_deck_cards);
		L.RegVar("pile_cards", get_pile_cards, set_pile_cards);
		L.RegVar("hand_cards", get_hand_cards, set_hand_cards);
		L.RegVar("jokers", get_jokers, set_jokers);
		L.RegVar("play_num", get_play_num, set_play_num);
		L.RegVar("discard_num", get_discard_num, set_discard_num);
		L.RegVar("score", get_score, set_score);
		L.RegVar("target_score", get_target_score, set_target_score);
		L.RegVar("boss_target_score", get_boss_target_score, set_boss_target_score);
		L.RegVar("round_play_num", get_round_play_num, set_round_play_num);
		L.RegVar("round_discard_num", get_round_discard_num, set_round_discard_num);
		L.RegVar("shop_item_data_list", get_shop_item_data_list, set_shop_item_data_list);
		L.RegVar("shop_package_data_list", get_shop_package_data_list, set_shop_package_data_list);
		L.RegVar("cur_refresh_cost", get_cur_refresh_cost, set_cur_refresh_cost);
		L.RegVar("cur_package_id", get_cur_package_id, set_cur_package_id);
		L.RegVar("cur_package_wuchang", get_cur_package_wuchang, set_cur_package_wuchang);
		L.RegVar("last_package_num", get_last_package_num, set_last_package_num);
		L.RegVar("package_joker_id", get_package_joker_id, set_package_joker_id);
		L.RegVar("package_wuchang_id", get_package_wuchang_id, set_package_wuchang_id);
		L.RegVar("wu_chang_wait_cards", get_wu_chang_wait_cards, set_wu_chang_wait_cards);
		L.RegVar("wu_chang_reset_num", get_wu_chang_reset_num, set_wu_chang_reset_num);
		L.RegVar("white_wu_chang_id", get_white_wu_chang_id, set_white_wu_chang_id);
		L.RegVar("black_wu_chang_id", get_black_wu_chang_id, set_black_wu_chang_id);
		L.RegVar("weal_woe_refresh_num", get_weal_woe_refresh_num, set_weal_woe_refresh_num);
		L.RegVar("weal_list", get_weal_list, set_weal_list);
		L.RegVar("woe_list", get_woe_list, set_woe_list);
		L.RegVar("cur_woe_id", get_cur_woe_id, set_cur_woe_id);
		L.RegVar("is_other_suit", get_is_other_suit, set_is_other_suit);
		L.RegVar("is_better_straight", get_is_better_straight, set_is_better_straight);
		L.RegVar("is_always_wu_chang", get_is_always_wu_chang, set_is_always_wu_chang);
		L.RegVar("is_disable_type", get_is_disable_type, set_is_disable_type);
		L.RegVar("disable_type", get_disable_type, set_disable_type);
		L.RegVar("is_only_type", get_is_only_type, set_is_only_type);
		L.RegVar("only_type", get_only_type, set_only_type);
		L.RegVar("hand_trigger", get_hand_trigger, set_hand_trigger);
		L.RegVar("ignore_woe", get_ignore_woe, set_ignore_woe);
		L.RegVar("ignore_spade", get_ignore_spade, set_ignore_spade);
		L.RegVar("is_odd_even", get_is_odd_even, set_is_odd_even);
		L.RegVar("odd_value", get_odd_value, set_odd_value);
		L.RegVar("even_value", get_even_value, set_even_value);
		L.RegVar("settle_data", get_settle_data, set_settle_data);
		L.RegVar("roll_back_num", get_roll_back_num, set_roll_back_num);
		L.RegVar("other_data", get_other_data, set_other_data);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateRogueCard_RogueCardSaveData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				RogueCardSaveData o = new RogueCardSaveData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: RogueCard.RogueCardSaveData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cur_state(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int cur_state = ((RogueCardSaveData)obj).cur_state;
			LuaDLL.lua_pushinteger(L, cur_state);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cur_state on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_record_items(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> record_items = ((RogueCardSaveData)obj).record_items;
			ToLua.PushSealed(L, record_items);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index record_items on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_global_attr_dic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> global_attr_dic = ((RogueCardSaveData)obj).global_attr_dic;
			ToLua.PushSealed(L, global_attr_dic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index global_attr_dic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_difficulty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int difficulty = ((RogueCardSaveData)obj).difficulty;
			LuaDLL.lua_pushinteger(L, difficulty);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index difficulty on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stage_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int stage_id = ((RogueCardSaveData)obj).stage_id;
			LuaDLL.lua_pushinteger(L, stage_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stage_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cur_round(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int cur_round = ((RogueCardSaveData)obj).cur_round;
			LuaDLL.lua_pushinteger(L, cur_round);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cur_round on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cur_stage_state(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int cur_stage_state = ((RogueCardSaveData)obj).cur_stage_state;
			LuaDLL.lua_pushinteger(L, cur_stage_state);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cur_stage_state on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hand_type_level(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> hand_type_level = ((RogueCardSaveData)obj).hand_type_level;
			ToLua.PushSealed(L, hand_type_level);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hand_type_level on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int gold = ((RogueCardSaveData)obj).gold;
			LuaDLL.lua_pushinteger(L, gold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_random_seed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int random_seed = ((RogueCardSaveData)obj).random_seed;
			LuaDLL.lua_pushinteger(L, random_seed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index random_seed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deck_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int deck_id = ((RogueCardSaveData)obj).deck_id;
			LuaDLL.lua_pushinteger(L, deck_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deck_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_deck_cards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<RogueCardSaveCardData> deck_cards = ((RogueCardSaveData)obj).deck_cards;
			ToLua.PushSealed(L, deck_cards);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deck_cards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pile_cards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<RogueCardSaveCardData> pile_cards = ((RogueCardSaveData)obj).pile_cards;
			ToLua.PushSealed(L, pile_cards);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pile_cards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hand_cards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<RogueCardSaveCardData> hand_cards = ((RogueCardSaveData)obj).hand_cards;
			ToLua.PushSealed(L, hand_cards);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hand_cards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jokers(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<RogueCardSaveJokerData> jokers = ((RogueCardSaveData)obj).jokers;
			ToLua.PushSealed(L, jokers);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokers on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_play_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int play_num = ((RogueCardSaveData)obj).play_num;
			LuaDLL.lua_pushinteger(L, play_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index play_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_discard_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int discard_num = ((RogueCardSaveData)obj).discard_num;
			LuaDLL.lua_pushinteger(L, discard_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index discard_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int score = ((RogueCardSaveData)obj).score;
			LuaDLL.lua_pushinteger(L, score);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index score on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_target_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int target_score = ((RogueCardSaveData)obj).target_score;
			LuaDLL.lua_pushinteger(L, target_score);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index target_score on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_boss_target_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int boss_target_score = ((RogueCardSaveData)obj).boss_target_score;
			LuaDLL.lua_pushinteger(L, boss_target_score);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index boss_target_score on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_round_play_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int round_play_num = ((RogueCardSaveData)obj).round_play_num;
			LuaDLL.lua_pushinteger(L, round_play_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index round_play_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_round_discard_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int round_discard_num = ((RogueCardSaveData)obj).round_discard_num;
			LuaDLL.lua_pushinteger(L, round_discard_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index round_discard_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shop_item_data_list(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> shop_item_data_list = ((RogueCardSaveData)obj).shop_item_data_list;
			ToLua.PushSealed(L, shop_item_data_list);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shop_item_data_list on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shop_package_data_list(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> shop_package_data_list = ((RogueCardSaveData)obj).shop_package_data_list;
			ToLua.PushSealed(L, shop_package_data_list);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shop_package_data_list on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cur_refresh_cost(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int cur_refresh_cost = ((RogueCardSaveData)obj).cur_refresh_cost;
			LuaDLL.lua_pushinteger(L, cur_refresh_cost);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cur_refresh_cost on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cur_package_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int cur_package_id = ((RogueCardSaveData)obj).cur_package_id;
			LuaDLL.lua_pushinteger(L, cur_package_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cur_package_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cur_package_wuchang(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int cur_package_wuchang = ((RogueCardSaveData)obj).cur_package_wuchang;
			LuaDLL.lua_pushinteger(L, cur_package_wuchang);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cur_package_wuchang on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_last_package_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int last_package_num = ((RogueCardSaveData)obj).last_package_num;
			LuaDLL.lua_pushinteger(L, last_package_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index last_package_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_package_joker_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> package_joker_id = ((RogueCardSaveData)obj).package_joker_id;
			ToLua.PushSealed(L, package_joker_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index package_joker_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_package_wuchang_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> package_wuchang_id = ((RogueCardSaveData)obj).package_wuchang_id;
			ToLua.PushSealed(L, package_wuchang_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index package_wuchang_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wu_chang_wait_cards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<RogueCardSaveCardData> wu_chang_wait_cards = ((RogueCardSaveData)obj).wu_chang_wait_cards;
			ToLua.PushSealed(L, wu_chang_wait_cards);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wu_chang_wait_cards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wu_chang_reset_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int wu_chang_reset_num = ((RogueCardSaveData)obj).wu_chang_reset_num;
			LuaDLL.lua_pushinteger(L, wu_chang_reset_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wu_chang_reset_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_white_wu_chang_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int white_wu_chang_id = ((RogueCardSaveData)obj).white_wu_chang_id;
			LuaDLL.lua_pushinteger(L, white_wu_chang_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index white_wu_chang_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_black_wu_chang_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int black_wu_chang_id = ((RogueCardSaveData)obj).black_wu_chang_id;
			LuaDLL.lua_pushinteger(L, black_wu_chang_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index black_wu_chang_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_weal_woe_refresh_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int weal_woe_refresh_num = ((RogueCardSaveData)obj).weal_woe_refresh_num;
			LuaDLL.lua_pushinteger(L, weal_woe_refresh_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index weal_woe_refresh_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_weal_list(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> weal_list = ((RogueCardSaveData)obj).weal_list;
			ToLua.PushSealed(L, weal_list);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index weal_list on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_woe_list(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> woe_list = ((RogueCardSaveData)obj).woe_list;
			ToLua.PushSealed(L, woe_list);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index woe_list on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cur_woe_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int cur_woe_id = ((RogueCardSaveData)obj).cur_woe_id;
			LuaDLL.lua_pushinteger(L, cur_woe_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cur_woe_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_is_other_suit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool is_other_suit = ((RogueCardSaveData)obj).is_other_suit;
			LuaDLL.lua_pushboolean(L, is_other_suit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index is_other_suit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_is_better_straight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool is_better_straight = ((RogueCardSaveData)obj).is_better_straight;
			LuaDLL.lua_pushboolean(L, is_better_straight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index is_better_straight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_is_always_wu_chang(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool is_always_wu_chang = ((RogueCardSaveData)obj).is_always_wu_chang;
			LuaDLL.lua_pushboolean(L, is_always_wu_chang);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index is_always_wu_chang on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_is_disable_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool is_disable_type = ((RogueCardSaveData)obj).is_disable_type;
			LuaDLL.lua_pushboolean(L, is_disable_type);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index is_disable_type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_disable_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> disable_type = ((RogueCardSaveData)obj).disable_type;
			ToLua.PushSealed(L, disable_type);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index disable_type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_is_only_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool is_only_type = ((RogueCardSaveData)obj).is_only_type;
			LuaDLL.lua_pushboolean(L, is_only_type);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index is_only_type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_only_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int only_type = ((RogueCardSaveData)obj).only_type;
			LuaDLL.lua_pushinteger(L, only_type);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index only_type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hand_trigger(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hand_trigger = ((RogueCardSaveData)obj).hand_trigger;
			LuaDLL.lua_pushboolean(L, hand_trigger);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hand_trigger on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ignore_woe(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool ignore_woe = ((RogueCardSaveData)obj).ignore_woe;
			LuaDLL.lua_pushboolean(L, ignore_woe);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignore_woe on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ignore_spade(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool ignore_spade = ((RogueCardSaveData)obj).ignore_spade;
			LuaDLL.lua_pushboolean(L, ignore_spade);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignore_spade on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_is_odd_even(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool is_odd_even = ((RogueCardSaveData)obj).is_odd_even;
			LuaDLL.lua_pushboolean(L, is_odd_even);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index is_odd_even on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_odd_value(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int odd_value = ((RogueCardSaveData)obj).odd_value;
			LuaDLL.lua_pushinteger(L, odd_value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index odd_value on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_even_value(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int even_value = ((RogueCardSaveData)obj).even_value;
			LuaDLL.lua_pushinteger(L, even_value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index even_value on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_settle_data(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveSettleData settle_data = ((RogueCardSaveData)obj).settle_data;
			ToLua.PushObject(L, settle_data);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index settle_data on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_roll_back_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int roll_back_num = ((RogueCardSaveData)obj).roll_back_num;
			LuaDLL.lua_pushinteger(L, roll_back_num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index roll_back_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_other_data(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> other_data = ((RogueCardSaveData)obj).other_data;
			ToLua.PushSealed(L, other_data);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index other_data on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cur_state(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int cur_state = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.cur_state = cur_state;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cur_state on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_record_items(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			List<int> record_items = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.record_items = record_items;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index record_items on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_global_attr_dic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			List<int> global_attr_dic = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.global_attr_dic = global_attr_dic;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index global_attr_dic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_difficulty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int difficulty = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.difficulty = difficulty;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index difficulty on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stage_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int stage_id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.stage_id = stage_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stage_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cur_round(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int cur_round = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.cur_round = cur_round;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cur_round on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cur_stage_state(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int cur_stage_state = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.cur_stage_state = cur_stage_state;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cur_stage_state on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hand_type_level(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			List<int> hand_type_level = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.hand_type_level = hand_type_level;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hand_type_level on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int gold = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.gold = gold;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_random_seed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int random_seed = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.random_seed = random_seed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index random_seed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_deck_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int deck_id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.deck_id = deck_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deck_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_deck_cards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			List<RogueCardSaveCardData> deck_cards = (List<RogueCardSaveCardData>)ToLua.CheckObject(L, 2, typeof(List<RogueCardSaveCardData>));
			obj2.deck_cards = deck_cards;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index deck_cards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pile_cards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			List<RogueCardSaveCardData> pile_cards = (List<RogueCardSaveCardData>)ToLua.CheckObject(L, 2, typeof(List<RogueCardSaveCardData>));
			obj2.pile_cards = pile_cards;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index pile_cards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hand_cards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			List<RogueCardSaveCardData> hand_cards = (List<RogueCardSaveCardData>)ToLua.CheckObject(L, 2, typeof(List<RogueCardSaveCardData>));
			obj2.hand_cards = hand_cards;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hand_cards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jokers(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			List<RogueCardSaveJokerData> jokers = (List<RogueCardSaveJokerData>)ToLua.CheckObject(L, 2, typeof(List<RogueCardSaveJokerData>));
			obj2.jokers = jokers;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index jokers on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_play_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int play_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.play_num = play_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index play_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_discard_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
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
	private static int set_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
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
	private static int set_target_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int target_score = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.target_score = target_score;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index target_score on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_boss_target_score(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int boss_target_score = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.boss_target_score = boss_target_score;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index boss_target_score on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_round_play_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int round_play_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.round_play_num = round_play_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index round_play_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_round_discard_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int round_discard_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.round_discard_num = round_discard_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index round_discard_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shop_item_data_list(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			List<int> shop_item_data_list = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.shop_item_data_list = shop_item_data_list;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shop_item_data_list on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shop_package_data_list(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			List<int> shop_package_data_list = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.shop_package_data_list = shop_package_data_list;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shop_package_data_list on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cur_refresh_cost(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int cur_refresh_cost = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.cur_refresh_cost = cur_refresh_cost;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cur_refresh_cost on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cur_package_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int cur_package_id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.cur_package_id = cur_package_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cur_package_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cur_package_wuchang(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int cur_package_wuchang = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.cur_package_wuchang = cur_package_wuchang;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cur_package_wuchang on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_last_package_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int last_package_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.last_package_num = last_package_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index last_package_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_package_joker_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			List<int> package_joker_id = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.package_joker_id = package_joker_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index package_joker_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_package_wuchang_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			List<int> package_wuchang_id = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.package_wuchang_id = package_wuchang_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index package_wuchang_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wu_chang_wait_cards(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			List<RogueCardSaveCardData> wu_chang_wait_cards = (List<RogueCardSaveCardData>)ToLua.CheckObject(L, 2, typeof(List<RogueCardSaveCardData>));
			obj2.wu_chang_wait_cards = wu_chang_wait_cards;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wu_chang_wait_cards on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wu_chang_reset_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int wu_chang_reset_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.wu_chang_reset_num = wu_chang_reset_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wu_chang_reset_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_white_wu_chang_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int white_wu_chang_id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.white_wu_chang_id = white_wu_chang_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index white_wu_chang_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_black_wu_chang_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int black_wu_chang_id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.black_wu_chang_id = black_wu_chang_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index black_wu_chang_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_weal_woe_refresh_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int weal_woe_refresh_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.weal_woe_refresh_num = weal_woe_refresh_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index weal_woe_refresh_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_weal_list(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			List<int> weal_list = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.weal_list = weal_list;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index weal_list on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_woe_list(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			List<int> woe_list = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.woe_list = woe_list;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index woe_list on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cur_woe_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int cur_woe_id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.cur_woe_id = cur_woe_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cur_woe_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_is_other_suit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			bool is_other_suit = LuaDLL.luaL_checkboolean(L, 2);
			obj2.is_other_suit = is_other_suit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index is_other_suit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_is_better_straight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			bool is_better_straight = LuaDLL.luaL_checkboolean(L, 2);
			obj2.is_better_straight = is_better_straight;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index is_better_straight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_is_always_wu_chang(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			bool is_always_wu_chang = LuaDLL.luaL_checkboolean(L, 2);
			obj2.is_always_wu_chang = is_always_wu_chang;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index is_always_wu_chang on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_is_disable_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			bool is_disable_type = LuaDLL.luaL_checkboolean(L, 2);
			obj2.is_disable_type = is_disable_type;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index is_disable_type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_disable_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			List<int> disable_type = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.disable_type = disable_type;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index disable_type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_is_only_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			bool is_only_type = LuaDLL.luaL_checkboolean(L, 2);
			obj2.is_only_type = is_only_type;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index is_only_type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_only_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int only_type = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.only_type = only_type;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index only_type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hand_trigger(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			bool hand_trigger = LuaDLL.luaL_checkboolean(L, 2);
			obj2.hand_trigger = hand_trigger;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hand_trigger on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ignore_woe(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			bool ignore_woe = LuaDLL.luaL_checkboolean(L, 2);
			obj2.ignore_woe = ignore_woe;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignore_woe on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ignore_spade(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			bool ignore_spade = LuaDLL.luaL_checkboolean(L, 2);
			obj2.ignore_spade = ignore_spade;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ignore_spade on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_is_odd_even(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			bool is_odd_even = LuaDLL.luaL_checkboolean(L, 2);
			obj2.is_odd_even = is_odd_even;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index is_odd_even on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_odd_value(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int odd_value = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.odd_value = odd_value;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index odd_value on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_even_value(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int even_value = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.even_value = even_value;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index even_value on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_settle_data(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			RogueCardSaveSettleData settle_data = (RogueCardSaveSettleData)ToLua.CheckObject<RogueCardSaveSettleData>(L, 2);
			obj2.settle_data = settle_data;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index settle_data on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_roll_back_num(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			int roll_back_num = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.roll_back_num = roll_back_num;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index roll_back_num on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_other_data(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RogueCardSaveData obj2 = (RogueCardSaveData)obj;
			List<int> other_data = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.other_data = other_data;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index other_data on a nil value");
		}
	}
}
