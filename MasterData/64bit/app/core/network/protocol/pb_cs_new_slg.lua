local var_0_0 = ...

local function var_0_1(arg_1_0)
	if import then
		return import("." .. arg_1_0, var_0_0)
	else
		return require(arg_1_0)
	end
end

local protobuf = require("protobuf.protobuf")
local var_0_3 = var_0_1("pb_out_base")
local var_0_4 = var_0_1("pb_bs")
local descriptor_helper = require("protobuf.descriptor_helper")
local var_0_10 = {
	C2S_NEWSLG_ENTER_ME = protobuf.Descriptor(),
	S2C_NEWSLG_ENTER_ME = protobuf.Descriptor(),
	S2C_NEWSLG_ENTER_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_MONSTERS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_USER_SHOW_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_USER_BASE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_TEAMS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_ALLIANCE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_MAIN_CITY_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_BARRACKS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_SUPPLY_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_MAX_TEAM_AUTHORITY_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_MAIN_QUEST_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_MAIN_QUEST_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_CHALLENGED_BOSS_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_BOSS_TEAMS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_MOVE_UNITS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_MAX_REPORT_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_BATTLE_PASS_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_CITY_OCCUPIER_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_CITY_BE_DECLARED_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_FARM_MAP_SHOWS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_FIRST_KILL_AWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_BOUNTY_TASK_AWARD_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_FIRST_KILL_AWARD_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_TECHNOLOGY_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_SEASON_TASKS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_SEASON_TASK_AWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ENTER_CITY_ELEMENTS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETMONSTERINFO_ME = protobuf.Descriptor(),
	C2S_NEWSLG_GETMONSTERINFO_TARGET_POS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETMONSTERINFO_MONSTER_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETMONSTERINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETMONSTERINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETMONSTERINFO_TARGET_POS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETMONSTERINFO_MONSTER_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETMONSTERINFO_MONSTER_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_MONSTERMARCH_ME = protobuf.Descriptor(),
	C2S_NEWSLG_MONSTERMARCH_MONSTER_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_MONSTERMARCH_MOVE_PATH_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_MONSTERMARCH_SUPPLY_TROOP_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_MONSTERMARCH_TEAM_INDEXS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_MONSTERMARCH_TEAMS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MONSTERMARCH_ME = protobuf.Descriptor(),
	S2C_NEWSLG_MONSTERMARCH_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MONSTERMARCH_MONSTER_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MONSTERMARCH_MONSTER_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MONSTERMARCH_MOVE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MONSTERMARCH_TEAM_INDEXS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETMAPSHOWDATA_ME = protobuf.Descriptor(),
	C2S_NEWSLG_GETMAPSHOWDATA_CENTER_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETMAPSHOWDATA_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETMAPSHOWDATA_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETMAPSHOWDATA_CENTER_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETMAPSHOWDATA_USER_SHOW_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETMAPSHOWDATA_CITY_SHOW_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETMAPSHOWDATA_BOSS_SHOW_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETMAPSHOWDATA_BOSS_AUTHORITIES_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETMAPSHOWDATA_FARM_MAP_SHOWS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_MONSTERMARCHCANCEL_ME = protobuf.Descriptor(),
	C2S_NEWSLG_MONSTERMARCHCANCEL_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MONSTERMARCHCANCEL_ME = protobuf.Descriptor(),
	S2C_NEWSLG_MONSTERMARCHCANCEL_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MONSTERMARCHCANCEL_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MONSTERMARCHCANCEL_TEAM_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_MOVEHOME_ME = protobuf.Descriptor(),
	C2S_NEWSLG_MOVEHOME_PATH_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_MOVEHOME_TARGET_POS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MOVEHOME_ME = protobuf.Descriptor(),
	S2C_NEWSLG_MOVEHOME_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MOVEHOME_PATH_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MOVEHOME_LATEST_MOVE_HOME_TIME_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MOVEHOME_TARGET_POS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_NOTIFYMAPSHOW_ME = protobuf.Descriptor(),
	S2C_NEWSLG_NOTIFYMAPSHOW_USER_SHOW_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_NOTIFYMAPSHOW_DELETED_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_LEAVE_ME = protobuf.Descriptor(),
	S2C_NEWSLG_LEAVE_ME = protobuf.Descriptor(),
	S2C_NEWSLG_LEAVE_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_NOTIFYMOVEUNIT_ME = protobuf.Descriptor(),
	S2C_NEWSLG_NOTIFYMOVEUNIT_MOVE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MONSTERBATTLEREPORT_ME = protobuf.Descriptor(),
	S2C_NEWSLG_MONSTERBATTLEREPORT_RESULT_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MONSTERBATTLEREPORT_REPORT_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETREPORT_ME = protobuf.Descriptor(),
	C2S_NEWSLG_GETREPORT_REPORT_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETREPORT_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETREPORT_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETREPORT_REPORT_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETREPORTLIST_ME = protobuf.Descriptor(),
	C2S_NEWSLG_GETREPORTLIST_SINGLE_NUM_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETREPORTLIST_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETREPORTLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETREPORTLIST_REPORTS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETREPORTLIST_FINISH_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETRANK_ME = protobuf.Descriptor(),
	C2S_NEWSLG_GETRANK_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETRANK_CITY_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETRANK_LIMIT_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETRANK_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETRANK_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETRANK_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETRANK_CITY_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETRANK_LIMIT_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETRANK_SELF_UNIT_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETRANK_RANK_UNITS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETMAPSIMPLESHOWDATA_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETMAPSIMPLESHOWDATA_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETMAPSIMPLESHOWDATA_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETMAPSIMPLESHOWDATA_SIMPLE_USER_SHOW_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETMAPSIMPLESHOWDATA_SIMPLE_CITY_SHOW_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_OBTAINBATTLEREWARD_ME = protobuf.Descriptor(),
	C2S_NEWSLG_OBTAINBATTLEREWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_OBTAINBATTLEREWARD_ME = protobuf.Descriptor(),
	S2C_NEWSLG_OBTAINBATTLEREWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_OBTAINBATTLEREWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_OBTAINBATTLEREWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_OBTAINBATTLEREWARD_PRIVILEGE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_OBTAINBATTLEREWARD_HAS_AWARD_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_EDITUSERTEAM_ME = protobuf.Descriptor(),
	C2S_NEWSLG_EDITUSERTEAM_TEAMS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_EDITUSERTEAM_ME = protobuf.Descriptor(),
	S2C_NEWSLG_EDITUSERTEAM_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_EDITUSERTEAM_TEAM_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_SYNCUSERTEAM_ME = protobuf.Descriptor(),
	S2C_NEWSLG_SYNCUSERTEAM_TEAMS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_UPGRADEMAINCITY_ME = protobuf.Descriptor(),
	C2S_NEWSLG_UPGRADEMAINCITY_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_UPGRADEMAINCITY_ME = protobuf.Descriptor(),
	S2C_NEWSLG_UPGRADEMAINCITY_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_UPGRADEMAINCITY_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_STATIONMAINCITY_ME = protobuf.Descriptor(),
	C2S_NEWSLG_STATIONMAINCITY_TP_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_STATIONMAINCITY_POS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_STATIONMAINCITY_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_STATIONMAINCITY_ME = protobuf.Descriptor(),
	S2C_NEWSLG_STATIONMAINCITY_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_STATIONMAINCITY_TP_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_STATIONMAINCITY_POS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_STATIONMAINCITY_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_UPGRADEBARRACK_ME = protobuf.Descriptor(),
	C2S_NEWSLG_UPGRADEBARRACK_TP_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_UPGRADEBARRACK_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_UPGRADEBARRACK_ME = protobuf.Descriptor(),
	S2C_NEWSLG_UPGRADEBARRACK_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_UPGRADEBARRACK_TP_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_UPGRADEBARRACK_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_UPGRADESUPPLY_ME = protobuf.Descriptor(),
	C2S_NEWSLG_UPGRADESUPPLY_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_UPGRADESUPPLY_ME = protobuf.Descriptor(),
	S2C_NEWSLG_UPGRADESUPPLY_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_UPGRADESUPPLY_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_UPGRADESUPPLY_SUPPLY_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_OBTAINSUPPLYAWARD_ME = protobuf.Descriptor(),
	S2C_NEWSLG_OBTAINSUPPLYAWARD_ME = protobuf.Descriptor(),
	S2C_NEWSLG_OBTAINSUPPLYAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_OBTAINSUPPLYAWARD_SUPPLY_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_OBTAINSUPPLYAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_USESUPPLYTOKEN_ME = protobuf.Descriptor(),
	C2S_NEWSLG_USESUPPLYTOKEN_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_USESUPPLYTOKEN_SIZE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_USESUPPLYTOKEN_ME = protobuf.Descriptor(),
	S2C_NEWSLG_USESUPPLYTOKEN_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_USESUPPLYTOKEN_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_USESUPPLYTOKEN_SIZE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_USESUPPLYTOKEN_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_CITYMARCH_ME = protobuf.Descriptor(),
	C2S_NEWSLG_CITYMARCH_CITY_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_CITYMARCH_TEAMS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_CITYMARCH_MOVE_PATH_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_CITYMARCH_SUPPLY_TROOP_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_CITYMARCH_CITY_MOVE_PATH_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_CITYMARCH_TEAM_INDEX_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_CITYMARCH_MARCH_TP_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYMARCH_ME = protobuf.Descriptor(),
	S2C_NEWSLG_CITYMARCH_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYMARCH_CITY_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYMARCH_MOVE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYMARCH_TEAM_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYMARCH_MARCH_TP_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_CITYCANCELMOVE_ME = protobuf.Descriptor(),
	C2S_NEWSLG_CITYCANCELMOVE_TEAM_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYCANCELMOVE_ME = protobuf.Descriptor(),
	S2C_NEWSLG_CITYCANCELMOVE_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYCANCELMOVE_TEAM_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYCANCELMOVE_MOVE_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETCITYGATHER_ME = protobuf.Descriptor(),
	C2S_NEWSLG_GETCITYGATHER_CITY_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETCITYGATHER_CAR_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETCITYGATHER_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETCITYGATHER_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETCITYGATHER_TEAMS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETCITYGATHER_CITY_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETCITYGATHER_CAR_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETCITYDEFINFO_ME = protobuf.Descriptor(),
	C2S_NEWSLG_GETCITYDEFINFO_CITY_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETCITYDEFINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETCITYDEFINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETCITYDEFINFO_CITY_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETCITYDEFINFO_DEF_TEAMS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETCITYDEFINFO_TEAMS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETPREDAYINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETPREDAYINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETPREDAYINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETPREDAYINFO_ALLI_RANK_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETPREDAYINFO_FIRST_CITY_SCORE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETPREDAYINFO_FIRST_CITY_SCORE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETPREDAYINFO_FIRST_ALLI_CITY_SCORE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETPREDAYINFO_FIRST_ALLI_CITY_SCORE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYNTF_ME = protobuf.Descriptor(),
	S2C_NEWSLG_CITYNTF_CITY_SHOW_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYBATTLEEND_ME = protobuf.Descriptor(),
	S2C_NEWSLG_CITYBATTLEEND_RESULT_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_SYNCUSERBASE_ME = protobuf.Descriptor(),
	S2C_NEWSLG_SYNCUSERBASE_USER_BASE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FLUSHBATTLERESULTS_ME = protobuf.Descriptor(),
	S2C_NEWSLG_FLUSHBATTLERESULTS_RESULTS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FLUSHBATTLERESULTS_CITIES_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FLUSHBATTLERESULTS_SCORE_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETUSERDETAIL_ME = protobuf.Descriptor(),
	C2S_NEWSLG_GETUSERDETAIL_UID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETUSERDETAIL_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETUSERDETAIL_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETUSERDETAIL_UID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETUSERDETAIL_DETAIL_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_SIMULATEBATTLE_ME = protobuf.Descriptor(),
	C2S_NEWSLG_SIMULATEBATTLE_ATK_AUTHORITY_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_SIMULATEBATTLE_ATK_TROOPS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_SIMULATEBATTLE_ATK_TROOP_TYPE_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_SIMULATEBATTLE_ATK_CHARACTERS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_SIMULATEBATTLE_ATK_NUM_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_SIMULATEBATTLE_DEF_AUTHORITY_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_SIMULATEBATTLE_DEF_TROOPS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_SIMULATEBATTLE_DEF_TROOP_TYPE_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_SIMULATEBATTLE_DEF_CHARACTERS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_SIMULATEBATTLE_DEF_NUM_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_SIMULATEBATTLE_BATTLE_TP_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_SIMULATEBATTLE_DEF_MONSTER_TEAM_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_SIMULATEBATTLE_ME = protobuf.Descriptor(),
	S2C_NEWSLG_SIMULATEBATTLE_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_SIMULATEBATTLE_REPORT_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_NOTIFYCHECKPOINTQUEST_ME = protobuf.Descriptor(),
	S2C_NEWSLG_NOTIFYCHECKPOINTQUEST_CHECKPOINT_QUESTS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_SYNCCITYQUESTPROGRESS_ME = protobuf.Descriptor(),
	S2C_NEWSLG_SYNCCITYQUESTPROGRESS_CITY_PROGRESS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_SYNCMAINQUESTPROGRESS_ME = protobuf.Descriptor(),
	S2C_NEWSLG_SYNCMAINQUESTPROGRESS_MAIN_QUEST_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_CITYQUESTAWARD_ME = protobuf.Descriptor(),
	C2S_NEWSLG_CITYQUESTAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYQUESTAWARD_ME = protobuf.Descriptor(),
	S2C_NEWSLG_CITYQUESTAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYQUESTAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYQUESTAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_MAINQUESTAWARD_ME = protobuf.Descriptor(),
	C2S_NEWSLG_MAINQUESTAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MAINQUESTAWARD_ME = protobuf.Descriptor(),
	S2C_NEWSLG_MAINQUESTAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MAINQUESTAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MAINQUESTAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETMATCHSERVER_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETMATCHSERVER_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETMATCHSERVER_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETMATCHSERVER_SERVERINFO_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_OBTAINPREVIEWREWARDS_ME = protobuf.Descriptor(),
	S2C_NEWSLG_OBTAINPREVIEWREWARDS_ME = protobuf.Descriptor(),
	S2C_NEWSLG_OBTAINPREVIEWREWARDS_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_OBTAINPREVIEWREWARDS_REWARDS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSCREATETEAM_ME = protobuf.Descriptor(),
	C2S_NEWSLG_BOSSCREATETEAM_BOSS_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSCREATETEAM_MOVE_PATH_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSCREATETEAM_SUPPLY_TROOP_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSCREATETEAM_TEAM_INDEX_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSCREATETEAM_TEAMS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSCREATETEAM_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOSSCREATETEAM_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSCREATETEAM_BOSS_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSCREATETEAM_MOVE_PATH_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSCREATETEAM_SUPPLY_TROOP_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSCREATETEAM_TEAM_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSCREATETEAM_TEAM_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSJOINTEAM_ME = protobuf.Descriptor(),
	C2S_NEWSLG_BOSSJOINTEAM_TEAM_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSJOINTEAM_TEAMS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSJOINTEAM_MOVE_PATH_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSJOINTEAM_SUPPLY_TROOP_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSJOINTEAM_TEAM_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSJOINTEAM_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOSSJOINTEAM_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSJOINTEAM_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSJOINTEAM_MOVE_PATH_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSJOINTEAM_SUPPLY_TROOP_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSJOINTEAM_TEAM_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSJOINTEAM_TEAM_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSTEAMKICKOUT_ME = protobuf.Descriptor(),
	C2S_NEWSLG_BOSSTEAMKICKOUT_TEAM_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSTEAMKICKOUT_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSTEAMKICKOUT_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOSSTEAMKICKOUT_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSTEAMKICKOUT_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSTEAMKICKOUT_USER_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSTRANSFERLEADER_ME = protobuf.Descriptor(),
	C2S_NEWSLG_BOSSTRANSFERLEADER_TEAM_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSTRANSFERLEADER_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSTRANSFERLEADER_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOSSTRANSFERLEADER_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSTRANSFERLEADER_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSTRANSFERLEADER_USER_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSLEAVE_ME = protobuf.Descriptor(),
	C2S_NEWSLG_BOSSLEAVE_TEAM_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSLEAVE_IS_DISMISS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSLEAVE_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOSSLEAVE_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSLEAVE_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSLEAVE_IS_DISMISSED_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSTEAMLIST_ME = protobuf.Descriptor(),
	C2S_NEWSLG_BOSSTEAMLIST_BOSS_IDS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSTEAMLIST_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSTEAMLIST_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOSSTEAMLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSTEAMLIST_BOSS_IDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSTEAMLIST_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSTEAMLIST_TEAMS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSTEAMINFO_ME = protobuf.Descriptor(),
	C2S_NEWSLG_BOSSTEAMINFO_TEAM_IDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSTEAMINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOSSTEAMINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSTEAMINFO_TEAM_IDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSTEAMINFO_TEAMS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSUSERSTATENOTIFY_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOSSUSERSTATENOTIFY_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSUSERSTATENOTIFY_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSUSERSTATENOTIFY_TP_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSUSERSTATENOTIFY_NEW_LEADER_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSUSERSTATENOTIFY_ROBOT_USERS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSTEAMJOINNOTIFY_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOSSTEAMJOINNOTIFY_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSTEAMJOINNOTIFY_JOIN_USER_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSDISMISSTEAM_ME = protobuf.Descriptor(),
	C2S_NEWSLG_BOSSDISMISSTEAM_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSDISMISSTEAM_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOSSDISMISSTEAM_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSDISMISSTEAM_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSBATTLESTARTNOTIFY_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOSSBATTLESTARTNOTIFY_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSBATTLESTARTNOTIFY_REPORT_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSBATTLESTARTNOTIFY_BOSS_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSBATTLEFINISHNOTIFY_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOSSBATTLEFINISHNOTIFY_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSBATTLEFINISHNOTIFY_RESULT_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSBATTLEFINISHNOTIFY_BOSS_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSBATTLEFINISHNOTIFY_CHALLENGED_BOSS_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSQUICKJOINTEAM_ME = protobuf.Descriptor(),
	C2S_NEWSLG_BOSSQUICKJOINTEAM_BOSS_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSQUICKJOINTEAM_MOVE_PATH_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSQUICKJOINTEAM_SUPPLY_TROOP_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSQUICKJOINTEAM_TEAM_INDEX_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSQUICKJOINTEAM_TEAMS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSQUICKJOINTEAM_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOSSQUICKJOINTEAM_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSQUICKJOINTEAM_BOSS_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSQUICKJOINTEAM_MOVE_PATH_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSQUICKJOINTEAM_SUPPLY_TROOP_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSQUICKJOINTEAM_TEAM_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSQUICKJOINTEAM_TEAM_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOSSMONSTERTEAM_ME = protobuf.Descriptor(),
	C2S_NEWSLG_BOSSMONSTERTEAM_BOSS_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSMONSTERTEAM_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOSSMONSTERTEAM_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSMONSTERTEAM_BOSS_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOSSMONSTERTEAM_TEAM_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_MOVEHOMEALLIANCEPROVINCE_ME = protobuf.Descriptor(),
	S2C_NEWSLG_MOVEHOMEALLIANCEPROVINCE_ME = protobuf.Descriptor(),
	S2C_NEWSLG_MOVEHOMEALLIANCEPROVINCE_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MOVEHOMEALLIANCEPROVINCE_POS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MOVEHOMEALLIANCEPROVINCE_LATEST_MOVE_HOME_TIME_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETUSERSHOWRANKSTATISTIC_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETUSERSHOWRANKSTATISTIC_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETUSERSHOWRANKSTATISTIC_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETUSERSHOWRANKSTATISTIC_PERSON_CONTRIBUTE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETUSERSHOWRANKSTATISTIC_ALLIANCE_CONTRIBUTE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETUSERSHOWRANKSTATISTIC_FINAL_CONTRIBUTE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_NOTIFYMONSTERBATTLERESULT_ME = protobuf.Descriptor(),
	S2C_NEWSLG_NOTIFYMONSTERBATTLERESULT_MONSTER_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_NOTIFYMONSTERBATTLERESULT_RESULT_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETMAINCITYINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETMAINCITYINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETMAINCITYINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETMAINCITYINFO_MAIN_CITY_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_NOTIFYACTINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_NOTIFYACTINFO_ACT_INFO_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_MOVETARGETRIGHTNOW_ME = protobuf.Descriptor(),
	C2S_NEWSLG_MOVETARGETRIGHTNOW_MOVE_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_MOVETARGETRIGHTNOW_END_TIME_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MOVETARGETRIGHTNOW_ME = protobuf.Descriptor(),
	S2C_NEWSLG_MOVETARGETRIGHTNOW_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MOVETARGETRIGHTNOW_MOVE_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_MOVETARGETRIGHTNOW_END_TIME_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_CITYDECLARE_ME = protobuf.Descriptor(),
	C2S_NEWSLG_CITYDECLARE_CITY_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_CITYDECLARE_TP_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYDECLARE_ME = protobuf.Descriptor(),
	S2C_NEWSLG_CITYDECLARE_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYDECLARE_CITY_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYDECLARE_TP_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYDECLARENTF_ME = protobuf.Descriptor(),
	S2C_NEWSLG_CITYDECLARENTF_CITIES_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYDECLARENTF_ALLI_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYBEDECLAREDNTF_ME = protobuf.Descriptor(),
	S2C_NEWSLG_CITYBEDECLAREDNTF_CITY_BE_DECLARED_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYMARCHNTF_ME = protobuf.Descriptor(),
	S2C_NEWSLG_CITYMARCHNTF_CITY_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYMARCHNTF_NUM_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BUILDCITY_ME = protobuf.Descriptor(),
	C2S_NEWSLG_BUILDCITY_CITY_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BUILDCITY_NUM_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BUILDCITY_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BUILDCITY_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BUILDCITY_CITY_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BUILDCITY_BUILD_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BUILDCITY_NUM_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETCITYBUILDINFO_ME = protobuf.Descriptor(),
	C2S_NEWSLG_GETCITYBUILDINFO_CITY_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETCITYBUILDINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETCITYBUILDINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETCITYBUILDINFO_CITY_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETCITYBUILDINFO_BUILD_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYBATTLEALLISUMMARYNTF_ME = protobuf.Descriptor(),
	S2C_NEWSLG_CITYBATTLEALLISUMMARYNTF_ALLI_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYBATTLEALLISUMMARYNTF_CITIES_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYBATTLEALLISUMMARYNTF_SCORE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYBATTLEALLISUMMARYNTF_SCORE_ADDITION_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETINFOONCITYBATTLEEND_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETINFOONCITYBATTLEEND_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETINFOONCITYBATTLEEND_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETINFOONCITYBATTLEEND_CITY_OCCUPIER_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETINFOONCITYBATTLEEND_SCORE_ADDITION_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETINFOONCITYBATTLEEND_RES_ADDITION_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETINFOONCITYBATTLEEND_GIVE_UP_CITY_IDS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_SETCITYDECLARATION_ME = protobuf.Descriptor(),
	C2S_NEWSLG_SETCITYDECLARATION_CITY_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_SETCITYDECLARATION_DECLARATION_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_SETCITYDECLARATION_ME = protobuf.Descriptor(),
	S2C_NEWSLG_SETCITYDECLARATION_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_SETCITYDECLARATION_CITY_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_SETCITYDECLARATION_DECLARATION_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETCITYSHOWDATA_ME = protobuf.Descriptor(),
	C2S_NEWSLG_GETCITYSHOWDATA_CITY_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETCITYSHOWDATA_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETCITYSHOWDATA_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETCITYSHOWDATA_SHOWS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_OBTAINQUESTREWARD_ME = protobuf.Descriptor(),
	C2S_NEWSLG_OBTAINQUESTREWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_OBTAINQUESTREWARD_ME = protobuf.Descriptor(),
	S2C_NEWSLG_OBTAINQUESTREWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_OBTAINQUESTREWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_OBTAINQUESTREWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_ONEKEYOBTAINREWARDS_ME = protobuf.Descriptor(),
	C2S_NEWSLG_ONEKEYOBTAINREWARDS_TYPE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ONEKEYOBTAINREWARDS_ME = protobuf.Descriptor(),
	S2C_NEWSLG_ONEKEYOBTAINREWARDS_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ONEKEYOBTAINREWARDS_TYPE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ONEKEYOBTAINREWARDS_IDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ONEKEYOBTAINREWARDS_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_DELETEMOVEUNIT_ME = protobuf.Descriptor(),
	S2C_NEWSLG_DELETEMOVEUNIT_MOVE_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_USERACHIEVEMENTNTF_ME = protobuf.Descriptor(),
	S2C_NEWSLG_USERACHIEVEMENTNTF_ACHIEVEMENTS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETUSERSHOWSTATISTIC_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETUSERSHOWSTATISTIC_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETUSERSHOWSTATISTIC_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETUSERSHOWSTATISTIC_KILL_MONSTER_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETUSERSHOWSTATISTIC_BOSS_TEAM_WIN_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETUSERSHOWSTATISTIC_ATTACK_CITY_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_ASSISTCITY_ME = protobuf.Descriptor(),
	C2S_NEWSLG_ASSISTCITY_CITY_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ASSISTCITY_ME = protobuf.Descriptor(),
	S2C_NEWSLG_ASSISTCITY_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ASSISTCITY_CITY_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_ASSISTCITYNTF_ME = protobuf.Descriptor(),
	S2C_NEWSLG_ASSISTCITYNTF_ASSIST_CITY_AUTHORITY_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYOCCUPIERNTF_ME = protobuf.Descriptor(),
	S2C_NEWSLG_CITYOCCUPIERNTF_CITY_OCCUPIER_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_CITYELEMENTNTF_ME = protobuf.Descriptor(),
	S2C_NEWSLG_CITYELEMENTNTF_CITY_ELEMENTS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETSMALLMAPINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETSMALLMAPINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETSMALLMAPINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETSMALLMAPINFO_INFO_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETALLIANCEINFO_ME = protobuf.Descriptor(),
	C2S_NEWSLG_GETALLIANCEINFO_USER_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETALLIANCEINFO_ALLIANCE_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETALLIANCEINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETALLIANCEINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETALLIANCEINFO_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETALLIANCEINFO_ALLIANCE_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETALLIANCEINFO_INFO_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_SETALLIANCESTRATEGY_ME = protobuf.Descriptor(),
	C2S_NEWSLG_SETALLIANCESTRATEGY_ALLI_STRATEGY_BASE_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_SETALLIANCESTRATEGY_ME = protobuf.Descriptor(),
	S2C_NEWSLG_SETALLIANCESTRATEGY_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_SETALLIANCESTRATEGY_ALLI_STRATEGY_BASE_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_NOTIFYALLIANCESTRATEGY_ME = protobuf.Descriptor(),
	S2C_NEWSLG_NOTIFYALLIANCESTRATEGY_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_NOTIFYALLIANCESTRATEGY_ALLI_STRATEGY_BASE_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_FARMMARCH_ME = protobuf.Descriptor(),
	C2S_NEWSLG_FARMMARCH_FARM_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_FARMMARCH_MOVE_PATH_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_FARMMARCH_SUPPLY_TROOP_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_FARMMARCH_TEAMS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_FARMMARCH_TEAM_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMMARCH_ME = protobuf.Descriptor(),
	S2C_NEWSLG_FARMMARCH_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMMARCH_FARM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMMARCH_MOVE_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMMARCH_TEAM_INDEX_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_FARMCANCELMOVE_ME = protobuf.Descriptor(),
	C2S_NEWSLG_FARMCANCELMOVE_TEAM_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMCANCELMOVE_ME = protobuf.Descriptor(),
	S2C_NEWSLG_FARMCANCELMOVE_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMCANCELMOVE_TEAM_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMCANCELMOVE_MOVE_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETFARMDEFINFO_ME = protobuf.Descriptor(),
	C2S_NEWSLG_GETFARMDEFINFO_FARM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETFARMDEFINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETFARMDEFINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETFARMDEFINFO_FARM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETFARMDEFINFO_DEF_DATA_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETFARMBATTLEINFO_ME = protobuf.Descriptor(),
	C2S_NEWSLG_GETFARMBATTLEINFO_FARM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETFARMBATTLEINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETFARMBATTLEINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETFARMBATTLEINFO_FARM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETFARMBATTLEINFO_ATK_DATA_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMMAPSHOWNTF_ME = protobuf.Descriptor(),
	S2C_NEWSLG_FARMMAPSHOWNTF_FARM_MAP_SHOWS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMBATTLEREPORT_ME = protobuf.Descriptor(),
	S2C_NEWSLG_FARMBATTLEREPORT_RESULT_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMBATTLEREPORT_REPORT_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_FARMGIVEUP_ME = protobuf.Descriptor(),
	C2S_NEWSLG_FARMGIVEUP_FARM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMGIVEUP_ME = protobuf.Descriptor(),
	S2C_NEWSLG_FARMGIVEUP_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMGIVEUP_FARM_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_GETUSERFARMINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETUSERFARMINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_GETUSERFARMINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETUSERFARMINFO_FARM_NUM_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETUSERFARMINFO_FARMS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_GETUSERFARMINFO_DAILY_FARM_KILL_SCORE_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_USEFARMTOKEN_ME = protobuf.Descriptor(),
	C2S_NEWSLG_USEFARMTOKEN_FARM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_USEFARMTOKEN_ME = protobuf.Descriptor(),
	S2C_NEWSLG_USEFARMTOKEN_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_USEFARMTOKEN_FARM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_USEFARMTOKEN_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMAWARD_ME = protobuf.Descriptor(),
	S2C_NEWSLG_FARMAWARD_TP_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMAWARD_FARM_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMAWARD_ROB_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FARMAWARD_ROB_SIZE_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOUNTYINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOUNTYINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOUNTYINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOUNTYINFO_BOUNTY_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOUNTYREFRESHTASK_ME = protobuf.Descriptor(),
	C2S_NEWSLG_BOUNTYREFRESHTASK_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOUNTYREFRESHTASK_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOUNTYREFRESHTASK_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOUNTYREFRESHTASK_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOUNTYREFRESHTASK_TASK_DAILY_REFRESH_TIMES_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOUNTYREFRESHTASK_TASK_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_BOUNTYTASKAWARD_ME = protobuf.Descriptor(),
	C2S_NEWSLG_BOUNTYTASKAWARD_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOUNTYTASKAWARD_ME = protobuf.Descriptor(),
	S2C_NEWSLG_BOUNTYTASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOUNTYTASKAWARD_INDEX_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOUNTYTASKAWARD_TASK_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_BOUNTYTASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_FIRSTKILLINFO_ME = protobuf.Descriptor(),
	C2S_NEWSLG_FIRSTKILLINFO_IDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FIRSTKILLINFO_ME = protobuf.Descriptor(),
	S2C_NEWSLG_FIRSTKILLINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FIRSTKILLINFO_IDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FIRSTKILLINFO_FIRST_KILLS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_FIRSTKILLAWARD_ME = protobuf.Descriptor(),
	C2S_NEWSLG_FIRSTKILLAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FIRSTKILLAWARD_ME = protobuf.Descriptor(),
	S2C_NEWSLG_FIRSTKILLAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FIRSTKILLAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FIRSTKILLAWARD_FIRST_KILL_AWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FIRSTKILLAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_FIRSTKILLNOTIFY_ME = protobuf.Descriptor(),
	S2C_NEWSLG_FIRSTKILLNOTIFY_INFO_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_SEASONTASKSYNCPROGRESS_ME = protobuf.Descriptor(),
	S2C_NEWSLG_SEASONTASKSYNCPROGRESS_TASKS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_SEASONTASKAWARD_ME = protobuf.Descriptor(),
	C2S_NEWSLG_SEASONTASKAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_SEASONTASKAWARD_ME = protobuf.Descriptor(),
	S2C_NEWSLG_SEASONTASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_SEASONTASKAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_SEASONTASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_TECHNOLOGYACTIVATE_ME = protobuf.Descriptor(),
	C2S_NEWSLG_TECHNOLOGYACTIVATE_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_TECHNOLOGYACTIVATE_ME = protobuf.Descriptor(),
	S2C_NEWSLG_TECHNOLOGYACTIVATE_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_TECHNOLOGYACTIVATE_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_TECHNOLOGYUPDATE_ME = protobuf.Descriptor(),
	S2C_NEWSLG_TECHNOLOGYUPDATE_POINT_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_TECHNOLOGYACTIVATEONEKEY_ME = protobuf.Descriptor(),
	C2S_NEWSLG_TECHNOLOGYACTIVATEONEKEY_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_TECHNOLOGYACTIVATEONEKEY_LOCATION_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_TECHNOLOGYACTIVATEONEKEY_ME = protobuf.Descriptor(),
	S2C_NEWSLG_TECHNOLOGYACTIVATEONEKEY_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_TECHNOLOGYACTIVATEONEKEY_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_TECHNOLOGYACTIVATEONEKEY_LOCATION_F = protobuf.FieldDescriptor(),
	S2C_NEWSLG_TECHNOLOGYACTIVATEONEKEY_ACTIVATE_IDS_F = protobuf.FieldDescriptor(),
	C2S_NEWSLG_TECHNOLOGYRESET_ME = protobuf.Descriptor(),
	S2C_NEWSLG_TECHNOLOGYRESET_ME = protobuf.Descriptor(),
	S2C_NEWSLG_TECHNOLOGYRESET_RET_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_ENTER_ME, {
	"C2S_NewSlg_Enter",
	".cs.C2S_NewSlg_Enter",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_RET_F, {
	"ret",
	".cs.S2C_NewSlg_Enter.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_MONSTERS_F, {
	"monsters",
	".cs.S2C_NewSlg_Enter.monsters",
	2,
	1,
	3,
	false,
	{},
	var_0_3.NEWSLGMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_USER_SHOW_F, {
	"user_show",
	".cs.S2C_NewSlg_Enter.user_show",
	3,
	2,
	3,
	false,
	{},
	var_0_3.NEWSLGMAPUSERSHOW_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_USER_BASE_F, {
	"user_base",
	".cs.S2C_NewSlg_Enter.user_base",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.NEWSLGUSERBASE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_TEAMS_F, {
	"teams",
	".cs.S2C_NewSlg_Enter.teams",
	5,
	4,
	3,
	false,
	{},
	var_0_3.NEWSLGUSERTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_ALLIANCE_F, {
	"alliance",
	".cs.S2C_NewSlg_Enter.alliance",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.NEWSLGALLIANCE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_MAIN_CITY_F, {
	"main_city",
	".cs.S2C_NewSlg_Enter.main_city",
	7,
	6,
	1,
	false,
	nil,
	var_0_3.NEWSLGMAINCITY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_BARRACKS_F, {
	"barracks",
	".cs.S2C_NewSlg_Enter.barracks",
	8,
	7,
	3,
	false,
	{},
	var_0_3.NEWSLGBARRACK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_SUPPLY_F, {
	"supply",
	".cs.S2C_NewSlg_Enter.supply",
	9,
	8,
	1,
	false,
	nil,
	var_0_3.NEWSLGSUPPLY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_MAX_TEAM_AUTHORITY_F, {
	"max_team_authority",
	".cs.S2C_NewSlg_Enter.max_team_authority",
	10,
	9,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_MAIN_QUEST_ID_F, {
	"main_quest_id",
	".cs.S2C_NewSlg_Enter.main_quest_id",
	11,
	10,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_MAIN_QUEST_F, {
	"main_quest",
	".cs.S2C_NewSlg_Enter.main_quest",
	12,
	11,
	1,
	false,
	nil,
	var_0_3.COMMONTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_CHALLENGED_BOSS_LEVEL_F, {
	"challenged_boss_level",
	".cs.S2C_NewSlg_Enter.challenged_boss_level",
	13,
	12,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_BOSS_TEAMS_F, {
	"boss_teams",
	".cs.S2C_NewSlg_Enter.boss_teams",
	14,
	13,
	3,
	false,
	{},
	var_0_3.NEWSLGBOSSTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_MOVE_UNITS_F, {
	"move_units",
	".cs.S2C_NewSlg_Enter.move_units",
	15,
	14,
	3,
	false,
	{},
	var_0_3.NEWSLGMOVEUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_MAX_REPORT_ID_F, {
	"max_report_id",
	".cs.S2C_NewSlg_Enter.max_report_id",
	16,
	15,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_BATTLE_PASS_ID_F, {
	"battle_pass_id",
	".cs.S2C_NewSlg_Enter.battle_pass_id",
	17,
	16,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_CITY_OCCUPIER_F, {
	"city_occupier",
	".cs.S2C_NewSlg_Enter.city_occupier",
	19,
	17,
	3,
	false,
	{},
	var_0_3.KV2_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_CITY_BE_DECLARED_F, {
	"city_be_declared",
	".cs.S2C_NewSlg_Enter.city_be_declared",
	20,
	18,
	3,
	false,
	{},
	var_0_3.NEWSLGCITYDECLAREDALLI_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_FARM_MAP_SHOWS_F, {
	"farm_map_shows",
	".cs.S2C_NewSlg_Enter.farm_map_shows",
	21,
	19,
	3,
	false,
	{},
	var_0_3.NEWSLGFARMMAPSHOW_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_FIRST_KILL_AWARD_IDS_F, {
	"first_kill_award_ids",
	".cs.S2C_NewSlg_Enter.first_kill_award_ids",
	22,
	20,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_BOUNTY_TASK_AWARD_F, {
	"bounty_task_award",
	".cs.S2C_NewSlg_Enter.bounty_task_award",
	23,
	21,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_FIRST_KILL_AWARD_F, {
	"first_kill_award",
	".cs.S2C_NewSlg_Enter.first_kill_award",
	24,
	22,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_TECHNOLOGY_F, {
	"technology",
	".cs.S2C_NewSlg_Enter.technology",
	25,
	23,
	1,
	false,
	nil,
	var_0_3.NEWSLGTECHNOLOGY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_SEASON_TASKS_F, {
	"season_tasks",
	".cs.S2C_NewSlg_Enter.season_tasks",
	26,
	24,
	3,
	false,
	{},
	var_0_3.COMMONTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_SEASON_TASK_AWARD_IDS_F, {
	"season_task_award_ids",
	".cs.S2C_NewSlg_Enter.season_task_award_ids",
	27,
	25,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ENTER_CITY_ELEMENTS_F, {
	"city_elements",
	".cs.S2C_NewSlg_Enter.city_elements",
	28,
	26,
	3,
	false,
	{},
	var_0_3.NEWSLGCITYELEMENT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_ENTER_ME, {
	"S2C_NewSlg_Enter",
	".cs.S2C_NewSlg_Enter",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_ENTER_RET_F,
		var_0_10.S2C_NEWSLG_ENTER_MONSTERS_F,
		var_0_10.S2C_NEWSLG_ENTER_USER_SHOW_F,
		var_0_10.S2C_NEWSLG_ENTER_USER_BASE_F,
		var_0_10.S2C_NEWSLG_ENTER_TEAMS_F,
		var_0_10.S2C_NEWSLG_ENTER_ALLIANCE_F,
		var_0_10.S2C_NEWSLG_ENTER_MAIN_CITY_F,
		var_0_10.S2C_NEWSLG_ENTER_BARRACKS_F,
		var_0_10.S2C_NEWSLG_ENTER_SUPPLY_F,
		var_0_10.S2C_NEWSLG_ENTER_MAX_TEAM_AUTHORITY_F,
		var_0_10.S2C_NEWSLG_ENTER_MAIN_QUEST_ID_F,
		var_0_10.S2C_NEWSLG_ENTER_MAIN_QUEST_F,
		var_0_10.S2C_NEWSLG_ENTER_CHALLENGED_BOSS_LEVEL_F,
		var_0_10.S2C_NEWSLG_ENTER_BOSS_TEAMS_F,
		var_0_10.S2C_NEWSLG_ENTER_MOVE_UNITS_F,
		var_0_10.S2C_NEWSLG_ENTER_MAX_REPORT_ID_F,
		var_0_10.S2C_NEWSLG_ENTER_BATTLE_PASS_ID_F,
		var_0_10.S2C_NEWSLG_ENTER_CITY_OCCUPIER_F,
		var_0_10.S2C_NEWSLG_ENTER_CITY_BE_DECLARED_F,
		var_0_10.S2C_NEWSLG_ENTER_FARM_MAP_SHOWS_F,
		var_0_10.S2C_NEWSLG_ENTER_FIRST_KILL_AWARD_IDS_F,
		var_0_10.S2C_NEWSLG_ENTER_BOUNTY_TASK_AWARD_F,
		var_0_10.S2C_NEWSLG_ENTER_FIRST_KILL_AWARD_F,
		var_0_10.S2C_NEWSLG_ENTER_TECHNOLOGY_F,
		var_0_10.S2C_NEWSLG_ENTER_SEASON_TASKS_F,
		var_0_10.S2C_NEWSLG_ENTER_SEASON_TASK_AWARD_IDS_F,
		var_0_10.S2C_NEWSLG_ENTER_CITY_ELEMENTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETMONSTERINFO_TARGET_POS_F, {
	"target_pos",
	".cs.C2S_NewSlg_GetMonsterInfo.target_pos",
	1,
	0,
	2,
	false,
	nil,
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETMONSTERINFO_MONSTER_ID_F, {
	"monster_id",
	".cs.C2S_NewSlg_GetMonsterInfo.monster_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETMONSTERINFO_ME, {
	"C2S_NewSlg_GetMonsterInfo",
	".cs.C2S_NewSlg_GetMonsterInfo",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_GETMONSTERINFO_TARGET_POS_F,
		var_0_10.C2S_NEWSLG_GETMONSTERINFO_MONSTER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMONSTERINFO_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetMonsterInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMONSTERINFO_TARGET_POS_F, {
	"target_pos",
	".cs.S2C_NewSlg_GetMonsterInfo.target_pos",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMONSTERINFO_MONSTER_ID_F, {
	"monster_id",
	".cs.S2C_NewSlg_GetMonsterInfo.monster_id",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMONSTERINFO_MONSTER_F, {
	"monster",
	".cs.S2C_NewSlg_GetMonsterInfo.monster",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.NEWSLGMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETMONSTERINFO_ME, {
	"S2C_NewSlg_GetMonsterInfo",
	".cs.S2C_NewSlg_GetMonsterInfo",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETMONSTERINFO_RET_F,
		var_0_10.S2C_NEWSLG_GETMONSTERINFO_TARGET_POS_F,
		var_0_10.S2C_NEWSLG_GETMONSTERINFO_MONSTER_ID_F,
		var_0_10.S2C_NEWSLG_GETMONSTERINFO_MONSTER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_MONSTERMARCH_MONSTER_ID_F, {
	"monster_id",
	".cs.C2S_NewSlg_MonsterMarch.monster_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_MONSTERMARCH_MOVE_PATH_F, {
	"move_path",
	".cs.C2S_NewSlg_MonsterMarch.move_path",
	3,
	1,
	3,
	false,
	{},
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_MONSTERMARCH_SUPPLY_TROOP_F, {
	"supply_troop",
	".cs.C2S_NewSlg_MonsterMarch.supply_troop",
	4,
	2,
	1,
	false,
	0,
	nil,
	nil,
	3,
	2
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_MONSTERMARCH_TEAM_INDEXS_F, {
	"team_indexs",
	".cs.C2S_NewSlg_MonsterMarch.team_indexs",
	5,
	3,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_MONSTERMARCH_TEAMS_F, {
	"teams",
	".cs.C2S_NewSlg_MonsterMarch.teams",
	6,
	4,
	3,
	false,
	{},
	var_0_3.NEWSLGUSERTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_MONSTERMARCH_ME, {
	"C2S_NewSlg_MonsterMarch",
	".cs.C2S_NewSlg_MonsterMarch",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_MONSTERMARCH_MONSTER_ID_F,
		var_0_10.C2S_NEWSLG_MONSTERMARCH_MOVE_PATH_F,
		var_0_10.C2S_NEWSLG_MONSTERMARCH_SUPPLY_TROOP_F,
		var_0_10.C2S_NEWSLG_MONSTERMARCH_TEAM_INDEXS_F,
		var_0_10.C2S_NEWSLG_MONSTERMARCH_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MONSTERMARCH_RET_F, {
	"ret",
	".cs.S2C_NewSlg_MonsterMarch.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MONSTERMARCH_MONSTER_ID_F, {
	"monster_id",
	".cs.S2C_NewSlg_MonsterMarch.monster_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MONSTERMARCH_MONSTER_F, {
	"monster",
	".cs.S2C_NewSlg_MonsterMarch.monster",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.NEWSLGMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MONSTERMARCH_MOVE_F, {
	"move",
	".cs.S2C_NewSlg_MonsterMarch.move",
	4,
	3,
	3,
	false,
	{},
	var_0_3.NEWSLGSIMPLEMOVE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MONSTERMARCH_TEAM_INDEXS_F, {
	"team_indexs",
	".cs.S2C_NewSlg_MonsterMarch.team_indexs",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_MONSTERMARCH_ME, {
	"S2C_NewSlg_MonsterMarch",
	".cs.S2C_NewSlg_MonsterMarch",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_MONSTERMARCH_RET_F,
		var_0_10.S2C_NEWSLG_MONSTERMARCH_MONSTER_ID_F,
		var_0_10.S2C_NEWSLG_MONSTERMARCH_MONSTER_F,
		var_0_10.S2C_NEWSLG_MONSTERMARCH_MOVE_F,
		var_0_10.S2C_NEWSLG_MONSTERMARCH_TEAM_INDEXS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETMAPSHOWDATA_CENTER_F, {
	"center",
	".cs.C2S_NewSlg_GetMapShowData.center",
	1,
	0,
	2,
	false,
	nil,
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETMAPSHOWDATA_ME, {
	"C2S_NewSlg_GetMapShowData",
	".cs.C2S_NewSlg_GetMapShowData",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_GETMAPSHOWDATA_CENTER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMAPSHOWDATA_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetMapShowData.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMAPSHOWDATA_CENTER_F, {
	"center",
	".cs.S2C_NewSlg_GetMapShowData.center",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMAPSHOWDATA_USER_SHOW_F, {
	"user_show",
	".cs.S2C_NewSlg_GetMapShowData.user_show",
	3,
	2,
	3,
	false,
	{},
	var_0_3.NEWSLGMAPUSERSHOW_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMAPSHOWDATA_CITY_SHOW_F, {
	"city_show",
	".cs.S2C_NewSlg_GetMapShowData.city_show",
	4,
	3,
	3,
	false,
	{},
	var_0_3.NEWSLGMAPCITYSHOW_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMAPSHOWDATA_BOSS_SHOW_F, {
	"boss_show",
	".cs.S2C_NewSlg_GetMapShowData.boss_show",
	5,
	4,
	3,
	false,
	{},
	var_0_3.NEWSLGMAPBOSSSHOW_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMAPSHOWDATA_BOSS_AUTHORITIES_F, {
	"boss_authorities",
	".cs.S2C_NewSlg_GetMapShowData.boss_authorities",
	6,
	5,
	3,
	false,
	{},
	var_0_3.KV2_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMAPSHOWDATA_FARM_MAP_SHOWS_F, {
	"farm_map_shows",
	".cs.S2C_NewSlg_GetMapShowData.farm_map_shows",
	7,
	6,
	3,
	false,
	{},
	var_0_3.NEWSLGFARMMAPSHOW_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETMAPSHOWDATA_ME, {
	"S2C_NewSlg_GetMapShowData",
	".cs.S2C_NewSlg_GetMapShowData",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETMAPSHOWDATA_RET_F,
		var_0_10.S2C_NEWSLG_GETMAPSHOWDATA_CENTER_F,
		var_0_10.S2C_NEWSLG_GETMAPSHOWDATA_USER_SHOW_F,
		var_0_10.S2C_NEWSLG_GETMAPSHOWDATA_CITY_SHOW_F,
		var_0_10.S2C_NEWSLG_GETMAPSHOWDATA_BOSS_SHOW_F,
		var_0_10.S2C_NEWSLG_GETMAPSHOWDATA_BOSS_AUTHORITIES_F,
		var_0_10.S2C_NEWSLG_GETMAPSHOWDATA_FARM_MAP_SHOWS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_MONSTERMARCHCANCEL_INDEX_F, {
	"index",
	".cs.C2S_NewSlg_MonsterMarchCancel.index",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_MONSTERMARCHCANCEL_ME, {
	"C2S_NewSlg_MonsterMarchCancel",
	".cs.C2S_NewSlg_MonsterMarchCancel",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_MONSTERMARCHCANCEL_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MONSTERMARCHCANCEL_RET_F, {
	"ret",
	".cs.S2C_NewSlg_MonsterMarchCancel.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MONSTERMARCHCANCEL_INDEX_F, {
	"index",
	".cs.S2C_NewSlg_MonsterMarchCancel.index",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MONSTERMARCHCANCEL_TEAM_F, {
	"team",
	".cs.S2C_NewSlg_MonsterMarchCancel.team",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.NEWSLGUSERTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_MONSTERMARCHCANCEL_ME, {
	"S2C_NewSlg_MonsterMarchCancel",
	".cs.S2C_NewSlg_MonsterMarchCancel",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_MONSTERMARCHCANCEL_RET_F,
		var_0_10.S2C_NEWSLG_MONSTERMARCHCANCEL_INDEX_F,
		var_0_10.S2C_NEWSLG_MONSTERMARCHCANCEL_TEAM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_MOVEHOME_PATH_F, {
	"path",
	".cs.C2S_NewSlg_MoveHome.path",
	1,
	0,
	3,
	false,
	{},
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_MOVEHOME_TARGET_POS_F, {
	"target_pos",
	".cs.C2S_NewSlg_MoveHome.target_pos",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_MOVEHOME_ME, {
	"C2S_NewSlg_MoveHome",
	".cs.C2S_NewSlg_MoveHome",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_MOVEHOME_PATH_F,
		var_0_10.C2S_NEWSLG_MOVEHOME_TARGET_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MOVEHOME_RET_F, {
	"ret",
	".cs.S2C_NewSlg_MoveHome.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MOVEHOME_PATH_F, {
	"path",
	".cs.S2C_NewSlg_MoveHome.path",
	2,
	1,
	3,
	false,
	{},
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MOVEHOME_LATEST_MOVE_HOME_TIME_F, {
	"latest_move_home_time",
	".cs.S2C_NewSlg_MoveHome.latest_move_home_time",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MOVEHOME_TARGET_POS_F, {
	"target_pos",
	".cs.S2C_NewSlg_MoveHome.target_pos",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_MOVEHOME_ME, {
	"S2C_NewSlg_MoveHome",
	".cs.S2C_NewSlg_MoveHome",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_MOVEHOME_RET_F,
		var_0_10.S2C_NEWSLG_MOVEHOME_PATH_F,
		var_0_10.S2C_NEWSLG_MOVEHOME_LATEST_MOVE_HOME_TIME_F,
		var_0_10.S2C_NEWSLG_MOVEHOME_TARGET_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_NOTIFYMAPSHOW_USER_SHOW_F, {
	"user_show",
	".cs.S2C_NewSlg_NotifyMapShow.user_show",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.NEWSLGMAPUSERSHOW_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_NOTIFYMAPSHOW_DELETED_F, {
	"deleted",
	".cs.S2C_NewSlg_NotifyMapShow.deleted",
	2,
	1,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_NOTIFYMAPSHOW_ME, {
	"S2C_NewSlg_NotifyMapShow",
	".cs.S2C_NewSlg_NotifyMapShow",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_NOTIFYMAPSHOW_USER_SHOW_F,
		var_0_10.S2C_NEWSLG_NOTIFYMAPSHOW_DELETED_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_LEAVE_ME, {
	"C2S_NewSlg_Leave",
	".cs.C2S_NewSlg_Leave",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_LEAVE_RET_F, {
	"ret",
	".cs.S2C_NewSlg_Leave.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_LEAVE_ME, {
	"S2C_NewSlg_Leave",
	".cs.S2C_NewSlg_Leave",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_LEAVE_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_NOTIFYMOVEUNIT_MOVE_F, {
	"move",
	".cs.S2C_NewSlg_NotifyMoveUnit.move",
	2,
	0,
	1,
	false,
	nil,
	var_0_3.NEWSLGMOVEUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_NOTIFYMOVEUNIT_ME, {
	"S2C_NewSlg_NotifyMoveUnit",
	".cs.S2C_NewSlg_NotifyMoveUnit",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_NOTIFYMOVEUNIT_MOVE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MONSTERBATTLEREPORT_RESULT_F, {
	"result",
	".cs.S2C_NewSlg_MonsterBattleReport.result",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.NEWSLGBATTLERESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MONSTERBATTLEREPORT_REPORT_F, {
	"report",
	".cs.S2C_NewSlg_MonsterBattleReport.report",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.NEWSLGBATTLEREPORT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_MONSTERBATTLEREPORT_ME, {
	"S2C_NewSlg_MonsterBattleReport",
	".cs.S2C_NewSlg_MonsterBattleReport",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_MONSTERBATTLEREPORT_RESULT_F,
		var_0_10.S2C_NEWSLG_MONSTERBATTLEREPORT_REPORT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETREPORT_REPORT_ID_F, {
	"report_id",
	".cs.C2S_NewSlg_GetReport.report_id",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETREPORT_ME, {
	"C2S_NewSlg_GetReport",
	".cs.C2S_NewSlg_GetReport",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_GETREPORT_REPORT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETREPORT_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetReport.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETREPORT_REPORT_F, {
	"report",
	".cs.S2C_NewSlg_GetReport.report",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.NEWSLGBATTLEREPORT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETREPORT_ME, {
	"S2C_NewSlg_GetReport",
	".cs.S2C_NewSlg_GetReport",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETREPORT_RET_F,
		var_0_10.S2C_NEWSLG_GETREPORT_REPORT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETREPORTLIST_SINGLE_NUM_F, {
	"single_num",
	".cs.C2S_NewSlg_GetReportList.single_num",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETREPORTLIST_ME, {
	"C2S_NewSlg_GetReportList",
	".cs.C2S_NewSlg_GetReportList",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_GETREPORTLIST_SINGLE_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETREPORTLIST_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetReportList.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETREPORTLIST_REPORTS_F, {
	"reports",
	".cs.S2C_NewSlg_GetReportList.reports",
	2,
	1,
	3,
	false,
	{},
	var_0_3.NEWSLGBATTLEREPORTSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETREPORTLIST_FINISH_F, {
	"finish",
	".cs.S2C_NewSlg_GetReportList.finish",
	3,
	2,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETREPORTLIST_ME, {
	"S2C_NewSlg_GetReportList",
	".cs.S2C_NewSlg_GetReportList",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETREPORTLIST_RET_F,
		var_0_10.S2C_NEWSLG_GETREPORTLIST_REPORTS_F,
		var_0_10.S2C_NEWSLG_GETREPORTLIST_FINISH_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETRANK_ID_F, {
	"id",
	".cs.C2S_NewSlg_GetRank.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETRANK_CITY_ID_F, {
	"city_id",
	".cs.C2S_NewSlg_GetRank.city_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETRANK_LIMIT_F, {
	"limit",
	".cs.C2S_NewSlg_GetRank.limit",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETRANK_ME, {
	"C2S_NewSlg_GetRank",
	".cs.C2S_NewSlg_GetRank",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_GETRANK_ID_F,
		var_0_10.C2S_NEWSLG_GETRANK_CITY_ID_F,
		var_0_10.C2S_NEWSLG_GETRANK_LIMIT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETRANK_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetRank.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETRANK_ID_F, {
	"id",
	".cs.S2C_NewSlg_GetRank.id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETRANK_CITY_ID_F, {
	"city_id",
	".cs.S2C_NewSlg_GetRank.city_id",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETRANK_LIMIT_F, {
	"limit",
	".cs.S2C_NewSlg_GetRank.limit",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETRANK_SELF_UNIT_F, {
	"self_unit",
	".cs.S2C_NewSlg_GetRank.self_unit",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.RANKUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETRANK_RANK_UNITS_F, {
	"rank_units",
	".cs.S2C_NewSlg_GetRank.rank_units",
	6,
	5,
	3,
	false,
	{},
	var_0_3.RANKUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETRANK_ME, {
	"S2C_NewSlg_GetRank",
	".cs.S2C_NewSlg_GetRank",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETRANK_RET_F,
		var_0_10.S2C_NEWSLG_GETRANK_ID_F,
		var_0_10.S2C_NEWSLG_GETRANK_CITY_ID_F,
		var_0_10.S2C_NEWSLG_GETRANK_LIMIT_F,
		var_0_10.S2C_NEWSLG_GETRANK_SELF_UNIT_F,
		var_0_10.S2C_NEWSLG_GETRANK_RANK_UNITS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETMAPSIMPLESHOWDATA_ME, {
	"C2S_NewSlg_GetMapSimpleShowData",
	".cs.C2S_NewSlg_GetMapSimpleShowData",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMAPSIMPLESHOWDATA_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetMapSimpleShowData.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMAPSIMPLESHOWDATA_SIMPLE_USER_SHOW_F, {
	"simple_user_show",
	".cs.S2C_NewSlg_GetMapSimpleShowData.simple_user_show",
	2,
	1,
	3,
	false,
	{},
	var_0_3.NEWSLGMAPSIMPLEUSERSHOW_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMAPSIMPLESHOWDATA_SIMPLE_CITY_SHOW_F, {
	"simple_city_show",
	".cs.S2C_NewSlg_GetMapSimpleShowData.simple_city_show",
	3,
	2,
	3,
	false,
	{},
	var_0_3.NEWSLGMAPSIMPLECITYSHOW_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETMAPSIMPLESHOWDATA_ME, {
	"S2C_NewSlg_GetMapSimpleShowData",
	".cs.S2C_NewSlg_GetMapSimpleShowData",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETMAPSIMPLESHOWDATA_RET_F,
		var_0_10.S2C_NEWSLG_GETMAPSIMPLESHOWDATA_SIMPLE_USER_SHOW_F,
		var_0_10.S2C_NEWSLG_GETMAPSIMPLESHOWDATA_SIMPLE_CITY_SHOW_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_OBTAINBATTLEREWARD_ID_F, {
	"id",
	".cs.C2S_NewSlg_ObtainBattleReward.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_OBTAINBATTLEREWARD_ME, {
	"C2S_NewSlg_ObtainBattleReward",
	".cs.C2S_NewSlg_ObtainBattleReward",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_OBTAINBATTLEREWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_OBTAINBATTLEREWARD_RET_F, {
	"ret",
	".cs.S2C_NewSlg_ObtainBattleReward.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_OBTAINBATTLEREWARD_ID_F, {
	"id",
	".cs.S2C_NewSlg_ObtainBattleReward.id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_OBTAINBATTLEREWARD_AWARDS_F, {
	"awards",
	".cs.S2C_NewSlg_ObtainBattleReward.awards",
	3,
	2,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_OBTAINBATTLEREWARD_PRIVILEGE_AWARDS_F, {
	"privilege_awards",
	".cs.S2C_NewSlg_ObtainBattleReward.privilege_awards",
	4,
	3,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_OBTAINBATTLEREWARD_HAS_AWARD_F, {
	"has_award",
	".cs.S2C_NewSlg_ObtainBattleReward.has_award",
	5,
	4,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_OBTAINBATTLEREWARD_ME, {
	"S2C_NewSlg_ObtainBattleReward",
	".cs.S2C_NewSlg_ObtainBattleReward",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_OBTAINBATTLEREWARD_RET_F,
		var_0_10.S2C_NEWSLG_OBTAINBATTLEREWARD_ID_F,
		var_0_10.S2C_NEWSLG_OBTAINBATTLEREWARD_AWARDS_F,
		var_0_10.S2C_NEWSLG_OBTAINBATTLEREWARD_PRIVILEGE_AWARDS_F,
		var_0_10.S2C_NEWSLG_OBTAINBATTLEREWARD_HAS_AWARD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_EDITUSERTEAM_TEAMS_F, {
	"teams",
	".cs.C2S_NewSlg_EditUserTeam.teams",
	1,
	0,
	3,
	false,
	{},
	var_0_3.NEWSLGUSERTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_EDITUSERTEAM_ME, {
	"C2S_NewSlg_EditUserTeam",
	".cs.C2S_NewSlg_EditUserTeam",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_EDITUSERTEAM_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_EDITUSERTEAM_RET_F, {
	"ret",
	".cs.S2C_NewSlg_EditUserTeam.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_EDITUSERTEAM_TEAM_INDEX_F, {
	"team_index",
	".cs.S2C_NewSlg_EditUserTeam.team_index",
	2,
	1,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_EDITUSERTEAM_ME, {
	"S2C_NewSlg_EditUserTeam",
	".cs.S2C_NewSlg_EditUserTeam",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_EDITUSERTEAM_RET_F,
		var_0_10.S2C_NEWSLG_EDITUSERTEAM_TEAM_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_SYNCUSERTEAM_TEAMS_F, {
	"teams",
	".cs.S2C_NewSlg_SyncUserTeam.teams",
	1,
	0,
	3,
	false,
	{},
	var_0_3.NEWSLGUSERTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_SYNCUSERTEAM_ME, {
	"S2C_NewSlg_SyncUserTeam",
	".cs.S2C_NewSlg_SyncUserTeam",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_SYNCUSERTEAM_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_UPGRADEMAINCITY_LEVEL_F, {
	"level",
	".cs.C2S_NewSlg_UpgradeMainCity.level",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_UPGRADEMAINCITY_ME, {
	"C2S_NewSlg_UpgradeMainCity",
	".cs.C2S_NewSlg_UpgradeMainCity",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_UPGRADEMAINCITY_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_UPGRADEMAINCITY_RET_F, {
	"ret",
	".cs.S2C_NewSlg_UpgradeMainCity.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_UPGRADEMAINCITY_LEVEL_F, {
	"level",
	".cs.S2C_NewSlg_UpgradeMainCity.level",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_UPGRADEMAINCITY_ME, {
	"S2C_NewSlg_UpgradeMainCity",
	".cs.S2C_NewSlg_UpgradeMainCity",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_UPGRADEMAINCITY_RET_F,
		var_0_10.S2C_NEWSLG_UPGRADEMAINCITY_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_STATIONMAINCITY_TP_F, {
	"tp",
	".cs.C2S_NewSlg_StationMainCity.tp",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_STATIONMAINCITY_POS_F, {
	"pos",
	".cs.C2S_NewSlg_StationMainCity.pos",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_STATIONMAINCITY_ID_F, {
	"id",
	".cs.C2S_NewSlg_StationMainCity.id",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_STATIONMAINCITY_ME, {
	"C2S_NewSlg_StationMainCity",
	".cs.C2S_NewSlg_StationMainCity",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_STATIONMAINCITY_TP_F,
		var_0_10.C2S_NEWSLG_STATIONMAINCITY_POS_F,
		var_0_10.C2S_NEWSLG_STATIONMAINCITY_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_STATIONMAINCITY_RET_F, {
	"ret",
	".cs.S2C_NewSlg_StationMainCity.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_STATIONMAINCITY_TP_F, {
	"tp",
	".cs.S2C_NewSlg_StationMainCity.tp",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_STATIONMAINCITY_POS_F, {
	"pos",
	".cs.S2C_NewSlg_StationMainCity.pos",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_STATIONMAINCITY_ID_F, {
	"id",
	".cs.S2C_NewSlg_StationMainCity.id",
	4,
	3,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_STATIONMAINCITY_ME, {
	"S2C_NewSlg_StationMainCity",
	".cs.S2C_NewSlg_StationMainCity",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_STATIONMAINCITY_RET_F,
		var_0_10.S2C_NEWSLG_STATIONMAINCITY_TP_F,
		var_0_10.S2C_NEWSLG_STATIONMAINCITY_POS_F,
		var_0_10.S2C_NEWSLG_STATIONMAINCITY_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_UPGRADEBARRACK_TP_F, {
	"tp",
	".cs.C2S_NewSlg_UpgradeBarrack.tp",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_UPGRADEBARRACK_LEVEL_F, {
	"level",
	".cs.C2S_NewSlg_UpgradeBarrack.level",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_UPGRADEBARRACK_ME, {
	"C2S_NewSlg_UpgradeBarrack",
	".cs.C2S_NewSlg_UpgradeBarrack",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_UPGRADEBARRACK_TP_F,
		var_0_10.C2S_NEWSLG_UPGRADEBARRACK_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_UPGRADEBARRACK_RET_F, {
	"ret",
	".cs.S2C_NewSlg_UpgradeBarrack.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_UPGRADEBARRACK_TP_F, {
	"tp",
	".cs.S2C_NewSlg_UpgradeBarrack.tp",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_UPGRADEBARRACK_LEVEL_F, {
	"level",
	".cs.S2C_NewSlg_UpgradeBarrack.level",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_UPGRADEBARRACK_ME, {
	"S2C_NewSlg_UpgradeBarrack",
	".cs.S2C_NewSlg_UpgradeBarrack",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_UPGRADEBARRACK_RET_F,
		var_0_10.S2C_NEWSLG_UPGRADEBARRACK_TP_F,
		var_0_10.S2C_NEWSLG_UPGRADEBARRACK_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_UPGRADESUPPLY_LEVEL_F, {
	"level",
	".cs.C2S_NewSlg_UpgradeSupply.level",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_UPGRADESUPPLY_ME, {
	"C2S_NewSlg_UpgradeSupply",
	".cs.C2S_NewSlg_UpgradeSupply",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_UPGRADESUPPLY_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_UPGRADESUPPLY_RET_F, {
	"ret",
	".cs.S2C_NewSlg_UpgradeSupply.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_UPGRADESUPPLY_LEVEL_F, {
	"level",
	".cs.S2C_NewSlg_UpgradeSupply.level",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_UPGRADESUPPLY_SUPPLY_F, {
	"supply",
	".cs.S2C_NewSlg_UpgradeSupply.supply",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.NEWSLGSUPPLY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_UPGRADESUPPLY_ME, {
	"S2C_NewSlg_UpgradeSupply",
	".cs.S2C_NewSlg_UpgradeSupply",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_UPGRADESUPPLY_RET_F,
		var_0_10.S2C_NEWSLG_UPGRADESUPPLY_LEVEL_F,
		var_0_10.S2C_NEWSLG_UPGRADESUPPLY_SUPPLY_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_OBTAINSUPPLYAWARD_ME, {
	"C2S_NewSlg_ObtainSupplyAward",
	".cs.C2S_NewSlg_ObtainSupplyAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_OBTAINSUPPLYAWARD_RET_F, {
	"ret",
	".cs.S2C_NewSlg_ObtainSupplyAward.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_OBTAINSUPPLYAWARD_SUPPLY_F, {
	"supply",
	".cs.S2C_NewSlg_ObtainSupplyAward.supply",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.NEWSLGSUPPLY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_OBTAINSUPPLYAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_NewSlg_ObtainSupplyAward.awards",
	3,
	2,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_OBTAINSUPPLYAWARD_ME, {
	"S2C_NewSlg_ObtainSupplyAward",
	".cs.S2C_NewSlg_ObtainSupplyAward",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_OBTAINSUPPLYAWARD_RET_F,
		var_0_10.S2C_NEWSLG_OBTAINSUPPLYAWARD_SUPPLY_F,
		var_0_10.S2C_NEWSLG_OBTAINSUPPLYAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_USESUPPLYTOKEN_ID_F, {
	"id",
	".cs.C2S_NewSlg_UseSupplyToken.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_USESUPPLYTOKEN_SIZE_F, {
	"size",
	".cs.C2S_NewSlg_UseSupplyToken.size",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_USESUPPLYTOKEN_ME, {
	"C2S_NewSlg_UseSupplyToken",
	".cs.C2S_NewSlg_UseSupplyToken",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_USESUPPLYTOKEN_ID_F,
		var_0_10.C2S_NEWSLG_USESUPPLYTOKEN_SIZE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_USESUPPLYTOKEN_RET_F, {
	"ret",
	".cs.S2C_NewSlg_UseSupplyToken.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_USESUPPLYTOKEN_ID_F, {
	"id",
	".cs.S2C_NewSlg_UseSupplyToken.id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_USESUPPLYTOKEN_SIZE_F, {
	"size",
	".cs.S2C_NewSlg_UseSupplyToken.size",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_USESUPPLYTOKEN_AWARDS_F, {
	"awards",
	".cs.S2C_NewSlg_UseSupplyToken.awards",
	4,
	3,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_USESUPPLYTOKEN_ME, {
	"S2C_NewSlg_UseSupplyToken",
	".cs.S2C_NewSlg_UseSupplyToken",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_USESUPPLYTOKEN_RET_F,
		var_0_10.S2C_NEWSLG_USESUPPLYTOKEN_ID_F,
		var_0_10.S2C_NEWSLG_USESUPPLYTOKEN_SIZE_F,
		var_0_10.S2C_NEWSLG_USESUPPLYTOKEN_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_CITYMARCH_CITY_ID_F, {
	"city_id",
	".cs.C2S_NewSlg_CityMarch.city_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_CITYMARCH_TEAMS_F, {
	"teams",
	".cs.C2S_NewSlg_CityMarch.teams",
	2,
	1,
	3,
	false,
	{},
	var_0_3.NEWSLGUSERTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_CITYMARCH_MOVE_PATH_F, {
	"move_path",
	".cs.C2S_NewSlg_CityMarch.move_path",
	3,
	2,
	3,
	false,
	{},
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_CITYMARCH_SUPPLY_TROOP_F, {
	"supply_troop",
	".cs.C2S_NewSlg_CityMarch.supply_troop",
	4,
	3,
	2,
	false,
	0,
	nil,
	nil,
	3,
	2
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_CITYMARCH_CITY_MOVE_PATH_F, {
	"city_move_path",
	".cs.C2S_NewSlg_CityMarch.city_move_path",
	5,
	4,
	3,
	false,
	{},
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_CITYMARCH_TEAM_INDEX_F, {
	"team_index",
	".cs.C2S_NewSlg_CityMarch.team_index",
	6,
	5,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_CITYMARCH_MARCH_TP_F, {
	"march_tp",
	".cs.C2S_NewSlg_CityMarch.march_tp",
	7,
	6,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_CITYMARCH_ME, {
	"C2S_NewSlg_CityMarch",
	".cs.C2S_NewSlg_CityMarch",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_CITYMARCH_CITY_ID_F,
		var_0_10.C2S_NEWSLG_CITYMARCH_TEAMS_F,
		var_0_10.C2S_NEWSLG_CITYMARCH_MOVE_PATH_F,
		var_0_10.C2S_NEWSLG_CITYMARCH_SUPPLY_TROOP_F,
		var_0_10.C2S_NEWSLG_CITYMARCH_CITY_MOVE_PATH_F,
		var_0_10.C2S_NEWSLG_CITYMARCH_TEAM_INDEX_F,
		var_0_10.C2S_NEWSLG_CITYMARCH_MARCH_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYMARCH_RET_F, {
	"ret",
	".cs.S2C_NewSlg_CityMarch.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYMARCH_CITY_ID_F, {
	"city_id",
	".cs.S2C_NewSlg_CityMarch.city_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYMARCH_MOVE_F, {
	"move",
	".cs.S2C_NewSlg_CityMarch.move",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.NEWSLGSIMPLEMOVE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYMARCH_TEAM_INDEX_F, {
	"team_index",
	".cs.S2C_NewSlg_CityMarch.team_index",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYMARCH_MARCH_TP_F, {
	"march_tp",
	".cs.S2C_NewSlg_CityMarch.march_tp",
	5,
	4,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_CITYMARCH_ME, {
	"S2C_NewSlg_CityMarch",
	".cs.S2C_NewSlg_CityMarch",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_CITYMARCH_RET_F,
		var_0_10.S2C_NEWSLG_CITYMARCH_CITY_ID_F,
		var_0_10.S2C_NEWSLG_CITYMARCH_MOVE_F,
		var_0_10.S2C_NEWSLG_CITYMARCH_TEAM_INDEX_F,
		var_0_10.S2C_NEWSLG_CITYMARCH_MARCH_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_CITYCANCELMOVE_TEAM_INDEX_F, {
	"team_index",
	".cs.C2S_NewSlg_CityCancelMove.team_index",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_CITYCANCELMOVE_ME, {
	"C2S_NewSlg_CityCancelMove",
	".cs.C2S_NewSlg_CityCancelMove",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_CITYCANCELMOVE_TEAM_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYCANCELMOVE_RET_F, {
	"ret",
	".cs.S2C_NewSlg_CityCancelMove.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYCANCELMOVE_TEAM_INDEX_F, {
	"team_index",
	".cs.S2C_NewSlg_CityCancelMove.team_index",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYCANCELMOVE_MOVE_F, {
	"move",
	".cs.S2C_NewSlg_CityCancelMove.move",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.NEWSLGSIMPLEMOVE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_CITYCANCELMOVE_ME, {
	"S2C_NewSlg_CityCancelMove",
	".cs.S2C_NewSlg_CityCancelMove",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_CITYCANCELMOVE_RET_F,
		var_0_10.S2C_NEWSLG_CITYCANCELMOVE_TEAM_INDEX_F,
		var_0_10.S2C_NEWSLG_CITYCANCELMOVE_MOVE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETCITYGATHER_CITY_ID_F, {
	"city_id",
	".cs.C2S_NewSlg_GetCityGather.city_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETCITYGATHER_CAR_ID_F, {
	"car_id",
	".cs.C2S_NewSlg_GetCityGather.car_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETCITYGATHER_ME, {
	"C2S_NewSlg_GetCityGather",
	".cs.C2S_NewSlg_GetCityGather",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_GETCITYGATHER_CITY_ID_F,
		var_0_10.C2S_NEWSLG_GETCITYGATHER_CAR_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETCITYGATHER_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetCityGather.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETCITYGATHER_TEAMS_F, {
	"teams",
	".cs.S2C_NewSlg_GetCityGather.teams",
	2,
	1,
	3,
	false,
	{},
	var_0_3.NEWSLGUSERTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETCITYGATHER_CITY_ID_F, {
	"city_id",
	".cs.S2C_NewSlg_GetCityGather.city_id",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETCITYGATHER_CAR_ID_F, {
	"car_id",
	".cs.S2C_NewSlg_GetCityGather.car_id",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETCITYGATHER_ME, {
	"S2C_NewSlg_GetCityGather",
	".cs.S2C_NewSlg_GetCityGather",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETCITYGATHER_RET_F,
		var_0_10.S2C_NEWSLG_GETCITYGATHER_TEAMS_F,
		var_0_10.S2C_NEWSLG_GETCITYGATHER_CITY_ID_F,
		var_0_10.S2C_NEWSLG_GETCITYGATHER_CAR_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETCITYDEFINFO_CITY_ID_F, {
	"city_id",
	".cs.C2S_NewSlg_GetCityDefInfo.city_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETCITYDEFINFO_ME, {
	"C2S_NewSlg_GetCityDefInfo",
	".cs.C2S_NewSlg_GetCityDefInfo",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_GETCITYDEFINFO_CITY_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETCITYDEFINFO_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetCityDefInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETCITYDEFINFO_CITY_ID_F, {
	"city_id",
	".cs.S2C_NewSlg_GetCityDefInfo.city_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETCITYDEFINFO_DEF_TEAMS_F, {
	"def_teams",
	".cs.S2C_NewSlg_GetCityDefInfo.def_teams",
	3,
	2,
	3,
	false,
	{},
	var_0_3.NEWSLGBATTLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETCITYDEFINFO_TEAMS_F, {
	"teams",
	".cs.S2C_NewSlg_GetCityDefInfo.teams",
	4,
	3,
	3,
	false,
	{},
	var_0_3.NEWSLGUSERTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETCITYDEFINFO_ME, {
	"S2C_NewSlg_GetCityDefInfo",
	".cs.S2C_NewSlg_GetCityDefInfo",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETCITYDEFINFO_RET_F,
		var_0_10.S2C_NEWSLG_GETCITYDEFINFO_CITY_ID_F,
		var_0_10.S2C_NEWSLG_GETCITYDEFINFO_DEF_TEAMS_F,
		var_0_10.S2C_NEWSLG_GETCITYDEFINFO_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETPREDAYINFO_ME, {
	"C2S_NewSlg_GetPreDayInfo",
	".cs.C2S_NewSlg_GetPreDayInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETPREDAYINFO_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetPreDayInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETPREDAYINFO_ALLI_RANK_F, {
	"alli_rank",
	".cs.S2C_NewSlg_GetPreDayInfo.alli_rank",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETPREDAYINFO_FIRST_CITY_SCORE_F, {
	"first_city_score",
	".cs.S2C_NewSlg_GetPreDayInfo.first_city_score",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETPREDAYINFO_FIRST_CITY_SCORE_USER_ID_F, {
	"first_city_score_user_id",
	".cs.S2C_NewSlg_GetPreDayInfo.first_city_score_user_id",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETPREDAYINFO_FIRST_ALLI_CITY_SCORE_F, {
	"first_alli_city_score",
	".cs.S2C_NewSlg_GetPreDayInfo.first_alli_city_score",
	5,
	4,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETPREDAYINFO_FIRST_ALLI_CITY_SCORE_USER_ID_F, {
	"first_alli_city_score_user_id",
	".cs.S2C_NewSlg_GetPreDayInfo.first_alli_city_score_user_id",
	6,
	5,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETPREDAYINFO_ME, {
	"S2C_NewSlg_GetPreDayInfo",
	".cs.S2C_NewSlg_GetPreDayInfo",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETPREDAYINFO_RET_F,
		var_0_10.S2C_NEWSLG_GETPREDAYINFO_ALLI_RANK_F,
		var_0_10.S2C_NEWSLG_GETPREDAYINFO_FIRST_CITY_SCORE_F,
		var_0_10.S2C_NEWSLG_GETPREDAYINFO_FIRST_CITY_SCORE_USER_ID_F,
		var_0_10.S2C_NEWSLG_GETPREDAYINFO_FIRST_ALLI_CITY_SCORE_F,
		var_0_10.S2C_NEWSLG_GETPREDAYINFO_FIRST_ALLI_CITY_SCORE_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYNTF_CITY_SHOW_F, {
	"city_show",
	".cs.S2C_NewSlg_CityNtf.city_show",
	1,
	0,
	3,
	false,
	{},
	var_0_3.NEWSLGMAPCITYSHOW_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_CITYNTF_ME, {
	"S2C_NewSlg_CityNtf",
	".cs.S2C_NewSlg_CityNtf",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_CITYNTF_CITY_SHOW_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYBATTLEEND_RESULT_F, {
	"result",
	".cs.S2C_NewSlg_CityBattleEnd.result",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.NEWSLGBATTLERESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_CITYBATTLEEND_ME, {
	"S2C_NewSlg_CityBattleEnd",
	".cs.S2C_NewSlg_CityBattleEnd",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_CITYBATTLEEND_RESULT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_SYNCUSERBASE_USER_BASE_F, {
	"user_base",
	".cs.S2C_NewSlg_SyncUserBase.user_base",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.NEWSLGUSERBASE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_SYNCUSERBASE_ME, {
	"S2C_NewSlg_SyncUserBase",
	".cs.S2C_NewSlg_SyncUserBase",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_SYNCUSERBASE_USER_BASE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FLUSHBATTLERESULTS_RESULTS_F, {
	"results",
	".cs.S2C_NewSlg_FlushBattleResults.results",
	1,
	0,
	3,
	false,
	{},
	var_0_3.NEWSLGBATTLERESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FLUSHBATTLERESULTS_CITIES_F, {
	"cities",
	".cs.S2C_NewSlg_FlushBattleResults.cities",
	2,
	1,
	3,
	false,
	{},
	var_0_3.NEWSLGALLICITYBATTLE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FLUSHBATTLERESULTS_SCORE_F, {
	"score",
	".cs.S2C_NewSlg_FlushBattleResults.score",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_FLUSHBATTLERESULTS_ME, {
	"S2C_NewSlg_FlushBattleResults",
	".cs.S2C_NewSlg_FlushBattleResults",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_FLUSHBATTLERESULTS_RESULTS_F,
		var_0_10.S2C_NEWSLG_FLUSHBATTLERESULTS_CITIES_F,
		var_0_10.S2C_NEWSLG_FLUSHBATTLERESULTS_SCORE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETUSERDETAIL_UID_F, {
	"uid",
	".cs.C2S_NewSlg_GetUserDetail.uid",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETUSERDETAIL_ME, {
	"C2S_NewSlg_GetUserDetail",
	".cs.C2S_NewSlg_GetUserDetail",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_GETUSERDETAIL_UID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETUSERDETAIL_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetUserDetail.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETUSERDETAIL_UID_F, {
	"uid",
	".cs.S2C_NewSlg_GetUserDetail.uid",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETUSERDETAIL_DETAIL_F, {
	"detail",
	".cs.S2C_NewSlg_GetUserDetail.detail",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.NEWSLGUSERDETAIL_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETUSERDETAIL_ME, {
	"S2C_NewSlg_GetUserDetail",
	".cs.S2C_NewSlg_GetUserDetail",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETUSERDETAIL_RET_F,
		var_0_10.S2C_NEWSLG_GETUSERDETAIL_UID_F,
		var_0_10.S2C_NEWSLG_GETUSERDETAIL_DETAIL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_SIMULATEBATTLE_ATK_AUTHORITY_F, {
	"atk_authority",
	".cs.C2S_NewSlg_SimulateBattle.atk_authority",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_SIMULATEBATTLE_ATK_TROOPS_F, {
	"atk_troops",
	".cs.C2S_NewSlg_SimulateBattle.atk_troops",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_SIMULATEBATTLE_ATK_TROOP_TYPE_F, {
	"atk_troop_type",
	".cs.C2S_NewSlg_SimulateBattle.atk_troop_type",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_SIMULATEBATTLE_ATK_CHARACTERS_F, {
	"atk_characters",
	".cs.C2S_NewSlg_SimulateBattle.atk_characters",
	4,
	3,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_SIMULATEBATTLE_ATK_NUM_F, {
	"atk_num",
	".cs.C2S_NewSlg_SimulateBattle.atk_num",
	5,
	4,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_SIMULATEBATTLE_DEF_AUTHORITY_F, {
	"def_authority",
	".cs.C2S_NewSlg_SimulateBattle.def_authority",
	6,
	5,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_SIMULATEBATTLE_DEF_TROOPS_F, {
	"def_troops",
	".cs.C2S_NewSlg_SimulateBattle.def_troops",
	7,
	6,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_SIMULATEBATTLE_DEF_TROOP_TYPE_F, {
	"def_troop_type",
	".cs.C2S_NewSlg_SimulateBattle.def_troop_type",
	8,
	7,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_SIMULATEBATTLE_DEF_CHARACTERS_F, {
	"def_characters",
	".cs.C2S_NewSlg_SimulateBattle.def_characters",
	9,
	8,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_SIMULATEBATTLE_DEF_NUM_F, {
	"def_num",
	".cs.C2S_NewSlg_SimulateBattle.def_num",
	10,
	9,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_SIMULATEBATTLE_BATTLE_TP_F, {
	"battle_tp",
	".cs.C2S_NewSlg_SimulateBattle.battle_tp",
	11,
	10,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_SIMULATEBATTLE_DEF_MONSTER_TEAM_F, {
	"def_monster_team",
	".cs.C2S_NewSlg_SimulateBattle.def_monster_team",
	12,
	11,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_SIMULATEBATTLE_ME, {
	"C2S_NewSlg_SimulateBattle",
	".cs.C2S_NewSlg_SimulateBattle",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_SIMULATEBATTLE_ATK_AUTHORITY_F,
		var_0_10.C2S_NEWSLG_SIMULATEBATTLE_ATK_TROOPS_F,
		var_0_10.C2S_NEWSLG_SIMULATEBATTLE_ATK_TROOP_TYPE_F,
		var_0_10.C2S_NEWSLG_SIMULATEBATTLE_ATK_CHARACTERS_F,
		var_0_10.C2S_NEWSLG_SIMULATEBATTLE_ATK_NUM_F,
		var_0_10.C2S_NEWSLG_SIMULATEBATTLE_DEF_AUTHORITY_F,
		var_0_10.C2S_NEWSLG_SIMULATEBATTLE_DEF_TROOPS_F,
		var_0_10.C2S_NEWSLG_SIMULATEBATTLE_DEF_TROOP_TYPE_F,
		var_0_10.C2S_NEWSLG_SIMULATEBATTLE_DEF_CHARACTERS_F,
		var_0_10.C2S_NEWSLG_SIMULATEBATTLE_DEF_NUM_F,
		var_0_10.C2S_NEWSLG_SIMULATEBATTLE_BATTLE_TP_F,
		var_0_10.C2S_NEWSLG_SIMULATEBATTLE_DEF_MONSTER_TEAM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_SIMULATEBATTLE_RET_F, {
	"ret",
	".cs.S2C_NewSlg_SimulateBattle.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_SIMULATEBATTLE_REPORT_F, {
	"report",
	".cs.S2C_NewSlg_SimulateBattle.report",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.NEWSLGBATTLEREPORT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_SIMULATEBATTLE_ME, {
	"S2C_NewSlg_SimulateBattle",
	".cs.S2C_NewSlg_SimulateBattle",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_SIMULATEBATTLE_RET_F,
		var_0_10.S2C_NEWSLG_SIMULATEBATTLE_REPORT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_NOTIFYCHECKPOINTQUEST_CHECKPOINT_QUESTS_F, {
	"checkpoint_quests",
	".cs.S2C_NewSlg_NotifyCheckpointQuest.checkpoint_quests",
	1,
	0,
	3,
	false,
	{},
	var_0_3.KVUINT32_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_NOTIFYCHECKPOINTQUEST_ME, {
	"S2C_NewSlg_NotifyCheckpointQuest",
	".cs.S2C_NewSlg_NotifyCheckpointQuest",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_NOTIFYCHECKPOINTQUEST_CHECKPOINT_QUESTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_SYNCCITYQUESTPROGRESS_CITY_PROGRESS_F, {
	"city_progress",
	".cs.S2C_NewSlg_SyncCityQuestProgress.city_progress",
	1,
	0,
	3,
	false,
	{},
	var_0_3.K64V32_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_SYNCCITYQUESTPROGRESS_ME, {
	"S2C_NewSlg_SyncCityQuestProgress",
	".cs.S2C_NewSlg_SyncCityQuestProgress",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_SYNCCITYQUESTPROGRESS_CITY_PROGRESS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_SYNCMAINQUESTPROGRESS_MAIN_QUEST_F, {
	"main_quest",
	".cs.S2C_NewSlg_SyncMainQuestProgress.main_quest",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.COMMONTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_SYNCMAINQUESTPROGRESS_ME, {
	"S2C_NewSlg_SyncMainQuestProgress",
	".cs.S2C_NewSlg_SyncMainQuestProgress",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_SYNCMAINQUESTPROGRESS_MAIN_QUEST_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_CITYQUESTAWARD_IDS_F, {
	"ids",
	".cs.C2S_NewSlg_CityQuestAward.ids",
	1,
	0,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_CITYQUESTAWARD_ME, {
	"C2S_NewSlg_CityQuestAward",
	".cs.C2S_NewSlg_CityQuestAward",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_CITYQUESTAWARD_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYQUESTAWARD_RET_F, {
	"ret",
	".cs.S2C_NewSlg_CityQuestAward.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYQUESTAWARD_IDS_F, {
	"ids",
	".cs.S2C_NewSlg_CityQuestAward.ids",
	2,
	1,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYQUESTAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_NewSlg_CityQuestAward.awards",
	3,
	2,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_CITYQUESTAWARD_ME, {
	"S2C_NewSlg_CityQuestAward",
	".cs.S2C_NewSlg_CityQuestAward",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_CITYQUESTAWARD_RET_F,
		var_0_10.S2C_NEWSLG_CITYQUESTAWARD_IDS_F,
		var_0_10.S2C_NEWSLG_CITYQUESTAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_MAINQUESTAWARD_ID_F, {
	"id",
	".cs.C2S_NewSlg_MainQuestAward.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_MAINQUESTAWARD_ME, {
	"C2S_NewSlg_MainQuestAward",
	".cs.C2S_NewSlg_MainQuestAward",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_MAINQUESTAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MAINQUESTAWARD_RET_F, {
	"ret",
	".cs.S2C_NewSlg_MainQuestAward.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MAINQUESTAWARD_ID_F, {
	"id",
	".cs.S2C_NewSlg_MainQuestAward.id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MAINQUESTAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_NewSlg_MainQuestAward.awards",
	3,
	2,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_MAINQUESTAWARD_ME, {
	"S2C_NewSlg_MainQuestAward",
	".cs.S2C_NewSlg_MainQuestAward",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_MAINQUESTAWARD_RET_F,
		var_0_10.S2C_NEWSLG_MAINQUESTAWARD_ID_F,
		var_0_10.S2C_NEWSLG_MAINQUESTAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETMATCHSERVER_ME, {
	"C2S_NewSlg_GetMatchServer",
	".cs.C2S_NewSlg_GetMatchServer",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMATCHSERVER_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetMatchServer.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMATCHSERVER_SERVERINFO_F, {
	"serverInfo",
	".cs.S2C_NewSlg_GetMatchServer.serverInfo",
	2,
	1,
	3,
	false,
	{},
	var_0_3.SERVERINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETMATCHSERVER_ME, {
	"S2C_NewSlg_GetMatchServer",
	".cs.S2C_NewSlg_GetMatchServer",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETMATCHSERVER_RET_F,
		var_0_10.S2C_NEWSLG_GETMATCHSERVER_SERVERINFO_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_OBTAINPREVIEWREWARDS_ME, {
	"C2S_NewSlg_ObtainPreviewRewards",
	".cs.C2S_NewSlg_ObtainPreviewRewards",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_OBTAINPREVIEWREWARDS_RET_F, {
	"ret",
	".cs.S2C_NewSlg_ObtainPreviewRewards.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_OBTAINPREVIEWREWARDS_REWARDS_F, {
	"rewards",
	".cs.S2C_NewSlg_ObtainPreviewRewards.rewards",
	2,
	1,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_OBTAINPREVIEWREWARDS_ME, {
	"S2C_NewSlg_ObtainPreviewRewards",
	".cs.S2C_NewSlg_ObtainPreviewRewards",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_OBTAINPREVIEWREWARDS_RET_F,
		var_0_10.S2C_NEWSLG_OBTAINPREVIEWREWARDS_REWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSCREATETEAM_BOSS_ID_F, {
	"boss_id",
	".cs.C2S_NewSlg_BossCreateTeam.boss_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSCREATETEAM_MOVE_PATH_F, {
	"move_path",
	".cs.C2S_NewSlg_BossCreateTeam.move_path",
	2,
	1,
	3,
	false,
	{},
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSCREATETEAM_SUPPLY_TROOP_F, {
	"supply_troop",
	".cs.C2S_NewSlg_BossCreateTeam.supply_troop",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	3,
	2
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSCREATETEAM_TEAM_INDEX_F, {
	"team_index",
	".cs.C2S_NewSlg_BossCreateTeam.team_index",
	4,
	3,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSCREATETEAM_TEAMS_F, {
	"teams",
	".cs.C2S_NewSlg_BossCreateTeam.teams",
	5,
	4,
	3,
	false,
	{},
	var_0_3.NEWSLGUSERTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_BOSSCREATETEAM_ME, {
	"C2S_NewSlg_BossCreateTeam",
	".cs.C2S_NewSlg_BossCreateTeam",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_BOSSCREATETEAM_BOSS_ID_F,
		var_0_10.C2S_NEWSLG_BOSSCREATETEAM_MOVE_PATH_F,
		var_0_10.C2S_NEWSLG_BOSSCREATETEAM_SUPPLY_TROOP_F,
		var_0_10.C2S_NEWSLG_BOSSCREATETEAM_TEAM_INDEX_F,
		var_0_10.C2S_NEWSLG_BOSSCREATETEAM_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSCREATETEAM_RET_F, {
	"ret",
	".cs.S2C_NewSlg_BossCreateTeam.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSCREATETEAM_BOSS_ID_F, {
	"boss_id",
	".cs.S2C_NewSlg_BossCreateTeam.boss_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSCREATETEAM_MOVE_PATH_F, {
	"move_path",
	".cs.S2C_NewSlg_BossCreateTeam.move_path",
	3,
	2,
	3,
	false,
	{},
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSCREATETEAM_SUPPLY_TROOP_F, {
	"supply_troop",
	".cs.S2C_NewSlg_BossCreateTeam.supply_troop",
	4,
	3,
	2,
	false,
	0,
	nil,
	nil,
	3,
	2
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSCREATETEAM_TEAM_INDEX_F, {
	"team_index",
	".cs.S2C_NewSlg_BossCreateTeam.team_index",
	5,
	4,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSCREATETEAM_TEAM_F, {
	"team",
	".cs.S2C_NewSlg_BossCreateTeam.team",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.NEWSLGBOSSTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOSSCREATETEAM_ME, {
	"S2C_NewSlg_BossCreateTeam",
	".cs.S2C_NewSlg_BossCreateTeam",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOSSCREATETEAM_RET_F,
		var_0_10.S2C_NEWSLG_BOSSCREATETEAM_BOSS_ID_F,
		var_0_10.S2C_NEWSLG_BOSSCREATETEAM_MOVE_PATH_F,
		var_0_10.S2C_NEWSLG_BOSSCREATETEAM_SUPPLY_TROOP_F,
		var_0_10.S2C_NEWSLG_BOSSCREATETEAM_TEAM_INDEX_F,
		var_0_10.S2C_NEWSLG_BOSSCREATETEAM_TEAM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSJOINTEAM_TEAM_ID_F, {
	"team_id",
	".cs.C2S_NewSlg_BossJoinTeam.team_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSJOINTEAM_TEAMS_F, {
	"teams",
	".cs.C2S_NewSlg_BossJoinTeam.teams",
	2,
	1,
	3,
	false,
	{},
	var_0_3.NEWSLGUSERTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSJOINTEAM_MOVE_PATH_F, {
	"move_path",
	".cs.C2S_NewSlg_BossJoinTeam.move_path",
	3,
	2,
	3,
	false,
	{},
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSJOINTEAM_SUPPLY_TROOP_F, {
	"supply_troop",
	".cs.C2S_NewSlg_BossJoinTeam.supply_troop",
	4,
	3,
	2,
	false,
	0,
	nil,
	nil,
	3,
	2
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSJOINTEAM_TEAM_INDEX_F, {
	"team_index",
	".cs.C2S_NewSlg_BossJoinTeam.team_index",
	5,
	4,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_BOSSJOINTEAM_ME, {
	"C2S_NewSlg_BossJoinTeam",
	".cs.C2S_NewSlg_BossJoinTeam",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_BOSSJOINTEAM_TEAM_ID_F,
		var_0_10.C2S_NEWSLG_BOSSJOINTEAM_TEAMS_F,
		var_0_10.C2S_NEWSLG_BOSSJOINTEAM_MOVE_PATH_F,
		var_0_10.C2S_NEWSLG_BOSSJOINTEAM_SUPPLY_TROOP_F,
		var_0_10.C2S_NEWSLG_BOSSJOINTEAM_TEAM_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSJOINTEAM_RET_F, {
	"ret",
	".cs.S2C_NewSlg_BossJoinTeam.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSJOINTEAM_TEAM_ID_F, {
	"team_id",
	".cs.S2C_NewSlg_BossJoinTeam.team_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSJOINTEAM_MOVE_PATH_F, {
	"move_path",
	".cs.S2C_NewSlg_BossJoinTeam.move_path",
	3,
	2,
	3,
	false,
	{},
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSJOINTEAM_SUPPLY_TROOP_F, {
	"supply_troop",
	".cs.S2C_NewSlg_BossJoinTeam.supply_troop",
	4,
	3,
	2,
	false,
	0,
	nil,
	nil,
	3,
	2
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSJOINTEAM_TEAM_INDEX_F, {
	"team_index",
	".cs.S2C_NewSlg_BossJoinTeam.team_index",
	5,
	4,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSJOINTEAM_TEAM_F, {
	"team",
	".cs.S2C_NewSlg_BossJoinTeam.team",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.NEWSLGBOSSTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOSSJOINTEAM_ME, {
	"S2C_NewSlg_BossJoinTeam",
	".cs.S2C_NewSlg_BossJoinTeam",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOSSJOINTEAM_RET_F,
		var_0_10.S2C_NEWSLG_BOSSJOINTEAM_TEAM_ID_F,
		var_0_10.S2C_NEWSLG_BOSSJOINTEAM_MOVE_PATH_F,
		var_0_10.S2C_NEWSLG_BOSSJOINTEAM_SUPPLY_TROOP_F,
		var_0_10.S2C_NEWSLG_BOSSJOINTEAM_TEAM_INDEX_F,
		var_0_10.S2C_NEWSLG_BOSSJOINTEAM_TEAM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSTEAMKICKOUT_TEAM_ID_F, {
	"team_id",
	".cs.C2S_NewSlg_BossTeamKickOut.team_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSTEAMKICKOUT_USER_ID_F, {
	"user_id",
	".cs.C2S_NewSlg_BossTeamKickOut.user_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_BOSSTEAMKICKOUT_ME, {
	"C2S_NewSlg_BossTeamKickOut",
	".cs.C2S_NewSlg_BossTeamKickOut",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_BOSSTEAMKICKOUT_TEAM_ID_F,
		var_0_10.C2S_NEWSLG_BOSSTEAMKICKOUT_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSTEAMKICKOUT_RET_F, {
	"ret",
	".cs.S2C_NewSlg_BossTeamKickOut.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSTEAMKICKOUT_TEAM_ID_F, {
	"team_id",
	".cs.S2C_NewSlg_BossTeamKickOut.team_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSTEAMKICKOUT_USER_ID_F, {
	"user_id",
	".cs.S2C_NewSlg_BossTeamKickOut.user_id",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOSSTEAMKICKOUT_ME, {
	"S2C_NewSlg_BossTeamKickOut",
	".cs.S2C_NewSlg_BossTeamKickOut",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOSSTEAMKICKOUT_RET_F,
		var_0_10.S2C_NEWSLG_BOSSTEAMKICKOUT_TEAM_ID_F,
		var_0_10.S2C_NEWSLG_BOSSTEAMKICKOUT_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSTRANSFERLEADER_TEAM_ID_F, {
	"team_id",
	".cs.C2S_NewSlg_BossTransferLeader.team_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSTRANSFERLEADER_USER_ID_F, {
	"user_id",
	".cs.C2S_NewSlg_BossTransferLeader.user_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_BOSSTRANSFERLEADER_ME, {
	"C2S_NewSlg_BossTransferLeader",
	".cs.C2S_NewSlg_BossTransferLeader",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_BOSSTRANSFERLEADER_TEAM_ID_F,
		var_0_10.C2S_NEWSLG_BOSSTRANSFERLEADER_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSTRANSFERLEADER_RET_F, {
	"ret",
	".cs.S2C_NewSlg_BossTransferLeader.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSTRANSFERLEADER_TEAM_ID_F, {
	"team_id",
	".cs.S2C_NewSlg_BossTransferLeader.team_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSTRANSFERLEADER_USER_ID_F, {
	"user_id",
	".cs.S2C_NewSlg_BossTransferLeader.user_id",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOSSTRANSFERLEADER_ME, {
	"S2C_NewSlg_BossTransferLeader",
	".cs.S2C_NewSlg_BossTransferLeader",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOSSTRANSFERLEADER_RET_F,
		var_0_10.S2C_NEWSLG_BOSSTRANSFERLEADER_TEAM_ID_F,
		var_0_10.S2C_NEWSLG_BOSSTRANSFERLEADER_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSLEAVE_TEAM_ID_F, {
	"team_id",
	".cs.C2S_NewSlg_BossLeave.team_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSLEAVE_IS_DISMISS_F, {
	"is_dismiss",
	".cs.C2S_NewSlg_BossLeave.is_dismiss",
	2,
	1,
	2,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_BOSSLEAVE_ME, {
	"C2S_NewSlg_BossLeave",
	".cs.C2S_NewSlg_BossLeave",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_BOSSLEAVE_TEAM_ID_F,
		var_0_10.C2S_NEWSLG_BOSSLEAVE_IS_DISMISS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSLEAVE_RET_F, {
	"ret",
	".cs.S2C_NewSlg_BossLeave.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSLEAVE_TEAM_ID_F, {
	"team_id",
	".cs.S2C_NewSlg_BossLeave.team_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSLEAVE_IS_DISMISSED_F, {
	"is_dismissed",
	".cs.S2C_NewSlg_BossLeave.is_dismissed",
	3,
	2,
	2,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOSSLEAVE_ME, {
	"S2C_NewSlg_BossLeave",
	".cs.S2C_NewSlg_BossLeave",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOSSLEAVE_RET_F,
		var_0_10.S2C_NEWSLG_BOSSLEAVE_TEAM_ID_F,
		var_0_10.S2C_NEWSLG_BOSSLEAVE_IS_DISMISSED_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSTEAMLIST_BOSS_IDS_F, {
	"boss_ids",
	".cs.C2S_NewSlg_BossTeamList.boss_ids",
	1,
	0,
	3,
	false,
	{},
	var_0_3.KU32VINT64_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSTEAMLIST_TEAM_ID_F, {
	"team_id",
	".cs.C2S_NewSlg_BossTeamList.team_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_BOSSTEAMLIST_ME, {
	"C2S_NewSlg_BossTeamList",
	".cs.C2S_NewSlg_BossTeamList",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_BOSSTEAMLIST_BOSS_IDS_F,
		var_0_10.C2S_NEWSLG_BOSSTEAMLIST_TEAM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSTEAMLIST_RET_F, {
	"ret",
	".cs.S2C_NewSlg_BossTeamList.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSTEAMLIST_BOSS_IDS_F, {
	"boss_ids",
	".cs.S2C_NewSlg_BossTeamList.boss_ids",
	2,
	1,
	3,
	false,
	{},
	var_0_3.KU32VINT64_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSTEAMLIST_TEAM_ID_F, {
	"team_id",
	".cs.S2C_NewSlg_BossTeamList.team_id",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSTEAMLIST_TEAMS_F, {
	"teams",
	".cs.S2C_NewSlg_BossTeamList.teams",
	4,
	3,
	3,
	false,
	{},
	var_0_3.NEWSLGBOSSTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOSSTEAMLIST_ME, {
	"S2C_NewSlg_BossTeamList",
	".cs.S2C_NewSlg_BossTeamList",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOSSTEAMLIST_RET_F,
		var_0_10.S2C_NEWSLG_BOSSTEAMLIST_BOSS_IDS_F,
		var_0_10.S2C_NEWSLG_BOSSTEAMLIST_TEAM_ID_F,
		var_0_10.S2C_NEWSLG_BOSSTEAMLIST_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSTEAMINFO_TEAM_IDS_F, {
	"team_ids",
	".cs.C2S_NewSlg_BossTeamInfo.team_ids",
	1,
	0,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_BOSSTEAMINFO_ME, {
	"C2S_NewSlg_BossTeamInfo",
	".cs.C2S_NewSlg_BossTeamInfo",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_BOSSTEAMINFO_TEAM_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSTEAMINFO_RET_F, {
	"ret",
	".cs.S2C_NewSlg_BossTeamInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSTEAMINFO_TEAM_IDS_F, {
	"team_ids",
	".cs.S2C_NewSlg_BossTeamInfo.team_ids",
	2,
	1,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSTEAMINFO_TEAMS_F, {
	"teams",
	".cs.S2C_NewSlg_BossTeamInfo.teams",
	3,
	2,
	3,
	false,
	{},
	var_0_3.NEWSLGBOSSTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOSSTEAMINFO_ME, {
	"S2C_NewSlg_BossTeamInfo",
	".cs.S2C_NewSlg_BossTeamInfo",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOSSTEAMINFO_RET_F,
		var_0_10.S2C_NEWSLG_BOSSTEAMINFO_TEAM_IDS_F,
		var_0_10.S2C_NEWSLG_BOSSTEAMINFO_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSUSERSTATENOTIFY_TEAM_ID_F, {
	"team_id",
	".cs.S2C_NewSlg_BossUserStateNotify.team_id",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSUSERSTATENOTIFY_USER_ID_F, {
	"user_id",
	".cs.S2C_NewSlg_BossUserStateNotify.user_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSUSERSTATENOTIFY_TP_F, {
	"tp",
	".cs.S2C_NewSlg_BossUserStateNotify.tp",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSUSERSTATENOTIFY_NEW_LEADER_ID_F, {
	"new_leader_id",
	".cs.S2C_NewSlg_BossUserStateNotify.new_leader_id",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSUSERSTATENOTIFY_ROBOT_USERS_F, {
	"robot_users",
	".cs.S2C_NewSlg_BossUserStateNotify.robot_users",
	5,
	4,
	3,
	false,
	{},
	var_0_3.NEWSLGBOSSTEAMUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOSSUSERSTATENOTIFY_ME, {
	"S2C_NewSlg_BossUserStateNotify",
	".cs.S2C_NewSlg_BossUserStateNotify",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOSSUSERSTATENOTIFY_TEAM_ID_F,
		var_0_10.S2C_NEWSLG_BOSSUSERSTATENOTIFY_USER_ID_F,
		var_0_10.S2C_NEWSLG_BOSSUSERSTATENOTIFY_TP_F,
		var_0_10.S2C_NEWSLG_BOSSUSERSTATENOTIFY_NEW_LEADER_ID_F,
		var_0_10.S2C_NEWSLG_BOSSUSERSTATENOTIFY_ROBOT_USERS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSTEAMJOINNOTIFY_TEAM_ID_F, {
	"team_id",
	".cs.S2C_NewSlg_BossTeamJoinNotify.team_id",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSTEAMJOINNOTIFY_JOIN_USER_F, {
	"join_user",
	".cs.S2C_NewSlg_BossTeamJoinNotify.join_user",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.NEWSLGBOSSTEAMUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOSSTEAMJOINNOTIFY_ME, {
	"S2C_NewSlg_BossTeamJoinNotify",
	".cs.S2C_NewSlg_BossTeamJoinNotify",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOSSTEAMJOINNOTIFY_TEAM_ID_F,
		var_0_10.S2C_NEWSLG_BOSSTEAMJOINNOTIFY_JOIN_USER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSDISMISSTEAM_TEAM_ID_F, {
	"team_id",
	".cs.C2S_NewSlg_BossDismissTeam.team_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_BOSSDISMISSTEAM_ME, {
	"C2S_NewSlg_BossDismissTeam",
	".cs.C2S_NewSlg_BossDismissTeam",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_BOSSDISMISSTEAM_TEAM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSDISMISSTEAM_RET_F, {
	"ret",
	".cs.S2C_NewSlg_BossDismissTeam.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSDISMISSTEAM_TEAM_ID_F, {
	"team_id",
	".cs.S2C_NewSlg_BossDismissTeam.team_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOSSDISMISSTEAM_ME, {
	"S2C_NewSlg_BossDismissTeam",
	".cs.S2C_NewSlg_BossDismissTeam",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOSSDISMISSTEAM_RET_F,
		var_0_10.S2C_NEWSLG_BOSSDISMISSTEAM_TEAM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSBATTLESTARTNOTIFY_TEAM_ID_F, {
	"team_id",
	".cs.S2C_NewSlg_BossBattleStartNotify.team_id",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSBATTLESTARTNOTIFY_REPORT_F, {
	"report",
	".cs.S2C_NewSlg_BossBattleStartNotify.report",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.NEWSLGBATTLEREPORT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSBATTLESTARTNOTIFY_BOSS_ID_F, {
	"boss_id",
	".cs.S2C_NewSlg_BossBattleStartNotify.boss_id",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOSSBATTLESTARTNOTIFY_ME, {
	"S2C_NewSlg_BossBattleStartNotify",
	".cs.S2C_NewSlg_BossBattleStartNotify",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOSSBATTLESTARTNOTIFY_TEAM_ID_F,
		var_0_10.S2C_NEWSLG_BOSSBATTLESTARTNOTIFY_REPORT_F,
		var_0_10.S2C_NEWSLG_BOSSBATTLESTARTNOTIFY_BOSS_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSBATTLEFINISHNOTIFY_TEAM_ID_F, {
	"team_id",
	".cs.S2C_NewSlg_BossBattleFinishNotify.team_id",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSBATTLEFINISHNOTIFY_RESULT_F, {
	"result",
	".cs.S2C_NewSlg_BossBattleFinishNotify.result",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.NEWSLGBATTLERESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSBATTLEFINISHNOTIFY_BOSS_ID_F, {
	"boss_id",
	".cs.S2C_NewSlg_BossBattleFinishNotify.boss_id",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSBATTLEFINISHNOTIFY_CHALLENGED_BOSS_LEVEL_F, {
	"challenged_boss_level",
	".cs.S2C_NewSlg_BossBattleFinishNotify.challenged_boss_level",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOSSBATTLEFINISHNOTIFY_ME, {
	"S2C_NewSlg_BossBattleFinishNotify",
	".cs.S2C_NewSlg_BossBattleFinishNotify",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOSSBATTLEFINISHNOTIFY_TEAM_ID_F,
		var_0_10.S2C_NEWSLG_BOSSBATTLEFINISHNOTIFY_RESULT_F,
		var_0_10.S2C_NEWSLG_BOSSBATTLEFINISHNOTIFY_BOSS_ID_F,
		var_0_10.S2C_NEWSLG_BOSSBATTLEFINISHNOTIFY_CHALLENGED_BOSS_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSQUICKJOINTEAM_BOSS_ID_F, {
	"boss_id",
	".cs.C2S_NewSlg_BossQuickJoinTeam.boss_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSQUICKJOINTEAM_MOVE_PATH_F, {
	"move_path",
	".cs.C2S_NewSlg_BossQuickJoinTeam.move_path",
	2,
	1,
	3,
	false,
	{},
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSQUICKJOINTEAM_SUPPLY_TROOP_F, {
	"supply_troop",
	".cs.C2S_NewSlg_BossQuickJoinTeam.supply_troop",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	3,
	2
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSQUICKJOINTEAM_TEAM_INDEX_F, {
	"team_index",
	".cs.C2S_NewSlg_BossQuickJoinTeam.team_index",
	4,
	3,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSQUICKJOINTEAM_TEAMS_F, {
	"teams",
	".cs.C2S_NewSlg_BossQuickJoinTeam.teams",
	5,
	4,
	3,
	false,
	{},
	var_0_3.NEWSLGUSERTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_BOSSQUICKJOINTEAM_ME, {
	"C2S_NewSlg_BossQuickJoinTeam",
	".cs.C2S_NewSlg_BossQuickJoinTeam",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_BOSSQUICKJOINTEAM_BOSS_ID_F,
		var_0_10.C2S_NEWSLG_BOSSQUICKJOINTEAM_MOVE_PATH_F,
		var_0_10.C2S_NEWSLG_BOSSQUICKJOINTEAM_SUPPLY_TROOP_F,
		var_0_10.C2S_NEWSLG_BOSSQUICKJOINTEAM_TEAM_INDEX_F,
		var_0_10.C2S_NEWSLG_BOSSQUICKJOINTEAM_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSQUICKJOINTEAM_RET_F, {
	"ret",
	".cs.S2C_NewSlg_BossQuickJoinTeam.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSQUICKJOINTEAM_BOSS_ID_F, {
	"boss_id",
	".cs.S2C_NewSlg_BossQuickJoinTeam.boss_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSQUICKJOINTEAM_MOVE_PATH_F, {
	"move_path",
	".cs.S2C_NewSlg_BossQuickJoinTeam.move_path",
	3,
	2,
	3,
	false,
	{},
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSQUICKJOINTEAM_SUPPLY_TROOP_F, {
	"supply_troop",
	".cs.S2C_NewSlg_BossQuickJoinTeam.supply_troop",
	4,
	3,
	2,
	false,
	0,
	nil,
	nil,
	3,
	2
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSQUICKJOINTEAM_TEAM_INDEX_F, {
	"team_index",
	".cs.S2C_NewSlg_BossQuickJoinTeam.team_index",
	5,
	4,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSQUICKJOINTEAM_TEAM_F, {
	"team",
	".cs.S2C_NewSlg_BossQuickJoinTeam.team",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.NEWSLGBOSSTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOSSQUICKJOINTEAM_ME, {
	"S2C_NewSlg_BossQuickJoinTeam",
	".cs.S2C_NewSlg_BossQuickJoinTeam",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOSSQUICKJOINTEAM_RET_F,
		var_0_10.S2C_NEWSLG_BOSSQUICKJOINTEAM_BOSS_ID_F,
		var_0_10.S2C_NEWSLG_BOSSQUICKJOINTEAM_MOVE_PATH_F,
		var_0_10.S2C_NEWSLG_BOSSQUICKJOINTEAM_SUPPLY_TROOP_F,
		var_0_10.S2C_NEWSLG_BOSSQUICKJOINTEAM_TEAM_INDEX_F,
		var_0_10.S2C_NEWSLG_BOSSQUICKJOINTEAM_TEAM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOSSMONSTERTEAM_BOSS_ID_F, {
	"boss_id",
	".cs.C2S_NewSlg_BossMonsterTeam.boss_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_BOSSMONSTERTEAM_ME, {
	"C2S_NewSlg_BossMonsterTeam",
	".cs.C2S_NewSlg_BossMonsterTeam",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_BOSSMONSTERTEAM_BOSS_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSMONSTERTEAM_RET_F, {
	"ret",
	".cs.S2C_NewSlg_BossMonsterTeam.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSMONSTERTEAM_BOSS_ID_F, {
	"boss_id",
	".cs.S2C_NewSlg_BossMonsterTeam.boss_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOSSMONSTERTEAM_TEAM_F, {
	"team",
	".cs.S2C_NewSlg_BossMonsterTeam.team",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.NEWSLGBATTLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOSSMONSTERTEAM_ME, {
	"S2C_NewSlg_BossMonsterTeam",
	".cs.S2C_NewSlg_BossMonsterTeam",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOSSMONSTERTEAM_RET_F,
		var_0_10.S2C_NEWSLG_BOSSMONSTERTEAM_BOSS_ID_F,
		var_0_10.S2C_NEWSLG_BOSSMONSTERTEAM_TEAM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_MOVEHOMEALLIANCEPROVINCE_ME, {
	"C2S_NewSlg_MoveHomeAllianceProvince",
	".cs.C2S_NewSlg_MoveHomeAllianceProvince",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MOVEHOMEALLIANCEPROVINCE_RET_F, {
	"ret",
	".cs.S2C_NewSlg_MoveHomeAllianceProvince.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MOVEHOMEALLIANCEPROVINCE_POS_F, {
	"pos",
	".cs.S2C_NewSlg_MoveHomeAllianceProvince.pos",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MOVEHOMEALLIANCEPROVINCE_LATEST_MOVE_HOME_TIME_F, {
	"latest_move_home_time",
	".cs.S2C_NewSlg_MoveHomeAllianceProvince.latest_move_home_time",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_MOVEHOMEALLIANCEPROVINCE_ME, {
	"S2C_NewSlg_MoveHomeAllianceProvince",
	".cs.S2C_NewSlg_MoveHomeAllianceProvince",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_MOVEHOMEALLIANCEPROVINCE_RET_F,
		var_0_10.S2C_NEWSLG_MOVEHOMEALLIANCEPROVINCE_POS_F,
		var_0_10.S2C_NEWSLG_MOVEHOMEALLIANCEPROVINCE_LATEST_MOVE_HOME_TIME_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETUSERSHOWRANKSTATISTIC_ME, {
	"C2S_NewSlg_GetUserShowRankStatistic",
	".cs.C2S_NewSlg_GetUserShowRankStatistic",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETUSERSHOWRANKSTATISTIC_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetUserShowRankStatistic.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETUSERSHOWRANKSTATISTIC_PERSON_CONTRIBUTE_F, {
	"person_contribute",
	".cs.S2C_NewSlg_GetUserShowRankStatistic.person_contribute",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.NEWSLGSHOWRANKSTATISTIC_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETUSERSHOWRANKSTATISTIC_ALLIANCE_CONTRIBUTE_F, {
	"alliance_contribute",
	".cs.S2C_NewSlg_GetUserShowRankStatistic.alliance_contribute",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.NEWSLGSHOWRANKSTATISTIC_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETUSERSHOWRANKSTATISTIC_FINAL_CONTRIBUTE_F, {
	"final_contribute",
	".cs.S2C_NewSlg_GetUserShowRankStatistic.final_contribute",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.NEWSLGSHOWRANKSTATISTIC_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETUSERSHOWRANKSTATISTIC_ME, {
	"S2C_NewSlg_GetUserShowRankStatistic",
	".cs.S2C_NewSlg_GetUserShowRankStatistic",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETUSERSHOWRANKSTATISTIC_RET_F,
		var_0_10.S2C_NEWSLG_GETUSERSHOWRANKSTATISTIC_PERSON_CONTRIBUTE_F,
		var_0_10.S2C_NEWSLG_GETUSERSHOWRANKSTATISTIC_ALLIANCE_CONTRIBUTE_F,
		var_0_10.S2C_NEWSLG_GETUSERSHOWRANKSTATISTIC_FINAL_CONTRIBUTE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_NOTIFYMONSTERBATTLERESULT_MONSTER_F, {
	"monster",
	".cs.S2C_NewSlg_NotifyMonsterBattleResult.monster",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.NEWSLGMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_NOTIFYMONSTERBATTLERESULT_RESULT_F, {
	"result",
	".cs.S2C_NewSlg_NotifyMonsterBattleResult.result",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.NEWSLGBATTLERESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_NOTIFYMONSTERBATTLERESULT_ME, {
	"S2C_NewSlg_NotifyMonsterBattleResult",
	".cs.S2C_NewSlg_NotifyMonsterBattleResult",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_NOTIFYMONSTERBATTLERESULT_MONSTER_F,
		var_0_10.S2C_NEWSLG_NOTIFYMONSTERBATTLERESULT_RESULT_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETMAINCITYINFO_ME, {
	"C2S_NewSlg_GetMainCityInfo",
	".cs.C2S_NewSlg_GetMainCityInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMAINCITYINFO_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetMainCityInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETMAINCITYINFO_MAIN_CITY_F, {
	"main_city",
	".cs.S2C_NewSlg_GetMainCityInfo.main_city",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.NEWSLGMAINCITY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETMAINCITYINFO_ME, {
	"S2C_NewSlg_GetMainCityInfo",
	".cs.S2C_NewSlg_GetMainCityInfo",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETMAINCITYINFO_RET_F,
		var_0_10.S2C_NEWSLG_GETMAINCITYINFO_MAIN_CITY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_NOTIFYACTINFO_ACT_INFO_F, {
	"act_info",
	".cs.S2C_NewSlg_NotifyActInfo.act_info",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.NEWSLGACTINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_NOTIFYACTINFO_ME, {
	"S2C_NewSlg_NotifyActInfo",
	".cs.S2C_NewSlg_NotifyActInfo",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_NOTIFYACTINFO_ACT_INFO_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_MOVETARGETRIGHTNOW_MOVE_ID_F, {
	"move_id",
	".cs.C2S_NewSlg_MoveTargetRightNow.move_id",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_MOVETARGETRIGHTNOW_END_TIME_F, {
	"end_time",
	".cs.C2S_NewSlg_MoveTargetRightNow.end_time",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	3,
	2
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_MOVETARGETRIGHTNOW_ME, {
	"C2S_NewSlg_MoveTargetRightNow",
	".cs.C2S_NewSlg_MoveTargetRightNow",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_MOVETARGETRIGHTNOW_MOVE_ID_F,
		var_0_10.C2S_NEWSLG_MOVETARGETRIGHTNOW_END_TIME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MOVETARGETRIGHTNOW_RET_F, {
	"ret",
	".cs.S2C_NewSlg_MoveTargetRightNow.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MOVETARGETRIGHTNOW_MOVE_ID_F, {
	"move_id",
	".cs.S2C_NewSlg_MoveTargetRightNow.move_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_MOVETARGETRIGHTNOW_END_TIME_F, {
	"end_time",
	".cs.S2C_NewSlg_MoveTargetRightNow.end_time",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	3,
	2
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_MOVETARGETRIGHTNOW_ME, {
	"S2C_NewSlg_MoveTargetRightNow",
	".cs.S2C_NewSlg_MoveTargetRightNow",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_MOVETARGETRIGHTNOW_RET_F,
		var_0_10.S2C_NEWSLG_MOVETARGETRIGHTNOW_MOVE_ID_F,
		var_0_10.S2C_NEWSLG_MOVETARGETRIGHTNOW_END_TIME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_CITYDECLARE_CITY_ID_F, {
	"city_id",
	".cs.C2S_NewSlg_CityDeclare.city_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_CITYDECLARE_TP_F, {
	"tp",
	".cs.C2S_NewSlg_CityDeclare.tp",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_CITYDECLARE_ME, {
	"C2S_NewSlg_CityDeclare",
	".cs.C2S_NewSlg_CityDeclare",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_CITYDECLARE_CITY_ID_F,
		var_0_10.C2S_NEWSLG_CITYDECLARE_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYDECLARE_RET_F, {
	"ret",
	".cs.S2C_NewSlg_CityDeclare.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYDECLARE_CITY_ID_F, {
	"city_id",
	".cs.S2C_NewSlg_CityDeclare.city_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYDECLARE_TP_F, {
	"tp",
	".cs.S2C_NewSlg_CityDeclare.tp",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_CITYDECLARE_ME, {
	"S2C_NewSlg_CityDeclare",
	".cs.S2C_NewSlg_CityDeclare",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_CITYDECLARE_RET_F,
		var_0_10.S2C_NEWSLG_CITYDECLARE_CITY_ID_F,
		var_0_10.S2C_NEWSLG_CITYDECLARE_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYDECLARENTF_CITIES_F, {
	"cities",
	".cs.S2C_NewSlg_CityDeclareNtf.cities",
	1,
	0,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYDECLARENTF_ALLI_ID_F, {
	"alli_id",
	".cs.S2C_NewSlg_CityDeclareNtf.alli_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_CITYDECLARENTF_ME, {
	"S2C_NewSlg_CityDeclareNtf",
	".cs.S2C_NewSlg_CityDeclareNtf",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_CITYDECLARENTF_CITIES_F,
		var_0_10.S2C_NEWSLG_CITYDECLARENTF_ALLI_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYBEDECLAREDNTF_CITY_BE_DECLARED_F, {
	"city_be_declared",
	".cs.S2C_NewSlg_CityBeDeclaredNtf.city_be_declared",
	1,
	0,
	3,
	false,
	{},
	var_0_3.NEWSLGCITYDECLAREDALLI_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_CITYBEDECLAREDNTF_ME, {
	"S2C_NewSlg_CityBeDeclaredNtf",
	".cs.S2C_NewSlg_CityBeDeclaredNtf",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_CITYBEDECLAREDNTF_CITY_BE_DECLARED_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYMARCHNTF_CITY_ID_F, {
	"city_id",
	".cs.S2C_NewSlg_CityMarchNtf.city_id",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYMARCHNTF_NUM_F, {
	"num",
	".cs.S2C_NewSlg_CityMarchNtf.num",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_CITYMARCHNTF_ME, {
	"S2C_NewSlg_CityMarchNtf",
	".cs.S2C_NewSlg_CityMarchNtf",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_CITYMARCHNTF_CITY_ID_F,
		var_0_10.S2C_NEWSLG_CITYMARCHNTF_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BUILDCITY_CITY_ID_F, {
	"city_id",
	".cs.C2S_NewSlg_BuildCity.city_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BUILDCITY_NUM_F, {
	"num",
	".cs.C2S_NewSlg_BuildCity.num",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_BUILDCITY_ME, {
	"C2S_NewSlg_BuildCity",
	".cs.C2S_NewSlg_BuildCity",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_BUILDCITY_CITY_ID_F,
		var_0_10.C2S_NEWSLG_BUILDCITY_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BUILDCITY_RET_F, {
	"ret",
	".cs.S2C_NewSlg_BuildCity.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BUILDCITY_CITY_ID_F, {
	"city_id",
	".cs.S2C_NewSlg_BuildCity.city_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BUILDCITY_BUILD_F, {
	"build",
	".cs.S2C_NewSlg_BuildCity.build",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.NEWSLGCITYBUILD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BUILDCITY_NUM_F, {
	"num",
	".cs.S2C_NewSlg_BuildCity.num",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BUILDCITY_ME, {
	"S2C_NewSlg_BuildCity",
	".cs.S2C_NewSlg_BuildCity",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BUILDCITY_RET_F,
		var_0_10.S2C_NEWSLG_BUILDCITY_CITY_ID_F,
		var_0_10.S2C_NEWSLG_BUILDCITY_BUILD_F,
		var_0_10.S2C_NEWSLG_BUILDCITY_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETCITYBUILDINFO_CITY_ID_F, {
	"city_id",
	".cs.C2S_NewSlg_GetCityBuildInfo.city_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETCITYBUILDINFO_ME, {
	"C2S_NewSlg_GetCityBuildInfo",
	".cs.C2S_NewSlg_GetCityBuildInfo",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_GETCITYBUILDINFO_CITY_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETCITYBUILDINFO_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetCityBuildInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETCITYBUILDINFO_CITY_ID_F, {
	"city_id",
	".cs.S2C_NewSlg_GetCityBuildInfo.city_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETCITYBUILDINFO_BUILD_F, {
	"build",
	".cs.S2C_NewSlg_GetCityBuildInfo.build",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.NEWSLGCITYBUILD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETCITYBUILDINFO_ME, {
	"S2C_NewSlg_GetCityBuildInfo",
	".cs.S2C_NewSlg_GetCityBuildInfo",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETCITYBUILDINFO_RET_F,
		var_0_10.S2C_NEWSLG_GETCITYBUILDINFO_CITY_ID_F,
		var_0_10.S2C_NEWSLG_GETCITYBUILDINFO_BUILD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYBATTLEALLISUMMARYNTF_ALLI_ID_F, {
	"alli_id",
	".cs.S2C_NewSlg_CityBattleAlliSummaryNtf.alli_id",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYBATTLEALLISUMMARYNTF_CITIES_F, {
	"cities",
	".cs.S2C_NewSlg_CityBattleAlliSummaryNtf.cities",
	2,
	1,
	3,
	false,
	{},
	var_0_3.NEWSLGALLICITYBATTLE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYBATTLEALLISUMMARYNTF_SCORE_F, {
	"score",
	".cs.S2C_NewSlg_CityBattleAlliSummaryNtf.score",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYBATTLEALLISUMMARYNTF_SCORE_ADDITION_F, {
	"score_addition",
	".cs.S2C_NewSlg_CityBattleAlliSummaryNtf.score_addition",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_CITYBATTLEALLISUMMARYNTF_ME, {
	"S2C_NewSlg_CityBattleAlliSummaryNtf",
	".cs.S2C_NewSlg_CityBattleAlliSummaryNtf",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_CITYBATTLEALLISUMMARYNTF_ALLI_ID_F,
		var_0_10.S2C_NEWSLG_CITYBATTLEALLISUMMARYNTF_CITIES_F,
		var_0_10.S2C_NEWSLG_CITYBATTLEALLISUMMARYNTF_SCORE_F,
		var_0_10.S2C_NEWSLG_CITYBATTLEALLISUMMARYNTF_SCORE_ADDITION_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETINFOONCITYBATTLEEND_ME, {
	"C2S_NewSlg_GetInfoOnCityBattleEnd",
	".cs.C2S_NewSlg_GetInfoOnCityBattleEnd",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETINFOONCITYBATTLEEND_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetInfoOnCityBattleEnd.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETINFOONCITYBATTLEEND_CITY_OCCUPIER_F, {
	"city_occupier",
	".cs.S2C_NewSlg_GetInfoOnCityBattleEnd.city_occupier",
	2,
	1,
	3,
	false,
	{},
	var_0_3.KV2_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETINFOONCITYBATTLEEND_SCORE_ADDITION_F, {
	"score_addition",
	".cs.S2C_NewSlg_GetInfoOnCityBattleEnd.score_addition",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETINFOONCITYBATTLEEND_RES_ADDITION_F, {
	"res_addition",
	".cs.S2C_NewSlg_GetInfoOnCityBattleEnd.res_addition",
	4,
	3,
	3,
	false,
	{},
	var_0_3.KV2_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETINFOONCITYBATTLEEND_GIVE_UP_CITY_IDS_F, {
	"give_up_city_ids",
	".cs.S2C_NewSlg_GetInfoOnCityBattleEnd.give_up_city_ids",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETINFOONCITYBATTLEEND_ME, {
	"S2C_NewSlg_GetInfoOnCityBattleEnd",
	".cs.S2C_NewSlg_GetInfoOnCityBattleEnd",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETINFOONCITYBATTLEEND_RET_F,
		var_0_10.S2C_NEWSLG_GETINFOONCITYBATTLEEND_CITY_OCCUPIER_F,
		var_0_10.S2C_NEWSLG_GETINFOONCITYBATTLEEND_SCORE_ADDITION_F,
		var_0_10.S2C_NEWSLG_GETINFOONCITYBATTLEEND_RES_ADDITION_F,
		var_0_10.S2C_NEWSLG_GETINFOONCITYBATTLEEND_GIVE_UP_CITY_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_SETCITYDECLARATION_CITY_ID_F, {
	"city_id",
	".cs.C2S_NewSlg_SetCityDeclaration.city_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_SETCITYDECLARATION_DECLARATION_F, {
	"declaration",
	".cs.C2S_NewSlg_SetCityDeclaration.declaration",
	2,
	1,
	2,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_SETCITYDECLARATION_ME, {
	"C2S_NewSlg_SetCityDeclaration",
	".cs.C2S_NewSlg_SetCityDeclaration",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_SETCITYDECLARATION_CITY_ID_F,
		var_0_10.C2S_NEWSLG_SETCITYDECLARATION_DECLARATION_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_SETCITYDECLARATION_RET_F, {
	"ret",
	".cs.S2C_NewSlg_SetCityDeclaration.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_SETCITYDECLARATION_CITY_ID_F, {
	"city_id",
	".cs.S2C_NewSlg_SetCityDeclaration.city_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_SETCITYDECLARATION_DECLARATION_F, {
	"declaration",
	".cs.S2C_NewSlg_SetCityDeclaration.declaration",
	3,
	2,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_SETCITYDECLARATION_ME, {
	"S2C_NewSlg_SetCityDeclaration",
	".cs.S2C_NewSlg_SetCityDeclaration",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_SETCITYDECLARATION_RET_F,
		var_0_10.S2C_NEWSLG_SETCITYDECLARATION_CITY_ID_F,
		var_0_10.S2C_NEWSLG_SETCITYDECLARATION_DECLARATION_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETCITYSHOWDATA_CITY_ID_F, {
	"city_id",
	".cs.C2S_NewSlg_GetCityShowData.city_id",
	1,
	0,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETCITYSHOWDATA_ME, {
	"C2S_NewSlg_GetCityShowData",
	".cs.C2S_NewSlg_GetCityShowData",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_GETCITYSHOWDATA_CITY_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETCITYSHOWDATA_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetCityShowData.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETCITYSHOWDATA_SHOWS_F, {
	"shows",
	".cs.S2C_NewSlg_GetCityShowData.shows",
	2,
	1,
	3,
	false,
	{},
	var_0_3.NEWSLGMAPCITYSIMPLESHOW_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETCITYSHOWDATA_ME, {
	"S2C_NewSlg_GetCityShowData",
	".cs.S2C_NewSlg_GetCityShowData",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETCITYSHOWDATA_RET_F,
		var_0_10.S2C_NEWSLG_GETCITYSHOWDATA_SHOWS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_OBTAINQUESTREWARD_ID_F, {
	"id",
	".cs.C2S_NewSlg_ObtainQuestReward.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_OBTAINQUESTREWARD_ME, {
	"C2S_NewSlg_ObtainQuestReward",
	".cs.C2S_NewSlg_ObtainQuestReward",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_OBTAINQUESTREWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_OBTAINQUESTREWARD_RET_F, {
	"ret",
	".cs.S2C_NewSlg_ObtainQuestReward.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_OBTAINQUESTREWARD_ID_F, {
	"id",
	".cs.S2C_NewSlg_ObtainQuestReward.id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_OBTAINQUESTREWARD_AWARDS_F, {
	"awards",
	".cs.S2C_NewSlg_ObtainQuestReward.awards",
	3,
	2,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_OBTAINQUESTREWARD_ME, {
	"S2C_NewSlg_ObtainQuestReward",
	".cs.S2C_NewSlg_ObtainQuestReward",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_OBTAINQUESTREWARD_RET_F,
		var_0_10.S2C_NEWSLG_OBTAINQUESTREWARD_ID_F,
		var_0_10.S2C_NEWSLG_OBTAINQUESTREWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_ONEKEYOBTAINREWARDS_TYPE_F, {
	"type",
	".cs.C2S_NewSlg_OnekeyObtainRewards.type",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_ONEKEYOBTAINREWARDS_ME, {
	"C2S_NewSlg_OnekeyObtainRewards",
	".cs.C2S_NewSlg_OnekeyObtainRewards",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_ONEKEYOBTAINREWARDS_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ONEKEYOBTAINREWARDS_RET_F, {
	"ret",
	".cs.S2C_NewSlg_OnekeyObtainRewards.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ONEKEYOBTAINREWARDS_TYPE_F, {
	"type",
	".cs.S2C_NewSlg_OnekeyObtainRewards.type",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ONEKEYOBTAINREWARDS_IDS_F, {
	"ids",
	".cs.S2C_NewSlg_OnekeyObtainRewards.ids",
	3,
	2,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ONEKEYOBTAINREWARDS_AWARDS_F, {
	"awards",
	".cs.S2C_NewSlg_OnekeyObtainRewards.awards",
	4,
	3,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_ONEKEYOBTAINREWARDS_ME, {
	"S2C_NewSlg_OnekeyObtainRewards",
	".cs.S2C_NewSlg_OnekeyObtainRewards",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_ONEKEYOBTAINREWARDS_RET_F,
		var_0_10.S2C_NEWSLG_ONEKEYOBTAINREWARDS_TYPE_F,
		var_0_10.S2C_NEWSLG_ONEKEYOBTAINREWARDS_IDS_F,
		var_0_10.S2C_NEWSLG_ONEKEYOBTAINREWARDS_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_DELETEMOVEUNIT_MOVE_ID_F, {
	"move_id",
	".cs.S2C_NewSlg_DeleteMoveUnit.move_id",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_DELETEMOVEUNIT_ME, {
	"S2C_NewSlg_DeleteMoveUnit",
	".cs.S2C_NewSlg_DeleteMoveUnit",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_DELETEMOVEUNIT_MOVE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_USERACHIEVEMENTNTF_ACHIEVEMENTS_F, {
	"achievements",
	".cs.S2C_NewSlg_UserAchievementNtf.achievements",
	1,
	0,
	3,
	false,
	{},
	var_0_3.COMMONTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_USERACHIEVEMENTNTF_ME, {
	"S2C_NewSlg_UserAchievementNtf",
	".cs.S2C_NewSlg_UserAchievementNtf",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_USERACHIEVEMENTNTF_ACHIEVEMENTS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETUSERSHOWSTATISTIC_ME, {
	"C2S_NewSlg_GetUserShowStatistic",
	".cs.C2S_NewSlg_GetUserShowStatistic",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETUSERSHOWSTATISTIC_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetUserShowStatistic.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETUSERSHOWSTATISTIC_KILL_MONSTER_F, {
	"kill_monster",
	".cs.S2C_NewSlg_GetUserShowStatistic.kill_monster",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.NEWSLGSHOWSTATISTIC_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETUSERSHOWSTATISTIC_BOSS_TEAM_WIN_F, {
	"boss_team_win",
	".cs.S2C_NewSlg_GetUserShowStatistic.boss_team_win",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.NEWSLGSHOWSTATISTIC_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETUSERSHOWSTATISTIC_ATTACK_CITY_F, {
	"attack_city",
	".cs.S2C_NewSlg_GetUserShowStatistic.attack_city",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.NEWSLGSHOWSTATISTIC_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETUSERSHOWSTATISTIC_ME, {
	"S2C_NewSlg_GetUserShowStatistic",
	".cs.S2C_NewSlg_GetUserShowStatistic",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETUSERSHOWSTATISTIC_RET_F,
		var_0_10.S2C_NEWSLG_GETUSERSHOWSTATISTIC_KILL_MONSTER_F,
		var_0_10.S2C_NEWSLG_GETUSERSHOWSTATISTIC_BOSS_TEAM_WIN_F,
		var_0_10.S2C_NEWSLG_GETUSERSHOWSTATISTIC_ATTACK_CITY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_ASSISTCITY_CITY_ID_F, {
	"city_id",
	".cs.C2S_NewSlg_AssistCity.city_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_ASSISTCITY_ME, {
	"C2S_NewSlg_AssistCity",
	".cs.C2S_NewSlg_AssistCity",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_ASSISTCITY_CITY_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ASSISTCITY_RET_F, {
	"ret",
	".cs.S2C_NewSlg_AssistCity.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ASSISTCITY_CITY_ID_F, {
	"city_id",
	".cs.S2C_NewSlg_AssistCity.city_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_ASSISTCITY_ME, {
	"S2C_NewSlg_AssistCity",
	".cs.S2C_NewSlg_AssistCity",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_ASSISTCITY_RET_F,
		var_0_10.S2C_NEWSLG_ASSISTCITY_CITY_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_ASSISTCITYNTF_ASSIST_CITY_AUTHORITY_F, {
	"assist_city_authority",
	".cs.S2C_NewSlg_AssistCityNtf.assist_city_authority",
	1,
	0,
	3,
	false,
	{},
	var_0_3.KV2_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_ASSISTCITYNTF_ME, {
	"S2C_NewSlg_AssistCityNtf",
	".cs.S2C_NewSlg_AssistCityNtf",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_ASSISTCITYNTF_ASSIST_CITY_AUTHORITY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYOCCUPIERNTF_CITY_OCCUPIER_F, {
	"city_occupier",
	".cs.S2C_NewSlg_CityOccupierNtf.city_occupier",
	1,
	0,
	3,
	false,
	{},
	var_0_3.KV2_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_CITYOCCUPIERNTF_ME, {
	"S2C_NewSlg_CityOccupierNtf",
	".cs.S2C_NewSlg_CityOccupierNtf",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_CITYOCCUPIERNTF_CITY_OCCUPIER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_CITYELEMENTNTF_CITY_ELEMENTS_F, {
	"city_elements",
	".cs.S2C_NewSlg_CityElementNtf.city_elements",
	1,
	0,
	3,
	false,
	{},
	var_0_3.NEWSLGCITYELEMENT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_CITYELEMENTNTF_ME, {
	"S2C_NewSlg_CityElementNtf",
	".cs.S2C_NewSlg_CityElementNtf",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_CITYELEMENTNTF_CITY_ELEMENTS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETSMALLMAPINFO_ME, {
	"C2S_NewSlg_GetSmallMapInfo",
	".cs.C2S_NewSlg_GetSmallMapInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETSMALLMAPINFO_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetSmallMapInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETSMALLMAPINFO_INFO_F, {
	"info",
	".cs.S2C_NewSlg_GetSmallMapInfo.info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.NEWSLGSMALLMAPINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETSMALLMAPINFO_ME, {
	"S2C_NewSlg_GetSmallMapInfo",
	".cs.S2C_NewSlg_GetSmallMapInfo",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETSMALLMAPINFO_RET_F,
		var_0_10.S2C_NEWSLG_GETSMALLMAPINFO_INFO_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETALLIANCEINFO_USER_ID_F, {
	"user_id",
	".cs.C2S_NewSlg_GetAllianceInfo.user_id",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETALLIANCEINFO_ALLIANCE_ID_F, {
	"alliance_id",
	".cs.C2S_NewSlg_GetAllianceInfo.alliance_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETALLIANCEINFO_ME, {
	"C2S_NewSlg_GetAllianceInfo",
	".cs.C2S_NewSlg_GetAllianceInfo",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_GETALLIANCEINFO_USER_ID_F,
		var_0_10.C2S_NEWSLG_GETALLIANCEINFO_ALLIANCE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETALLIANCEINFO_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetAllianceInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETALLIANCEINFO_USER_ID_F, {
	"user_id",
	".cs.S2C_NewSlg_GetAllianceInfo.user_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETALLIANCEINFO_ALLIANCE_ID_F, {
	"alliance_id",
	".cs.S2C_NewSlg_GetAllianceInfo.alliance_id",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETALLIANCEINFO_INFO_F, {
	"info",
	".cs.S2C_NewSlg_GetAllianceInfo.info",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.NEWSLGALLIANCE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETALLIANCEINFO_ME, {
	"S2C_NewSlg_GetAllianceInfo",
	".cs.S2C_NewSlg_GetAllianceInfo",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETALLIANCEINFO_RET_F,
		var_0_10.S2C_NEWSLG_GETALLIANCEINFO_USER_ID_F,
		var_0_10.S2C_NEWSLG_GETALLIANCEINFO_ALLIANCE_ID_F,
		var_0_10.S2C_NEWSLG_GETALLIANCEINFO_INFO_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_SETALLIANCESTRATEGY_ALLI_STRATEGY_BASE_ID_F, {
	"alli_strategy_base_id",
	".cs.C2S_NewSlg_SetAllianceStrategy.alli_strategy_base_id",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_SETALLIANCESTRATEGY_ME, {
	"C2S_NewSlg_SetAllianceStrategy",
	".cs.C2S_NewSlg_SetAllianceStrategy",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_SETALLIANCESTRATEGY_ALLI_STRATEGY_BASE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_SETALLIANCESTRATEGY_RET_F, {
	"ret",
	".cs.S2C_NewSlg_SetAllianceStrategy.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_SETALLIANCESTRATEGY_ALLI_STRATEGY_BASE_ID_F, {
	"alli_strategy_base_id",
	".cs.S2C_NewSlg_SetAllianceStrategy.alli_strategy_base_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_SETALLIANCESTRATEGY_ME, {
	"S2C_NewSlg_SetAllianceStrategy",
	".cs.S2C_NewSlg_SetAllianceStrategy",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_SETALLIANCESTRATEGY_RET_F,
		var_0_10.S2C_NEWSLG_SETALLIANCESTRATEGY_ALLI_STRATEGY_BASE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_NOTIFYALLIANCESTRATEGY_USER_ID_F, {
	"user_id",
	".cs.S2C_NewSlg_NotifyAllianceStrategy.user_id",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_NOTIFYALLIANCESTRATEGY_ALLI_STRATEGY_BASE_ID_F, {
	"alli_strategy_base_id",
	".cs.S2C_NewSlg_NotifyAllianceStrategy.alli_strategy_base_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_NOTIFYALLIANCESTRATEGY_ME, {
	"S2C_NewSlg_NotifyAllianceStrategy",
	".cs.S2C_NewSlg_NotifyAllianceStrategy",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_NOTIFYALLIANCESTRATEGY_USER_ID_F,
		var_0_10.S2C_NEWSLG_NOTIFYALLIANCESTRATEGY_ALLI_STRATEGY_BASE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_FARMMARCH_FARM_ID_F, {
	"farm_id",
	".cs.C2S_NewSlg_FarmMarch.farm_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_FARMMARCH_MOVE_PATH_F, {
	"move_path",
	".cs.C2S_NewSlg_FarmMarch.move_path",
	2,
	1,
	3,
	false,
	{},
	var_0_3.POS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_FARMMARCH_SUPPLY_TROOP_F, {
	"supply_troop",
	".cs.C2S_NewSlg_FarmMarch.supply_troop",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	3,
	2
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_FARMMARCH_TEAMS_F, {
	"teams",
	".cs.C2S_NewSlg_FarmMarch.teams",
	4,
	3,
	3,
	false,
	{},
	var_0_3.NEWSLGUSERTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_FARMMARCH_TEAM_INDEX_F, {
	"team_index",
	".cs.C2S_NewSlg_FarmMarch.team_index",
	5,
	4,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_FARMMARCH_ME, {
	"C2S_NewSlg_FarmMarch",
	".cs.C2S_NewSlg_FarmMarch",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_FARMMARCH_FARM_ID_F,
		var_0_10.C2S_NEWSLG_FARMMARCH_MOVE_PATH_F,
		var_0_10.C2S_NEWSLG_FARMMARCH_SUPPLY_TROOP_F,
		var_0_10.C2S_NEWSLG_FARMMARCH_TEAMS_F,
		var_0_10.C2S_NEWSLG_FARMMARCH_TEAM_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMMARCH_RET_F, {
	"ret",
	".cs.S2C_NewSlg_FarmMarch.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMMARCH_FARM_ID_F, {
	"farm_id",
	".cs.S2C_NewSlg_FarmMarch.farm_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMMARCH_MOVE_F, {
	"move",
	".cs.S2C_NewSlg_FarmMarch.move",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.NEWSLGSIMPLEMOVE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMMARCH_TEAM_INDEX_F, {
	"team_index",
	".cs.S2C_NewSlg_FarmMarch.team_index",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_FARMMARCH_ME, {
	"S2C_NewSlg_FarmMarch",
	".cs.S2C_NewSlg_FarmMarch",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_FARMMARCH_RET_F,
		var_0_10.S2C_NEWSLG_FARMMARCH_FARM_ID_F,
		var_0_10.S2C_NEWSLG_FARMMARCH_MOVE_F,
		var_0_10.S2C_NEWSLG_FARMMARCH_TEAM_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_FARMCANCELMOVE_TEAM_INDEX_F, {
	"team_index",
	".cs.C2S_NewSlg_FarmCancelMove.team_index",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_FARMCANCELMOVE_ME, {
	"C2S_NewSlg_FarmCancelMove",
	".cs.C2S_NewSlg_FarmCancelMove",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_FARMCANCELMOVE_TEAM_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMCANCELMOVE_RET_F, {
	"ret",
	".cs.S2C_NewSlg_FarmCancelMove.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMCANCELMOVE_TEAM_INDEX_F, {
	"team_index",
	".cs.S2C_NewSlg_FarmCancelMove.team_index",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMCANCELMOVE_MOVE_F, {
	"move",
	".cs.S2C_NewSlg_FarmCancelMove.move",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.NEWSLGSIMPLEMOVE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_FARMCANCELMOVE_ME, {
	"S2C_NewSlg_FarmCancelMove",
	".cs.S2C_NewSlg_FarmCancelMove",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_FARMCANCELMOVE_RET_F,
		var_0_10.S2C_NEWSLG_FARMCANCELMOVE_TEAM_INDEX_F,
		var_0_10.S2C_NEWSLG_FARMCANCELMOVE_MOVE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETFARMDEFINFO_FARM_ID_F, {
	"farm_id",
	".cs.C2S_NewSlg_GetFarmDefInfo.farm_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETFARMDEFINFO_ME, {
	"C2S_NewSlg_GetFarmDefInfo",
	".cs.C2S_NewSlg_GetFarmDefInfo",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_GETFARMDEFINFO_FARM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETFARMDEFINFO_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetFarmDefInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETFARMDEFINFO_FARM_ID_F, {
	"farm_id",
	".cs.S2C_NewSlg_GetFarmDefInfo.farm_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETFARMDEFINFO_DEF_DATA_F, {
	"def_data",
	".cs.S2C_NewSlg_GetFarmDefInfo.def_data",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.NEWSLGFARMDEFDATA_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETFARMDEFINFO_ME, {
	"S2C_NewSlg_GetFarmDefInfo",
	".cs.S2C_NewSlg_GetFarmDefInfo",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETFARMDEFINFO_RET_F,
		var_0_10.S2C_NEWSLG_GETFARMDEFINFO_FARM_ID_F,
		var_0_10.S2C_NEWSLG_GETFARMDEFINFO_DEF_DATA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_GETFARMBATTLEINFO_FARM_ID_F, {
	"farm_id",
	".cs.C2S_NewSlg_GetFarmBattleInfo.farm_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETFARMBATTLEINFO_ME, {
	"C2S_NewSlg_GetFarmBattleInfo",
	".cs.C2S_NewSlg_GetFarmBattleInfo",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_GETFARMBATTLEINFO_FARM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETFARMBATTLEINFO_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetFarmBattleInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETFARMBATTLEINFO_FARM_ID_F, {
	"farm_id",
	".cs.S2C_NewSlg_GetFarmBattleInfo.farm_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETFARMBATTLEINFO_ATK_DATA_F, {
	"atk_data",
	".cs.S2C_NewSlg_GetFarmBattleInfo.atk_data",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.NEWSLGFARMATKDATA_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETFARMBATTLEINFO_ME, {
	"S2C_NewSlg_GetFarmBattleInfo",
	".cs.S2C_NewSlg_GetFarmBattleInfo",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETFARMBATTLEINFO_RET_F,
		var_0_10.S2C_NEWSLG_GETFARMBATTLEINFO_FARM_ID_F,
		var_0_10.S2C_NEWSLG_GETFARMBATTLEINFO_ATK_DATA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMMAPSHOWNTF_FARM_MAP_SHOWS_F, {
	"farm_map_shows",
	".cs.S2C_NewSlg_FarmMapShowNtf.farm_map_shows",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.NEWSLGFARMMAPSHOW_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_FARMMAPSHOWNTF_ME, {
	"S2C_NewSlg_FarmMapShowNtf",
	".cs.S2C_NewSlg_FarmMapShowNtf",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_FARMMAPSHOWNTF_FARM_MAP_SHOWS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMBATTLEREPORT_RESULT_F, {
	"result",
	".cs.S2C_NewSlg_FarmBattleReport.result",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.NEWSLGBATTLERESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMBATTLEREPORT_REPORT_F, {
	"report",
	".cs.S2C_NewSlg_FarmBattleReport.report",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.NEWSLGBATTLEREPORT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_FARMBATTLEREPORT_ME, {
	"S2C_NewSlg_FarmBattleReport",
	".cs.S2C_NewSlg_FarmBattleReport",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_FARMBATTLEREPORT_RESULT_F,
		var_0_10.S2C_NEWSLG_FARMBATTLEREPORT_REPORT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_FARMGIVEUP_FARM_ID_F, {
	"farm_id",
	".cs.C2S_NewSlg_FarmGiveUp.farm_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_FARMGIVEUP_ME, {
	"C2S_NewSlg_FarmGiveUp",
	".cs.C2S_NewSlg_FarmGiveUp",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_FARMGIVEUP_FARM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMGIVEUP_RET_F, {
	"ret",
	".cs.S2C_NewSlg_FarmGiveUp.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMGIVEUP_FARM_ID_F, {
	"farm_id",
	".cs.S2C_NewSlg_FarmGiveUp.farm_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_FARMGIVEUP_ME, {
	"S2C_NewSlg_FarmGiveUp",
	".cs.S2C_NewSlg_FarmGiveUp",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_FARMGIVEUP_RET_F,
		var_0_10.S2C_NEWSLG_FARMGIVEUP_FARM_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_GETUSERFARMINFO_ME, {
	"C2S_NewSlg_GetUserFarmInfo",
	".cs.C2S_NewSlg_GetUserFarmInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETUSERFARMINFO_RET_F, {
	"ret",
	".cs.S2C_NewSlg_GetUserFarmInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETUSERFARMINFO_FARM_NUM_F, {
	"farm_num",
	".cs.S2C_NewSlg_GetUserFarmInfo.farm_num",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETUSERFARMINFO_FARMS_F, {
	"farms",
	".cs.S2C_NewSlg_GetUserFarmInfo.farms",
	3,
	2,
	3,
	false,
	{},
	var_0_3.NEWSLGUSERFARM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_GETUSERFARMINFO_DAILY_FARM_KILL_SCORE_F, {
	"daily_farm_kill_score",
	".cs.S2C_NewSlg_GetUserFarmInfo.daily_farm_kill_score",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_GETUSERFARMINFO_ME, {
	"S2C_NewSlg_GetUserFarmInfo",
	".cs.S2C_NewSlg_GetUserFarmInfo",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_GETUSERFARMINFO_RET_F,
		var_0_10.S2C_NEWSLG_GETUSERFARMINFO_FARM_NUM_F,
		var_0_10.S2C_NEWSLG_GETUSERFARMINFO_FARMS_F,
		var_0_10.S2C_NEWSLG_GETUSERFARMINFO_DAILY_FARM_KILL_SCORE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_USEFARMTOKEN_FARM_ID_F, {
	"farm_id",
	".cs.C2S_NewSlg_UseFarmToken.farm_id",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_USEFARMTOKEN_ME, {
	"C2S_NewSlg_UseFarmToken",
	".cs.C2S_NewSlg_UseFarmToken",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_USEFARMTOKEN_FARM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_USEFARMTOKEN_RET_F, {
	"ret",
	".cs.S2C_NewSlg_UseFarmToken.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_USEFARMTOKEN_FARM_ID_F, {
	"farm_id",
	".cs.S2C_NewSlg_UseFarmToken.farm_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_USEFARMTOKEN_AWARDS_F, {
	"awards",
	".cs.S2C_NewSlg_UseFarmToken.awards",
	3,
	2,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_USEFARMTOKEN_ME, {
	"S2C_NewSlg_UseFarmToken",
	".cs.S2C_NewSlg_UseFarmToken",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_USEFARMTOKEN_RET_F,
		var_0_10.S2C_NEWSLG_USEFARMTOKEN_FARM_ID_F,
		var_0_10.S2C_NEWSLG_USEFARMTOKEN_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMAWARD_TP_F, {
	"tp",
	".cs.S2C_NewSlg_FarmAward.tp",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMAWARD_FARM_ID_F, {
	"farm_id",
	".cs.S2C_NewSlg_FarmAward.farm_id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_NewSlg_FarmAward.awards",
	3,
	2,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMAWARD_ROB_USER_ID_F, {
	"rob_user_id",
	".cs.S2C_NewSlg_FarmAward.rob_user_id",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FARMAWARD_ROB_SIZE_F, {
	"rob_size",
	".cs.S2C_NewSlg_FarmAward.rob_size",
	5,
	4,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_FARMAWARD_ME, {
	"S2C_NewSlg_FarmAward",
	".cs.S2C_NewSlg_FarmAward",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_FARMAWARD_TP_F,
		var_0_10.S2C_NEWSLG_FARMAWARD_FARM_ID_F,
		var_0_10.S2C_NEWSLG_FARMAWARD_AWARDS_F,
		var_0_10.S2C_NEWSLG_FARMAWARD_ROB_USER_ID_F,
		var_0_10.S2C_NEWSLG_FARMAWARD_ROB_SIZE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_BOUNTYINFO_ME, {
	"C2S_NewSlg_BountyInfo",
	".cs.C2S_NewSlg_BountyInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOUNTYINFO_RET_F, {
	"ret",
	".cs.S2C_NewSlg_BountyInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOUNTYINFO_BOUNTY_F, {
	"bounty",
	".cs.S2C_NewSlg_BountyInfo.bounty",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.USERNEWSLGBOUNTY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOUNTYINFO_ME, {
	"S2C_NewSlg_BountyInfo",
	".cs.S2C_NewSlg_BountyInfo",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOUNTYINFO_RET_F,
		var_0_10.S2C_NEWSLG_BOUNTYINFO_BOUNTY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOUNTYREFRESHTASK_INDEX_F, {
	"index",
	".cs.C2S_NewSlg_BountyRefreshTask.index",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_BOUNTYREFRESHTASK_ME, {
	"C2S_NewSlg_BountyRefreshTask",
	".cs.C2S_NewSlg_BountyRefreshTask",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_BOUNTYREFRESHTASK_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOUNTYREFRESHTASK_RET_F, {
	"ret",
	".cs.S2C_NewSlg_BountyRefreshTask.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOUNTYREFRESHTASK_INDEX_F, {
	"index",
	".cs.S2C_NewSlg_BountyRefreshTask.index",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOUNTYREFRESHTASK_TASK_DAILY_REFRESH_TIMES_F, {
	"task_daily_refresh_times",
	".cs.S2C_NewSlg_BountyRefreshTask.task_daily_refresh_times",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOUNTYREFRESHTASK_TASK_F, {
	"task",
	".cs.S2C_NewSlg_BountyRefreshTask.task",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.USERNEWSLGBOUNTYTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOUNTYREFRESHTASK_ME, {
	"S2C_NewSlg_BountyRefreshTask",
	".cs.S2C_NewSlg_BountyRefreshTask",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOUNTYREFRESHTASK_RET_F,
		var_0_10.S2C_NEWSLG_BOUNTYREFRESHTASK_INDEX_F,
		var_0_10.S2C_NEWSLG_BOUNTYREFRESHTASK_TASK_DAILY_REFRESH_TIMES_F,
		var_0_10.S2C_NEWSLG_BOUNTYREFRESHTASK_TASK_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_BOUNTYTASKAWARD_INDEX_F, {
	"index",
	".cs.C2S_NewSlg_BountyTaskAward.index",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_BOUNTYTASKAWARD_ME, {
	"C2S_NewSlg_BountyTaskAward",
	".cs.C2S_NewSlg_BountyTaskAward",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_BOUNTYTASKAWARD_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOUNTYTASKAWARD_RET_F, {
	"ret",
	".cs.S2C_NewSlg_BountyTaskAward.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOUNTYTASKAWARD_INDEX_F, {
	"index",
	".cs.S2C_NewSlg_BountyTaskAward.index",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOUNTYTASKAWARD_TASK_F, {
	"task",
	".cs.S2C_NewSlg_BountyTaskAward.task",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.USERNEWSLGBOUNTYTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_BOUNTYTASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_NewSlg_BountyTaskAward.awards",
	4,
	3,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_BOUNTYTASKAWARD_ME, {
	"S2C_NewSlg_BountyTaskAward",
	".cs.S2C_NewSlg_BountyTaskAward",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_BOUNTYTASKAWARD_RET_F,
		var_0_10.S2C_NEWSLG_BOUNTYTASKAWARD_INDEX_F,
		var_0_10.S2C_NEWSLG_BOUNTYTASKAWARD_TASK_F,
		var_0_10.S2C_NEWSLG_BOUNTYTASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_FIRSTKILLINFO_IDS_F, {
	"ids",
	".cs.C2S_NewSlg_FirstKillInfo.ids",
	1,
	0,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_FIRSTKILLINFO_ME, {
	"C2S_NewSlg_FirstKillInfo",
	".cs.C2S_NewSlg_FirstKillInfo",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_FIRSTKILLINFO_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FIRSTKILLINFO_RET_F, {
	"ret",
	".cs.S2C_NewSlg_FirstKillInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FIRSTKILLINFO_IDS_F, {
	"ids",
	".cs.S2C_NewSlg_FirstKillInfo.ids",
	2,
	1,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FIRSTKILLINFO_FIRST_KILLS_F, {
	"first_kills",
	".cs.S2C_NewSlg_FirstKillInfo.first_kills",
	3,
	2,
	3,
	false,
	{},
	var_0_3.NEWSLGFIRSTKILL_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_FIRSTKILLINFO_ME, {
	"S2C_NewSlg_FirstKillInfo",
	".cs.S2C_NewSlg_FirstKillInfo",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_FIRSTKILLINFO_RET_F,
		var_0_10.S2C_NEWSLG_FIRSTKILLINFO_IDS_F,
		var_0_10.S2C_NEWSLG_FIRSTKILLINFO_FIRST_KILLS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_FIRSTKILLAWARD_ID_F, {
	"id",
	".cs.C2S_NewSlg_FirstKillAward.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_FIRSTKILLAWARD_ME, {
	"C2S_NewSlg_FirstKillAward",
	".cs.C2S_NewSlg_FirstKillAward",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_FIRSTKILLAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FIRSTKILLAWARD_RET_F, {
	"ret",
	".cs.S2C_NewSlg_FirstKillAward.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FIRSTKILLAWARD_ID_F, {
	"id",
	".cs.S2C_NewSlg_FirstKillAward.id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FIRSTKILLAWARD_FIRST_KILL_AWARD_IDS_F, {
	"first_kill_award_ids",
	".cs.S2C_NewSlg_FirstKillAward.first_kill_award_ids",
	3,
	2,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FIRSTKILLAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_NewSlg_FirstKillAward.awards",
	4,
	3,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_FIRSTKILLAWARD_ME, {
	"S2C_NewSlg_FirstKillAward",
	".cs.S2C_NewSlg_FirstKillAward",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_FIRSTKILLAWARD_RET_F,
		var_0_10.S2C_NEWSLG_FIRSTKILLAWARD_ID_F,
		var_0_10.S2C_NEWSLG_FIRSTKILLAWARD_FIRST_KILL_AWARD_IDS_F,
		var_0_10.S2C_NEWSLG_FIRSTKILLAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_FIRSTKILLNOTIFY_INFO_F, {
	"info",
	".cs.S2C_NewSlg_FirstKillNotify.info",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.NEWSLGFIRSTKILL_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_FIRSTKILLNOTIFY_ME, {
	"S2C_NewSlg_FirstKillNotify",
	".cs.S2C_NewSlg_FirstKillNotify",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_FIRSTKILLNOTIFY_INFO_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_SEASONTASKSYNCPROGRESS_TASKS_F, {
	"tasks",
	".cs.S2C_NewSlg_SeasonTaskSyncProgress.tasks",
	1,
	0,
	3,
	false,
	{},
	var_0_3.COMMONTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_SEASONTASKSYNCPROGRESS_ME, {
	"S2C_NewSlg_SeasonTaskSyncProgress",
	".cs.S2C_NewSlg_SeasonTaskSyncProgress",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_SEASONTASKSYNCPROGRESS_TASKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_SEASONTASKAWARD_ID_F, {
	"id",
	".cs.C2S_NewSlg_SeasonTaskAward.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_SEASONTASKAWARD_ME, {
	"C2S_NewSlg_SeasonTaskAward",
	".cs.C2S_NewSlg_SeasonTaskAward",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_SEASONTASKAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_SEASONTASKAWARD_RET_F, {
	"ret",
	".cs.S2C_NewSlg_SeasonTaskAward.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_SEASONTASKAWARD_ID_F, {
	"id",
	".cs.S2C_NewSlg_SeasonTaskAward.id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_SEASONTASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_NewSlg_SeasonTaskAward.awards",
	3,
	2,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_SEASONTASKAWARD_ME, {
	"S2C_NewSlg_SeasonTaskAward",
	".cs.S2C_NewSlg_SeasonTaskAward",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_SEASONTASKAWARD_RET_F,
		var_0_10.S2C_NEWSLG_SEASONTASKAWARD_ID_F,
		var_0_10.S2C_NEWSLG_SEASONTASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_TECHNOLOGYACTIVATE_ID_F, {
	"id",
	".cs.C2S_NewSlg_TechnologyActivate.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_TECHNOLOGYACTIVATE_ME, {
	"C2S_NewSlg_TechnologyActivate",
	".cs.C2S_NewSlg_TechnologyActivate",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_TECHNOLOGYACTIVATE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_TECHNOLOGYACTIVATE_RET_F, {
	"ret",
	".cs.S2C_NewSlg_TechnologyActivate.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_TECHNOLOGYACTIVATE_ID_F, {
	"id",
	".cs.S2C_NewSlg_TechnologyActivate.id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_TECHNOLOGYACTIVATE_ME, {
	"S2C_NewSlg_TechnologyActivate",
	".cs.S2C_NewSlg_TechnologyActivate",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_TECHNOLOGYACTIVATE_RET_F,
		var_0_10.S2C_NEWSLG_TECHNOLOGYACTIVATE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_TECHNOLOGYUPDATE_POINT_F, {
	"point",
	".cs.S2C_NewSlg_TechnologyUpdate.point",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_TECHNOLOGYUPDATE_ME, {
	"S2C_NewSlg_TechnologyUpdate",
	".cs.S2C_NewSlg_TechnologyUpdate",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_TECHNOLOGYUPDATE_POINT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_TECHNOLOGYACTIVATEONEKEY_ID_F, {
	"id",
	".cs.C2S_NewSlg_TechnologyActivateOneKey.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWSLG_TECHNOLOGYACTIVATEONEKEY_LOCATION_F, {
	"location",
	".cs.C2S_NewSlg_TechnologyActivateOneKey.location",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_TECHNOLOGYACTIVATEONEKEY_ME, {
	"C2S_NewSlg_TechnologyActivateOneKey",
	".cs.C2S_NewSlg_TechnologyActivateOneKey",
	{},
	{},
	{
		var_0_10.C2S_NEWSLG_TECHNOLOGYACTIVATEONEKEY_ID_F,
		var_0_10.C2S_NEWSLG_TECHNOLOGYACTIVATEONEKEY_LOCATION_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_TECHNOLOGYACTIVATEONEKEY_RET_F, {
	"ret",
	".cs.S2C_NewSlg_TechnologyActivateOneKey.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_TECHNOLOGYACTIVATEONEKEY_ID_F, {
	"id",
	".cs.S2C_NewSlg_TechnologyActivateOneKey.id",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_TECHNOLOGYACTIVATEONEKEY_LOCATION_F, {
	"location",
	".cs.S2C_NewSlg_TechnologyActivateOneKey.location",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_TECHNOLOGYACTIVATEONEKEY_ACTIVATE_IDS_F, {
	"activate_ids",
	".cs.S2C_NewSlg_TechnologyActivateOneKey.activate_ids",
	4,
	3,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_TECHNOLOGYACTIVATEONEKEY_ME, {
	"S2C_NewSlg_TechnologyActivateOneKey",
	".cs.S2C_NewSlg_TechnologyActivateOneKey",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_TECHNOLOGYACTIVATEONEKEY_RET_F,
		var_0_10.S2C_NEWSLG_TECHNOLOGYACTIVATEONEKEY_ID_F,
		var_0_10.S2C_NEWSLG_TECHNOLOGYACTIVATEONEKEY_LOCATION_F,
		var_0_10.S2C_NEWSLG_TECHNOLOGYACTIVATEONEKEY_ACTIVATE_IDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWSLG_TECHNOLOGYRESET_ME, {
	"C2S_NewSlg_TechnologyReset",
	".cs.C2S_NewSlg_TechnologyReset",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWSLG_TECHNOLOGYRESET_RET_F, {
	"ret",
	".cs.S2C_NewSlg_TechnologyReset.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWSLG_TECHNOLOGYRESET_ME, {
	"S2C_NewSlg_TechnologyReset",
	".cs.S2C_NewSlg_TechnologyReset",
	{},
	{},
	{
		var_0_10.S2C_NEWSLG_TECHNOLOGYRESET_RET_F
	},
	false,
	{}
})

return var_0_10
