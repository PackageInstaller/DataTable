using System.Collections.Generic;
using Newtonsoft.Json.Linq;

namespace ACT.EventTrack;

public class EventConfigs
{
	public const string MISSION_EVENT = "mission_event";

	public const string DUNGEON_EVENT = "dungeon_event";

	public const string ABYSS_EVENT = "abyss_event";

	public const string CHAPTER_0_SCENE_EVENT = "chapter_0_scene_event";

	public const string DRAMA_EVENT = "drama_event";

	public const string FALL_EVENT = "fall_event";

	public const string PERFECT_DODGE_FROM_MONSTER = "perfect_dodge_from_monster";

	public const string ROLE_SWITCH = "role_switch";

	public const string KILLED_BY_MONSTER = "killed_by_monster";

	public const string HIT_BY_MONSTER = "hit_by_monster";

	public const string USE_SKILL = "use_skill";

	public const string CLIENT_INTERACT_STATE_CHANGE = "client_interact_state_change";

	public const string TRAP_INTERACT_DAMAGE = "trap_interact_damage";

	public const string MONSTER_DIE = "monster_die";

	public const string FILE_VERIFICATION_START = "file_verification_start";

	public const string FILE_VERIFICATION_END = "file_verification_end·";

	public const string UPDATE_CLIENT_VERSION = "update_client_version";

	public const string RESOURCE_DOWNLOAD_BEGIN = "resource_download_begin";

	public const string RESOURCE_DOWNLOAD_END = "resource_download_end";

	public const string LOADING_ERROR = "loading_error";

	public const string SETTING_INFO = "setting_info";

	public const string CLIENT_IMAGE_SETTING_INFO = "client_image_setting_info";

	public const string NEW_GUIDE = "new_guide";

	public const string SYSTEM_OPEN = "system_open";

	public const string TEAM_CHANGE = "team_change";

	public const string FREETRAIN_GROUND = "freetrain_ground";

	public const string TEACHINGTRAIN_GROUND = "teachingtrain_ground";

	public const string HYPERLINK_CLICK = "hyperlink_click";

	public const string MOVEMENT_EVENT = "movement_event";

	public const string PARKOURRAID_EVENT = "parkourraid_event";

	public const string TARGETED_WISH = "targeted_wish";

	public const string ACTIVITY_CLICK = "activity_click";

	public const string CLIENT_ERROR_CODE = "client_error_code";

	public const string ABYSS_SETTLEMENT = "abyss_settlement";

	public const string INSTANCEDUNGEON_EVENT = "instancedungeon_event";

	public const string QUIT_GAME_CHOICE = "quit_game_choice";

	public const string GUIDETUTORIAL_EVENT = "guidetutorial_event";

	public const string APC_EVENT = "apc_event";

	public const string EXPLORERAID_EVENT = "exploreraid_event";

	public const string CHARACTER_ELITE_STAGE_CLICK = "character_elite_stage_click";

	public const string MESSAGE_EVENT = "message_event";

	public const string GAME_CONTROLLER = "game_controller";

	public const string ANNOUNCE_EVENT = "announce_event";

	public const string SHOP_EVENT = "shop_event";

	public const string INPUTKEY_INFO = "inputkey_info";

	public const string ACTIVITY_CALENDAR_JUMP = "activity_calender_jump";

	public const string REDDOT_EVENT = "reddot_event";

	public const string NPC_INTERACT = "npc_interact";

	public const string MAP_LABEL = "map_label";

	public const string ITEM_OBTAIN_JUMP = "item_obtain_jump";

	public const string WORLD_BOSS_FIGHT_EVENT = "world_boss_fight_event";

	public const string CDKEY_EVENT = "cdkey_event";

	public const string CLIENT_PAY_REQUEST = "client_pay_request";

	public const string CHARACTER_SKIN_CLICK = "character_skin_click";

	public const string LIVEAREA_SCENE_CHANGE = "livearea_scene_change";

	public const string PIPE_CONNECT_SUCCESS = "pipe_connect_success";

	public const string CASUAL_GAMEPLAY = "casual_gameplay";

	public const string LIBRARYCONTENT_EVENT = "librarycontent_event";

