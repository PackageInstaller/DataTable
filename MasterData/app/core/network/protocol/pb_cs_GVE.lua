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
	C2S_GVE_TASKGETINFO_ME = protobuf.Descriptor(),
	S2C_GVE_TASKGETINFO_ME = protobuf.Descriptor(),
	S2C_GVE_TASKGETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_TASKGETINFO_TASK_DATA_F = protobuf.FieldDescriptor(),
	S2C_GVE_TASKGETINFO_AWARD_CHAPTERS_F = protobuf.FieldDescriptor(),
	S2C_GVE_TASKGETINFO_MAX_CHAPTER_ID_F = protobuf.FieldDescriptor(),
	C2S_GVE_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_GVE_TASKAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_GVE_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_TASKAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GVE_TASKAWARD_MAX_CHAPTER_ID_F = protobuf.FieldDescriptor(),
	C2S_GVE_CHAPTERAWARD_ME = protobuf.Descriptor(),
	C2S_GVE_CHAPTERAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_CHAPTERAWARD_ME = protobuf.Descriptor(),
	S2C_GVE_CHAPTERAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_CHAPTERAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_CHAPTERAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_GVE_GETINFO_ME = protobuf.Descriptor(),
	S2C_GVE_GETINFO_ME = protobuf.Descriptor(),
	S2C_GVE_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETINFO_ACTIVITY_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETINFO_DAY_AWARD_TIME_F = protobuf.FieldDescriptor(),
	S2C_GVE_NOTICEACTIVITY_ME = protobuf.Descriptor(),
	S2C_GVE_NOTICEACTIVITY_ACTIVITY_F = protobuf.FieldDescriptor(),
	C2S_GVE_TEAMINFO_ME = protobuf.Descriptor(),
	S2C_GVE_TEAMINFO_ME = protobuf.Descriptor(),
	S2C_GVE_TEAMINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_TEAMINFO_TEAM_F = protobuf.FieldDescriptor(),
	C2S_GVE_USERLIST_ME = protobuf.Descriptor(),
	S2C_GVE_USERLIST_ME = protobuf.Descriptor(),
	S2C_GVE_USERLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_USERLIST_LIST_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDENTER_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDENTER_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDENTER_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDENTER_CELLS_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDENTER_X_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDENTER_Y_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDENTER_IS_FIRST_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDMOVE_ME = protobuf.Descriptor(),
	C2S_GVE_WORLDMOVE_X_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDMOVE_Y_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDMOVE_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDMOVE_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDMOVE_NEAR_DATA_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDKEEPALIVE_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDKEEPALIVE_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDKEEPALIVE_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDDATANOTIFY_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDDATANOTIFY_CELLS_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDDATANOTIFY_NEAR_DATA_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDCELLDETAIL_ME = protobuf.Descriptor(),
	C2S_GVE_WORLDCELLDETAIL_X_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDCELLDETAIL_Y_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCELLDETAIL_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDCELLDETAIL_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCELLDETAIL_X_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCELLDETAIL_Y_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCELLDETAIL_HP_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCELLDETAIL_WAVE_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCELLDETAIL_LOCK_TS_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCELLDETAIL_RECOVER_TS_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCELLDETAIL_OWN_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCELLDETAIL_LOCK_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCELLDETAIL_SNAPSHOT_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDCHALLENGEBEGIN_ME = protobuf.Descriptor(),
	C2S_GVE_WORLDCHALLENGEBEGIN_X_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDCHALLENGEBEGIN_Y_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDCHALLENGEBEGIN_PATH_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDCHALLENGEBEGIN_SEQ_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDCHALLENGEBEGIN_WAVE_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCHALLENGEBEGIN_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDCHALLENGEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCHALLENGEBEGIN_X_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCHALLENGEBEGIN_Y_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCHALLENGEBEGIN_SEQ_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCHALLENGEBEGIN_WAVE_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCHALLENGEBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCHALLENGEBEGIN_STAR_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCHALLENGEBEGIN_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCHALLENGEBEGIN_MONSTER_HP_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCHALLENGEBEGIN_ATK_TIMESTAMP_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCHALLENGEBEGIN_KNIGHT_ACTION_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCHALLENGEBEGIN_RECOVER_ACTION_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDSELECTKNIGHT_ME = protobuf.Descriptor(),
	C2S_GVE_WORLDSELECTKNIGHT_DATAS_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDSELECTKNIGHT_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDSELECTKNIGHT_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDSELECTKNIGHT_DATAS_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDGIVEUPCELL_ME = protobuf.Descriptor(),
	C2S_GVE_WORLDGIVEUPCELL_X_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDGIVEUPCELL_Y_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDGIVEUPCELL_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDGIVEUPCELL_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDGIVEUPCELL_X_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDGIVEUPCELL_Y_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDGIVEUPCELL_GIVEUP_TS_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDCANCALGIVEUPCELL_ME = protobuf.Descriptor(),
	C2S_GVE_WORLDCANCALGIVEUPCELL_X_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDCANCALGIVEUPCELL_Y_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCANCALGIVEUPCELL_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDCANCALGIVEUPCELL_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCANCALGIVEUPCELL_X_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDCANCALGIVEUPCELL_Y_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDTIMEAWARD_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDTIMEAWARD_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDTIMEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDTIMEAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDSETCELLKNIGHT_ME = protobuf.Descriptor(),
	C2S_GVE_WORLDSETCELLKNIGHT_X_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDSETCELLKNIGHT_Y_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDSETCELLKNIGHT_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDSETCELLKNIGHT_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDSETCELLKNIGHT_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDSETCELLKNIGHT_X_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDSETCELLKNIGHT_Y_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDSETCELLKNIGHT_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	C2S_GVE_WORLDUSERDATAFLUSH_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDUSERDATAFLUSH_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDUSERDATAFLUSH_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDUSERDATAFLUSH_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDUSERDATAFLUSH_CELLS_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDUSERDATAFLUSH_CHALLENGE_WIN_COUNT_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDUSERDATAFLUSH_RECOVER_TS_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDACTIONNOTIFY_ME = protobuf.Descriptor(),
	S2C_GVE_WORLDACTIONNOTIFY_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_GVE_WORLDACTIONNOTIFY_RECOVER_TS_F = protobuf.FieldDescriptor(),
	C2S_GVE_BOSSGETINFO_ME = protobuf.Descriptor(),
	C2S_GVE_BOSSGETINFO_BOSS_ID_F = protobuf.FieldDescriptor(),
	C2S_GVE_BOSSGETINFO_X_F = protobuf.FieldDescriptor(),
	C2S_GVE_BOSSGETINFO_Y_F = protobuf.FieldDescriptor(),
	S2C_GVE_BOSSGETINFO_ME = protobuf.Descriptor(),
	S2C_GVE_BOSSGETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_BOSSGETINFO_BOSS_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_BOSSGETINFO_X_F = protobuf.FieldDescriptor(),
	S2C_GVE_BOSSGETINFO_Y_F = protobuf.FieldDescriptor(),
	S2C_GVE_BOSSGETINFO_BOSS_INFO_F = protobuf.FieldDescriptor(),
	S2C_GVE_BOSSGETINFO_BOSS9_CHALLENGE_COUNT_F = protobuf.FieldDescriptor(),
	S2C_GVE_BOSSGETINFO_BOSS9_DAMAGE_MAX_F = protobuf.FieldDescriptor(),
	C2S_GVE_GETALLBOSSISDEAD_ME = protobuf.Descriptor(),
	S2C_GVE_GETALLBOSSISDEAD_ME = protobuf.Descriptor(),
	S2C_GVE_GETALLBOSSISDEAD_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETALLBOSSISDEAD_BOSS_F = protobuf.FieldDescriptor(),
	C2S_GVE_CHALLENGEBOSSBEGIN_ME = protobuf.Descriptor(),
	C2S_GVE_CHALLENGEBOSSBEGIN_BOSS_ID_F = protobuf.FieldDescriptor(),
	C2S_GVE_CHALLENGEBOSSBEGIN_GUARD_ID_F = protobuf.FieldDescriptor(),
	C2S_GVE_CHALLENGEBOSSBEGIN_SEQ_F = protobuf.FieldDescriptor(),
	C2S_GVE_CHALLENGEBOSSBEGIN_CHALLENGE_TYPE_F = protobuf.FieldDescriptor(),
	C2S_GVE_CHALLENGEBOSSBEGIN_PATH_F = protobuf.FieldDescriptor(),
	S2C_GVE_CHALLENGEBOSSBEGIN_ME = protobuf.Descriptor(),
	S2C_GVE_CHALLENGEBOSSBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_CHALLENGEBOSSBEGIN_BOSS_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_CHALLENGEBOSSBEGIN_GUARD_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_CHALLENGEBOSSBEGIN_SEQ_F = protobuf.FieldDescriptor(),
	S2C_GVE_CHALLENGEBOSSBEGIN_CHALLENGE_TYPE_F = protobuf.FieldDescriptor(),
	S2C_GVE_CHALLENGEBOSSBEGIN_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_GVE_CHALLENGEBOSSBEGIN_DAMAGE_F = protobuf.FieldDescriptor(),
	S2C_GVE_CHALLENGEBOSSBEGIN_BOSS_INFO_F = protobuf.FieldDescriptor(),
	S2C_GVE_CHALLENGEBOSSBEGIN_KNIGHT_ACTION_F = protobuf.FieldDescriptor(),
	S2C_GVE_CHALLENGEBOSSBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_CHALLENGEBOSSBEGIN_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GVE_CHALLENGEBOSSBEGIN_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_GVE_CHALLENGEBOSSBEGIN_BOSS9_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_GVE_GETBOSSRANK_ME = protobuf.Descriptor(),
	C2S_GVE_GETBOSSRANK_RANK_TYPE_F = protobuf.FieldDescriptor(),
	C2S_GVE_GETBOSSRANK_BOSS_ID_F = protobuf.FieldDescriptor(),
	C2S_GVE_GETBOSSRANK_PAGE_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETBOSSRANK_ME = protobuf.Descriptor(),
	S2C_GVE_GETBOSSRANK_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETBOSSRANK_RANK_TYPE_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETBOSSRANK_BOSS_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETBOSSRANK_PAGE_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETBOSSRANK_TOTAL_PAGE_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETBOSSRANK_SELF_DATA_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETBOSSRANK_DATA_F = protobuf.FieldDescriptor(),
	S2C_GVE_BOSSNOTIFYDEAD_ME = protobuf.Descriptor(),
	S2C_GVE_BOSSNOTIFYDEAD_BOSS_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_BOSSNOTIFYDEAD_GUARD_ID_F = protobuf.FieldDescriptor(),
	C2S_GVE_GETRESEARCHINFO_ME = protobuf.Descriptor(),
	S2C_GVE_GETRESEARCHINFO_ME = protobuf.Descriptor(),
	S2C_GVE_GETRESEARCHINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETRESEARCHINFO_MISSION_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETRESEARCHINFO_MISSION_START_TIME_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETRESEARCHINFO_MISSION_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETRESEARCHINFO_MISSION_GAIN_RESEARCH_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETRESEARCHINFO_MISSION_RESEARCH_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETRESEARCHINFO_BOSS_RESEARCH_F = protobuf.FieldDescriptor(),
	C2S_GVE_RESEARCHMISSION_ME = protobuf.Descriptor(),
	C2S_GVE_RESEARCHMISSION_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_RESEARCHMISSION_ME = protobuf.Descriptor(),
	S2C_GVE_RESEARCHMISSION_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_RESEARCHMISSION_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_RESEARCHMISSION_START_TIME_F = protobuf.FieldDescriptor(),
	C2S_GVE_RESEARCHAWARD_ME = protobuf.Descriptor(),
	S2C_GVE_RESEARCHAWARD_ME = protobuf.Descriptor(),
	S2C_GVE_RESEARCHAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_RESEARCHAWARD_START_TIME_F = protobuf.FieldDescriptor(),
	S2C_GVE_RESEARCHAWARD_GAIN_RESEARCH_F = protobuf.FieldDescriptor(),
	S2C_GVE_RESEARCHAWARD_TEAM_RESEARCH_F = protobuf.FieldDescriptor(),
	C2S_GVE_RESEARCHRANKLIST_ME = protobuf.Descriptor(),
	S2C_GVE_RESEARCHRANKLIST_ME = protobuf.Descriptor(),
	S2C_GVE_RESEARCHRANKLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_RESEARCHRANKLIST_LIST_F = protobuf.FieldDescriptor(),
	C2S_GVE_HALIDOM_GETINFO_ME = protobuf.Descriptor(),
	S2C_GVE_HALIDOM_GETINFO_ME = protobuf.Descriptor(),
	S2C_GVE_HALIDOM_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_GETINFO_HALIDOM_INFO_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_GETINFO_HALIDOM_FIGHT_VALUE_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_GETINFO_JOB_SWITCH_END_TIMESTAMP_F = protobuf.FieldDescriptor(),
	C2S_GVE_HALIDOM_MERGE_ME = protobuf.Descriptor(),
	C2S_GVE_HALIDOM_MERGE_MERGE_CONFIG_ID_F = protobuf.FieldDescriptor(),
	C2S_GVE_HALIDOM_MERGE_IS_EQUIP_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_MERGE_ME = protobuf.Descriptor(),
	S2C_GVE_HALIDOM_MERGE_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_MERGE_MERGE_CONFIG_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_MERGE_BAG_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_MERGE_NEW_RESOURCE_NUM_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_MERGE_IS_EQUIP_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_MERGE_HALIDOM_FIGHT_VALUE_F = protobuf.FieldDescriptor(),
	C2S_GVE_HALIDOM_FASTDECOMPOSITION_ME = protobuf.Descriptor(),
	S2C_GVE_HALIDOM_FASTDECOMPOSITION_ME = protobuf.Descriptor(),
	S2C_GVE_HALIDOM_FASTDECOMPOSITION_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_FASTDECOMPOSITION_NEW_RESOURCE_NUM_F = protobuf.FieldDescriptor(),
	C2S_GVE_HALIDOM_LEVELUP_ME = protobuf.Descriptor(),
	C2S_GVE_HALIDOM_LEVELUP_MERGE_CONFIG_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_LEVELUP_ME = protobuf.Descriptor(),
	S2C_GVE_HALIDOM_LEVELUP_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_LEVELUP_NEW_CONFIG_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_LEVELUP_HALIDOM_FIGHT_VALUE_F = protobuf.FieldDescriptor(),
	C2S_GVE_HALIDOM_SWITCHJOB_ME = protobuf.Descriptor(),
	C2S_GVE_HALIDOM_SWITCHJOB_SWITCH_CONFIG_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_SWITCHJOB_ME = protobuf.Descriptor(),
	S2C_GVE_HALIDOM_SWITCHJOB_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_SWITCHJOB_EQUIP_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_SWITCHJOB_JOB_SWITCH_END_TIMESTAMP_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_SWITCHJOB_HALIDOM_FIGHT_VALUE_F = protobuf.FieldDescriptor(),
	C2S_GVE_HALIDOM_DECOMPOSITION_ME = protobuf.Descriptor(),
	C2S_GVE_HALIDOM_DECOMPOSITION_DECOMPOSITION_CONFIG_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_DECOMPOSITION_ME = protobuf.Descriptor(),
	S2C_GVE_HALIDOM_DECOMPOSITION_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_DECOMPOSITION_NEW_RESOURCE_NUM_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_DECOMPOSITION_DECOMPOSITION_CONFIG_ID_F = protobuf.FieldDescriptor(),
	C2S_GVE_HALIDOM_EQUIP_ME = protobuf.Descriptor(),
	C2S_GVE_HALIDOM_EQUIP_CONFIG_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_EQUIP_ME = protobuf.Descriptor(),
	S2C_GVE_HALIDOM_EQUIP_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_EQUIP_CONFIG_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_EQUIP_HALIDOM_FIGHT_VALUE_F = protobuf.FieldDescriptor(),
	C2S_GVE_HALIDOM_USERLIST_ME = protobuf.Descriptor(),
	S2C_GVE_HALIDOM_USERLIST_ME = protobuf.Descriptor(),
	S2C_GVE_HALIDOM_USERLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_HALIDOM_USERLIST_USER_NUM_F = protobuf.FieldDescriptor(),
	S2C_GVE_SYNCRANDOMBOSSINFO_ME = protobuf.Descriptor(),
	S2C_GVE_SYNCRANDOMBOSSINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_SYNCRANDOMBOSSINFO_BOSS_INFO_F = protobuf.FieldDescriptor(),
	C2S_GVE_GETBOSSFIRSTKILL_ME = protobuf.Descriptor(),
	S2C_GVE_GETBOSSFIRSTKILL_ME = protobuf.Descriptor(),
	S2C_GVE_GETBOSSFIRSTKILL_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETBOSSFIRSTKILL_FIRST_KILL_DATAS_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETBOSSFIRSTKILL_AWARD_ID_F = protobuf.FieldDescriptor(),
	C2S_GVE_GETALLRANDOMBOSSINFO_ME = protobuf.Descriptor(),
	S2C_GVE_GETALLRANDOMBOSSINFO_ME = protobuf.Descriptor(),
	S2C_GVE_GETALLRANDOMBOSSINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETALLRANDOMBOSSINFO_BOSS_INFO_F = protobuf.FieldDescriptor(),
	C2S_GVE_GETBOSSAWARD_ME = protobuf.Descriptor(),
	C2S_GVE_GETBOSSAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETBOSSAWARD_ME = protobuf.Descriptor(),
	S2C_GVE_GETBOSSAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETBOSSAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_GVE_GETBOSSAWARD_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_TASKGETINFO_ME, {
	"C2S_GVE_TaskGetInfo",
	".cs.C2S_GVE_TaskGetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_TASKGETINFO_RET_F, {
	"ret",
	".cs.S2C_GVE_TaskGetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_TASKGETINFO_TASK_DATA_F, {
	"task_data",
	".cs.S2C_GVE_TaskGetInfo.task_data",
	2,
	1,
	3,
	false,
	{},
	var_0_3.GVETASKDATA_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_TASKGETINFO_AWARD_CHAPTERS_F, {
	"award_chapters",
	".cs.S2C_GVE_TaskGetInfo.award_chapters",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_TASKGETINFO_MAX_CHAPTER_ID_F, {
	"max_chapter_id",
	".cs.S2C_GVE_TaskGetInfo.max_chapter_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_TASKGETINFO_ME, {
	"S2C_GVE_TaskGetInfo",
	".cs.S2C_GVE_TaskGetInfo",
	{},
	{},
	{
		var_0_10.S2C_GVE_TASKGETINFO_RET_F,
		var_0_10.S2C_GVE_TASKGETINFO_TASK_DATA_F,
		var_0_10.S2C_GVE_TASKGETINFO_AWARD_CHAPTERS_F,
		var_0_10.S2C_GVE_TASKGETINFO_MAX_CHAPTER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_TASKAWARD_ID_F, {
	"id",
	".cs.C2S_GVE_TaskAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_TASKAWARD_ME, {
	"C2S_GVE_TaskAward",
	".cs.C2S_GVE_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_GVE_TASKAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_GVE_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_TASKAWARD_ID_F, {
	"id",
	".cs.S2C_GVE_TaskAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_GVE_TaskAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_TASKAWARD_MAX_CHAPTER_ID_F, {
	"max_chapter_id",
	".cs.S2C_GVE_TaskAward.max_chapter_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_TASKAWARD_ME, {
	"S2C_GVE_TaskAward",
	".cs.S2C_GVE_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_GVE_TASKAWARD_RET_F,
		var_0_10.S2C_GVE_TASKAWARD_ID_F,
		var_0_10.S2C_GVE_TASKAWARD_AWARDS_F,
		var_0_10.S2C_GVE_TASKAWARD_MAX_CHAPTER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_CHAPTERAWARD_ID_F, {
	"id",
	".cs.C2S_GVE_ChapterAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_CHAPTERAWARD_ME, {
	"C2S_GVE_ChapterAward",
	".cs.C2S_GVE_ChapterAward",
	{},
	{},
	{
		var_0_10.C2S_GVE_CHAPTERAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_CHAPTERAWARD_RET_F, {
	"ret",
	".cs.S2C_GVE_ChapterAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_CHAPTERAWARD_ID_F, {
	"id",
	".cs.S2C_GVE_ChapterAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_CHAPTERAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_GVE_ChapterAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_CHAPTERAWARD_ME, {
	"S2C_GVE_ChapterAward",
	".cs.S2C_GVE_ChapterAward",
	{},
	{},
	{
		var_0_10.S2C_GVE_CHAPTERAWARD_RET_F,
		var_0_10.S2C_GVE_CHAPTERAWARD_ID_F,
		var_0_10.S2C_GVE_CHAPTERAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_GETINFO_ME, {
	"C2S_GVE_GetInfo",
	".cs.C2S_GVE_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETINFO_RET_F, {
	"ret",
	".cs.S2C_GVE_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETINFO_ACTIVITY_F, {
	"activity",
	".cs.S2C_GVE_GetInfo.activity",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.GVEACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETINFO_DAY_AWARD_TIME_F, {
	"day_award_time",
	".cs.S2C_GVE_GetInfo.day_award_time",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_GETINFO_ME, {
	"S2C_GVE_GetInfo",
	".cs.S2C_GVE_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_GVE_GETINFO_RET_F,
		var_0_10.S2C_GVE_GETINFO_ACTIVITY_F,
		var_0_10.S2C_GVE_GETINFO_DAY_AWARD_TIME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_NOTICEACTIVITY_ACTIVITY_F, {
	"activity",
	".cs.S2C_GVE_NoticeActivity.activity",
	1,
	0,
	2,
	false,
	nil,
	var_0_3.GVEACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_NOTICEACTIVITY_ME, {
	"S2C_GVE_NoticeActivity",
	".cs.S2C_GVE_NoticeActivity",
	{},
	{},
	{
		var_0_10.S2C_GVE_NOTICEACTIVITY_ACTIVITY_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_TEAMINFO_ME, {
	"C2S_GVE_TeamInfo",
	".cs.C2S_GVE_TeamInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_TEAMINFO_RET_F, {
	"ret",
	".cs.S2C_GVE_TeamInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_TEAMINFO_TEAM_F, {
	"team",
	".cs.S2C_GVE_TeamInfo.team",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.GVETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_TEAMINFO_ME, {
	"S2C_GVE_TeamInfo",
	".cs.S2C_GVE_TeamInfo",
	{},
	{},
	{
		var_0_10.S2C_GVE_TEAMINFO_RET_F,
		var_0_10.S2C_GVE_TEAMINFO_TEAM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_USERLIST_ME, {
	"C2S_GVE_UserList",
	".cs.C2S_GVE_UserList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_USERLIST_RET_F, {
	"ret",
	".cs.S2C_GVE_UserList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_USERLIST_LIST_F, {
	"list",
	".cs.S2C_GVE_UserList.list",
	2,
	1,
	3,
	false,
	{},
	var_0_3.GVETEAMUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_USERLIST_ME, {
	"S2C_GVE_UserList",
	".cs.S2C_GVE_UserList",
	{},
	{},
	{
		var_0_10.S2C_GVE_USERLIST_RET_F,
		var_0_10.S2C_GVE_USERLIST_LIST_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_WORLDENTER_ME, {
	"C2S_GVE_WorldEnter",
	".cs.C2S_GVE_WorldEnter",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDENTER_RET_F, {
	"ret",
	".cs.S2C_GVE_WorldEnter.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDENTER_CELLS_F, {
	"cells",
	".cs.S2C_GVE_WorldEnter.cells",
	2,
	1,
	3,
	false,
	{},
	var_0_3.WORLDCELL_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDENTER_X_F, {
	"x",
	".cs.S2C_GVE_WorldEnter.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDENTER_Y_F, {
	"y",
	".cs.S2C_GVE_WorldEnter.y",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDENTER_IS_FIRST_F, {
	"is_first",
	".cs.S2C_GVE_WorldEnter.is_first",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_WORLDENTER_ME, {
	"S2C_GVE_WorldEnter",
	".cs.S2C_GVE_WorldEnter",
	{},
	{},
	{
		var_0_10.S2C_GVE_WORLDENTER_RET_F,
		var_0_10.S2C_GVE_WORLDENTER_CELLS_F,
		var_0_10.S2C_GVE_WORLDENTER_X_F,
		var_0_10.S2C_GVE_WORLDENTER_Y_F,
		var_0_10.S2C_GVE_WORLDENTER_IS_FIRST_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDMOVE_X_F, {
	"x",
	".cs.C2S_GVE_WorldMove.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDMOVE_Y_F, {
	"y",
	".cs.C2S_GVE_WorldMove.y",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_WORLDMOVE_ME, {
	"C2S_GVE_WorldMove",
	".cs.C2S_GVE_WorldMove",
	{},
	{},
	{
		var_0_10.C2S_GVE_WORLDMOVE_X_F,
		var_0_10.C2S_GVE_WORLDMOVE_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDMOVE_RET_F, {
	"ret",
	".cs.S2C_GVE_WorldMove.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDMOVE_NEAR_DATA_F, {
	"near_data",
	".cs.S2C_GVE_WorldMove.near_data",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.WORLDNEARDATA_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_WORLDMOVE_ME, {
	"S2C_GVE_WorldMove",
	".cs.S2C_GVE_WorldMove",
	{},
	{},
	{
		var_0_10.S2C_GVE_WORLDMOVE_RET_F,
		var_0_10.S2C_GVE_WORLDMOVE_NEAR_DATA_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_WORLDKEEPALIVE_ME, {
	"C2S_GVE_WorldKeepAlive",
	".cs.C2S_GVE_WorldKeepAlive",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDKEEPALIVE_RET_F, {
	"ret",
	".cs.S2C_GVE_WorldKeepAlive.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_WORLDKEEPALIVE_ME, {
	"S2C_GVE_WorldKeepAlive",
	".cs.S2C_GVE_WorldKeepAlive",
	{},
	{},
	{
		var_0_10.S2C_GVE_WORLDKEEPALIVE_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDDATANOTIFY_CELLS_F, {
	"cells",
	".cs.S2C_GVE_WorldDataNotify.cells",
	1,
	0,
	3,
	false,
	{},
	var_0_3.WORLDCELL_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDDATANOTIFY_NEAR_DATA_F, {
	"near_data",
	".cs.S2C_GVE_WorldDataNotify.near_data",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.WORLDNEARDATA_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_WORLDDATANOTIFY_ME, {
	"S2C_GVE_WorldDataNotify",
	".cs.S2C_GVE_WorldDataNotify",
	{},
	{},
	{
		var_0_10.S2C_GVE_WORLDDATANOTIFY_CELLS_F,
		var_0_10.S2C_GVE_WORLDDATANOTIFY_NEAR_DATA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDCELLDETAIL_X_F, {
	"x",
	".cs.C2S_GVE_WorldCellDetail.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDCELLDETAIL_Y_F, {
	"y",
	".cs.C2S_GVE_WorldCellDetail.y",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_WORLDCELLDETAIL_ME, {
	"C2S_GVE_WorldCellDetail",
	".cs.C2S_GVE_WorldCellDetail",
	{},
	{},
	{
		var_0_10.C2S_GVE_WORLDCELLDETAIL_X_F,
		var_0_10.C2S_GVE_WORLDCELLDETAIL_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCELLDETAIL_RET_F, {
	"ret",
	".cs.S2C_GVE_WorldCellDetail.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCELLDETAIL_X_F, {
	"x",
	".cs.S2C_GVE_WorldCellDetail.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCELLDETAIL_Y_F, {
	"y",
	".cs.S2C_GVE_WorldCellDetail.y",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCELLDETAIL_HP_F, {
	"hp",
	".cs.S2C_GVE_WorldCellDetail.hp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCELLDETAIL_WAVE_F, {
	"wave",
	".cs.S2C_GVE_WorldCellDetail.wave",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCELLDETAIL_LOCK_TS_F, {
	"lock_ts",
	".cs.S2C_GVE_WorldCellDetail.lock_ts",
	6,
	5,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCELLDETAIL_RECOVER_TS_F, {
	"recover_ts",
	".cs.S2C_GVE_WorldCellDetail.recover_ts",
	7,
	6,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCELLDETAIL_OWN_USER_ID_F, {
	"own_user_id",
	".cs.S2C_GVE_WorldCellDetail.own_user_id",
	8,
	7,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCELLDETAIL_LOCK_KNIGHTS_F, {
	"lock_knights",
	".cs.S2C_GVE_WorldCellDetail.lock_knights",
	9,
	8,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCELLDETAIL_SNAPSHOT_F, {
	"snapshot",
	".cs.S2C_GVE_WorldCellDetail.snapshot",
	10,
	9,
	1,
	false,
	nil,
	var_0_3.SIMPLEUSERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_WORLDCELLDETAIL_ME, {
	"S2C_GVE_WorldCellDetail",
	".cs.S2C_GVE_WorldCellDetail",
	{},
	{},
	{
		var_0_10.S2C_GVE_WORLDCELLDETAIL_RET_F,
		var_0_10.S2C_GVE_WORLDCELLDETAIL_X_F,
		var_0_10.S2C_GVE_WORLDCELLDETAIL_Y_F,
		var_0_10.S2C_GVE_WORLDCELLDETAIL_HP_F,
		var_0_10.S2C_GVE_WORLDCELLDETAIL_WAVE_F,
		var_0_10.S2C_GVE_WORLDCELLDETAIL_LOCK_TS_F,
		var_0_10.S2C_GVE_WORLDCELLDETAIL_RECOVER_TS_F,
		var_0_10.S2C_GVE_WORLDCELLDETAIL_OWN_USER_ID_F,
		var_0_10.S2C_GVE_WORLDCELLDETAIL_LOCK_KNIGHTS_F,
		var_0_10.S2C_GVE_WORLDCELLDETAIL_SNAPSHOT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDCHALLENGEBEGIN_X_F, {
	"x",
	".cs.C2S_GVE_WorldChallengeBegin.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDCHALLENGEBEGIN_Y_F, {
	"y",
	".cs.C2S_GVE_WorldChallengeBegin.y",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDCHALLENGEBEGIN_PATH_F, {
	"path",
	".cs.C2S_GVE_WorldChallengeBegin.path",
	3,
	2,
	3,
	false,
	{},
	var_0_3.POINT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDCHALLENGEBEGIN_SEQ_F, {
	"seq",
	".cs.C2S_GVE_WorldChallengeBegin.seq",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDCHALLENGEBEGIN_WAVE_F, {
	"wave",
	".cs.C2S_GVE_WorldChallengeBegin.wave",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_WORLDCHALLENGEBEGIN_ME, {
	"C2S_GVE_WorldChallengeBegin",
	".cs.C2S_GVE_WorldChallengeBegin",
	{},
	{},
	{
		var_0_10.C2S_GVE_WORLDCHALLENGEBEGIN_X_F,
		var_0_10.C2S_GVE_WORLDCHALLENGEBEGIN_Y_F,
		var_0_10.C2S_GVE_WORLDCHALLENGEBEGIN_PATH_F,
		var_0_10.C2S_GVE_WORLDCHALLENGEBEGIN_SEQ_F,
		var_0_10.C2S_GVE_WORLDCHALLENGEBEGIN_WAVE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_RET_F, {
	"ret",
	".cs.S2C_GVE_WorldChallengeBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_X_F, {
	"x",
	".cs.S2C_GVE_WorldChallengeBegin.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_Y_F, {
	"y",
	".cs.S2C_GVE_WorldChallengeBegin.y",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_SEQ_F, {
	"seq",
	".cs.S2C_GVE_WorldChallengeBegin.seq",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_WAVE_F, {
	"wave",
	".cs.S2C_GVE_WorldChallengeBegin.wave",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_GVE_WorldChallengeBegin.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_STAR_F, {
	"star",
	".cs.S2C_GVE_WorldChallengeBegin.star",
	7,
	6,
	3,
	false,
	{},
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_IS_WIN_F, {
	"is_win",
	".cs.S2C_GVE_WorldChallengeBegin.is_win",
	8,
	7,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_MONSTER_HP_F, {
	"monster_hp",
	".cs.S2C_GVE_WorldChallengeBegin.monster_hp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_ATK_TIMESTAMP_F, {
	"atk_timestamp",
	".cs.S2C_GVE_WorldChallengeBegin.atk_timestamp",
	10,
	9,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_KNIGHT_ACTION_F, {
	"knight_action",
	".cs.S2C_GVE_WorldChallengeBegin.knight_action",
	11,
	10,
	3,
	false,
	{},
	var_0_3.GVEKNIGHTPOS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_RECOVER_ACTION_F, {
	"recover_action",
	".cs.S2C_GVE_WorldChallengeBegin.recover_action",
	12,
	11,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_ME, {
	"S2C_GVE_WorldChallengeBegin",
	".cs.S2C_GVE_WorldChallengeBegin",
	{},
	{},
	{
		var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_RET_F,
		var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_X_F,
		var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_Y_F,
		var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_SEQ_F,
		var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_WAVE_F,
		var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_BATTLE_ID_F,
		var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_STAR_F,
		var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_IS_WIN_F,
		var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_MONSTER_HP_F,
		var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_ATK_TIMESTAMP_F,
		var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_KNIGHT_ACTION_F,
		var_0_10.S2C_GVE_WORLDCHALLENGEBEGIN_RECOVER_ACTION_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDSELECTKNIGHT_DATAS_F, {
	"datas",
	".cs.C2S_GVE_WorldSelectKnight.datas",
	1,
	0,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_WORLDSELECTKNIGHT_ME, {
	"C2S_GVE_WorldSelectKnight",
	".cs.C2S_GVE_WorldSelectKnight",
	{},
	{},
	{
		var_0_10.C2S_GVE_WORLDSELECTKNIGHT_DATAS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDSELECTKNIGHT_RET_F, {
	"ret",
	".cs.S2C_GVE_WorldSelectKnight.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDSELECTKNIGHT_DATAS_F, {
	"datas",
	".cs.S2C_GVE_WorldSelectKnight.datas",
	2,
	1,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_WORLDSELECTKNIGHT_ME, {
	"S2C_GVE_WorldSelectKnight",
	".cs.S2C_GVE_WorldSelectKnight",
	{},
	{},
	{
		var_0_10.S2C_GVE_WORLDSELECTKNIGHT_RET_F,
		var_0_10.S2C_GVE_WORLDSELECTKNIGHT_DATAS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDGIVEUPCELL_X_F, {
	"x",
	".cs.C2S_GVE_WorldGiveupCell.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDGIVEUPCELL_Y_F, {
	"y",
	".cs.C2S_GVE_WorldGiveupCell.y",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_WORLDGIVEUPCELL_ME, {
	"C2S_GVE_WorldGiveupCell",
	".cs.C2S_GVE_WorldGiveupCell",
	{},
	{},
	{
		var_0_10.C2S_GVE_WORLDGIVEUPCELL_X_F,
		var_0_10.C2S_GVE_WORLDGIVEUPCELL_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDGIVEUPCELL_RET_F, {
	"ret",
	".cs.S2C_GVE_WorldGiveupCell.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDGIVEUPCELL_X_F, {
	"x",
	".cs.S2C_GVE_WorldGiveupCell.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDGIVEUPCELL_Y_F, {
	"y",
	".cs.S2C_GVE_WorldGiveupCell.y",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDGIVEUPCELL_GIVEUP_TS_F, {
	"giveup_ts",
	".cs.S2C_GVE_WorldGiveupCell.giveup_ts",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_WORLDGIVEUPCELL_ME, {
	"S2C_GVE_WorldGiveupCell",
	".cs.S2C_GVE_WorldGiveupCell",
	{},
	{},
	{
		var_0_10.S2C_GVE_WORLDGIVEUPCELL_RET_F,
		var_0_10.S2C_GVE_WORLDGIVEUPCELL_X_F,
		var_0_10.S2C_GVE_WORLDGIVEUPCELL_Y_F,
		var_0_10.S2C_GVE_WORLDGIVEUPCELL_GIVEUP_TS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDCANCALGIVEUPCELL_X_F, {
	"x",
	".cs.C2S_GVE_WorldCancalGiveupCell.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDCANCALGIVEUPCELL_Y_F, {
	"y",
	".cs.C2S_GVE_WorldCancalGiveupCell.y",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_WORLDCANCALGIVEUPCELL_ME, {
	"C2S_GVE_WorldCancalGiveupCell",
	".cs.C2S_GVE_WorldCancalGiveupCell",
	{},
	{},
	{
		var_0_10.C2S_GVE_WORLDCANCALGIVEUPCELL_X_F,
		var_0_10.C2S_GVE_WORLDCANCALGIVEUPCELL_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCANCALGIVEUPCELL_RET_F, {
	"ret",
	".cs.S2C_GVE_WorldCancalGiveupCell.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCANCALGIVEUPCELL_X_F, {
	"x",
	".cs.S2C_GVE_WorldCancalGiveupCell.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDCANCALGIVEUPCELL_Y_F, {
	"y",
	".cs.S2C_GVE_WorldCancalGiveupCell.y",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_WORLDCANCALGIVEUPCELL_ME, {
	"S2C_GVE_WorldCancalGiveupCell",
	".cs.S2C_GVE_WorldCancalGiveupCell",
	{},
	{},
	{
		var_0_10.S2C_GVE_WORLDCANCALGIVEUPCELL_RET_F,
		var_0_10.S2C_GVE_WORLDCANCALGIVEUPCELL_X_F,
		var_0_10.S2C_GVE_WORLDCANCALGIVEUPCELL_Y_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_WORLDTIMEAWARD_ME, {
	"C2S_GVE_WorldTimeAward",
	".cs.C2S_GVE_WorldTimeAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDTIMEAWARD_RET_F, {
	"ret",
	".cs.S2C_GVE_WorldTimeAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDTIMEAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_GVE_WorldTimeAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_WORLDTIMEAWARD_ME, {
	"S2C_GVE_WorldTimeAward",
	".cs.S2C_GVE_WorldTimeAward",
	{},
	{},
	{
		var_0_10.S2C_GVE_WORLDTIMEAWARD_RET_F,
		var_0_10.S2C_GVE_WORLDTIMEAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDSETCELLKNIGHT_X_F, {
	"x",
	".cs.C2S_GVE_WorldSetCellKnight.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDSETCELLKNIGHT_Y_F, {
	"y",
	".cs.C2S_GVE_WorldSetCellKnight.y",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_WORLDSETCELLKNIGHT_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_GVE_WorldSetCellKnight.knight_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_WORLDSETCELLKNIGHT_ME, {
	"C2S_GVE_WorldSetCellKnight",
	".cs.C2S_GVE_WorldSetCellKnight",
	{},
	{},
	{
		var_0_10.C2S_GVE_WORLDSETCELLKNIGHT_X_F,
		var_0_10.C2S_GVE_WORLDSETCELLKNIGHT_Y_F,
		var_0_10.C2S_GVE_WORLDSETCELLKNIGHT_KNIGHT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDSETCELLKNIGHT_RET_F, {
	"ret",
	".cs.S2C_GVE_WorldSetCellKnight.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDSETCELLKNIGHT_X_F, {
	"x",
	".cs.S2C_GVE_WorldSetCellKnight.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDSETCELLKNIGHT_Y_F, {
	"y",
	".cs.S2C_GVE_WorldSetCellKnight.y",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDSETCELLKNIGHT_KNIGHT_ID_F, {
	"knight_id",
	".cs.S2C_GVE_WorldSetCellKnight.knight_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_WORLDSETCELLKNIGHT_ME, {
	"S2C_GVE_WorldSetCellKnight",
	".cs.S2C_GVE_WorldSetCellKnight",
	{},
	{},
	{
		var_0_10.S2C_GVE_WORLDSETCELLKNIGHT_RET_F,
		var_0_10.S2C_GVE_WORLDSETCELLKNIGHT_X_F,
		var_0_10.S2C_GVE_WORLDSETCELLKNIGHT_Y_F,
		var_0_10.S2C_GVE_WORLDSETCELLKNIGHT_KNIGHT_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_WORLDUSERDATAFLUSH_ME, {
	"C2S_GVE_WorldUserDataFlush",
	".cs.C2S_GVE_WorldUserDataFlush",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDUSERDATAFLUSH_RET_F, {
	"ret",
	".cs.S2C_GVE_WorldUserDataFlush.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDUSERDATAFLUSH_KNIGHTS_F, {
	"knights",
	".cs.S2C_GVE_WorldUserDataFlush.knights",
	2,
	1,
	3,
	false,
	{},
	var_0_3.GVEKNIGHTPOS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDUSERDATAFLUSH_CELLS_F, {
	"cells",
	".cs.S2C_GVE_WorldUserDataFlush.cells",
	3,
	2,
	3,
	false,
	{},
	var_0_3.GVESELFCELL_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDUSERDATAFLUSH_CHALLENGE_WIN_COUNT_F, {
	"challenge_win_count",
	".cs.S2C_GVE_WorldUserDataFlush.challenge_win_count",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDUSERDATAFLUSH_RECOVER_TS_F, {
	"recover_ts",
	".cs.S2C_GVE_WorldUserDataFlush.recover_ts",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_WORLDUSERDATAFLUSH_ME, {
	"S2C_GVE_WorldUserDataFlush",
	".cs.S2C_GVE_WorldUserDataFlush",
	{},
	{},
	{
		var_0_10.S2C_GVE_WORLDUSERDATAFLUSH_RET_F,
		var_0_10.S2C_GVE_WORLDUSERDATAFLUSH_KNIGHTS_F,
		var_0_10.S2C_GVE_WORLDUSERDATAFLUSH_CELLS_F,
		var_0_10.S2C_GVE_WORLDUSERDATAFLUSH_CHALLENGE_WIN_COUNT_F,
		var_0_10.S2C_GVE_WORLDUSERDATAFLUSH_RECOVER_TS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDACTIONNOTIFY_KNIGHTS_F, {
	"knights",
	".cs.S2C_GVE_WorldActionNotify.knights",
	1,
	0,
	3,
	false,
	{},
	var_0_3.GVEKNIGHTPOS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_WORLDACTIONNOTIFY_RECOVER_TS_F, {
	"recover_ts",
	".cs.S2C_GVE_WorldActionNotify.recover_ts",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_WORLDACTIONNOTIFY_ME, {
	"S2C_GVE_WorldActionNotify",
	".cs.S2C_GVE_WorldActionNotify",
	{},
	{},
	{
		var_0_10.S2C_GVE_WORLDACTIONNOTIFY_KNIGHTS_F,
		var_0_10.S2C_GVE_WORLDACTIONNOTIFY_RECOVER_TS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_BOSSGETINFO_BOSS_ID_F, {
	"boss_id",
	".cs.C2S_GVE_BossGetInfo.boss_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_BOSSGETINFO_X_F, {
	"x",
	".cs.C2S_GVE_BossGetInfo.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_BOSSGETINFO_Y_F, {
	"y",
	".cs.C2S_GVE_BossGetInfo.y",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_BOSSGETINFO_ME, {
	"C2S_GVE_BossGetInfo",
	".cs.C2S_GVE_BossGetInfo",
	{},
	{},
	{
		var_0_10.C2S_GVE_BOSSGETINFO_BOSS_ID_F,
		var_0_10.C2S_GVE_BOSSGETINFO_X_F,
		var_0_10.C2S_GVE_BOSSGETINFO_Y_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_BOSSGETINFO_RET_F, {
	"ret",
	".cs.S2C_GVE_BossGetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_BOSSGETINFO_BOSS_ID_F, {
	"boss_id",
	".cs.S2C_GVE_BossGetInfo.boss_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_BOSSGETINFO_X_F, {
	"x",
	".cs.S2C_GVE_BossGetInfo.x",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_BOSSGETINFO_Y_F, {
	"y",
	".cs.S2C_GVE_BossGetInfo.y",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_BOSSGETINFO_BOSS_INFO_F, {
	"boss_info",
	".cs.S2C_GVE_BossGetInfo.boss_info",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.GVEBOSS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_BOSSGETINFO_BOSS9_CHALLENGE_COUNT_F, {
	"boss9_challenge_count",
	".cs.S2C_GVE_BossGetInfo.boss9_challenge_count",
	6,
	5,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_BOSSGETINFO_BOSS9_DAMAGE_MAX_F, {
	"boss9_damage_max",
	".cs.S2C_GVE_BossGetInfo.boss9_damage_max",
	7,
	6,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_BOSSGETINFO_ME, {
	"S2C_GVE_BossGetInfo",
	".cs.S2C_GVE_BossGetInfo",
	{},
	{},
	{
		var_0_10.S2C_GVE_BOSSGETINFO_RET_F,
		var_0_10.S2C_GVE_BOSSGETINFO_BOSS_ID_F,
		var_0_10.S2C_GVE_BOSSGETINFO_X_F,
		var_0_10.S2C_GVE_BOSSGETINFO_Y_F,
		var_0_10.S2C_GVE_BOSSGETINFO_BOSS_INFO_F,
		var_0_10.S2C_GVE_BOSSGETINFO_BOSS9_CHALLENGE_COUNT_F,
		var_0_10.S2C_GVE_BOSSGETINFO_BOSS9_DAMAGE_MAX_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_GETALLBOSSISDEAD_ME, {
	"C2S_GVE_GetAllBossIsDead",
	".cs.C2S_GVE_GetAllBossIsDead",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETALLBOSSISDEAD_RET_F, {
	"ret",
	".cs.S2C_GVE_GetAllBossIsDead.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETALLBOSSISDEAD_BOSS_F, {
	"boss",
	".cs.S2C_GVE_GetAllBossIsDead.boss",
	2,
	1,
	3,
	false,
	{},
	var_0_3.GVEBOSSISDEAD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_GETALLBOSSISDEAD_ME, {
	"S2C_GVE_GetAllBossIsDead",
	".cs.S2C_GVE_GetAllBossIsDead",
	{},
	{},
	{
		var_0_10.S2C_GVE_GETALLBOSSISDEAD_RET_F,
		var_0_10.S2C_GVE_GETALLBOSSISDEAD_BOSS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_CHALLENGEBOSSBEGIN_BOSS_ID_F, {
	"boss_id",
	".cs.C2S_GVE_ChallengeBossBegin.boss_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_CHALLENGEBOSSBEGIN_GUARD_ID_F, {
	"guard_id",
	".cs.C2S_GVE_ChallengeBossBegin.guard_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_CHALLENGEBOSSBEGIN_SEQ_F, {
	"seq",
	".cs.C2S_GVE_ChallengeBossBegin.seq",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_CHALLENGEBOSSBEGIN_CHALLENGE_TYPE_F, {
	"challenge_type",
	".cs.C2S_GVE_ChallengeBossBegin.challenge_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_CHALLENGEBOSSBEGIN_PATH_F, {
	"path",
	".cs.C2S_GVE_ChallengeBossBegin.path",
	5,
	4,
	3,
	false,
	{},
	var_0_3.POINT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_CHALLENGEBOSSBEGIN_ME, {
	"C2S_GVE_ChallengeBossBegin",
	".cs.C2S_GVE_ChallengeBossBegin",
	{},
	{},
	{
		var_0_10.C2S_GVE_CHALLENGEBOSSBEGIN_BOSS_ID_F,
		var_0_10.C2S_GVE_CHALLENGEBOSSBEGIN_GUARD_ID_F,
		var_0_10.C2S_GVE_CHALLENGEBOSSBEGIN_SEQ_F,
		var_0_10.C2S_GVE_CHALLENGEBOSSBEGIN_CHALLENGE_TYPE_F,
		var_0_10.C2S_GVE_CHALLENGEBOSSBEGIN_PATH_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_RET_F, {
	"ret",
	".cs.S2C_GVE_ChallengeBossBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_BOSS_ID_F, {
	"boss_id",
	".cs.S2C_GVE_ChallengeBossBegin.boss_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_GUARD_ID_F, {
	"guard_id",
	".cs.S2C_GVE_ChallengeBossBegin.guard_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_SEQ_F, {
	"seq",
	".cs.S2C_GVE_ChallengeBossBegin.seq",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_CHALLENGE_TYPE_F, {
	"challenge_type",
	".cs.S2C_GVE_ChallengeBossBegin.challenge_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_IS_WIN_F, {
	"is_win",
	".cs.S2C_GVE_ChallengeBossBegin.is_win",
	6,
	5,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_DAMAGE_F, {
	"damage",
	".cs.S2C_GVE_ChallengeBossBegin.damage",
	7,
	6,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_BOSS_INFO_F, {
	"boss_info",
	".cs.S2C_GVE_ChallengeBossBegin.boss_info",
	8,
	7,
	1,
	false,
	nil,
	var_0_3.GVEBOSS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_KNIGHT_ACTION_F, {
	"knight_action",
	".cs.S2C_GVE_ChallengeBossBegin.knight_action",
	9,
	8,
	3,
	false,
	{},
	var_0_3.GVEKNIGHTPOS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_GVE_ChallengeBossBegin.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_AWARDS_F, {
	"awards",
	".cs.S2C_GVE_ChallengeBossBegin.awards",
	11,
	10,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_LEVEL_F, {
	"level",
	".cs.S2C_GVE_ChallengeBossBegin.level",
	12,
	11,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_BOSS9_AWARDS_F, {
	"boss9_awards",
	".cs.S2C_GVE_ChallengeBossBegin.boss9_awards",
	13,
	12,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_ME, {
	"S2C_GVE_ChallengeBossBegin",
	".cs.S2C_GVE_ChallengeBossBegin",
	{},
	{},
	{
		var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_RET_F,
		var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_BOSS_ID_F,
		var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_GUARD_ID_F,
		var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_SEQ_F,
		var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_CHALLENGE_TYPE_F,
		var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_IS_WIN_F,
		var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_DAMAGE_F,
		var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_BOSS_INFO_F,
		var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_KNIGHT_ACTION_F,
		var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_BATTLE_ID_F,
		var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_AWARDS_F,
		var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_LEVEL_F,
		var_0_10.S2C_GVE_CHALLENGEBOSSBEGIN_BOSS9_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_GETBOSSRANK_RANK_TYPE_F, {
	"rank_type",
	".cs.C2S_GVE_GetBossRank.rank_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_GETBOSSRANK_BOSS_ID_F, {
	"boss_id",
	".cs.C2S_GVE_GetBossRank.boss_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_GETBOSSRANK_PAGE_F, {
	"page",
	".cs.C2S_GVE_GetBossRank.page",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_GETBOSSRANK_ME, {
	"C2S_GVE_GetBossRank",
	".cs.C2S_GVE_GetBossRank",
	{},
	{},
	{
		var_0_10.C2S_GVE_GETBOSSRANK_RANK_TYPE_F,
		var_0_10.C2S_GVE_GETBOSSRANK_BOSS_ID_F,
		var_0_10.C2S_GVE_GETBOSSRANK_PAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETBOSSRANK_RET_F, {
	"ret",
	".cs.S2C_GVE_GetBossRank.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETBOSSRANK_RANK_TYPE_F, {
	"rank_type",
	".cs.S2C_GVE_GetBossRank.rank_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETBOSSRANK_BOSS_ID_F, {
	"boss_id",
	".cs.S2C_GVE_GetBossRank.boss_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETBOSSRANK_PAGE_F, {
	"page",
	".cs.S2C_GVE_GetBossRank.page",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETBOSSRANK_TOTAL_PAGE_F, {
	"total_page",
	".cs.S2C_GVE_GetBossRank.total_page",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETBOSSRANK_SELF_DATA_F, {
	"self_data",
	".cs.S2C_GVE_GetBossRank.self_data",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.GVERANKUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETBOSSRANK_DATA_F, {
	"data",
	".cs.S2C_GVE_GetBossRank.data",
	7,
	6,
	3,
	false,
	{},
	var_0_3.GVERANKUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_GETBOSSRANK_ME, {
	"S2C_GVE_GetBossRank",
	".cs.S2C_GVE_GetBossRank",
	{},
	{},
	{
		var_0_10.S2C_GVE_GETBOSSRANK_RET_F,
		var_0_10.S2C_GVE_GETBOSSRANK_RANK_TYPE_F,
		var_0_10.S2C_GVE_GETBOSSRANK_BOSS_ID_F,
		var_0_10.S2C_GVE_GETBOSSRANK_PAGE_F,
		var_0_10.S2C_GVE_GETBOSSRANK_TOTAL_PAGE_F,
		var_0_10.S2C_GVE_GETBOSSRANK_SELF_DATA_F,
		var_0_10.S2C_GVE_GETBOSSRANK_DATA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_BOSSNOTIFYDEAD_BOSS_ID_F, {
	"boss_id",
	".cs.S2C_GVE_BossNotifyDead.boss_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_BOSSNOTIFYDEAD_GUARD_ID_F, {
	"guard_id",
	".cs.S2C_GVE_BossNotifyDead.guard_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_BOSSNOTIFYDEAD_ME, {
	"S2C_GVE_BossNotifyDead",
	".cs.S2C_GVE_BossNotifyDead",
	{},
	{},
	{
		var_0_10.S2C_GVE_BOSSNOTIFYDEAD_BOSS_ID_F,
		var_0_10.S2C_GVE_BOSSNOTIFYDEAD_GUARD_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_GETRESEARCHINFO_ME, {
	"C2S_GVE_GetResearchInfo",
	".cs.C2S_GVE_GetResearchInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETRESEARCHINFO_RET_F, {
	"ret",
	".cs.S2C_GVE_GetResearchInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETRESEARCHINFO_MISSION_KNIGHT_ID_F, {
	"mission_knight_id",
	".cs.S2C_GVE_GetResearchInfo.mission_knight_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETRESEARCHINFO_MISSION_START_TIME_F, {
	"mission_start_time",
	".cs.S2C_GVE_GetResearchInfo.mission_start_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETRESEARCHINFO_MISSION_KNIGHTS_F, {
	"mission_knights",
	".cs.S2C_GVE_GetResearchInfo.mission_knights",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETRESEARCHINFO_MISSION_GAIN_RESEARCH_F, {
	"mission_gain_research",
	".cs.S2C_GVE_GetResearchInfo.mission_gain_research",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETRESEARCHINFO_MISSION_RESEARCH_F, {
	"mission_research",
	".cs.S2C_GVE_GetResearchInfo.mission_research",
	6,
	5,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETRESEARCHINFO_BOSS_RESEARCH_F, {
	"boss_research",
	".cs.S2C_GVE_GetResearchInfo.boss_research",
	7,
	6,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_GETRESEARCHINFO_ME, {
	"S2C_GVE_GetResearchInfo",
	".cs.S2C_GVE_GetResearchInfo",
	{},
	{},
	{
		var_0_10.S2C_GVE_GETRESEARCHINFO_RET_F,
		var_0_10.S2C_GVE_GETRESEARCHINFO_MISSION_KNIGHT_ID_F,
		var_0_10.S2C_GVE_GETRESEARCHINFO_MISSION_START_TIME_F,
		var_0_10.S2C_GVE_GETRESEARCHINFO_MISSION_KNIGHTS_F,
		var_0_10.S2C_GVE_GETRESEARCHINFO_MISSION_GAIN_RESEARCH_F,
		var_0_10.S2C_GVE_GETRESEARCHINFO_MISSION_RESEARCH_F,
		var_0_10.S2C_GVE_GETRESEARCHINFO_BOSS_RESEARCH_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_RESEARCHMISSION_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_GVE_ResearchMission.knight_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_RESEARCHMISSION_ME, {
	"C2S_GVE_ResearchMission",
	".cs.C2S_GVE_ResearchMission",
	{},
	{},
	{
		var_0_10.C2S_GVE_RESEARCHMISSION_KNIGHT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_RESEARCHMISSION_RET_F, {
	"ret",
	".cs.S2C_GVE_ResearchMission.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_RESEARCHMISSION_KNIGHT_ID_F, {
	"knight_id",
	".cs.S2C_GVE_ResearchMission.knight_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_RESEARCHMISSION_START_TIME_F, {
	"start_time",
	".cs.S2C_GVE_ResearchMission.start_time",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_RESEARCHMISSION_ME, {
	"S2C_GVE_ResearchMission",
	".cs.S2C_GVE_ResearchMission",
	{},
	{},
	{
		var_0_10.S2C_GVE_RESEARCHMISSION_RET_F,
		var_0_10.S2C_GVE_RESEARCHMISSION_KNIGHT_ID_F,
		var_0_10.S2C_GVE_RESEARCHMISSION_START_TIME_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_RESEARCHAWARD_ME, {
	"C2S_GVE_ResearchAward",
	".cs.C2S_GVE_ResearchAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_RESEARCHAWARD_RET_F, {
	"ret",
	".cs.S2C_GVE_ResearchAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_RESEARCHAWARD_START_TIME_F, {
	"start_time",
	".cs.S2C_GVE_ResearchAward.start_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_RESEARCHAWARD_GAIN_RESEARCH_F, {
	"gain_research",
	".cs.S2C_GVE_ResearchAward.gain_research",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_RESEARCHAWARD_TEAM_RESEARCH_F, {
	"team_research",
	".cs.S2C_GVE_ResearchAward.team_research",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_RESEARCHAWARD_ME, {
	"S2C_GVE_ResearchAward",
	".cs.S2C_GVE_ResearchAward",
	{},
	{},
	{
		var_0_10.S2C_GVE_RESEARCHAWARD_RET_F,
		var_0_10.S2C_GVE_RESEARCHAWARD_START_TIME_F,
		var_0_10.S2C_GVE_RESEARCHAWARD_GAIN_RESEARCH_F,
		var_0_10.S2C_GVE_RESEARCHAWARD_TEAM_RESEARCH_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_RESEARCHRANKLIST_ME, {
	"C2S_GVE_ResearchRankList",
	".cs.C2S_GVE_ResearchRankList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_RESEARCHRANKLIST_RET_F, {
	"ret",
	".cs.S2C_GVE_ResearchRankList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_RESEARCHRANKLIST_LIST_F, {
	"list",
	".cs.S2C_GVE_ResearchRankList.list",
	2,
	1,
	3,
	false,
	{},
	var_0_3.GVERESEARCHRANK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_RESEARCHRANKLIST_ME, {
	"S2C_GVE_ResearchRankList",
	".cs.S2C_GVE_ResearchRankList",
	{},
	{},
	{
		var_0_10.S2C_GVE_RESEARCHRANKLIST_RET_F,
		var_0_10.S2C_GVE_RESEARCHRANKLIST_LIST_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_HALIDOM_GETINFO_ME, {
	"C2S_GVE_Halidom_GetInfo",
	".cs.C2S_GVE_Halidom_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_GETINFO_RET_F, {
	"ret",
	".cs.S2C_GVE_Halidom_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_GETINFO_HALIDOM_INFO_F, {
	"halidom_info",
	".cs.S2C_GVE_Halidom_GetInfo.halidom_info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.GVEHALIDOM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_GETINFO_HALIDOM_FIGHT_VALUE_F, {
	"halidom_fight_value",
	".cs.S2C_GVE_Halidom_GetInfo.halidom_fight_value",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_GETINFO_JOB_SWITCH_END_TIMESTAMP_F, {
	"job_switch_end_timestamp",
	".cs.S2C_GVE_Halidom_GetInfo.job_switch_end_timestamp",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_HALIDOM_GETINFO_ME, {
	"S2C_GVE_Halidom_GetInfo",
	".cs.S2C_GVE_Halidom_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_GVE_HALIDOM_GETINFO_RET_F,
		var_0_10.S2C_GVE_HALIDOM_GETINFO_HALIDOM_INFO_F,
		var_0_10.S2C_GVE_HALIDOM_GETINFO_HALIDOM_FIGHT_VALUE_F,
		var_0_10.S2C_GVE_HALIDOM_GETINFO_JOB_SWITCH_END_TIMESTAMP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_HALIDOM_MERGE_MERGE_CONFIG_ID_F, {
	"merge_config_id",
	".cs.C2S_GVE_Halidom_Merge.merge_config_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_HALIDOM_MERGE_IS_EQUIP_F, {
	"is_equip",
	".cs.C2S_GVE_Halidom_Merge.is_equip",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_HALIDOM_MERGE_ME, {
	"C2S_GVE_Halidom_Merge",
	".cs.C2S_GVE_Halidom_Merge",
	{},
	{},
	{
		var_0_10.C2S_GVE_HALIDOM_MERGE_MERGE_CONFIG_ID_F,
		var_0_10.C2S_GVE_HALIDOM_MERGE_IS_EQUIP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_MERGE_RET_F, {
	"ret",
	".cs.S2C_GVE_Halidom_Merge.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_MERGE_MERGE_CONFIG_ID_F, {
	"merge_config_id",
	".cs.S2C_GVE_Halidom_Merge.merge_config_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_MERGE_BAG_F, {
	"bag",
	".cs.S2C_GVE_Halidom_Merge.bag",
	3,
	2,
	3,
	false,
	{},
	var_0_3.UINT32KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_MERGE_NEW_RESOURCE_NUM_F, {
	"new_resource_num",
	".cs.S2C_GVE_Halidom_Merge.new_resource_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_MERGE_IS_EQUIP_F, {
	"is_equip",
	".cs.S2C_GVE_Halidom_Merge.is_equip",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_MERGE_HALIDOM_FIGHT_VALUE_F, {
	"halidom_fight_value",
	".cs.S2C_GVE_Halidom_Merge.halidom_fight_value",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_HALIDOM_MERGE_ME, {
	"S2C_GVE_Halidom_Merge",
	".cs.S2C_GVE_Halidom_Merge",
	{},
	{},
	{
		var_0_10.S2C_GVE_HALIDOM_MERGE_RET_F,
		var_0_10.S2C_GVE_HALIDOM_MERGE_MERGE_CONFIG_ID_F,
		var_0_10.S2C_GVE_HALIDOM_MERGE_BAG_F,
		var_0_10.S2C_GVE_HALIDOM_MERGE_NEW_RESOURCE_NUM_F,
		var_0_10.S2C_GVE_HALIDOM_MERGE_IS_EQUIP_F,
		var_0_10.S2C_GVE_HALIDOM_MERGE_HALIDOM_FIGHT_VALUE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_HALIDOM_FASTDECOMPOSITION_ME, {
	"C2S_GVE_Halidom_FastDecomposition",
	".cs.C2S_GVE_Halidom_FastDecomposition",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_FASTDECOMPOSITION_RET_F, {
	"ret",
	".cs.S2C_GVE_Halidom_FastDecomposition.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_FASTDECOMPOSITION_NEW_RESOURCE_NUM_F, {
	"new_resource_num",
	".cs.S2C_GVE_Halidom_FastDecomposition.new_resource_num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_HALIDOM_FASTDECOMPOSITION_ME, {
	"S2C_GVE_Halidom_FastDecomposition",
	".cs.S2C_GVE_Halidom_FastDecomposition",
	{},
	{},
	{
		var_0_10.S2C_GVE_HALIDOM_FASTDECOMPOSITION_RET_F,
		var_0_10.S2C_GVE_HALIDOM_FASTDECOMPOSITION_NEW_RESOURCE_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_HALIDOM_LEVELUP_MERGE_CONFIG_ID_F, {
	"merge_config_id",
	".cs.C2S_GVE_Halidom_LevelUp.merge_config_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_HALIDOM_LEVELUP_ME, {
	"C2S_GVE_Halidom_LevelUp",
	".cs.C2S_GVE_Halidom_LevelUp",
	{},
	{},
	{
		var_0_10.C2S_GVE_HALIDOM_LEVELUP_MERGE_CONFIG_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_LEVELUP_RET_F, {
	"ret",
	".cs.S2C_GVE_Halidom_LevelUp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_LEVELUP_NEW_CONFIG_ID_F, {
	"new_config_id",
	".cs.S2C_GVE_Halidom_LevelUp.new_config_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_LEVELUP_HALIDOM_FIGHT_VALUE_F, {
	"halidom_fight_value",
	".cs.S2C_GVE_Halidom_LevelUp.halidom_fight_value",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_HALIDOM_LEVELUP_ME, {
	"S2C_GVE_Halidom_LevelUp",
	".cs.S2C_GVE_Halidom_LevelUp",
	{},
	{},
	{
		var_0_10.S2C_GVE_HALIDOM_LEVELUP_RET_F,
		var_0_10.S2C_GVE_HALIDOM_LEVELUP_NEW_CONFIG_ID_F,
		var_0_10.S2C_GVE_HALIDOM_LEVELUP_HALIDOM_FIGHT_VALUE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_HALIDOM_SWITCHJOB_SWITCH_CONFIG_ID_F, {
	"switch_config_id",
	".cs.C2S_GVE_Halidom_SwitchJob.switch_config_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_HALIDOM_SWITCHJOB_ME, {
	"C2S_GVE_Halidom_SwitchJob",
	".cs.C2S_GVE_Halidom_SwitchJob",
	{},
	{},
	{
		var_0_10.C2S_GVE_HALIDOM_SWITCHJOB_SWITCH_CONFIG_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_SWITCHJOB_RET_F, {
	"ret",
	".cs.S2C_GVE_Halidom_SwitchJob.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_SWITCHJOB_EQUIP_F, {
	"equip",
	".cs.S2C_GVE_Halidom_SwitchJob.equip",
	2,
	1,
	3,
	false,
	{},
	var_0_3.UINT32KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_SWITCHJOB_JOB_SWITCH_END_TIMESTAMP_F, {
	"job_switch_end_timestamp",
	".cs.S2C_GVE_Halidom_SwitchJob.job_switch_end_timestamp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_SWITCHJOB_HALIDOM_FIGHT_VALUE_F, {
	"halidom_fight_value",
	".cs.S2C_GVE_Halidom_SwitchJob.halidom_fight_value",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_HALIDOM_SWITCHJOB_ME, {
	"S2C_GVE_Halidom_SwitchJob",
	".cs.S2C_GVE_Halidom_SwitchJob",
	{},
	{},
	{
		var_0_10.S2C_GVE_HALIDOM_SWITCHJOB_RET_F,
		var_0_10.S2C_GVE_HALIDOM_SWITCHJOB_EQUIP_F,
		var_0_10.S2C_GVE_HALIDOM_SWITCHJOB_JOB_SWITCH_END_TIMESTAMP_F,
		var_0_10.S2C_GVE_HALIDOM_SWITCHJOB_HALIDOM_FIGHT_VALUE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_HALIDOM_DECOMPOSITION_DECOMPOSITION_CONFIG_ID_F, {
	"decomposition_config_id",
	".cs.C2S_GVE_Halidom_Decomposition.decomposition_config_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_HALIDOM_DECOMPOSITION_ME, {
	"C2S_GVE_Halidom_Decomposition",
	".cs.C2S_GVE_Halidom_Decomposition",
	{},
	{},
	{
		var_0_10.C2S_GVE_HALIDOM_DECOMPOSITION_DECOMPOSITION_CONFIG_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_DECOMPOSITION_RET_F, {
	"ret",
	".cs.S2C_GVE_Halidom_Decomposition.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_DECOMPOSITION_NEW_RESOURCE_NUM_F, {
	"new_resource_num",
	".cs.S2C_GVE_Halidom_Decomposition.new_resource_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_DECOMPOSITION_DECOMPOSITION_CONFIG_ID_F, {
	"decomposition_config_id",
	".cs.S2C_GVE_Halidom_Decomposition.decomposition_config_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_HALIDOM_DECOMPOSITION_ME, {
	"S2C_GVE_Halidom_Decomposition",
	".cs.S2C_GVE_Halidom_Decomposition",
	{},
	{},
	{
		var_0_10.S2C_GVE_HALIDOM_DECOMPOSITION_RET_F,
		var_0_10.S2C_GVE_HALIDOM_DECOMPOSITION_NEW_RESOURCE_NUM_F,
		var_0_10.S2C_GVE_HALIDOM_DECOMPOSITION_DECOMPOSITION_CONFIG_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_HALIDOM_EQUIP_CONFIG_ID_F, {
	"config_id",
	".cs.C2S_GVE_Halidom_Equip.config_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_HALIDOM_EQUIP_ME, {
	"C2S_GVE_Halidom_Equip",
	".cs.C2S_GVE_Halidom_Equip",
	{},
	{},
	{
		var_0_10.C2S_GVE_HALIDOM_EQUIP_CONFIG_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_EQUIP_RET_F, {
	"ret",
	".cs.S2C_GVE_Halidom_Equip.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_EQUIP_CONFIG_ID_F, {
	"config_id",
	".cs.S2C_GVE_Halidom_Equip.config_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_EQUIP_HALIDOM_FIGHT_VALUE_F, {
	"halidom_fight_value",
	".cs.S2C_GVE_Halidom_Equip.halidom_fight_value",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_HALIDOM_EQUIP_ME, {
	"S2C_GVE_Halidom_Equip",
	".cs.S2C_GVE_Halidom_Equip",
	{},
	{},
	{
		var_0_10.S2C_GVE_HALIDOM_EQUIP_RET_F,
		var_0_10.S2C_GVE_HALIDOM_EQUIP_CONFIG_ID_F,
		var_0_10.S2C_GVE_HALIDOM_EQUIP_HALIDOM_FIGHT_VALUE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_HALIDOM_USERLIST_ME, {
	"C2S_GVE_Halidom_UserList",
	".cs.C2S_GVE_Halidom_UserList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_USERLIST_RET_F, {
	"ret",
	".cs.S2C_GVE_Halidom_UserList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_HALIDOM_USERLIST_USER_NUM_F, {
	"user_num",
	".cs.S2C_GVE_Halidom_UserList.user_num",
	2,
	1,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_HALIDOM_USERLIST_ME, {
	"S2C_GVE_Halidom_UserList",
	".cs.S2C_GVE_Halidom_UserList",
	{},
	{},
	{
		var_0_10.S2C_GVE_HALIDOM_USERLIST_RET_F,
		var_0_10.S2C_GVE_HALIDOM_USERLIST_USER_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_SYNCRANDOMBOSSINFO_RET_F, {
	"ret",
	".cs.S2C_GVE_SyncRandomBossInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_SYNCRANDOMBOSSINFO_BOSS_INFO_F, {
	"boss_info",
	".cs.S2C_GVE_SyncRandomBossInfo.boss_info",
	2,
	1,
	3,
	false,
	{},
	var_0_3.GVEBOSS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_SYNCRANDOMBOSSINFO_ME, {
	"S2C_GVE_SyncRandomBossInfo",
	".cs.S2C_GVE_SyncRandomBossInfo",
	{},
	{},
	{
		var_0_10.S2C_GVE_SYNCRANDOMBOSSINFO_RET_F,
		var_0_10.S2C_GVE_SYNCRANDOMBOSSINFO_BOSS_INFO_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_GETBOSSFIRSTKILL_ME, {
	"C2S_GVE_GetBossFirstKill",
	".cs.C2S_GVE_GetBossFirstKill",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETBOSSFIRSTKILL_RET_F, {
	"ret",
	".cs.S2C_GVE_GetBossFirstKill.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETBOSSFIRSTKILL_FIRST_KILL_DATAS_F, {
	"first_kill_datas",
	".cs.S2C_GVE_GetBossFirstKill.first_kill_datas",
	2,
	1,
	3,
	false,
	{},
	var_0_3.GVEBOSSFIRSTKILL_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETBOSSFIRSTKILL_AWARD_ID_F, {
	"award_id",
	".cs.S2C_GVE_GetBossFirstKill.award_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_GETBOSSFIRSTKILL_ME, {
	"S2C_GVE_GetBossFirstKill",
	".cs.S2C_GVE_GetBossFirstKill",
	{},
	{},
	{
		var_0_10.S2C_GVE_GETBOSSFIRSTKILL_RET_F,
		var_0_10.S2C_GVE_GETBOSSFIRSTKILL_FIRST_KILL_DATAS_F,
		var_0_10.S2C_GVE_GETBOSSFIRSTKILL_AWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_GETALLRANDOMBOSSINFO_ME, {
	"C2S_GVE_GetAllRandomBossInfo",
	".cs.C2S_GVE_GetAllRandomBossInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETALLRANDOMBOSSINFO_RET_F, {
	"ret",
	".cs.S2C_GVE_GetAllRandomBossInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETALLRANDOMBOSSINFO_BOSS_INFO_F, {
	"boss_info",
	".cs.S2C_GVE_GetAllRandomBossInfo.boss_info",
	2,
	1,
	3,
	false,
	{},
	var_0_3.GVEBOSS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_GETALLRANDOMBOSSINFO_ME, {
	"S2C_GVE_GetAllRandomBossInfo",
	".cs.S2C_GVE_GetAllRandomBossInfo",
	{},
	{},
	{
		var_0_10.S2C_GVE_GETALLRANDOMBOSSINFO_RET_F,
		var_0_10.S2C_GVE_GETALLRANDOMBOSSINFO_BOSS_INFO_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GVE_GETBOSSAWARD_ID_F, {
	"id",
	".cs.C2S_GVE_GetBossAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GVE_GETBOSSAWARD_ME, {
	"C2S_GVE_GetBossAward",
	".cs.C2S_GVE_GetBossAward",
	{},
	{},
	{
		var_0_10.C2S_GVE_GETBOSSAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETBOSSAWARD_RET_F, {
	"ret",
	".cs.S2C_GVE_GetBossAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETBOSSAWARD_ID_F, {
	"id",
	".cs.S2C_GVE_GetBossAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GVE_GETBOSSAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_GVE_GetBossAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GVE_GETBOSSAWARD_ME, {
	"S2C_GVE_GetBossAward",
	".cs.S2C_GVE_GetBossAward",
	{},
	{},
	{
		var_0_10.S2C_GVE_GETBOSSAWARD_RET_F,
		var_0_10.S2C_GVE_GETBOSSAWARD_ID_F,
		var_0_10.S2C_GVE_GETBOSSAWARD_AWARDS_F
	},
	false,
	{}
})

return var_0_10
