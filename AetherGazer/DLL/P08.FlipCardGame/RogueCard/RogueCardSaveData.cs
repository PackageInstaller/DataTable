using System.Collections.Generic;

namespace RogueCard;

public class RogueCardSaveData
{
	public int cur_state;

	public List<int> record_items;

	public List<int> global_attr_dic;

	public int difficulty;

	public int stage_id;

	public int cur_round;

	public int cur_stage_state;

	public List<int> hand_type_level;

	public int gold;

	public int random_seed;

	public int deck_id;

	public List<RogueCardSaveCardData> deck_cards;

	public List<RogueCardSaveCardData> pile_cards;

	public List<RogueCardSaveCardData> hand_cards;

	public List<RogueCardSaveJokerData> jokers;

	public int play_num;

	public int discard_num;

	public int score;

	public int target_score;

	public int boss_target_score;

	public int round_play_num;

	public int round_discard_num;

	public List<int> shop_item_data_list;

	public List<int> shop_package_data_list;

	public int cur_refresh_cost;

	public int cur_package_id;

	public int cur_package_wuchang;

	public int last_package_num;

	public List<int> package_joker_id;

	public List<int> package_wuchang_id;

	public List<RogueCardSaveCardData> wu_chang_wait_cards;

	public int wu_chang_reset_num;

	public int white_wu_chang_id = -1;

	public int black_wu_chang_id = -1;

	public int weal_woe_refresh_num;

	public List<int> weal_list;

	public List<int> woe_list;

	public int cur_woe_id;

	public bool is_other_suit;

	public bool is_better_straight;

	public bool is_always_wu_chang;

	public bool is_disable_type;

	public List<int> disable_type;

	public bool is_only_type;

	public int only_type;

	public bool hand_trigger;

	public bool ignore_woe;

	public bool ignore_spade;

	public bool is_odd_even;

	public int odd_value;

	public int even_value;

	public RogueCardSaveSettleData settle_data;

	public int roll_back_num;

	public List<int> other_data;
}