	public const string CHARACTER_TRIAL_ACTIVITY_CLICK = "character_trial_activity_click";

	public const string POPUP_EVENT = "popup_event";

	public const string SERVER_PAY_REQUEST = "server_pay_request";

	public const string ANNOUNCEMENT_EVENT = "announcement_event";

	public const string WORLD_SIDE_EXCHANGE = "world_side_exchange";

	public const string PREDOWNLOAD_ENTRY_SHOW = "predownload_entry_show";

	public const string PREDOWNLOAD_ENTRY_CLICK = "predownload_entry_click";

	public const string PREDOWNLOAD_WINDOW_CLICK = "predownload_window_click";

	public const string PREDOWNLOAD_BEGIN = "predownload__begin";

	public const string PREDOWNLOAD_END = "predownload__end";

	public const string WORLD_MESSAGE_INTERACTION = "world_message_interaction";

	public const string SHARE_EVENT = "share_event";

	public const string COSMETIC_CLICK = "cosmetic_click";

	public const string GACHA_CLICK = "gacha_click";

	public const string PLAYER_ACTIVE_DURATION = "player_active_duration";

	public const string POTION_USE = "potion_use";

	public static readonly Dictionary<string, JObject> EventDictionary = new Dictionary<string, JObject>
	{
		{
			"mission_event",
			new JObject
			{
				["mission_id"] = 0,
				["sub_mission_id"] = 0,
				["status"] = 0
			}
		},
		{
			"dungeon_event",
			new JObject
			{
				["dungeon_id"] = 0,
				["player_level"] = 0,
				["status"] = 0,
				["event_duration"] = 0,
				["team_info"] = new JArray()
			}
		},
		{
			"abyss_event",
			new JObject
			{
				["abyss_id"] = 0,
				["player_level"] = 0,
				["status"] = 0,
				["event_duration"] = 0,
				["team_info"] = new JArray()
			}
		},
		{
			"chapter_0_scene_event",
			new JObject { ["event_name"] = "-" }
		},
		{
			"drama_event",
			new JObject
			{
				["id"] = 0,
				["type"] = 0,
				["status"] = 0,
				["event_duration"] = 0,
				["skip"] = false
			}
		},
		{
			"fall_event",
			new JObject
			{
				["world_id"] = 0,
				["pos_x"] = 0,
				["pos_y"] = 0,
				["pos_z"] = 0,
				["is_abnormal"] = false
			}
		},
		{
			"perfect_dodge_from_monster",
			new JObject
			{
				["world_id"] = 0,
				["monster_swid"] = 0,
				["monster_id"] = 0,
				["skill_id"] = 0,
				["is_witch"] = false
			}
		},
		{
			"role_switch",
			new JObject
			{
				["world_id"] = 0,
				["character_id"] = 0,
				["exit_character_id"] = 0,
				["pos_x"] = 0,
				["pos_y"] = 0,
				["pos_z"] = 0,
				["event_duration"] = 0,
				["is_switch_skill"] = false
			}
		},
		{
			"killed_by_monster",
			new JObject
			{
				["world_id"] = 0,
				["monster_swid"] = 0,
				["monster_id"] = 0,
				["character_id"] = 0
			}
		},
		{
			"hit_by_monster",
			new JObject
			{
				["world_id"] = 0,
				["monster_swid"] = 0,
				["monster_id"] = 0,
				["skill_id"] = 0
			}
		},
		{
			"use_skill",
			new JObject
			{
				["world_id"] = 0,
				["character_id"] = 0,
				["skill_id"] = 0,
				["state_name"] = "-",
				["ability_list"] = new JArray()
			}
		},
		{
			"client_interact_state_change",
			new JObject
			{
				["world_id"] = 0,
				["swid"] = 0,
				["value_before"] = 0,
				["value_after"] = 0,
				["interact_type"] = 0,
				["character_id"] = 0
			}
		},
		{
			"trap_interact_damage",
			new JObject
			{
				["world_id"] = 0,
				["swid"] = 0,
				["value"] = 0,
				["interact_type"] = 0,
				["character_id"] = 0
			}
		},
		{
			"monster_die",
			new JObject
			{
				["world_id"] = 0,
				["monster_swid"] = 0,
				["character_id"] = 0
			}
		},
		{
			"file_verification_start",
			new JObject { ["result"] = 0 }
		},
		{
			"file_verification_end·",
			new JObject
			{
				["result"] = 0,
				["event_duration"] = 0
			}
		},
		{
			"update_client_version",
			new JObject
			{
				["target_version"] = "-",
				["type"] = 0,
				["result"] = 0
			}
		},
		{
			"resource_download_begin",
			new JObject
			{
				["size"] = "-",
				["url"] = "-"
			}
		},
		{
			"resource_download_end",
			new JObject
			{
				["size"] = "-",
				["url"] = "-",
				["result"] = 0,
				["type"] = 0,
				["event_duration"] = 0
			}
		},
		{
			"loading_error",
			new JObject { ["type"] = 0 }
		},
		{
			"setting_info",
			new JObject
			{
				["setting_page"] = "-",
				["setting_info"] = new JArray(),
				["setting_load"] = 0,
				["is_default"] = false
			}
		},
		{
			"new_guide",
			new JObject
			{
				["id"] = 0,
				["type"] = 0,
				["status"] = 0,
				["skip"] = false,
				["event_duration"] = 0
			}
		},
		{
			"system_open",
			new JObject
			{
				["id"] = 0,
				["type"] = 0
			}
		},
		{
			"team_change",
			new JObject
			{
				["world_id"] = 0,
				["change_type"] = 0,
				["team_info"] = new JArray()
			}
		},
		{
			"freetrain_ground",
			new JObject
			{
				["status"] = 0,
				["event_duration"] = 0
			}
		},
		{
			"teachingtrain_ground",
			new JObject
			{
				["raid_id"] = 0,
				["process_id"] = 0,
				["type"] = 0,
				["status"] = 0,
				["result"] = 0,
				["event_duration"] = 0
			}
		},
		{
			"parkourraid_event",
			new JObject
			{
				["raid_id"] = 0,
				["group_id"] = 0,
				["raid_type"] = 0,
				["cycle_type"] = 0,
				["player_level"] = 0,
				["status"] = 0,
				["event_duration"] = 0,
				["team_info"] = new JArray(),
				["collector_id"] = 0,
				["collector_num"] = 0,
				["collector_total"] = 0,
				["die_count"] = 0
			}
		},
		{
			"targeted_wish",
			new JObject
			{
				["id"] = 0,
				["type"] = 1,
				["challenge_id"] = 0,
				["targeted_id"] = 0,
				["status"] = 1
			}
		},
		{
			"hyperlink_click",
			new JObject
			{
				["title"] = 0,
				["link"] = "-",
				["system_id"] = 0,
				["mail_id"] = 0
			}
		},
		{
			"activity_click",
			new JObject
			{
				["activity_type"] = 0,
				["activity_id"] = 0,
				["challenge_group_id"] = 0,
				["challenge_id"] = 0,
				["status"] = 0,
				["is_popup"] = false
			}
		},
		{
			"movement_event",
			new JObject
			{
				["world_id"] = 0,
				["swid"] = 0,
				["character_id"] = 0,
				["pos_x"] = 0,
				["pos_y"] = 0,
				["pos_z"] = 0,
				["type"] = 0,
				["event_type"] = 0
			}
		},
		{
			"client_error_code",
			new JObject
			{
				["error_code"] = "-",
				["system_module"] = "-",
				["rank"] = 0
			}
		},
		{
			"abyss_settlement",
			new JObject
			{
				["stage_id"] = 0,
				["abyss_id"] = 0,
				["event_duration"] = 0,
				["player_level"] = 0,
				["status"] = 0,
				["star"] = 0,
				["sub_info"] = new JArray()
			}
		},
		{
			"instancedungeon_event",
			new JObject
			{
				["trans_no"] = "-",
				["world_id"] = 0,
				["area_id"] = 0,
				["event_duration"] = 0,
				["player_level"] = 0,
				["status"] = 0,
				["star"] = 0,
				["team_info"] = new JArray()
			}
		},
		{
			"quit_game_choice",
			new JObject { ["type"] = 0 }
		},
		{
			"guidetutorial_event",
			new JObject
			{
				["tutorial_id"] = 0,
				["type"] = 0,
				["op"] = 0,
				["is_rednote"] = false
			}
		},
		{
			"apc_event",
			new JObject
			{
				["app_id"] = 0,
				["status"] = 0,
				["trans_no"] = "-",
				["world_id"] = 0,
				["raid_id"] = 0
			}
		},
		{
			"exploreraid_event",
			new JObject
			{
				["trans_no"] = "-",
				["world_id"] = 0,
				["raid_id"] = 0,
				["group_id"] = 0,
				["raid_type"] = 0,
				["cycle_type"] = 0,
				["player_level"] = 0,
				["status"] = 0,
				["team_info"] = new JArray(),
				["collector_id"] = 0,
				["collector_name"] = 0,
				["collector_total"] = 0,
				["die_count"] = 0,
				["trap_count"] = 0,
				["is_restart"] = false
			}
		},
		{
			"character_elite_stage_click",
			new JObject
			{
				["character_id"] = 0,
				["character_level"] = 0,
				["elite_stage"] = 0,
				["elite_level"] = 0,
				["elite_stage_id"] = 0,
				["status"] = 0
			}
		},
		{
			"message_event",
			new JObject
			{
				["conversation_character_id"] = 0,
				["conversation_type"] = 0,
				["conversation_id"] = 0,
				["conversation_status"] = 0,
				["message_id"] = 0,
				["message_type"] = 0,
				["message_choose_id"] = 0,
				["status"] = 0
			}
		},
		{
			"game_controller",
			new JObject
			{
				["controller_mode"] = "-",
				["brand"] = "-",
				["status"] = 0
			}
		},
		{
			"announce_event",
			new JObject
			{
				["announcement_id"] = 0,
				["type"] = 0,
				["status"] = 0
			}
		},
		{
			"shop_event",
			new JObject
			{
				["sub_shop_id"] = 0,
				["status"] = 0,
				["commodity_id"] = 0,
				["commodity_qty"] = 0
			}
		},
		{
			"inputkey_info",
			new JObject
			{
				["operation_info"] = new JArray(),
				["is_default"] = false
			}
		},
		{
			"activity_calender_jump",
			new JObject
			{
				["system_id"] = 0,
				["jump_id"] = 0
			}
		},
		{
			"reddot_event",
			new JObject
			{
				["reddot_path"] = "-",
				["type"] = 0,
				["system_id"] = 0,
				["status"] = 0
			}
		},
		{
			"npc_interact",
			new JObject
			{
				["npc_id"] = 0,
				["type"] = 0,
				["drama_id"] = 0,
				["sub_mission_id"] = 0,
				["player_level"] = 0
			}
		},
		{
			"map_label",
			new JObject
			{
				["area_id"] = 0,
				["sub_area_id"] = 0,
				["label_id"] = 0,
				["pos_x"] = 0,
				["pos_y"] = 0,
				["pos_z"] = 0,
				["status"] = 0
			}
		},
		{
			"item_obtain_jump",
			new JObject
			{
				["item_id"] = 0,
				["system_id"] = 0,
				["to_system_id"] = 0,
				["jump_info"] = new JObject()
			}
		},
		{
			"world_boss_fight_event",
			new JObject
			{
				["world_level"] = 0,
				["player_level"] = 0,
				["event_duration"] = 0,
				["world_id"] = 0,
				["monster_id"] = 0,
				["monster_swid"] = 0,
				["monster_level"] = 0,
				["monster_damage"] = 0,
				["result"] = 0,
				["team_info"] = new JArray()
			}
		},
		{
			"cdkey_event",
			new JObject
			{
				["cdkey"] = "-",
				["result"] = 0,
				["type"] = 0
			}
		},
		{
			"client_pay_request",
			new JObject
			{
				["goods_id"] = 0,
				["product_id"] = "-",
				["goods_price"] = 0,
				["goods_tier"] = "-",
				["sub_shop_id"] = 0
			}
		},
		{
			"character_skin_click",
			new JObject
			{
				["status"] = 0,
				["cosmetic_id"] = 0,
				["cosmetic_type"] = 0
			}
		},
		{
			"livearea_scene_change",
			new JObject
			{
				["livearea_id"] = 0,
				["exit_livearea_id"] = 0,
				["event_duration"] = 0,
				["livearea_character_info"] = new JArray(),
				["player_level"] = 0
			}
		},
		{
			"pipe_connect_success",
			new JObject
			{
				["area_id"] = 0,
				["sub_area_id"] = 0,
				["player_level"] = 0
			}
		},
		{
			"casual_gameplay",
			new JObject
			{
				["world_id"] = 0,
				["swid"] = 0,
				["interact_type"] = 0,
				["op_num"] = 0,
				["status"] = 0
			}
		},
		{
			"librarycontent_event",
			new JObject
			{
				["content_id"] = 0,
				["type"] = 0,
				["main_id"] = 0,
				["library_id"] = 0,
				["op"] = 0,
				["is_rednote"] = false
			}
		},
		{
			"character_trial_activity_click",
			new JObject
			{
				["activity_id"] = 0,
				["raid_id"] = 0,
				["status"] = 0
			}
		},
		{
			"popup_event",
			new JObject
			{
				["popup_id"] = 0,
				["event_duration"] = 0,
				["type"] = 0,
				["status"] = 0,
				["skip"] = false,
				["sub_shop_id"] = 0
			}
		},
		{
			"server_pay_request",
			new JObject
			{
				["goods_id"] = 0,
				["product_id"] = 0,
				["price"] = 0,
				["tier"] = "-",
				["sub_shop_id"] = 0
			}
		},
		{
			"announcement_event",
			new JObject
			{
				["announcement_id"] = 0,
				["announcement_type"] = 0,
				["type"] = 0,
				["status"] = 0
			}
		},
		{
			"world_side_exchange",
			new JObject
			{
				["world_id"] = 0,
				["trans_no"] = "-",
				["swid"] = 0,
				["pos_x"] = 0,
				["pos_y"] = 0,
				["pos_z"] = 0,
				["world_side_type"] = 0,
				["trigger_type"] = 0
			}
		},
		{
			"predownload_entry_show",
			new JObject { ["is_rednote"] = false }
		},
		{
			"predownload_entry_click",
			new JObject
			{
				["is_rednote"] = false,
				["size"] = 0,
				["target_version"] = "-"
			}
		},
		{
			"predownload_window_click",
			new JObject
			{
				["size"] = 0,
				["free_storage_size"] = 0,
				["target_version"] = "-",
				["result"] = 0,
				["type"] = 0
			}
		},
		{
			"predownload__begin",
			new JObject
			{
				["size"] = 0,
				["downloaded_size"] = 0,
				["step"] = 0,
				["target_version"] = "-",
				["is_notice_allowed"] = false
			}
		},
		{
			"predownload__end",
			new JObject
			{
				["size"] = 0,
				["step"] = 0,
				["result"] = 0,
				["type"] = 0,
				["event_duration"] = 0,
				["target_version"] = "-",
				["is_notice_allowed"] = false
			}
		},
		{
			"world_message_interaction",
			new JObject
			{
				["content"] = "-",
				["status"] = 0,
				["world_id"] = 0,
				["pos_x"] = 0,
				["pos_y"] = 0,
				["pos_z"] = 0,
				["world_side_type"] = 0
			}
		},
		{
			"share_event",
			new JObject
			{
				["lootitem"] = new JArray(),
				["media"] = 0,
				["result"] = 0
			}
		},
		{
			"cosmetic_click",
			new JObject
			{
				["cosmetic_id"] = 0,
				["quality"] = 0,
				["status"] = 0,
				["cosmetic_type"] = 0,
				["character_id"] = 0,
				["is_global"] = false
			}
		},
		{
			"gacha_click",
			new JObject
			{
				["gacha_id"] = 0,
				["gacha_type"] = 0,
				["type"] = 0
			}
		},
		{
			"player_active_duration",
			new JObject()
		},
		{
			"potion_use",
			new JObject()
		}
	};
}
