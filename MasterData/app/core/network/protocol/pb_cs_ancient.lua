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
	C2S_ANCIENT_ENTER_ME = protobuf.Descriptor(),
	S2C_ANCIENT_ENTER_ME = protobuf.Descriptor(),
	S2C_ANCIENT_ENTER_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ENTER_TEAM_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ENTER_PROMOTE_TEAMS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ENTER_SCORE_STAGE_RANK_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ENTER_SCORE_STAGE_SCORE_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ENTER_SCORE_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ENTER_TASKS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ENTER_TEAM_TASKS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ENTER_ACTIVE_VALUE_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ENTER_ACTIVE_AWARDED_IDS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ENTER_CONTRIBUTIONS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ENTER_LOOT_EXP_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ENTER_MY_FINAL_TEAM_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ENTER_FINAL_TEAMS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ENTER_ROUND_TEAMS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ENTER_HAS_INVITATION_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_CREATETEAM_ME = protobuf.Descriptor(),
	C2S_ANCIENT_CREATETEAM_CONFIRM_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_CREATETEAM_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_CREATETEAM_LABEL_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_CREATETEAM_ANCIENT_PET_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_CREATETEAM_ME = protobuf.Descriptor(),
	S2C_ANCIENT_CREATETEAM_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_CREATETEAM_TEAM_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_REQJOIN_ME = protobuf.Descriptor(),
	C2S_ANCIENT_REQJOIN_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_REQJOIN_ME = protobuf.Descriptor(),
	S2C_ANCIENT_REQJOIN_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_REQJOIN_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_REQJOIN_CONFIRM_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_QUICKJOIN_ME = protobuf.Descriptor(),
	S2C_ANCIENT_QUICKJOIN_ME = protobuf.Descriptor(),
	S2C_ANCIENT_QUICKJOIN_RET_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_INVITE_ME = protobuf.Descriptor(),
	C2S_ANCIENT_INVITE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_INVITE_ME = protobuf.Descriptor(),
	S2C_ANCIENT_INVITE_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_INVITE_USER_ID_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_CONFIRMINVITE_ME = protobuf.Descriptor(),
	C2S_ANCIENT_CONFIRMINVITE_TEAM_ID_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_CONFIRMINVITE_ACCEPT_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_CONFIRMINVITE_ME = protobuf.Descriptor(),
	S2C_ANCIENT_CONFIRMINVITE_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_CONFIRMINVITE_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_CONFIRMINVITE_ACCEPT_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_QUITTEAM_ME = protobuf.Descriptor(),
	S2C_ANCIENT_QUITTEAM_ME = protobuf.Descriptor(),
	S2C_ANCIENT_QUITTEAM_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_QUITTEAM_JOIN_TEAM_CD_TIME_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_QUITTEAM_TEAM_ID_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_KICK_ME = protobuf.Descriptor(),
	C2S_ANCIENT_KICK_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_KICK_ME = protobuf.Descriptor(),
	S2C_ANCIENT_KICK_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_KICK_USER_ID_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_SETTING_ME = protobuf.Descriptor(),
	C2S_ANCIENT_SETTING_OPERATE_TYPE_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_SETTING_IS_CONFIRM_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_SETTING_ANCIENT_PET_ID_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_SETTING_APPLY_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_SETTING_LABEL_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_SETTING_BAN_FIGHT_USER_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_SETTING_ME = protobuf.Descriptor(),
	S2C_ANCIENT_SETTING_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_NOTIFYTEAMCHANGE_ME = protobuf.Descriptor(),
	S2C_ANCIENT_NOTIFYTEAMCHANGE_TEAM_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_NOTIFYBEKICK_ME = protobuf.Descriptor(),
	S2C_ANCIENT_NOTIFYBEKICK_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_NOTIFYINVITE_ME = protobuf.Descriptor(),
	S2C_ANCIENT_NOTIFYINVITE_TEAMS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_GETINVITATIONLIST_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETINVITATIONLIST_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETINVITATIONLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETINVITATIONLIST_TEAMS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_NOTIFYDISBANDTEAM_ME = protobuf.Descriptor(),
	C2S_ANCIENT_GETAPPLYLIST_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETAPPLYLIST_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETAPPLYLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETAPPLYLIST_USERS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_CONFIRMAPPLY_ME = protobuf.Descriptor(),
	C2S_ANCIENT_CONFIRMAPPLY_USER_ID_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_CONFIRMAPPLY_ACCEPT_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_CONFIRMAPPLY_ME = protobuf.Descriptor(),
	S2C_ANCIENT_CONFIRMAPPLY_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_CONFIRMAPPLY_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_CONFIRMAPPLY_ACCEPT_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_RECOMMENDTEAM_ME = protobuf.Descriptor(),
	C2S_ANCIENT_RECOMMENDTEAM_TP_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_RECOMMENDTEAM_PAGE_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_RECOMMENDTEAM_ME = protobuf.Descriptor(),
	S2C_ANCIENT_RECOMMENDTEAM_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_RECOMMENDTEAM_TEAMS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_RECOMMENDTEAM_TP_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_RECOMMENDTEAM_PAGE_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_RECOMMENDTEAM_TOTAL_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_DELETEAPPLY_ME = protobuf.Descriptor(),
	C2S_ANCIENT_DELETEAPPLY_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_DELETEAPPLY_ME = protobuf.Descriptor(),
	S2C_ANCIENT_DELETEAPPLY_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_DELETEAPPLY_TEAM_ID_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_GETAPPLYRECORD_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETAPPLYRECORD_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETAPPLYRECORD_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETAPPLYRECORD_TEAMS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_GETTEAMINFO_ME = protobuf.Descriptor(),
	C2S_ANCIENT_GETTEAMINFO_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETTEAMINFO_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETTEAMINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETTEAMINFO_TEAM_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETTEAMINFO_IS_APPLY_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_SEARCH_ME = protobuf.Descriptor(),
	C2S_ANCIENT_SEARCH_CONTENT_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_SEARCH_ME = protobuf.Descriptor(),
	S2C_ANCIENT_SEARCH_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_SEARCH_CONTENT_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_SEARCH_TEAMS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_GETUSERLIST_ME = protobuf.Descriptor(),
	C2S_ANCIENT_GETUSERLIST_USER_IDS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETUSERLIST_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETUSERLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETUSERLIST_USERS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_GETMESSAGEBOARD_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETMESSAGEBOARD_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETMESSAGEBOARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETMESSAGEBOARD_MESSAGES_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETMESSAGEBOARD_DAILY_ADD_MESSAGE_NUM_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_ADDMESSAGE_ME = protobuf.Descriptor(),
	C2S_ANCIENT_ADDMESSAGE_CONTENT_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ADDMESSAGE_ME = protobuf.Descriptor(),
	S2C_ANCIENT_ADDMESSAGE_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ADDMESSAGE_MESSAGE_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ADDMESSAGE_DAILY_ADD_MESSAGE_NUM_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ADDMESSAGE_DEL_ID_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_OPERATEMESSAGE_ME = protobuf.Descriptor(),
	C2S_ANCIENT_OPERATEMESSAGE_ID_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_OPERATEMESSAGE_TP_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_OPERATEMESSAGE_ME = protobuf.Descriptor(),
	S2C_ANCIENT_OPERATEMESSAGE_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_OPERATEMESSAGE_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_OPERATEMESSAGE_TP_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_OPERATESTART_ME = protobuf.Descriptor(),
	S2C_ANCIENT_OPERATESTART_ME = protobuf.Descriptor(),
	S2C_ANCIENT_OPERATESTART_RET_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_OPERATEEND_ME = protobuf.Descriptor(),
	S2C_ANCIENT_OPERATEEND_ME = protobuf.Descriptor(),
	S2C_ANCIENT_OPERATEEND_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_OPERATENOTIFY_ME = protobuf.Descriptor(),
	S2C_ANCIENT_OPERATENOTIFY_OPERATE_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_FORMATION_ME = protobuf.Descriptor(),
	C2S_ANCIENT_FORMATION_ORIGIN_POS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_FORMATION_TARGET_POS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_FORMATION_ME = protobuf.Descriptor(),
	S2C_ANCIENT_FORMATION_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_FORMATION_ORIGIN_POS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_FORMATION_TARGET_POS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_FORMATIONNOTIFY_ME = protobuf.Descriptor(),
	S2C_ANCIENT_FORMATIONNOTIFY_FORMATION_POSITIONS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_LOOTINFO_ME = protobuf.Descriptor(),
	S2C_ANCIENT_LOOTINFO_ME = protobuf.Descriptor(),
	S2C_ANCIENT_LOOTINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_LOOTINFO_DICE_NUM_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_LOOTINFO_LOOTS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_DICEROLL_ME = protobuf.Descriptor(),
	C2S_ANCIENT_DICEROLL_SCORE_DAY_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_DICEROLL_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_DICEROLL_ME = protobuf.Descriptor(),
	S2C_ANCIENT_DICEROLL_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_DICEROLL_SCORE_DAY_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_DICEROLL_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_DICEROLL_DICE_NUM_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_DICEROLL_POINTS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_DICEGIVEUP_ME = protobuf.Descriptor(),
	C2S_ANCIENT_DICEGIVEUP_SCORE_DAY_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_DICEGIVEUP_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_DICEGIVEUP_ME = protobuf.Descriptor(),
	S2C_ANCIENT_DICEGIVEUP_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_DICEGIVEUP_SCORE_DAY_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_DICEGIVEUP_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_DICENOTIFY_ME = protobuf.Descriptor(),
	S2C_ANCIENT_DICENOTIFY_SCORE_DAY_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_DICENOTIFY_DICE_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_GETRANKLIST_ME = protobuf.Descriptor(),
	C2S_ANCIENT_GETRANKLIST_LIMIT_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETRANKLIST_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETRANKLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETRANKLIST_LIMIT_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETRANKLIST_SELF_RANK_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETRANKLIST_RANK_UNITS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_MATCH_ME = protobuf.Descriptor(),
	S2C_ANCIENT_MATCH_ME = protobuf.Descriptor(),
	S2C_ANCIENT_MATCH_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_MATCH_OPPONENT_TEAM_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_BATTLESTART_ME = protobuf.Descriptor(),
	S2C_ANCIENT_BATTLESTART_ME = protobuf.Descriptor(),
	S2C_ANCIENT_BATTLESTART_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_BATTLETURNNOTIFY_ME = protobuf.Descriptor(),
	S2C_ANCIENT_BATTLETURNNOTIFY_TURNS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_BATTLEENDNOTIFY_ME = protobuf.Descriptor(),
	S2C_ANCIENT_BATTLEENDNOTIFY_LOOT_EXP_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_BATTLEENDNOTIFY_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_BATTLEENDNOTIFY_SETTLES_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_BATTLESPECTATE_ME = protobuf.Descriptor(),
	S2C_ANCIENT_BATTLESPECTATE_ME = protobuf.Descriptor(),
	S2C_ANCIENT_BATTLESPECTATE_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_BATTLESPECTATE_OPPONENT_TEAM_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_BATTLESPECTATE_TURNS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_BATTLEREPORTS_ME = protobuf.Descriptor(),
	S2C_ANCIENT_BATTLEREPORTS_ME = protobuf.Descriptor(),
	S2C_ANCIENT_BATTLEREPORTS_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_BATTLEREPORTS_TEAM_BATTLE_TIMES_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_BATTLEREPORTS_TEAM_WIN_RATE_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_BATTLEREPORTS_SELF_KILL_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_BATTLEREPORTS_SELF_SCORE_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_BATTLEREPORTS_REPORTS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_FINALMATCH_ME = protobuf.Descriptor(),
	S2C_ANCIENT_FINALMATCH_ME = protobuf.Descriptor(),
	S2C_ANCIENT_FINALMATCH_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_FINALMATCH_OPPONENT_TEAM_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_FINALFORMATION_ME = protobuf.Descriptor(),
	C2S_ANCIENT_FINALFORMATION_ORIGIN_POS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_FINALFORMATION_TARGET_POS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_FINALFORMATION_ME = protobuf.Descriptor(),
	S2C_ANCIENT_FINALFORMATION_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_FINALFORMATION_ORIGIN_POS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_FINALFORMATION_TARGET_POS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_FINALFORMATIONNOTIFY_ME = protobuf.Descriptor(),
	S2C_ANCIENT_FINALFORMATIONNOTIFY_FORMATION_POSITIONS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_GUESSINFO_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GUESSINFO_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GUESSINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GUESSINFO_GUESSES_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ROUNDNOTIFY_ME = protobuf.Descriptor(),
	S2C_ANCIENT_ROUNDNOTIFY_GUESSES_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ROUNDNOTIFY_ROUND_TEAMS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_GUESS_ME = protobuf.Descriptor(),
	C2S_ANCIENT_GUESS_ROUND_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_GUESS_NUM_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_GUESS_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GUESS_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GUESS_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GUESS_ROUND_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GUESS_NUM_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GUESS_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GUESS_GUESS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_GUESSAWARD_ME = protobuf.Descriptor(),
	C2S_ANCIENT_GUESSAWARD_ROUND_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_GUESSAWARD_NUM_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GUESSAWARD_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GUESSAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GUESSAWARD_ROUND_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GUESSAWARD_NUM_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GUESSAWARD_GUESS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GUESSAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_FINALBATTLEREPORT_ME = protobuf.Descriptor(),
	C2S_ANCIENT_FINALBATTLEREPORT_ROUND_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_FINALBATTLEREPORT_NUM_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_FINALBATTLEREPORT_ME = protobuf.Descriptor(),
	S2C_ANCIENT_FINALBATTLEREPORT_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_FINALBATTLEREPORT_ROUND_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_FINALBATTLEREPORT_NUM_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_FINALBATTLEREPORT_REPORT_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_PETSETKNIGHT_ME = protobuf.Descriptor(),
	C2S_ANCIENT_PETSETKNIGHT_IDX_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_PETSETKNIGHT_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_PETSETKNIGHT_ME = protobuf.Descriptor(),
	S2C_ANCIENT_PETSETKNIGHT_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_PETSETKNIGHT_IDX_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_PETSETKNIGHT_KNIGHT_POS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_PETSETKNIGHT_PET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_TASKNTF_ME = protobuf.Descriptor(),
	S2C_ANCIENT_TASKNTF_TASKS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_ANCIENT_TASKAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_ANCIENT_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_TASKAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_ACTIVEAWARD_ME = protobuf.Descriptor(),
	C2S_ANCIENT_ACTIVEAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ACTIVEAWARD_ME = protobuf.Descriptor(),
	S2C_ANCIENT_ACTIVEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ACTIVEAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_ACTIVEAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_TEAMTASKNTF_ME = protobuf.Descriptor(),
	S2C_ANCIENT_TEAMTASKNTF_TASKS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_TEAMTASKNTF_PET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_TEAMTASKNTF_ACTIVE_VALUE_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_TEAMTASKNTF_ACTIVE_AWARDED_IDS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_BUYFIGHTTIMES_ME = protobuf.Descriptor(),
	C2S_ANCIENT_BUYFIGHTTIMES_COUNT_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_BUYFIGHTTIMES_ME = protobuf.Descriptor(),
	S2C_ANCIENT_BUYFIGHTTIMES_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_BUYFIGHTTIMES_COUNT_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_FIGHTTIMESNTF_ME = protobuf.Descriptor(),
	S2C_ANCIENT_FIGHTTIMESNTF_TIMES_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_FIGHTTIMESNTF_LEFT_COUNT_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_GETFINALTEAMLIST_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETFINALTEAMLIST_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETFINALTEAMLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETFINALTEAMLIST_TEAMS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_GETFINALUSERLIST_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETFINALUSERLIST_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETFINALUSERLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETFINALUSERLIST_USERS_F = protobuf.FieldDescriptor(),
	C2S_ANCIENT_GETFINALRANKLIST_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETFINALRANKLIST_ME = protobuf.Descriptor(),
	S2C_ANCIENT_GETFINALRANKLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_GETFINALRANKLIST_RANK_UNITS_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_NOTIFYMAXMESSAGEID_ME = protobuf.Descriptor(),
	S2C_ANCIENT_NOTIFYMAXMESSAGEID_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_ANCIENT_NOTIFYMAXMESSAGEID_MAX_MESSAGE_ID_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_ENTER_ME, {
	"C2S_Ancient_Enter",
	".cs.C2S_Ancient_Enter",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ENTER_RET_F, {
	"ret",
	".cs.S2C_Ancient_Enter.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ENTER_TEAM_F, {
	"team",
	".cs.S2C_Ancient_Enter.team",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.ANCIENTTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ENTER_PROMOTE_TEAMS_F, {
	"promote_teams",
	".cs.S2C_Ancient_Enter.promote_teams",
	3,
	2,
	3,
	false,
	{},
	var_0_3.ANCIENTPROMOTETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ENTER_SCORE_STAGE_RANK_F, {
	"score_stage_rank",
	".cs.S2C_Ancient_Enter.score_stage_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ENTER_SCORE_STAGE_SCORE_F, {
	"score_stage_score",
	".cs.S2C_Ancient_Enter.score_stage_score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ENTER_SCORE_F, {
	"score",
	".cs.S2C_Ancient_Enter.score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ENTER_TASKS_F, {
	"tasks",
	".cs.S2C_Ancient_Enter.tasks",
	7,
	6,
	3,
	false,
	{},
	var_0_3.COMMONTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ENTER_TEAM_TASKS_F, {
	"team_tasks",
	".cs.S2C_Ancient_Enter.team_tasks",
	8,
	7,
	3,
	false,
	{},
	var_0_3.COMMONTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ENTER_ACTIVE_VALUE_F, {
	"active_value",
	".cs.S2C_Ancient_Enter.active_value",
	9,
	8,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ENTER_ACTIVE_AWARDED_IDS_F, {
	"active_awarded_ids",
	".cs.S2C_Ancient_Enter.active_awarded_ids",
	10,
	9,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ENTER_CONTRIBUTIONS_F, {
	"contributions",
	".cs.S2C_Ancient_Enter.contributions",
	11,
	10,
	3,
	false,
	{},
	var_0_3.ANCIENTLOOTCONTRIBUTION_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ENTER_LOOT_EXP_F, {
	"loot_exp",
	".cs.S2C_Ancient_Enter.loot_exp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ENTER_MY_FINAL_TEAM_F, {
	"my_final_team",
	".cs.S2C_Ancient_Enter.my_final_team",
	13,
	12,
	1,
	false,
	nil,
	var_0_3.ANCIENTTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ENTER_FINAL_TEAMS_F, {
	"final_teams",
	".cs.S2C_Ancient_Enter.final_teams",
	14,
	13,
	3,
	false,
	{},
	var_0_3.ANCIENTSIMPLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ENTER_ROUND_TEAMS_F, {
	"round_teams",
	".cs.S2C_Ancient_Enter.round_teams",
	15,
	14,
	3,
	false,
	{},
	var_0_3.ANCIENTROUNDTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ENTER_HAS_INVITATION_F, {
	"has_invitation",
	".cs.S2C_Ancient_Enter.has_invitation",
	16,
	15,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_ENTER_ME, {
	"S2C_Ancient_Enter",
	".cs.S2C_Ancient_Enter",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_ENTER_RET_F,
		var_0_10.S2C_ANCIENT_ENTER_TEAM_F,
		var_0_10.S2C_ANCIENT_ENTER_PROMOTE_TEAMS_F,
		var_0_10.S2C_ANCIENT_ENTER_SCORE_STAGE_RANK_F,
		var_0_10.S2C_ANCIENT_ENTER_SCORE_STAGE_SCORE_F,
		var_0_10.S2C_ANCIENT_ENTER_SCORE_F,
		var_0_10.S2C_ANCIENT_ENTER_TASKS_F,
		var_0_10.S2C_ANCIENT_ENTER_TEAM_TASKS_F,
		var_0_10.S2C_ANCIENT_ENTER_ACTIVE_VALUE_F,
		var_0_10.S2C_ANCIENT_ENTER_ACTIVE_AWARDED_IDS_F,
		var_0_10.S2C_ANCIENT_ENTER_CONTRIBUTIONS_F,
		var_0_10.S2C_ANCIENT_ENTER_LOOT_EXP_F,
		var_0_10.S2C_ANCIENT_ENTER_MY_FINAL_TEAM_F,
		var_0_10.S2C_ANCIENT_ENTER_FINAL_TEAMS_F,
		var_0_10.S2C_ANCIENT_ENTER_ROUND_TEAMS_F,
		var_0_10.S2C_ANCIENT_ENTER_HAS_INVITATION_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_CREATETEAM_CONFIRM_F, {
	"confirm",
	".cs.C2S_Ancient_CreateTeam.confirm",
	1,
	0,
	2,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_CREATETEAM_LEVEL_F, {
	"level",
	".cs.C2S_Ancient_CreateTeam.level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_CREATETEAM_LABEL_F, {
	"label",
	".cs.C2S_Ancient_CreateTeam.label",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_CREATETEAM_ANCIENT_PET_ID_F, {
	"ancient_pet_id",
	".cs.C2S_Ancient_CreateTeam.ancient_pet_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_CREATETEAM_ME, {
	"C2S_Ancient_CreateTeam",
	".cs.C2S_Ancient_CreateTeam",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_CREATETEAM_CONFIRM_F,
		var_0_10.C2S_ANCIENT_CREATETEAM_LEVEL_F,
		var_0_10.C2S_ANCIENT_CREATETEAM_LABEL_F,
		var_0_10.C2S_ANCIENT_CREATETEAM_ANCIENT_PET_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_CREATETEAM_RET_F, {
	"ret",
	".cs.S2C_Ancient_CreateTeam.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_CREATETEAM_TEAM_F, {
	"team",
	".cs.S2C_Ancient_CreateTeam.team",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.ANCIENTTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_CREATETEAM_ME, {
	"S2C_Ancient_CreateTeam",
	".cs.S2C_Ancient_CreateTeam",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_CREATETEAM_RET_F,
		var_0_10.S2C_ANCIENT_CREATETEAM_TEAM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_REQJOIN_TEAM_ID_F, {
	"team_id",
	".cs.C2S_Ancient_ReqJoin.team_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_REQJOIN_ME, {
	"C2S_Ancient_ReqJoin",
	".cs.C2S_Ancient_ReqJoin",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_REQJOIN_TEAM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_REQJOIN_RET_F, {
	"ret",
	".cs.S2C_Ancient_ReqJoin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_REQJOIN_TEAM_ID_F, {
	"team_id",
	".cs.S2C_Ancient_ReqJoin.team_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_REQJOIN_CONFIRM_F, {
	"confirm",
	".cs.S2C_Ancient_ReqJoin.confirm",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_REQJOIN_ME, {
	"S2C_Ancient_ReqJoin",
	".cs.S2C_Ancient_ReqJoin",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_REQJOIN_RET_F,
		var_0_10.S2C_ANCIENT_REQJOIN_TEAM_ID_F,
		var_0_10.S2C_ANCIENT_REQJOIN_CONFIRM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_QUICKJOIN_ME, {
	"C2S_Ancient_QuickJoin",
	".cs.C2S_Ancient_QuickJoin",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_QUICKJOIN_RET_F, {
	"ret",
	".cs.S2C_Ancient_QuickJoin.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_QUICKJOIN_ME, {
	"S2C_Ancient_QuickJoin",
	".cs.S2C_Ancient_QuickJoin",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_QUICKJOIN_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_INVITE_USER_ID_F, {
	"user_id",
	".cs.C2S_Ancient_Invite.user_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_INVITE_ME, {
	"C2S_Ancient_Invite",
	".cs.C2S_Ancient_Invite",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_INVITE_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_INVITE_RET_F, {
	"ret",
	".cs.S2C_Ancient_Invite.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_INVITE_USER_ID_F, {
	"user_id",
	".cs.S2C_Ancient_Invite.user_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_INVITE_ME, {
	"S2C_Ancient_Invite",
	".cs.S2C_Ancient_Invite",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_INVITE_RET_F,
		var_0_10.S2C_ANCIENT_INVITE_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_CONFIRMINVITE_TEAM_ID_F, {
	"team_id",
	".cs.C2S_Ancient_ConfirmInvite.team_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_CONFIRMINVITE_ACCEPT_F, {
	"accept",
	".cs.C2S_Ancient_ConfirmInvite.accept",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_CONFIRMINVITE_ME, {
	"C2S_Ancient_ConfirmInvite",
	".cs.C2S_Ancient_ConfirmInvite",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_CONFIRMINVITE_TEAM_ID_F,
		var_0_10.C2S_ANCIENT_CONFIRMINVITE_ACCEPT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_CONFIRMINVITE_RET_F, {
	"ret",
	".cs.S2C_Ancient_ConfirmInvite.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_CONFIRMINVITE_TEAM_ID_F, {
	"team_id",
	".cs.S2C_Ancient_ConfirmInvite.team_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_CONFIRMINVITE_ACCEPT_F, {
	"accept",
	".cs.S2C_Ancient_ConfirmInvite.accept",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_CONFIRMINVITE_ME, {
	"S2C_Ancient_ConfirmInvite",
	".cs.S2C_Ancient_ConfirmInvite",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_CONFIRMINVITE_RET_F,
		var_0_10.S2C_ANCIENT_CONFIRMINVITE_TEAM_ID_F,
		var_0_10.S2C_ANCIENT_CONFIRMINVITE_ACCEPT_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_QUITTEAM_ME, {
	"C2S_Ancient_QuitTeam",
	".cs.C2S_Ancient_QuitTeam",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_QUITTEAM_RET_F, {
	"ret",
	".cs.S2C_Ancient_QuitTeam.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_QUITTEAM_JOIN_TEAM_CD_TIME_F, {
	"join_team_cd_time",
	".cs.S2C_Ancient_QuitTeam.join_team_cd_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_QUITTEAM_TEAM_ID_F, {
	"team_id",
	".cs.S2C_Ancient_QuitTeam.team_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_QUITTEAM_ME, {
	"S2C_Ancient_QuitTeam",
	".cs.S2C_Ancient_QuitTeam",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_QUITTEAM_RET_F,
		var_0_10.S2C_ANCIENT_QUITTEAM_JOIN_TEAM_CD_TIME_F,
		var_0_10.S2C_ANCIENT_QUITTEAM_TEAM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_KICK_USER_ID_F, {
	"user_id",
	".cs.C2S_Ancient_Kick.user_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_KICK_ME, {
	"C2S_Ancient_Kick",
	".cs.C2S_Ancient_Kick",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_KICK_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_KICK_RET_F, {
	"ret",
	".cs.S2C_Ancient_Kick.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_KICK_USER_ID_F, {
	"user_id",
	".cs.S2C_Ancient_Kick.user_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_KICK_ME, {
	"S2C_Ancient_Kick",
	".cs.S2C_Ancient_Kick",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_KICK_RET_F,
		var_0_10.S2C_ANCIENT_KICK_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_SETTING_OPERATE_TYPE_F, {
	"operate_type",
	".cs.C2S_Ancient_Setting.operate_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_SETTING_IS_CONFIRM_F, {
	"is_confirm",
	".cs.C2S_Ancient_Setting.is_confirm",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_SETTING_ANCIENT_PET_ID_F, {
	"ancient_pet_id",
	".cs.C2S_Ancient_Setting.ancient_pet_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_SETTING_APPLY_LEVEL_F, {
	"apply_level",
	".cs.C2S_Ancient_Setting.apply_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_SETTING_LABEL_F, {
	"label",
	".cs.C2S_Ancient_Setting.label",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_SETTING_BAN_FIGHT_USER_F, {
	"ban_fight_user",
	".cs.C2S_Ancient_Setting.ban_fight_user",
	6,
	5,
	3,
	false,
	{},
	var_0_3.K64VBOOL_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_SETTING_ME, {
	"C2S_Ancient_Setting",
	".cs.C2S_Ancient_Setting",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_SETTING_OPERATE_TYPE_F,
		var_0_10.C2S_ANCIENT_SETTING_IS_CONFIRM_F,
		var_0_10.C2S_ANCIENT_SETTING_ANCIENT_PET_ID_F,
		var_0_10.C2S_ANCIENT_SETTING_APPLY_LEVEL_F,
		var_0_10.C2S_ANCIENT_SETTING_LABEL_F,
		var_0_10.C2S_ANCIENT_SETTING_BAN_FIGHT_USER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_SETTING_RET_F, {
	"ret",
	".cs.S2C_Ancient_Setting.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_SETTING_ME, {
	"S2C_Ancient_Setting",
	".cs.S2C_Ancient_Setting",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_SETTING_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_NOTIFYTEAMCHANGE_TEAM_F, {
	"team",
	".cs.S2C_Ancient_NotifyTeamChange.team",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.ANCIENTTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_NOTIFYTEAMCHANGE_ME, {
	"S2C_Ancient_NotifyTeamChange",
	".cs.S2C_Ancient_NotifyTeamChange",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_NOTIFYTEAMCHANGE_TEAM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_NOTIFYBEKICK_TEAM_ID_F, {
	"team_id",
	".cs.S2C_Ancient_NotifyBeKick.team_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_NOTIFYBEKICK_ME, {
	"S2C_Ancient_NotifyBeKick",
	".cs.S2C_Ancient_NotifyBeKick",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_NOTIFYBEKICK_TEAM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_NOTIFYINVITE_TEAMS_F, {
	"teams",
	".cs.S2C_Ancient_NotifyInvite.teams",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.ANCIENTSIMPLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_NOTIFYINVITE_ME, {
	"S2C_Ancient_NotifyInvite",
	".cs.S2C_Ancient_NotifyInvite",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_NOTIFYINVITE_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_GETINVITATIONLIST_ME, {
	"C2S_Ancient_GetInvitationList",
	".cs.C2S_Ancient_GetInvitationList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETINVITATIONLIST_RET_F, {
	"ret",
	".cs.S2C_Ancient_GetInvitationList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETINVITATIONLIST_TEAMS_F, {
	"teams",
	".cs.S2C_Ancient_GetInvitationList.teams",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ANCIENTSIMPLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_GETINVITATIONLIST_ME, {
	"S2C_Ancient_GetInvitationList",
	".cs.S2C_Ancient_GetInvitationList",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_GETINVITATIONLIST_RET_F,
		var_0_10.S2C_ANCIENT_GETINVITATIONLIST_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_NOTIFYDISBANDTEAM_ME, {
	"S2C_Ancient_NotifyDisbandTeam",
	".cs.S2C_Ancient_NotifyDisbandTeam",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_GETAPPLYLIST_ME, {
	"C2S_Ancient_GetApplyList",
	".cs.C2S_Ancient_GetApplyList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETAPPLYLIST_RET_F, {
	"ret",
	".cs.S2C_Ancient_GetApplyList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETAPPLYLIST_USERS_F, {
	"users",
	".cs.S2C_Ancient_GetApplyList.users",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ANCIENTSIMPLEUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_GETAPPLYLIST_ME, {
	"S2C_Ancient_GetApplyList",
	".cs.S2C_Ancient_GetApplyList",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_GETAPPLYLIST_RET_F,
		var_0_10.S2C_ANCIENT_GETAPPLYLIST_USERS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_CONFIRMAPPLY_USER_ID_F, {
	"user_id",
	".cs.C2S_Ancient_ConfirmApply.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_CONFIRMAPPLY_ACCEPT_F, {
	"accept",
	".cs.C2S_Ancient_ConfirmApply.accept",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_CONFIRMAPPLY_ME, {
	"C2S_Ancient_ConfirmApply",
	".cs.C2S_Ancient_ConfirmApply",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_CONFIRMAPPLY_USER_ID_F,
		var_0_10.C2S_ANCIENT_CONFIRMAPPLY_ACCEPT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_CONFIRMAPPLY_RET_F, {
	"ret",
	".cs.S2C_Ancient_ConfirmApply.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_CONFIRMAPPLY_USER_ID_F, {
	"user_id",
	".cs.S2C_Ancient_ConfirmApply.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_CONFIRMAPPLY_ACCEPT_F, {
	"accept",
	".cs.S2C_Ancient_ConfirmApply.accept",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_CONFIRMAPPLY_ME, {
	"S2C_Ancient_ConfirmApply",
	".cs.S2C_Ancient_ConfirmApply",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_CONFIRMAPPLY_RET_F,
		var_0_10.S2C_ANCIENT_CONFIRMAPPLY_USER_ID_F,
		var_0_10.S2C_ANCIENT_CONFIRMAPPLY_ACCEPT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_RECOMMENDTEAM_TP_F, {
	"tp",
	".cs.C2S_Ancient_RecommendTeam.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_RECOMMENDTEAM_PAGE_F, {
	"page",
	".cs.C2S_Ancient_RecommendTeam.page",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_RECOMMENDTEAM_ME, {
	"C2S_Ancient_RecommendTeam",
	".cs.C2S_Ancient_RecommendTeam",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_RECOMMENDTEAM_TP_F,
		var_0_10.C2S_ANCIENT_RECOMMENDTEAM_PAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_RECOMMENDTEAM_RET_F, {
	"ret",
	".cs.S2C_Ancient_RecommendTeam.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_RECOMMENDTEAM_TEAMS_F, {
	"teams",
	".cs.S2C_Ancient_RecommendTeam.teams",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ANCIENTSIMPLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_RECOMMENDTEAM_TP_F, {
	"tp",
	".cs.S2C_Ancient_RecommendTeam.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_RECOMMENDTEAM_PAGE_F, {
	"page",
	".cs.S2C_Ancient_RecommendTeam.page",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_RECOMMENDTEAM_TOTAL_F, {
	"total",
	".cs.S2C_Ancient_RecommendTeam.total",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_RECOMMENDTEAM_ME, {
	"S2C_Ancient_RecommendTeam",
	".cs.S2C_Ancient_RecommendTeam",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_RECOMMENDTEAM_RET_F,
		var_0_10.S2C_ANCIENT_RECOMMENDTEAM_TEAMS_F,
		var_0_10.S2C_ANCIENT_RECOMMENDTEAM_TP_F,
		var_0_10.S2C_ANCIENT_RECOMMENDTEAM_PAGE_F,
		var_0_10.S2C_ANCIENT_RECOMMENDTEAM_TOTAL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_DELETEAPPLY_TEAM_ID_F, {
	"team_id",
	".cs.C2S_Ancient_DeleteApply.team_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_DELETEAPPLY_ME, {
	"C2S_Ancient_DeleteApply",
	".cs.C2S_Ancient_DeleteApply",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_DELETEAPPLY_TEAM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_DELETEAPPLY_RET_F, {
	"ret",
	".cs.S2C_Ancient_DeleteApply.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_DELETEAPPLY_TEAM_ID_F, {
	"team_id",
	".cs.S2C_Ancient_DeleteApply.team_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_DELETEAPPLY_ME, {
	"S2C_Ancient_DeleteApply",
	".cs.S2C_Ancient_DeleteApply",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_DELETEAPPLY_RET_F,
		var_0_10.S2C_ANCIENT_DELETEAPPLY_TEAM_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_GETAPPLYRECORD_ME, {
	"C2S_Ancient_GetApplyRecord",
	".cs.C2S_Ancient_GetApplyRecord",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETAPPLYRECORD_RET_F, {
	"ret",
	".cs.S2C_Ancient_GetApplyRecord.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETAPPLYRECORD_TEAMS_F, {
	"teams",
	".cs.S2C_Ancient_GetApplyRecord.teams",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ANCIENTSIMPLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_GETAPPLYRECORD_ME, {
	"S2C_Ancient_GetApplyRecord",
	".cs.S2C_Ancient_GetApplyRecord",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_GETAPPLYRECORD_RET_F,
		var_0_10.S2C_ANCIENT_GETAPPLYRECORD_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_GETTEAMINFO_TEAM_ID_F, {
	"team_id",
	".cs.C2S_Ancient_GetTeamInfo.team_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_GETTEAMINFO_ME, {
	"C2S_Ancient_GetTeamInfo",
	".cs.C2S_Ancient_GetTeamInfo",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_GETTEAMINFO_TEAM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETTEAMINFO_RET_F, {
	"ret",
	".cs.S2C_Ancient_GetTeamInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETTEAMINFO_TEAM_F, {
	"team",
	".cs.S2C_Ancient_GetTeamInfo.team",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.ANCIENTTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETTEAMINFO_IS_APPLY_F, {
	"is_apply",
	".cs.S2C_Ancient_GetTeamInfo.is_apply",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_GETTEAMINFO_ME, {
	"S2C_Ancient_GetTeamInfo",
	".cs.S2C_Ancient_GetTeamInfo",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_GETTEAMINFO_RET_F,
		var_0_10.S2C_ANCIENT_GETTEAMINFO_TEAM_F,
		var_0_10.S2C_ANCIENT_GETTEAMINFO_IS_APPLY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_SEARCH_CONTENT_F, {
	"content",
	".cs.C2S_Ancient_Search.content",
	1,
	0,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_SEARCH_ME, {
	"C2S_Ancient_Search",
	".cs.C2S_Ancient_Search",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_SEARCH_CONTENT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_SEARCH_RET_F, {
	"ret",
	".cs.S2C_Ancient_Search.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_SEARCH_CONTENT_F, {
	"content",
	".cs.S2C_Ancient_Search.content",
	2,
	1,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_SEARCH_TEAMS_F, {
	"teams",
	".cs.S2C_Ancient_Search.teams",
	3,
	2,
	3,
	false,
	{},
	var_0_3.ANCIENTSIMPLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_SEARCH_ME, {
	"S2C_Ancient_Search",
	".cs.S2C_Ancient_Search",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_SEARCH_RET_F,
		var_0_10.S2C_ANCIENT_SEARCH_CONTENT_F,
		var_0_10.S2C_ANCIENT_SEARCH_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_GETUSERLIST_USER_IDS_F, {
	"user_ids",
	".cs.C2S_Ancient_GetUserList.user_ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_GETUSERLIST_ME, {
	"C2S_Ancient_GetUserList",
	".cs.C2S_Ancient_GetUserList",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_GETUSERLIST_USER_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETUSERLIST_RET_F, {
	"ret",
	".cs.S2C_Ancient_GetUserList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETUSERLIST_USERS_F, {
	"users",
	".cs.S2C_Ancient_GetUserList.users",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ANCIENTSIMPLEUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_GETUSERLIST_ME, {
	"S2C_Ancient_GetUserList",
	".cs.S2C_Ancient_GetUserList",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_GETUSERLIST_RET_F,
		var_0_10.S2C_ANCIENT_GETUSERLIST_USERS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_GETMESSAGEBOARD_ME, {
	"C2S_Ancient_GetMessageBoard",
	".cs.C2S_Ancient_GetMessageBoard",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETMESSAGEBOARD_RET_F, {
	"ret",
	".cs.S2C_Ancient_GetMessageBoard.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETMESSAGEBOARD_MESSAGES_F, {
	"messages",
	".cs.S2C_Ancient_GetMessageBoard.messages",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ANCIENTMESSAGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETMESSAGEBOARD_DAILY_ADD_MESSAGE_NUM_F, {
	"daily_add_message_num",
	".cs.S2C_Ancient_GetMessageBoard.daily_add_message_num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_GETMESSAGEBOARD_ME, {
	"S2C_Ancient_GetMessageBoard",
	".cs.S2C_Ancient_GetMessageBoard",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_GETMESSAGEBOARD_RET_F,
		var_0_10.S2C_ANCIENT_GETMESSAGEBOARD_MESSAGES_F,
		var_0_10.S2C_ANCIENT_GETMESSAGEBOARD_DAILY_ADD_MESSAGE_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_ADDMESSAGE_CONTENT_F, {
	"content",
	".cs.C2S_Ancient_AddMessage.content",
	1,
	0,
	2,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_ADDMESSAGE_ME, {
	"C2S_Ancient_AddMessage",
	".cs.C2S_Ancient_AddMessage",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_ADDMESSAGE_CONTENT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ADDMESSAGE_RET_F, {
	"ret",
	".cs.S2C_Ancient_AddMessage.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ADDMESSAGE_MESSAGE_F, {
	"message",
	".cs.S2C_Ancient_AddMessage.message",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.ANCIENTMESSAGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ADDMESSAGE_DAILY_ADD_MESSAGE_NUM_F, {
	"daily_add_message_num",
	".cs.S2C_Ancient_AddMessage.daily_add_message_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ADDMESSAGE_DEL_ID_F, {
	"del_id",
	".cs.S2C_Ancient_AddMessage.del_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_ADDMESSAGE_ME, {
	"S2C_Ancient_AddMessage",
	".cs.S2C_Ancient_AddMessage",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_ADDMESSAGE_RET_F,
		var_0_10.S2C_ANCIENT_ADDMESSAGE_MESSAGE_F,
		var_0_10.S2C_ANCIENT_ADDMESSAGE_DAILY_ADD_MESSAGE_NUM_F,
		var_0_10.S2C_ANCIENT_ADDMESSAGE_DEL_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_OPERATEMESSAGE_ID_F, {
	"id",
	".cs.C2S_Ancient_OperateMessage.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_OPERATEMESSAGE_TP_F, {
	"tp",
	".cs.C2S_Ancient_OperateMessage.tp",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_OPERATEMESSAGE_ME, {
	"C2S_Ancient_OperateMessage",
	".cs.C2S_Ancient_OperateMessage",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_OPERATEMESSAGE_ID_F,
		var_0_10.C2S_ANCIENT_OPERATEMESSAGE_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_OPERATEMESSAGE_RET_F, {
	"ret",
	".cs.S2C_Ancient_OperateMessage.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_OPERATEMESSAGE_ID_F, {
	"id",
	".cs.S2C_Ancient_OperateMessage.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_OPERATEMESSAGE_TP_F, {
	"tp",
	".cs.S2C_Ancient_OperateMessage.tp",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_OPERATEMESSAGE_ME, {
	"S2C_Ancient_OperateMessage",
	".cs.S2C_Ancient_OperateMessage",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_OPERATEMESSAGE_RET_F,
		var_0_10.S2C_ANCIENT_OPERATEMESSAGE_ID_F,
		var_0_10.S2C_ANCIENT_OPERATEMESSAGE_TP_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_OPERATESTART_ME, {
	"C2S_Ancient_OperateStart",
	".cs.C2S_Ancient_OperateStart",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_OPERATESTART_RET_F, {
	"ret",
	".cs.S2C_Ancient_OperateStart.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_OPERATESTART_ME, {
	"S2C_Ancient_OperateStart",
	".cs.S2C_Ancient_OperateStart",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_OPERATESTART_RET_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_OPERATEEND_ME, {
	"C2S_Ancient_OperateEnd",
	".cs.C2S_Ancient_OperateEnd",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_OPERATEEND_RET_F, {
	"ret",
	".cs.S2C_Ancient_OperateEnd.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_OPERATEEND_ME, {
	"S2C_Ancient_OperateEnd",
	".cs.S2C_Ancient_OperateEnd",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_OPERATEEND_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_OPERATENOTIFY_OPERATE_F, {
	"operate",
	".cs.S2C_Ancient_OperateNotify.operate",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.ANCIENTOPERATE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_OPERATENOTIFY_ME, {
	"S2C_Ancient_OperateNotify",
	".cs.S2C_Ancient_OperateNotify",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_OPERATENOTIFY_OPERATE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_FORMATION_ORIGIN_POS_F, {
	"origin_pos",
	".cs.C2S_Ancient_Formation.origin_pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_FORMATION_TARGET_POS_F, {
	"target_pos",
	".cs.C2S_Ancient_Formation.target_pos",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_FORMATION_ME, {
	"C2S_Ancient_Formation",
	".cs.C2S_Ancient_Formation",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_FORMATION_ORIGIN_POS_F,
		var_0_10.C2S_ANCIENT_FORMATION_TARGET_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_FORMATION_RET_F, {
	"ret",
	".cs.S2C_Ancient_Formation.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_FORMATION_ORIGIN_POS_F, {
	"origin_pos",
	".cs.S2C_Ancient_Formation.origin_pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_FORMATION_TARGET_POS_F, {
	"target_pos",
	".cs.S2C_Ancient_Formation.target_pos",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_FORMATION_ME, {
	"S2C_Ancient_Formation",
	".cs.S2C_Ancient_Formation",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_FORMATION_RET_F,
		var_0_10.S2C_ANCIENT_FORMATION_ORIGIN_POS_F,
		var_0_10.S2C_ANCIENT_FORMATION_TARGET_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_FORMATIONNOTIFY_FORMATION_POSITIONS_F, {
	"formation_positions",
	".cs.S2C_Ancient_FormationNotify.formation_positions",
	1,
	0,
	3,
	false,
	{},
	var_0_3.ANCIENTFORMATIONPOSITION_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_FORMATIONNOTIFY_ME, {
	"S2C_Ancient_FormationNotify",
	".cs.S2C_Ancient_FormationNotify",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_FORMATIONNOTIFY_FORMATION_POSITIONS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_LOOTINFO_ME, {
	"C2S_Ancient_LootInfo",
	".cs.C2S_Ancient_LootInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_LOOTINFO_RET_F, {
	"ret",
	".cs.S2C_Ancient_LootInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_LOOTINFO_DICE_NUM_F, {
	"dice_num",
	".cs.S2C_Ancient_LootInfo.dice_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_LOOTINFO_LOOTS_F, {
	"loots",
	".cs.S2C_Ancient_LootInfo.loots",
	3,
	2,
	3,
	false,
	{},
	var_0_3.ANCIENTLOOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_LOOTINFO_ME, {
	"S2C_Ancient_LootInfo",
	".cs.S2C_Ancient_LootInfo",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_LOOTINFO_RET_F,
		var_0_10.S2C_ANCIENT_LOOTINFO_DICE_NUM_F,
		var_0_10.S2C_ANCIENT_LOOTINFO_LOOTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_DICEROLL_SCORE_DAY_F, {
	"score_day",
	".cs.C2S_Ancient_DiceRoll.score_day",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_DICEROLL_ID_F, {
	"id",
	".cs.C2S_Ancient_DiceRoll.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_DICEROLL_ME, {
	"C2S_Ancient_DiceRoll",
	".cs.C2S_Ancient_DiceRoll",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_DICEROLL_SCORE_DAY_F,
		var_0_10.C2S_ANCIENT_DICEROLL_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_DICEROLL_RET_F, {
	"ret",
	".cs.S2C_Ancient_DiceRoll.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_DICEROLL_SCORE_DAY_F, {
	"score_day",
	".cs.S2C_Ancient_DiceRoll.score_day",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_DICEROLL_ID_F, {
	"id",
	".cs.S2C_Ancient_DiceRoll.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_DICEROLL_DICE_NUM_F, {
	"dice_num",
	".cs.S2C_Ancient_DiceRoll.dice_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_DICEROLL_POINTS_F, {
	"points",
	".cs.S2C_Ancient_DiceRoll.points",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_DICEROLL_ME, {
	"S2C_Ancient_DiceRoll",
	".cs.S2C_Ancient_DiceRoll",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_DICEROLL_RET_F,
		var_0_10.S2C_ANCIENT_DICEROLL_SCORE_DAY_F,
		var_0_10.S2C_ANCIENT_DICEROLL_ID_F,
		var_0_10.S2C_ANCIENT_DICEROLL_DICE_NUM_F,
		var_0_10.S2C_ANCIENT_DICEROLL_POINTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_DICEGIVEUP_SCORE_DAY_F, {
	"score_day",
	".cs.C2S_Ancient_DiceGiveUp.score_day",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_DICEGIVEUP_ID_F, {
	"id",
	".cs.C2S_Ancient_DiceGiveUp.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_DICEGIVEUP_ME, {
	"C2S_Ancient_DiceGiveUp",
	".cs.C2S_Ancient_DiceGiveUp",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_DICEGIVEUP_SCORE_DAY_F,
		var_0_10.C2S_ANCIENT_DICEGIVEUP_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_DICEGIVEUP_RET_F, {
	"ret",
	".cs.S2C_Ancient_DiceGiveUp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_DICEGIVEUP_SCORE_DAY_F, {
	"score_day",
	".cs.S2C_Ancient_DiceGiveUp.score_day",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_DICEGIVEUP_ID_F, {
	"id",
	".cs.S2C_Ancient_DiceGiveUp.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_DICEGIVEUP_ME, {
	"S2C_Ancient_DiceGiveUp",
	".cs.S2C_Ancient_DiceGiveUp",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_DICEGIVEUP_RET_F,
		var_0_10.S2C_ANCIENT_DICEGIVEUP_SCORE_DAY_F,
		var_0_10.S2C_ANCIENT_DICEGIVEUP_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_DICENOTIFY_SCORE_DAY_F, {
	"score_day",
	".cs.S2C_Ancient_DiceNotify.score_day",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_DICENOTIFY_DICE_F, {
	"dice",
	".cs.S2C_Ancient_DiceNotify.dice",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.ANCIENTDICE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_DICENOTIFY_ME, {
	"S2C_Ancient_DiceNotify",
	".cs.S2C_Ancient_DiceNotify",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_DICENOTIFY_SCORE_DAY_F,
		var_0_10.S2C_ANCIENT_DICENOTIFY_DICE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_GETRANKLIST_LIMIT_F, {
	"limit",
	".cs.C2S_Ancient_GetRankList.limit",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_GETRANKLIST_ME, {
	"C2S_Ancient_GetRankList",
	".cs.C2S_Ancient_GetRankList",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_GETRANKLIST_LIMIT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETRANKLIST_RET_F, {
	"ret",
	".cs.S2C_Ancient_GetRankList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETRANKLIST_LIMIT_F, {
	"limit",
	".cs.S2C_Ancient_GetRankList.limit",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETRANKLIST_SELF_RANK_F, {
	"self_rank",
	".cs.S2C_Ancient_GetRankList.self_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETRANKLIST_RANK_UNITS_F, {
	"rank_units",
	".cs.S2C_Ancient_GetRankList.rank_units",
	4,
	3,
	3,
	false,
	{},
	var_0_3.RANKUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_GETRANKLIST_ME, {
	"S2C_Ancient_GetRankList",
	".cs.S2C_Ancient_GetRankList",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_GETRANKLIST_RET_F,
		var_0_10.S2C_ANCIENT_GETRANKLIST_LIMIT_F,
		var_0_10.S2C_ANCIENT_GETRANKLIST_SELF_RANK_F,
		var_0_10.S2C_ANCIENT_GETRANKLIST_RANK_UNITS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_MATCH_ME, {
	"C2S_Ancient_Match",
	".cs.C2S_Ancient_Match",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_MATCH_RET_F, {
	"ret",
	".cs.S2C_Ancient_Match.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_MATCH_OPPONENT_TEAM_F, {
	"opponent_team",
	".cs.S2C_Ancient_Match.opponent_team",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.ANCIENTTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_MATCH_ME, {
	"S2C_Ancient_Match",
	".cs.S2C_Ancient_Match",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_MATCH_RET_F,
		var_0_10.S2C_ANCIENT_MATCH_OPPONENT_TEAM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_BATTLESTART_ME, {
	"C2S_Ancient_BattleStart",
	".cs.C2S_Ancient_BattleStart",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_BATTLESTART_RET_F, {
	"ret",
	".cs.S2C_Ancient_BattleStart.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_BATTLESTART_ME, {
	"S2C_Ancient_BattleStart",
	".cs.S2C_Ancient_BattleStart",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_BATTLESTART_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_BATTLETURNNOTIFY_TURNS_F, {
	"turns",
	".cs.S2C_Ancient_BattleTurnNotify.turns",
	1,
	0,
	3,
	false,
	{},
	var_0_3.ANCIENTBATTLETURN_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_BATTLETURNNOTIFY_ME, {
	"S2C_Ancient_BattleTurnNotify",
	".cs.S2C_Ancient_BattleTurnNotify",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_BATTLETURNNOTIFY_TURNS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_BATTLEENDNOTIFY_LOOT_EXP_F, {
	"loot_exp",
	".cs.S2C_Ancient_BattleEndNotify.loot_exp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_BATTLEENDNOTIFY_IS_WIN_F, {
	"is_win",
	".cs.S2C_Ancient_BattleEndNotify.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_BATTLEENDNOTIFY_SETTLES_F, {
	"settles",
	".cs.S2C_Ancient_BattleEndNotify.settles",
	3,
	2,
	3,
	false,
	{},
	var_0_3.ANCIENTBATTLESETTLE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_BATTLEENDNOTIFY_ME, {
	"S2C_Ancient_BattleEndNotify",
	".cs.S2C_Ancient_BattleEndNotify",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_BATTLEENDNOTIFY_LOOT_EXP_F,
		var_0_10.S2C_ANCIENT_BATTLEENDNOTIFY_IS_WIN_F,
		var_0_10.S2C_ANCIENT_BATTLEENDNOTIFY_SETTLES_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_BATTLESPECTATE_ME, {
	"C2S_Ancient_BattleSpectate",
	".cs.C2S_Ancient_BattleSpectate",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_BATTLESPECTATE_RET_F, {
	"ret",
	".cs.S2C_Ancient_BattleSpectate.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_BATTLESPECTATE_OPPONENT_TEAM_F, {
	"opponent_team",
	".cs.S2C_Ancient_BattleSpectate.opponent_team",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.ANCIENTTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_BATTLESPECTATE_TURNS_F, {
	"turns",
	".cs.S2C_Ancient_BattleSpectate.turns",
	3,
	2,
	3,
	false,
	{},
	var_0_3.ANCIENTBATTLETURN_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_BATTLESPECTATE_ME, {
	"S2C_Ancient_BattleSpectate",
	".cs.S2C_Ancient_BattleSpectate",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_BATTLESPECTATE_RET_F,
		var_0_10.S2C_ANCIENT_BATTLESPECTATE_OPPONENT_TEAM_F,
		var_0_10.S2C_ANCIENT_BATTLESPECTATE_TURNS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_BATTLEREPORTS_ME, {
	"C2S_Ancient_BattleReports",
	".cs.C2S_Ancient_BattleReports",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_BATTLEREPORTS_RET_F, {
	"ret",
	".cs.S2C_Ancient_BattleReports.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_BATTLEREPORTS_TEAM_BATTLE_TIMES_F, {
	"team_battle_times",
	".cs.S2C_Ancient_BattleReports.team_battle_times",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_BATTLEREPORTS_TEAM_WIN_RATE_F, {
	"team_win_rate",
	".cs.S2C_Ancient_BattleReports.team_win_rate",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_BATTLEREPORTS_SELF_KILL_F, {
	"self_kill",
	".cs.S2C_Ancient_BattleReports.self_kill",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_BATTLEREPORTS_SELF_SCORE_F, {
	"self_score",
	".cs.S2C_Ancient_BattleReports.self_score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_BATTLEREPORTS_REPORTS_F, {
	"reports",
	".cs.S2C_Ancient_BattleReports.reports",
	6,
	5,
	3,
	false,
	{},
	var_0_3.ANCIENTBATTLEREPORT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_BATTLEREPORTS_ME, {
	"S2C_Ancient_BattleReports",
	".cs.S2C_Ancient_BattleReports",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_BATTLEREPORTS_RET_F,
		var_0_10.S2C_ANCIENT_BATTLEREPORTS_TEAM_BATTLE_TIMES_F,
		var_0_10.S2C_ANCIENT_BATTLEREPORTS_TEAM_WIN_RATE_F,
		var_0_10.S2C_ANCIENT_BATTLEREPORTS_SELF_KILL_F,
		var_0_10.S2C_ANCIENT_BATTLEREPORTS_SELF_SCORE_F,
		var_0_10.S2C_ANCIENT_BATTLEREPORTS_REPORTS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_FINALMATCH_ME, {
	"C2S_Ancient_FinalMatch",
	".cs.C2S_Ancient_FinalMatch",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_FINALMATCH_RET_F, {
	"ret",
	".cs.S2C_Ancient_FinalMatch.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_FINALMATCH_OPPONENT_TEAM_F, {
	"opponent_team",
	".cs.S2C_Ancient_FinalMatch.opponent_team",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.ANCIENTTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_FINALMATCH_ME, {
	"S2C_Ancient_FinalMatch",
	".cs.S2C_Ancient_FinalMatch",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_FINALMATCH_RET_F,
		var_0_10.S2C_ANCIENT_FINALMATCH_OPPONENT_TEAM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_FINALFORMATION_ORIGIN_POS_F, {
	"origin_pos",
	".cs.C2S_Ancient_FinalFormation.origin_pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_FINALFORMATION_TARGET_POS_F, {
	"target_pos",
	".cs.C2S_Ancient_FinalFormation.target_pos",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_FINALFORMATION_ME, {
	"C2S_Ancient_FinalFormation",
	".cs.C2S_Ancient_FinalFormation",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_FINALFORMATION_ORIGIN_POS_F,
		var_0_10.C2S_ANCIENT_FINALFORMATION_TARGET_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_FINALFORMATION_RET_F, {
	"ret",
	".cs.S2C_Ancient_FinalFormation.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_FINALFORMATION_ORIGIN_POS_F, {
	"origin_pos",
	".cs.S2C_Ancient_FinalFormation.origin_pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_FINALFORMATION_TARGET_POS_F, {
	"target_pos",
	".cs.S2C_Ancient_FinalFormation.target_pos",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_FINALFORMATION_ME, {
	"S2C_Ancient_FinalFormation",
	".cs.S2C_Ancient_FinalFormation",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_FINALFORMATION_RET_F,
		var_0_10.S2C_ANCIENT_FINALFORMATION_ORIGIN_POS_F,
		var_0_10.S2C_ANCIENT_FINALFORMATION_TARGET_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_FINALFORMATIONNOTIFY_FORMATION_POSITIONS_F, {
	"formation_positions",
	".cs.S2C_Ancient_FinalFormationNotify.formation_positions",
	1,
	0,
	3,
	false,
	{},
	var_0_3.ANCIENTFORMATIONPOSITION_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_FINALFORMATIONNOTIFY_ME, {
	"S2C_Ancient_FinalFormationNotify",
	".cs.S2C_Ancient_FinalFormationNotify",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_FINALFORMATIONNOTIFY_FORMATION_POSITIONS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_GUESSINFO_ME, {
	"C2S_Ancient_GuessInfo",
	".cs.C2S_Ancient_GuessInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GUESSINFO_RET_F, {
	"ret",
	".cs.S2C_Ancient_GuessInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GUESSINFO_GUESSES_F, {
	"guesses",
	".cs.S2C_Ancient_GuessInfo.guesses",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ANCIENTGUESS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_GUESSINFO_ME, {
	"S2C_Ancient_GuessInfo",
	".cs.S2C_Ancient_GuessInfo",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_GUESSINFO_RET_F,
		var_0_10.S2C_ANCIENT_GUESSINFO_GUESSES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ROUNDNOTIFY_GUESSES_F, {
	"guesses",
	".cs.S2C_Ancient_RoundNotify.guesses",
	1,
	0,
	3,
	false,
	{},
	var_0_3.ANCIENTGUESS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ROUNDNOTIFY_ROUND_TEAMS_F, {
	"round_teams",
	".cs.S2C_Ancient_RoundNotify.round_teams",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ANCIENTROUNDTEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_ROUNDNOTIFY_ME, {
	"S2C_Ancient_RoundNotify",
	".cs.S2C_Ancient_RoundNotify",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_ROUNDNOTIFY_GUESSES_F,
		var_0_10.S2C_ANCIENT_ROUNDNOTIFY_ROUND_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_GUESS_ROUND_F, {
	"round",
	".cs.C2S_Ancient_Guess.round",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_GUESS_NUM_F, {
	"num",
	".cs.C2S_Ancient_Guess.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_GUESS_TEAM_ID_F, {
	"team_id",
	".cs.C2S_Ancient_Guess.team_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_GUESS_ME, {
	"C2S_Ancient_Guess",
	".cs.C2S_Ancient_Guess",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_GUESS_ROUND_F,
		var_0_10.C2S_ANCIENT_GUESS_NUM_F,
		var_0_10.C2S_ANCIENT_GUESS_TEAM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GUESS_RET_F, {
	"ret",
	".cs.S2C_Ancient_Guess.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GUESS_ROUND_F, {
	"round",
	".cs.S2C_Ancient_Guess.round",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GUESS_NUM_F, {
	"num",
	".cs.S2C_Ancient_Guess.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GUESS_TEAM_ID_F, {
	"team_id",
	".cs.S2C_Ancient_Guess.team_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GUESS_GUESS_F, {
	"guess",
	".cs.S2C_Ancient_Guess.guess",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.ANCIENTGUESS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_GUESS_ME, {
	"S2C_Ancient_Guess",
	".cs.S2C_Ancient_Guess",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_GUESS_RET_F,
		var_0_10.S2C_ANCIENT_GUESS_ROUND_F,
		var_0_10.S2C_ANCIENT_GUESS_NUM_F,
		var_0_10.S2C_ANCIENT_GUESS_TEAM_ID_F,
		var_0_10.S2C_ANCIENT_GUESS_GUESS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_GUESSAWARD_ROUND_F, {
	"round",
	".cs.C2S_Ancient_GuessAward.round",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_GUESSAWARD_NUM_F, {
	"num",
	".cs.C2S_Ancient_GuessAward.num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_GUESSAWARD_ME, {
	"C2S_Ancient_GuessAward",
	".cs.C2S_Ancient_GuessAward",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_GUESSAWARD_ROUND_F,
		var_0_10.C2S_ANCIENT_GUESSAWARD_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GUESSAWARD_RET_F, {
	"ret",
	".cs.S2C_Ancient_GuessAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GUESSAWARD_ROUND_F, {
	"round",
	".cs.S2C_Ancient_GuessAward.round",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GUESSAWARD_NUM_F, {
	"num",
	".cs.S2C_Ancient_GuessAward.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GUESSAWARD_GUESS_F, {
	"guess",
	".cs.S2C_Ancient_GuessAward.guess",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.ANCIENTGUESS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GUESSAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Ancient_GuessAward.awards",
	5,
	4,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_GUESSAWARD_ME, {
	"S2C_Ancient_GuessAward",
	".cs.S2C_Ancient_GuessAward",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_GUESSAWARD_RET_F,
		var_0_10.S2C_ANCIENT_GUESSAWARD_ROUND_F,
		var_0_10.S2C_ANCIENT_GUESSAWARD_NUM_F,
		var_0_10.S2C_ANCIENT_GUESSAWARD_GUESS_F,
		var_0_10.S2C_ANCIENT_GUESSAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_FINALBATTLEREPORT_ROUND_F, {
	"round",
	".cs.C2S_Ancient_FinalBattleReport.round",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_FINALBATTLEREPORT_NUM_F, {
	"num",
	".cs.C2S_Ancient_FinalBattleReport.num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_FINALBATTLEREPORT_ME, {
	"C2S_Ancient_FinalBattleReport",
	".cs.C2S_Ancient_FinalBattleReport",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_FINALBATTLEREPORT_ROUND_F,
		var_0_10.C2S_ANCIENT_FINALBATTLEREPORT_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_FINALBATTLEREPORT_RET_F, {
	"ret",
	".cs.S2C_Ancient_FinalBattleReport.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_FINALBATTLEREPORT_ROUND_F, {
	"round",
	".cs.S2C_Ancient_FinalBattleReport.round",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_FINALBATTLEREPORT_NUM_F, {
	"num",
	".cs.S2C_Ancient_FinalBattleReport.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_FINALBATTLEREPORT_REPORT_F, {
	"report",
	".cs.S2C_Ancient_FinalBattleReport.report",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.ANCIENTFINALBATTLEREPORT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_FINALBATTLEREPORT_ME, {
	"S2C_Ancient_FinalBattleReport",
	".cs.S2C_Ancient_FinalBattleReport",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_FINALBATTLEREPORT_RET_F,
		var_0_10.S2C_ANCIENT_FINALBATTLEREPORT_ROUND_F,
		var_0_10.S2C_ANCIENT_FINALBATTLEREPORT_NUM_F,
		var_0_10.S2C_ANCIENT_FINALBATTLEREPORT_REPORT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_PETSETKNIGHT_IDX_F, {
	"idx",
	".cs.C2S_Ancient_PetSetKnight.idx",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_PETSETKNIGHT_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_Ancient_PetSetKnight.knight_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_PETSETKNIGHT_ME, {
	"C2S_Ancient_PetSetKnight",
	".cs.C2S_Ancient_PetSetKnight",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_PETSETKNIGHT_IDX_F,
		var_0_10.C2S_ANCIENT_PETSETKNIGHT_KNIGHT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_PETSETKNIGHT_RET_F, {
	"ret",
	".cs.S2C_Ancient_PetSetKnight.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_PETSETKNIGHT_IDX_F, {
	"idx",
	".cs.S2C_Ancient_PetSetKnight.idx",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_PETSETKNIGHT_KNIGHT_POS_F, {
	"knight_pos",
	".cs.S2C_Ancient_PetSetKnight.knight_pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_PETSETKNIGHT_PET_F, {
	"pet",
	".cs.S2C_Ancient_PetSetKnight.pet",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.ANCIENTPET_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_PETSETKNIGHT_ME, {
	"S2C_Ancient_PetSetKnight",
	".cs.S2C_Ancient_PetSetKnight",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_PETSETKNIGHT_RET_F,
		var_0_10.S2C_ANCIENT_PETSETKNIGHT_IDX_F,
		var_0_10.S2C_ANCIENT_PETSETKNIGHT_KNIGHT_POS_F,
		var_0_10.S2C_ANCIENT_PETSETKNIGHT_PET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_TASKNTF_TASKS_F, {
	"tasks",
	".cs.S2C_Ancient_TaskNtf.tasks",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_TASKNTF_ME, {
	"S2C_Ancient_TaskNtf",
	".cs.S2C_Ancient_TaskNtf",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_TASKNTF_TASKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_TASKAWARD_IDS_F, {
	"ids",
	".cs.C2S_Ancient_TaskAward.ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_TASKAWARD_ME, {
	"C2S_Ancient_TaskAward",
	".cs.C2S_Ancient_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_TASKAWARD_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_Ancient_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_TASKAWARD_IDS_F, {
	"ids",
	".cs.S2C_Ancient_TaskAward.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Ancient_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_TASKAWARD_ME, {
	"S2C_Ancient_TaskAward",
	".cs.S2C_Ancient_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_TASKAWARD_RET_F,
		var_0_10.S2C_ANCIENT_TASKAWARD_IDS_F,
		var_0_10.S2C_ANCIENT_TASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_ACTIVEAWARD_IDS_F, {
	"ids",
	".cs.C2S_Ancient_ActiveAward.ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_ACTIVEAWARD_ME, {
	"C2S_Ancient_ActiveAward",
	".cs.C2S_Ancient_ActiveAward",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_ACTIVEAWARD_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ACTIVEAWARD_RET_F, {
	"ret",
	".cs.S2C_Ancient_ActiveAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ACTIVEAWARD_IDS_F, {
	"ids",
	".cs.S2C_Ancient_ActiveAward.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_ACTIVEAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Ancient_ActiveAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_ACTIVEAWARD_ME, {
	"S2C_Ancient_ActiveAward",
	".cs.S2C_Ancient_ActiveAward",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_ACTIVEAWARD_RET_F,
		var_0_10.S2C_ANCIENT_ACTIVEAWARD_IDS_F,
		var_0_10.S2C_ANCIENT_ACTIVEAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_TEAMTASKNTF_TASKS_F, {
	"tasks",
	".cs.S2C_Ancient_TeamTaskNtf.tasks",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_TEAMTASKNTF_PET_F, {
	"pet",
	".cs.S2C_Ancient_TeamTaskNtf.pet",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.ANCIENTPET_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_TEAMTASKNTF_ACTIVE_VALUE_F, {
	"active_value",
	".cs.S2C_Ancient_TeamTaskNtf.active_value",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_TEAMTASKNTF_ACTIVE_AWARDED_IDS_F, {
	"active_awarded_ids",
	".cs.S2C_Ancient_TeamTaskNtf.active_awarded_ids",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_TEAMTASKNTF_ME, {
	"S2C_Ancient_TeamTaskNtf",
	".cs.S2C_Ancient_TeamTaskNtf",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_TEAMTASKNTF_TASKS_F,
		var_0_10.S2C_ANCIENT_TEAMTASKNTF_PET_F,
		var_0_10.S2C_ANCIENT_TEAMTASKNTF_ACTIVE_VALUE_F,
		var_0_10.S2C_ANCIENT_TEAMTASKNTF_ACTIVE_AWARDED_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ANCIENT_BUYFIGHTTIMES_COUNT_F, {
	"count",
	".cs.C2S_Ancient_BuyFightTimes.count",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_BUYFIGHTTIMES_ME, {
	"C2S_Ancient_BuyFightTimes",
	".cs.C2S_Ancient_BuyFightTimes",
	{},
	{},
	{
		var_0_10.C2S_ANCIENT_BUYFIGHTTIMES_COUNT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_BUYFIGHTTIMES_RET_F, {
	"ret",
	".cs.S2C_Ancient_BuyFightTimes.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_BUYFIGHTTIMES_COUNT_F, {
	"count",
	".cs.S2C_Ancient_BuyFightTimes.count",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_BUYFIGHTTIMES_ME, {
	"S2C_Ancient_BuyFightTimes",
	".cs.S2C_Ancient_BuyFightTimes",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_BUYFIGHTTIMES_RET_F,
		var_0_10.S2C_ANCIENT_BUYFIGHTTIMES_COUNT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_FIGHTTIMESNTF_TIMES_F, {
	"times",
	".cs.S2C_Ancient_FightTimesNtf.times",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_FIGHTTIMESNTF_LEFT_COUNT_F, {
	"left_count",
	".cs.S2C_Ancient_FightTimesNtf.left_count",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_FIGHTTIMESNTF_ME, {
	"S2C_Ancient_FightTimesNtf",
	".cs.S2C_Ancient_FightTimesNtf",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_FIGHTTIMESNTF_TIMES_F,
		var_0_10.S2C_ANCIENT_FIGHTTIMESNTF_LEFT_COUNT_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_GETFINALTEAMLIST_ME, {
	"C2S_Ancient_GetFinalTeamList",
	".cs.C2S_Ancient_GetFinalTeamList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETFINALTEAMLIST_RET_F, {
	"ret",
	".cs.S2C_Ancient_GetFinalTeamList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETFINALTEAMLIST_TEAMS_F, {
	"teams",
	".cs.S2C_Ancient_GetFinalTeamList.teams",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ANCIENTSIMPLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_GETFINALTEAMLIST_ME, {
	"S2C_Ancient_GetFinalTeamList",
	".cs.S2C_Ancient_GetFinalTeamList",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_GETFINALTEAMLIST_RET_F,
		var_0_10.S2C_ANCIENT_GETFINALTEAMLIST_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_GETFINALUSERLIST_ME, {
	"C2S_Ancient_GetFinalUserList",
	".cs.C2S_Ancient_GetFinalUserList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETFINALUSERLIST_RET_F, {
	"ret",
	".cs.S2C_Ancient_GetFinalUserList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETFINALUSERLIST_USERS_F, {
	"users",
	".cs.S2C_Ancient_GetFinalUserList.users",
	2,
	1,
	3,
	false,
	{},
	var_0_3.ANCIENTSIMPLEUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_GETFINALUSERLIST_ME, {
	"S2C_Ancient_GetFinalUserList",
	".cs.S2C_Ancient_GetFinalUserList",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_GETFINALUSERLIST_RET_F,
		var_0_10.S2C_ANCIENT_GETFINALUSERLIST_USERS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ANCIENT_GETFINALRANKLIST_ME, {
	"C2S_Ancient_GetFinalRankList",
	".cs.C2S_Ancient_GetFinalRankList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETFINALRANKLIST_RET_F, {
	"ret",
	".cs.S2C_Ancient_GetFinalRankList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_GETFINALRANKLIST_RANK_UNITS_F, {
	"rank_units",
	".cs.S2C_Ancient_GetFinalRankList.rank_units",
	2,
	1,
	3,
	false,
	{},
	var_0_3.RANKUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_GETFINALRANKLIST_ME, {
	"S2C_Ancient_GetFinalRankList",
	".cs.S2C_Ancient_GetFinalRankList",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_GETFINALRANKLIST_RET_F,
		var_0_10.S2C_ANCIENT_GETFINALRANKLIST_RANK_UNITS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_NOTIFYMAXMESSAGEID_TEAM_ID_F, {
	"team_id",
	".cs.S2C_Ancient_NotifyMaxMessageId.team_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ANCIENT_NOTIFYMAXMESSAGEID_MAX_MESSAGE_ID_F, {
	"max_message_id",
	".cs.S2C_Ancient_NotifyMaxMessageId.max_message_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ANCIENT_NOTIFYMAXMESSAGEID_ME, {
	"S2C_Ancient_NotifyMaxMessageId",
	".cs.S2C_Ancient_NotifyMaxMessageId",
	{},
	{},
	{
		var_0_10.S2C_ANCIENT_NOTIFYMAXMESSAGEID_TEAM_ID_F,
		var_0_10.S2C_ANCIENT_NOTIFYMAXMESSAGEID_MAX_MESSAGE_ID_F
	},
	false,
	{}
})

return var_0_10
