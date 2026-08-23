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
	C2S_TEAMBATTLE_EXIT_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_EXIT_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_EXIT_RET_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_ENTERROOM_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_ENTERROOM_TP_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_ENTERROOM_VALUE_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_ENTERROOM_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_ENTERROOM_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_ENTERROOM_TP_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_ENTERROOM_VALUE_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_ENTERROOM_USER_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_ENTERROOM_ROOM_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_SETBATTLEKNIGHTS_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_SETBATTLEKNIGHTS_KNIGHT_IDS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SETBATTLEKNIGHTS_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_SETBATTLEKNIGHTS_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SETBATTLEKNIGHTS_KNIGHT_IDS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SETBATTLEKNIGHTS_KNIGHTS_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_SETWORK_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_SETWORK_WORK_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SETWORK_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_SETWORK_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SETWORK_WORK_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_SETVISIBLEAREA_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_SETVISIBLEAREA_VISIBLE_AREA_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SETVISIBLEAREA_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_SETVISIBLEAREA_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SETVISIBLEAREA_VISIBLE_AREA_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_MOVE_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_MOVE_PATH_POS_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_MOVE_PATH_GRID_IDS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_MOVE_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_MOVE_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_MOVE_PATH_POS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_MOVE_PATH_GRID_IDS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_MOVE_EVENTS_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_HELP_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_HELP_TARGET_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_HELP_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_HELP_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_HELP_TARGET_ID_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_GETLOG_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_GETLOG_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_GETLOG_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_GETLOG_LOGS_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_CHALLENGEMONSTERBEGIN_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_CHALLENGEMONSTERBEGIN_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_CHALLENGEMONSTERBEGIN_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_CHALLENGEMONSTERBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_CHALLENGEMONSTERBEGIN_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_CHALLENGEMONSTERBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_CHALLENGEBOSSBEGIN_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_CHALLENGEBOSSBEGIN_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_CHALLENGEBOSSBEGIN_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_CHALLENGEBOSSBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_CHALLENGEBOSSBEGIN_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_CHALLENGEBOSSBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_OPCHALLENGERESULT_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_OPCHALLENGERESULT_IS_GIVE_UP_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_OPCHALLENGERESULT_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_OPCHALLENGERESULT_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_OPCHALLENGERESULT_IS_GIVE_UP_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_KNIGHTSHOPBUY_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_KNIGHTSHOPBUY_GRID_ID_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_KNIGHTSHOPBUY_POS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_KNIGHTSHOPBUY_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_KNIGHTSHOPBUY_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_KNIGHTSHOPBUY_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_KNIGHTSHOPBUY_POS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_KNIGHTSHOPBUY_KNIGHT_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_KNIGHTSHOPREFRESH_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_KNIGHTSHOPREFRESH_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_KNIGHTSHOPREFRESH_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_KNIGHTSHOPREFRESH_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_KNIGHTSHOPREFRESH_GRID_ID_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_BUFFSHOPBUY_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_BUFFSHOPBUY_GRID_ID_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_BUFFSHOPBUY_POS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_BUFFSHOPBUY_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_BUFFSHOPBUY_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_BUFFSHOPBUY_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_BUFFSHOPBUY_POS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_BUFFSHOPBUY_BUFF_ID_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_BUFFSHOPREFRESH_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_BUFFSHOPREFRESH_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_BUFFSHOPREFRESH_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_BUFFSHOPREFRESH_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_BUFFSHOPREFRESH_GRID_ID_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_MINE_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_MINE_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_MINE_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_MINE_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_MINE_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_MINE_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_REBORN_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_REBORN_GRID_ID_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_REBORN_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_REBORN_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_REBORN_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_REBORN_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_REBORN_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_REBORN_KNIGHTS_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_RECOVERHP_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_RECOVERHP_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_RECOVERHP_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_RECOVERHP_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_RECOVERHP_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_RECOVERHP_KNIGHTS_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_SELECTBUFF_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_SELECTBUFF_GRID_ID_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_SELECTBUFF_POS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SELECTBUFF_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_SELECTBUFF_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SELECTBUFF_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SELECTBUFF_POS_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_SELECTGAME_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_SELECTGAME_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SELECTGAME_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_SELECTGAME_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SELECTGAME_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SELECTGAME_EVENT_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_PLAYGAME_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_PLAYGAME_EVENT_ID_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_PLAYGAME_PARAMS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_PLAYGAME_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_PLAYGAME_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_PLAYGAME_EVENT_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_PLAYGAME_EVENT_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_PLAYGAME_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_SELECTITEM_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_SELECTITEM_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SELECTITEM_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_SELECTITEM_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SELECTITEM_GRID_ID_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_USEITEM_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_USEITEM_ITEM_ID_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_USEITEM_ITEM_NUM_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_USEITEM_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_USEITEM_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_USEITEM_ITEM_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_USEITEM_ITEM_NUM_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_GETSHAREAWARDS_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_GETSHAREAWARDS_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_GETSHAREAWARDS_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_GETSHAREAWARDS_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYENTERROOM_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYENTERROOM_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYENTERROOM_USER_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYENTERROOM_ROOM_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYEXIT_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYEXIT_USER_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYSETWORK_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYSETWORK_USER_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYSETVISIBLEAREA_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYSETVISIBLEAREA_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYSETVISIBLEAREA_ROOM_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYSETVISIBLEAREA_VISIBLE_AREA_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYMOVE_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYMOVE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYMOVE_PATH_POS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYMOVE_PATH_GRID_IDS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYMOVE_EVENTS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYMOVE_USER_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYMOVE_COMPLETE_GRID_IDS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYHELP_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYHELP_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYHELP_TARGET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERBEGIN_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERBEGIN_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERBEGIN_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERBEGIN_MONSTER_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_MONSTER_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_IS_GIVE_UP_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_USER_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_SCORE_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSBEGIN_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSBEGIN_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSBEGIN_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSBEGIN_BOSS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_BOSS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_IS_GIVE_UP_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_USER_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_SCORE_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPBUY_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPBUY_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPBUY_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPBUY_SHOP_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPREFRESH_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPREFRESH_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPREFRESH_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPREFRESH_SHOP_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYBUFFSHOPBUY_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYBUFFSHOPBUY_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYBUFFSHOPBUY_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYBUFFSHOPBUY_SHOP_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYBUFFSHOPBUY_GOODS_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYBUFFSHOPREFRESH_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYBUFFSHOPREFRESH_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYBUFFSHOPREFRESH_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYBUFFSHOPREFRESH_SHOP_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYMINE_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYMINE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYMINE_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYMINE_MINE_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYREBORN_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYREBORN_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYREBORN_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYRECOVERHP_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYRECOVERHP_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYRECOVERHP_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYSELECTBUFF_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYSELECTBUFF_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYSELECTBUFF_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYSELECTBUFF_BUFF_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYSELECTBUFF_BUFF_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYSELECTGAME_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYSELECTGAME_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYSELECTGAME_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYSELECTGAME_GAME_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYSELECTGAME_EVENT_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYSELECTITEM_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYSELECTITEM_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYSELECTITEM_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYUSEITEM_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYUSEITEM_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYUSEITEM_ITEM_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYUSEITEM_ITEM_NUM_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTIFYSHAREAWARDS_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTIFYSHAREAWARDS_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_NOTICEACTIVITY_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_NOTICEACTIVITY_ACTIVITY_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_TEAMINFO_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_TEAMINFO_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_TEAMINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_TEAMINFO_TEAM_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_TEAMLIST_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_TEAMLIST_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_TEAMLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_TEAMLIST_TEAMS_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_FINDTEAM_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_FINDTEAM_NAME_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_FINDTEAM_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_FINDTEAM_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_FINDTEAM_TEAM_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_CREATETEAM_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_CREATETEAM_TEAM_NAME_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_CREATETEAM_LEVEL_LIMIT_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_CREATETEAM_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_CREATETEAM_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_CREATETEAM_TEAM_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_SETTEAM_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_SETTEAM_OPEN_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SETTEAM_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_SETTEAM_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SETTEAM_OPEN_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_JOINTEAM_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_JOINTEAM_TEAM_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_JOINTEAM_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_JOINTEAM_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_JOINTEAM_TEAM_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_LEAVETEAM_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_LEAVETEAM_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_LEAVETEAM_RET_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_KICKOUT_ME = protobuf.Descriptor(),
	C2S_TEAMBATTLE_KICKOUT_MEMBER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_KICKOUT_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_KICKOUT_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_KICKOUT_MEMBER_ID_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_KICKNOTICE_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_UPDATETEAM_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_UPDATETEAM_TEAM_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_TEAMRANK_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_TEAMRANK_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_TEAMRANK_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_TEAMRANK_LIST_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_TEAMRANK_OWN_RANK_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_TEAMRANK_OWN_SCORE_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLE_SERVERINFOS_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_SERVERINFOS_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLE_SERVERINFOS_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SERVERINFOS_SERVER_INFOS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLE_SERVERINFOS_SID_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_EXIT_ME, {
	"C2S_TeamBattle_Exit",
	".cs.C2S_TeamBattle_Exit",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_EXIT_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_Exit.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_EXIT_ME, {
	"S2C_TeamBattle_Exit",
	".cs.S2C_TeamBattle_Exit",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_EXIT_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_ENTERROOM_TP_F, {
	"tp",
	".cs.C2S_TeamBattle_EnterRoom.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_ENTERROOM_VALUE_F, {
	"value",
	".cs.C2S_TeamBattle_EnterRoom.value",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_ENTERROOM_ME, {
	"C2S_TeamBattle_EnterRoom",
	".cs.C2S_TeamBattle_EnterRoom",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_ENTERROOM_TP_F,
		var_0_10.C2S_TEAMBATTLE_ENTERROOM_VALUE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_ENTERROOM_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_EnterRoom.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_ENTERROOM_TP_F, {
	"tp",
	".cs.S2C_TeamBattle_EnterRoom.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_ENTERROOM_VALUE_F, {
	"value",
	".cs.S2C_TeamBattle_EnterRoom.value",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_ENTERROOM_USER_F, {
	"user",
	".cs.S2C_TeamBattle_EnterRoom.user",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEMAPUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_ENTERROOM_ROOM_F, {
	"room",
	".cs.S2C_TeamBattle_EnterRoom.room",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEROOM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_ENTERROOM_ME, {
	"S2C_TeamBattle_EnterRoom",
	".cs.S2C_TeamBattle_EnterRoom",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_ENTERROOM_RET_F,
		var_0_10.S2C_TEAMBATTLE_ENTERROOM_TP_F,
		var_0_10.S2C_TEAMBATTLE_ENTERROOM_VALUE_F,
		var_0_10.S2C_TEAMBATTLE_ENTERROOM_USER_F,
		var_0_10.S2C_TEAMBATTLE_ENTERROOM_ROOM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_SETBATTLEKNIGHTS_KNIGHT_IDS_F, {
	"knight_ids",
	".cs.C2S_TeamBattle_SetBattleKnights.knight_ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_SETBATTLEKNIGHTS_ME, {
	"C2S_TeamBattle_SetBattleKnights",
	".cs.C2S_TeamBattle_SetBattleKnights",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_SETBATTLEKNIGHTS_KNIGHT_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SETBATTLEKNIGHTS_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_SetBattleKnights.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SETBATTLEKNIGHTS_KNIGHT_IDS_F, {
	"knight_ids",
	".cs.S2C_TeamBattle_SetBattleKnights.knight_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SETBATTLEKNIGHTS_KNIGHTS_F, {
	"knights",
	".cs.S2C_TeamBattle_SetBattleKnights.knights",
	3,
	2,
	3,
	false,
	{},
	var_0_3.TEAMBATTLEKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_SETBATTLEKNIGHTS_ME, {
	"S2C_TeamBattle_SetBattleKnights",
	".cs.S2C_TeamBattle_SetBattleKnights",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_SETBATTLEKNIGHTS_RET_F,
		var_0_10.S2C_TEAMBATTLE_SETBATTLEKNIGHTS_KNIGHT_IDS_F,
		var_0_10.S2C_TEAMBATTLE_SETBATTLEKNIGHTS_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_SETWORK_WORK_F, {
	"work",
	".cs.C2S_TeamBattle_SetWork.work",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_SETWORK_ME, {
	"C2S_TeamBattle_SetWork",
	".cs.C2S_TeamBattle_SetWork",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_SETWORK_WORK_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SETWORK_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_SetWork.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SETWORK_WORK_F, {
	"work",
	".cs.S2C_TeamBattle_SetWork.work",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_SETWORK_ME, {
	"S2C_TeamBattle_SetWork",
	".cs.S2C_TeamBattle_SetWork",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_SETWORK_RET_F,
		var_0_10.S2C_TEAMBATTLE_SETWORK_WORK_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_SETVISIBLEAREA_VISIBLE_AREA_F, {
	"visible_area",
	".cs.C2S_TeamBattle_SetVisibleArea.visible_area",
	1,
	0,
	3,
	false,
	{},
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_SETVISIBLEAREA_ME, {
	"C2S_TeamBattle_SetVisibleArea",
	".cs.C2S_TeamBattle_SetVisibleArea",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_SETVISIBLEAREA_VISIBLE_AREA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SETVISIBLEAREA_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_SetVisibleArea.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SETVISIBLEAREA_VISIBLE_AREA_F, {
	"visible_area",
	".cs.S2C_TeamBattle_SetVisibleArea.visible_area",
	2,
	1,
	3,
	false,
	{},
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_SETVISIBLEAREA_ME, {
	"S2C_TeamBattle_SetVisibleArea",
	".cs.S2C_TeamBattle_SetVisibleArea",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_SETVISIBLEAREA_RET_F,
		var_0_10.S2C_TEAMBATTLE_SETVISIBLEAREA_VISIBLE_AREA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_MOVE_PATH_POS_F, {
	"path_pos",
	".cs.C2S_TeamBattle_Move.path_pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_MOVE_PATH_GRID_IDS_F, {
	"path_grid_ids",
	".cs.C2S_TeamBattle_Move.path_grid_ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_MOVE_ME, {
	"C2S_TeamBattle_Move",
	".cs.C2S_TeamBattle_Move",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_MOVE_PATH_POS_F,
		var_0_10.C2S_TEAMBATTLE_MOVE_PATH_GRID_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_MOVE_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_Move.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_MOVE_PATH_POS_F, {
	"path_pos",
	".cs.S2C_TeamBattle_Move.path_pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_MOVE_PATH_GRID_IDS_F, {
	"path_grid_ids",
	".cs.S2C_TeamBattle_Move.path_grid_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_MOVE_EVENTS_F, {
	"events",
	".cs.S2C_TeamBattle_Move.events",
	5,
	3,
	3,
	false,
	{},
	var_0_3.TEAMBATTLEEVENT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_MOVE_ME, {
	"S2C_TeamBattle_Move",
	".cs.S2C_TeamBattle_Move",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_MOVE_RET_F,
		var_0_10.S2C_TEAMBATTLE_MOVE_PATH_POS_F,
		var_0_10.S2C_TEAMBATTLE_MOVE_PATH_GRID_IDS_F,
		var_0_10.S2C_TEAMBATTLE_MOVE_EVENTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_HELP_TARGET_ID_F, {
	"target_id",
	".cs.C2S_TeamBattle_Help.target_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_HELP_ME, {
	"C2S_TeamBattle_Help",
	".cs.C2S_TeamBattle_Help",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_HELP_TARGET_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_HELP_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_Help.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_HELP_TARGET_ID_F, {
	"target_id",
	".cs.S2C_TeamBattle_Help.target_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_HELP_ME, {
	"S2C_TeamBattle_Help",
	".cs.S2C_TeamBattle_Help",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_HELP_RET_F,
		var_0_10.S2C_TEAMBATTLE_HELP_TARGET_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_GETLOG_ME, {
	"C2S_TeamBattle_GetLog",
	".cs.C2S_TeamBattle_GetLog",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_GETLOG_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_GetLog.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_GETLOG_LOGS_F, {
	"logs",
	".cs.S2C_TeamBattle_GetLog.logs",
	2,
	1,
	3,
	false,
	{},
	var_0_3.TEAMBATTLELOG_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_GETLOG_ME, {
	"S2C_TeamBattle_GetLog",
	".cs.S2C_TeamBattle_GetLog",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_GETLOG_RET_F,
		var_0_10.S2C_TEAMBATTLE_GETLOG_LOGS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_CHALLENGEMONSTERBEGIN_GRID_ID_F, {
	"grid_id",
	".cs.C2S_TeamBattle_ChallengeMonsterBegin.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_CHALLENGEMONSTERBEGIN_ME, {
	"C2S_TeamBattle_ChallengeMonsterBegin",
	".cs.C2S_TeamBattle_ChallengeMonsterBegin",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_CHALLENGEMONSTERBEGIN_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_CHALLENGEMONSTERBEGIN_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_ChallengeMonsterBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_CHALLENGEMONSTERBEGIN_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_ChallengeMonsterBegin.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_CHALLENGEMONSTERBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_TeamBattle_ChallengeMonsterBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_CHALLENGEMONSTERBEGIN_ME, {
	"S2C_TeamBattle_ChallengeMonsterBegin",
	".cs.S2C_TeamBattle_ChallengeMonsterBegin",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_CHALLENGEMONSTERBEGIN_RET_F,
		var_0_10.S2C_TEAMBATTLE_CHALLENGEMONSTERBEGIN_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_CHALLENGEMONSTERBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_CHALLENGEBOSSBEGIN_GRID_ID_F, {
	"grid_id",
	".cs.C2S_TeamBattle_ChallengeBossBegin.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_CHALLENGEBOSSBEGIN_ME, {
	"C2S_TeamBattle_ChallengeBossBegin",
	".cs.C2S_TeamBattle_ChallengeBossBegin",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_CHALLENGEBOSSBEGIN_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_CHALLENGEBOSSBEGIN_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_ChallengeBossBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_CHALLENGEBOSSBEGIN_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_ChallengeBossBegin.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_CHALLENGEBOSSBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_TeamBattle_ChallengeBossBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_CHALLENGEBOSSBEGIN_ME, {
	"S2C_TeamBattle_ChallengeBossBegin",
	".cs.S2C_TeamBattle_ChallengeBossBegin",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_CHALLENGEBOSSBEGIN_RET_F,
		var_0_10.S2C_TEAMBATTLE_CHALLENGEBOSSBEGIN_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_CHALLENGEBOSSBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_OPCHALLENGERESULT_IS_GIVE_UP_F, {
	"is_give_up",
	".cs.C2S_TeamBattle_OpChallengeResult.is_give_up",
	1,
	0,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_OPCHALLENGERESULT_ME, {
	"C2S_TeamBattle_OpChallengeResult",
	".cs.C2S_TeamBattle_OpChallengeResult",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_OPCHALLENGERESULT_IS_GIVE_UP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_OPCHALLENGERESULT_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_OpChallengeResult.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_OPCHALLENGERESULT_IS_GIVE_UP_F, {
	"is_give_up",
	".cs.S2C_TeamBattle_OpChallengeResult.is_give_up",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_OPCHALLENGERESULT_ME, {
	"S2C_TeamBattle_OpChallengeResult",
	".cs.S2C_TeamBattle_OpChallengeResult",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_OPCHALLENGERESULT_RET_F,
		var_0_10.S2C_TEAMBATTLE_OPCHALLENGERESULT_IS_GIVE_UP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_KNIGHTSHOPBUY_GRID_ID_F, {
	"grid_id",
	".cs.C2S_TeamBattle_KnightShopBuy.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_KNIGHTSHOPBUY_POS_F, {
	"pos",
	".cs.C2S_TeamBattle_KnightShopBuy.pos",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_KNIGHTSHOPBUY_ME, {
	"C2S_TeamBattle_KnightShopBuy",
	".cs.C2S_TeamBattle_KnightShopBuy",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_KNIGHTSHOPBUY_GRID_ID_F,
		var_0_10.C2S_TEAMBATTLE_KNIGHTSHOPBUY_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_KNIGHTSHOPBUY_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_KnightShopBuy.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_KNIGHTSHOPBUY_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_KnightShopBuy.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_KNIGHTSHOPBUY_POS_F, {
	"pos",
	".cs.S2C_TeamBattle_KnightShopBuy.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_KNIGHTSHOPBUY_KNIGHT_F, {
	"knight",
	".cs.S2C_TeamBattle_KnightShopBuy.knight",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_KNIGHTSHOPBUY_ME, {
	"S2C_TeamBattle_KnightShopBuy",
	".cs.S2C_TeamBattle_KnightShopBuy",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_KNIGHTSHOPBUY_RET_F,
		var_0_10.S2C_TEAMBATTLE_KNIGHTSHOPBUY_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_KNIGHTSHOPBUY_POS_F,
		var_0_10.S2C_TEAMBATTLE_KNIGHTSHOPBUY_KNIGHT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_KNIGHTSHOPREFRESH_GRID_ID_F, {
	"grid_id",
	".cs.C2S_TeamBattle_KnightShopRefresh.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_KNIGHTSHOPREFRESH_ME, {
	"C2S_TeamBattle_KnightShopRefresh",
	".cs.C2S_TeamBattle_KnightShopRefresh",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_KNIGHTSHOPREFRESH_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_KNIGHTSHOPREFRESH_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_KnightShopRefresh.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_KNIGHTSHOPREFRESH_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_KnightShopRefresh.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_KNIGHTSHOPREFRESH_ME, {
	"S2C_TeamBattle_KnightShopRefresh",
	".cs.S2C_TeamBattle_KnightShopRefresh",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_KNIGHTSHOPREFRESH_RET_F,
		var_0_10.S2C_TEAMBATTLE_KNIGHTSHOPREFRESH_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_BUFFSHOPBUY_GRID_ID_F, {
	"grid_id",
	".cs.C2S_TeamBattle_BuffShopBuy.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_BUFFSHOPBUY_POS_F, {
	"pos",
	".cs.C2S_TeamBattle_BuffShopBuy.pos",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_BUFFSHOPBUY_ME, {
	"C2S_TeamBattle_BuffShopBuy",
	".cs.C2S_TeamBattle_BuffShopBuy",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_BUFFSHOPBUY_GRID_ID_F,
		var_0_10.C2S_TEAMBATTLE_BUFFSHOPBUY_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_BUFFSHOPBUY_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_BuffShopBuy.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_BUFFSHOPBUY_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_BuffShopBuy.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_BUFFSHOPBUY_POS_F, {
	"pos",
	".cs.S2C_TeamBattle_BuffShopBuy.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_BUFFSHOPBUY_BUFF_ID_F, {
	"buff_id",
	".cs.S2C_TeamBattle_BuffShopBuy.buff_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_BUFFSHOPBUY_ME, {
	"S2C_TeamBattle_BuffShopBuy",
	".cs.S2C_TeamBattle_BuffShopBuy",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_BUFFSHOPBUY_RET_F,
		var_0_10.S2C_TEAMBATTLE_BUFFSHOPBUY_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_BUFFSHOPBUY_POS_F,
		var_0_10.S2C_TEAMBATTLE_BUFFSHOPBUY_BUFF_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_BUFFSHOPREFRESH_GRID_ID_F, {
	"grid_id",
	".cs.C2S_TeamBattle_BuffShopRefresh.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_BUFFSHOPREFRESH_ME, {
	"C2S_TeamBattle_BuffShopRefresh",
	".cs.C2S_TeamBattle_BuffShopRefresh",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_BUFFSHOPREFRESH_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_BUFFSHOPREFRESH_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_BuffShopRefresh.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_BUFFSHOPREFRESH_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_BuffShopRefresh.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_BUFFSHOPREFRESH_ME, {
	"S2C_TeamBattle_BuffShopRefresh",
	".cs.S2C_TeamBattle_BuffShopRefresh",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_BUFFSHOPREFRESH_RET_F,
		var_0_10.S2C_TEAMBATTLE_BUFFSHOPREFRESH_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_MINE_GRID_ID_F, {
	"grid_id",
	".cs.C2S_TeamBattle_Mine.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_MINE_ME, {
	"C2S_TeamBattle_Mine",
	".cs.C2S_TeamBattle_Mine",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_MINE_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_MINE_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_Mine.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_MINE_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_Mine.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_MINE_AWARDS_F, {
	"awards",
	".cs.S2C_TeamBattle_Mine.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_MINE_ME, {
	"S2C_TeamBattle_Mine",
	".cs.S2C_TeamBattle_Mine",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_MINE_RET_F,
		var_0_10.S2C_TEAMBATTLE_MINE_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_MINE_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_REBORN_GRID_ID_F, {
	"grid_id",
	".cs.C2S_TeamBattle_Reborn.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_REBORN_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_TeamBattle_Reborn.knight_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_REBORN_ME, {
	"C2S_TeamBattle_Reborn",
	".cs.C2S_TeamBattle_Reborn",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_REBORN_GRID_ID_F,
		var_0_10.C2S_TEAMBATTLE_REBORN_KNIGHT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_REBORN_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_Reborn.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_REBORN_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_Reborn.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_REBORN_KNIGHT_ID_F, {
	"knight_id",
	".cs.S2C_TeamBattle_Reborn.knight_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_REBORN_KNIGHTS_F, {
	"knights",
	".cs.S2C_TeamBattle_Reborn.knights",
	4,
	3,
	3,
	false,
	{},
	var_0_3.TEAMBATTLEKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_REBORN_ME, {
	"S2C_TeamBattle_Reborn",
	".cs.S2C_TeamBattle_Reborn",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_REBORN_RET_F,
		var_0_10.S2C_TEAMBATTLE_REBORN_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_REBORN_KNIGHT_ID_F,
		var_0_10.S2C_TEAMBATTLE_REBORN_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_RECOVERHP_GRID_ID_F, {
	"grid_id",
	".cs.C2S_TeamBattle_RecoverHp.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_RECOVERHP_ME, {
	"C2S_TeamBattle_RecoverHp",
	".cs.C2S_TeamBattle_RecoverHp",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_RECOVERHP_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_RECOVERHP_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_RecoverHp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_RECOVERHP_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_RecoverHp.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_RECOVERHP_KNIGHTS_F, {
	"knights",
	".cs.S2C_TeamBattle_RecoverHp.knights",
	3,
	2,
	3,
	false,
	{},
	var_0_3.TEAMBATTLEKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_RECOVERHP_ME, {
	"S2C_TeamBattle_RecoverHp",
	".cs.S2C_TeamBattle_RecoverHp",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_RECOVERHP_RET_F,
		var_0_10.S2C_TEAMBATTLE_RECOVERHP_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_RECOVERHP_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_SELECTBUFF_GRID_ID_F, {
	"grid_id",
	".cs.C2S_TeamBattle_SelectBuff.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_SELECTBUFF_POS_F, {
	"pos",
	".cs.C2S_TeamBattle_SelectBuff.pos",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_SELECTBUFF_ME, {
	"C2S_TeamBattle_SelectBuff",
	".cs.C2S_TeamBattle_SelectBuff",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_SELECTBUFF_GRID_ID_F,
		var_0_10.C2S_TEAMBATTLE_SELECTBUFF_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SELECTBUFF_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_SelectBuff.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SELECTBUFF_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_SelectBuff.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SELECTBUFF_POS_F, {
	"pos",
	".cs.S2C_TeamBattle_SelectBuff.pos",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_SELECTBUFF_ME, {
	"S2C_TeamBattle_SelectBuff",
	".cs.S2C_TeamBattle_SelectBuff",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_SELECTBUFF_RET_F,
		var_0_10.S2C_TEAMBATTLE_SELECTBUFF_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_SELECTBUFF_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_SELECTGAME_GRID_ID_F, {
	"grid_id",
	".cs.C2S_TeamBattle_SelectGame.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_SELECTGAME_ME, {
	"C2S_TeamBattle_SelectGame",
	".cs.C2S_TeamBattle_SelectGame",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_SELECTGAME_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SELECTGAME_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_SelectGame.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SELECTGAME_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_SelectGame.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SELECTGAME_EVENT_F, {
	"event",
	".cs.S2C_TeamBattle_SelectGame.event",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEEVENT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_SELECTGAME_ME, {
	"S2C_TeamBattle_SelectGame",
	".cs.S2C_TeamBattle_SelectGame",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_SELECTGAME_RET_F,
		var_0_10.S2C_TEAMBATTLE_SELECTGAME_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_SELECTGAME_EVENT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_PLAYGAME_EVENT_ID_F, {
	"event_id",
	".cs.C2S_TeamBattle_PlayGame.event_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_PLAYGAME_PARAMS_F, {
	"params",
	".cs.C2S_TeamBattle_PlayGame.params",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_PLAYGAME_ME, {
	"C2S_TeamBattle_PlayGame",
	".cs.C2S_TeamBattle_PlayGame",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_PLAYGAME_EVENT_ID_F,
		var_0_10.C2S_TEAMBATTLE_PLAYGAME_PARAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_PLAYGAME_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_PlayGame.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_PLAYGAME_EVENT_ID_F, {
	"event_id",
	".cs.S2C_TeamBattle_PlayGame.event_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_PLAYGAME_EVENT_F, {
	"event",
	".cs.S2C_TeamBattle_PlayGame.event",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEEVENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_PLAYGAME_AWARDS_F, {
	"awards",
	".cs.S2C_TeamBattle_PlayGame.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_PLAYGAME_ME, {
	"S2C_TeamBattle_PlayGame",
	".cs.S2C_TeamBattle_PlayGame",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_PLAYGAME_RET_F,
		var_0_10.S2C_TEAMBATTLE_PLAYGAME_EVENT_ID_F,
		var_0_10.S2C_TEAMBATTLE_PLAYGAME_EVENT_F,
		var_0_10.S2C_TEAMBATTLE_PLAYGAME_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_SELECTITEM_GRID_ID_F, {
	"grid_id",
	".cs.C2S_TeamBattle_SelectItem.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_SELECTITEM_ME, {
	"C2S_TeamBattle_SelectItem",
	".cs.C2S_TeamBattle_SelectItem",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_SELECTITEM_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SELECTITEM_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_SelectItem.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SELECTITEM_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_SelectItem.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_SELECTITEM_ME, {
	"S2C_TeamBattle_SelectItem",
	".cs.S2C_TeamBattle_SelectItem",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_SELECTITEM_RET_F,
		var_0_10.S2C_TEAMBATTLE_SELECTITEM_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_USEITEM_ITEM_ID_F, {
	"item_id",
	".cs.C2S_TeamBattle_UseItem.item_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_USEITEM_ITEM_NUM_F, {
	"item_num",
	".cs.C2S_TeamBattle_UseItem.item_num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_USEITEM_ME, {
	"C2S_TeamBattle_UseItem",
	".cs.C2S_TeamBattle_UseItem",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_USEITEM_ITEM_ID_F,
		var_0_10.C2S_TEAMBATTLE_USEITEM_ITEM_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_USEITEM_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_UseItem.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_USEITEM_ITEM_ID_F, {
	"item_id",
	".cs.S2C_TeamBattle_UseItem.item_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_USEITEM_ITEM_NUM_F, {
	"item_num",
	".cs.S2C_TeamBattle_UseItem.item_num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_USEITEM_ME, {
	"S2C_TeamBattle_UseItem",
	".cs.S2C_TeamBattle_UseItem",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_USEITEM_RET_F,
		var_0_10.S2C_TEAMBATTLE_USEITEM_ITEM_ID_F,
		var_0_10.S2C_TEAMBATTLE_USEITEM_ITEM_NUM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_GETSHAREAWARDS_ME, {
	"C2S_TeamBattle_GetShareAwards",
	".cs.C2S_TeamBattle_GetShareAwards",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_GETSHAREAWARDS_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_GetShareAwards.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_GETSHAREAWARDS_AWARDS_F, {
	"awards",
	".cs.S2C_TeamBattle_GetShareAwards.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_GETSHAREAWARDS_ME, {
	"S2C_TeamBattle_GetShareAwards",
	".cs.S2C_TeamBattle_GetShareAwards",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_GETSHAREAWARDS_RET_F,
		var_0_10.S2C_TEAMBATTLE_GETSHAREAWARDS_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYENTERROOM_ROOM_ID_F, {
	"room_id",
	".cs.S2C_TeamBattle_NotifyEnterRoom.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYENTERROOM_USER_F, {
	"user",
	".cs.S2C_TeamBattle_NotifyEnterRoom.user",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEMAPUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYENTERROOM_ROOM_F, {
	"room",
	".cs.S2C_TeamBattle_NotifyEnterRoom.room",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEROOM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYENTERROOM_ME, {
	"S2C_TeamBattle_NotifyEnterRoom",
	".cs.S2C_TeamBattle_NotifyEnterRoom",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYENTERROOM_ROOM_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYENTERROOM_USER_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYENTERROOM_ROOM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYEXIT_USER_F, {
	"user",
	".cs.S2C_TeamBattle_NotifyExit.user",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEMAPUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYEXIT_ME, {
	"S2C_TeamBattle_NotifyExit",
	".cs.S2C_TeamBattle_NotifyExit",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYEXIT_USER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSETWORK_USER_F, {
	"user",
	".cs.S2C_TeamBattle_NotifySetWork.user",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEMAPUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSETWORK_ME, {
	"S2C_TeamBattle_NotifySetWork",
	".cs.S2C_TeamBattle_NotifySetWork",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYSETWORK_USER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSETVISIBLEAREA_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifySetVisibleArea.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSETVISIBLEAREA_ROOM_ID_F, {
	"room_id",
	".cs.S2C_TeamBattle_NotifySetVisibleArea.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSETVISIBLEAREA_VISIBLE_AREA_F, {
	"visible_area",
	".cs.S2C_TeamBattle_NotifySetVisibleArea.visible_area",
	3,
	2,
	3,
	false,
	{},
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSETVISIBLEAREA_ME, {
	"S2C_TeamBattle_NotifySetVisibleArea",
	".cs.S2C_TeamBattle_NotifySetVisibleArea",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYSETVISIBLEAREA_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYSETVISIBLEAREA_ROOM_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYSETVISIBLEAREA_VISIBLE_AREA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYMOVE_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifyMove.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYMOVE_PATH_POS_F, {
	"path_pos",
	".cs.S2C_TeamBattle_NotifyMove.path_pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYMOVE_PATH_GRID_IDS_F, {
	"path_grid_ids",
	".cs.S2C_TeamBattle_NotifyMove.path_grid_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYMOVE_EVENTS_F, {
	"events",
	".cs.S2C_TeamBattle_NotifyMove.events",
	4,
	3,
	3,
	false,
	{},
	var_0_3.TEAMBATTLEEVENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYMOVE_USER_F, {
	"user",
	".cs.S2C_TeamBattle_NotifyMove.user",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEMAPUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYMOVE_COMPLETE_GRID_IDS_F, {
	"complete_grid_ids",
	".cs.S2C_TeamBattle_NotifyMove.complete_grid_ids",
	6,
	5,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYMOVE_ME, {
	"S2C_TeamBattle_NotifyMove",
	".cs.S2C_TeamBattle_NotifyMove",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYMOVE_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYMOVE_PATH_POS_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYMOVE_PATH_GRID_IDS_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYMOVE_EVENTS_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYMOVE_USER_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYMOVE_COMPLETE_GRID_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYHELP_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifyHelp.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYHELP_TARGET_F, {
	"target",
	".cs.S2C_TeamBattle_NotifyHelp.target",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEMAPUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYHELP_ME, {
	"S2C_TeamBattle_NotifyHelp",
	".cs.S2C_TeamBattle_NotifyHelp",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYHELP_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYHELP_TARGET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERBEGIN_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifyChallengeMonsterBegin.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERBEGIN_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_NotifyChallengeMonsterBegin.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERBEGIN_MONSTER_F, {
	"monster",
	".cs.S2C_TeamBattle_NotifyChallengeMonsterBegin.monster",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERBEGIN_ME, {
	"S2C_TeamBattle_NotifyChallengeMonsterBegin",
	".cs.S2C_TeamBattle_NotifyChallengeMonsterBegin",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERBEGIN_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERBEGIN_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERBEGIN_MONSTER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifyChallengeMonsterFinish.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_NotifyChallengeMonsterFinish.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_MONSTER_F, {
	"monster",
	".cs.S2C_TeamBattle_NotifyChallengeMonsterFinish.monster",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEMONSTER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_TeamBattle_NotifyChallengeMonsterFinish.is_win",
	4,
	3,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_IS_GIVE_UP_F, {
	"is_give_up",
	".cs.S2C_TeamBattle_NotifyChallengeMonsterFinish.is_give_up",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_USER_F, {
	"user",
	".cs.S2C_TeamBattle_NotifyChallengeMonsterFinish.user",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEMAPUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_SCORE_F, {
	"score",
	".cs.S2C_TeamBattle_NotifyChallengeMonsterFinish.score",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_ME, {
	"S2C_TeamBattle_NotifyChallengeMonsterFinish",
	".cs.S2C_TeamBattle_NotifyChallengeMonsterFinish",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_MONSTER_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_IS_WIN_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_IS_GIVE_UP_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_USER_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEMONSTERFINISH_SCORE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSBEGIN_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifyChallengeBossBegin.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSBEGIN_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_NotifyChallengeBossBegin.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSBEGIN_BOSS_F, {
	"boss",
	".cs.S2C_TeamBattle_NotifyChallengeBossBegin.boss",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLELIMITBOSS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSBEGIN_ME, {
	"S2C_TeamBattle_NotifyChallengeBossBegin",
	".cs.S2C_TeamBattle_NotifyChallengeBossBegin",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSBEGIN_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSBEGIN_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSBEGIN_BOSS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifyChallengeBossFinish.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_NotifyChallengeBossFinish.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_BOSS_F, {
	"boss",
	".cs.S2C_TeamBattle_NotifyChallengeBossFinish.boss",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLELIMITBOSS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_TeamBattle_NotifyChallengeBossFinish.is_win",
	4,
	3,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_IS_GIVE_UP_F, {
	"is_give_up",
	".cs.S2C_TeamBattle_NotifyChallengeBossFinish.is_give_up",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_USER_F, {
	"user",
	".cs.S2C_TeamBattle_NotifyChallengeBossFinish.user",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEMAPUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_SCORE_F, {
	"score",
	".cs.S2C_TeamBattle_NotifyChallengeBossFinish.score",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_ME, {
	"S2C_TeamBattle_NotifyChallengeBossFinish",
	".cs.S2C_TeamBattle_NotifyChallengeBossFinish",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_BOSS_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_IS_WIN_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_IS_GIVE_UP_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_USER_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYCHALLENGEBOSSFINISH_SCORE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPBUY_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifyKnightShopBuy.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPBUY_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_NotifyKnightShopBuy.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPBUY_SHOP_F, {
	"shop",
	".cs.S2C_TeamBattle_NotifyKnightShopBuy.shop",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLESHOP_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPBUY_ME, {
	"S2C_TeamBattle_NotifyKnightShopBuy",
	".cs.S2C_TeamBattle_NotifyKnightShopBuy",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPBUY_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPBUY_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPBUY_SHOP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPREFRESH_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifyKnightShopRefresh.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPREFRESH_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_NotifyKnightShopRefresh.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPREFRESH_SHOP_F, {
	"shop",
	".cs.S2C_TeamBattle_NotifyKnightShopRefresh.shop",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLESHOP_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPREFRESH_ME, {
	"S2C_TeamBattle_NotifyKnightShopRefresh",
	".cs.S2C_TeamBattle_NotifyKnightShopRefresh",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPREFRESH_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPREFRESH_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYKNIGHTSHOPREFRESH_SHOP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYBUFFSHOPBUY_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifyBuffShopBuy.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYBUFFSHOPBUY_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_NotifyBuffShopBuy.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYBUFFSHOPBUY_SHOP_F, {
	"shop",
	".cs.S2C_TeamBattle_NotifyBuffShopBuy.shop",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLESHOP_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYBUFFSHOPBUY_GOODS_ID_F, {
	"goods_id",
	".cs.S2C_TeamBattle_NotifyBuffShopBuy.goods_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYBUFFSHOPBUY_ME, {
	"S2C_TeamBattle_NotifyBuffShopBuy",
	".cs.S2C_TeamBattle_NotifyBuffShopBuy",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYBUFFSHOPBUY_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYBUFFSHOPBUY_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYBUFFSHOPBUY_SHOP_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYBUFFSHOPBUY_GOODS_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYBUFFSHOPREFRESH_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifyBuffShopRefresh.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYBUFFSHOPREFRESH_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_NotifyBuffShopRefresh.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYBUFFSHOPREFRESH_SHOP_F, {
	"shop",
	".cs.S2C_TeamBattle_NotifyBuffShopRefresh.shop",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLESHOP_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYBUFFSHOPREFRESH_ME, {
	"S2C_TeamBattle_NotifyBuffShopRefresh",
	".cs.S2C_TeamBattle_NotifyBuffShopRefresh",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYBUFFSHOPREFRESH_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYBUFFSHOPREFRESH_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYBUFFSHOPREFRESH_SHOP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYMINE_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifyMine.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYMINE_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_NotifyMine.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYMINE_MINE_F, {
	"mine",
	".cs.S2C_TeamBattle_NotifyMine.mine",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEMINE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYMINE_ME, {
	"S2C_TeamBattle_NotifyMine",
	".cs.S2C_TeamBattle_NotifyMine",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYMINE_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYMINE_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYMINE_MINE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYREBORN_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifyReborn.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYREBORN_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_NotifyReborn.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYREBORN_ME, {
	"S2C_TeamBattle_NotifyReborn",
	".cs.S2C_TeamBattle_NotifyReborn",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYREBORN_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYREBORN_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYRECOVERHP_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifyRecoverHp.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYRECOVERHP_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_NotifyRecoverHp.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYRECOVERHP_ME, {
	"S2C_TeamBattle_NotifyRecoverHp",
	".cs.S2C_TeamBattle_NotifyRecoverHp",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYRECOVERHP_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYRECOVERHP_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTBUFF_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifySelectBuff.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTBUFF_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_NotifySelectBuff.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTBUFF_BUFF_F, {
	"buff",
	".cs.S2C_TeamBattle_NotifySelectBuff.buff",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEBUFF_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTBUFF_BUFF_ID_F, {
	"buff_id",
	".cs.S2C_TeamBattle_NotifySelectBuff.buff_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTBUFF_ME, {
	"S2C_TeamBattle_NotifySelectBuff",
	".cs.S2C_TeamBattle_NotifySelectBuff",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTBUFF_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTBUFF_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTBUFF_BUFF_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTBUFF_BUFF_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTGAME_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifySelectGame.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTGAME_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_NotifySelectGame.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTGAME_GAME_F, {
	"game",
	".cs.S2C_TeamBattle_NotifySelectGame.game",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEMINIGAME_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTGAME_EVENT_F, {
	"event",
	".cs.S2C_TeamBattle_NotifySelectGame.event",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEEVENT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTGAME_ME, {
	"S2C_TeamBattle_NotifySelectGame",
	".cs.S2C_TeamBattle_NotifySelectGame",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTGAME_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTGAME_GRID_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTGAME_GAME_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTGAME_EVENT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTITEM_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifySelectItem.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTITEM_GRID_ID_F, {
	"grid_id",
	".cs.S2C_TeamBattle_NotifySelectItem.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTITEM_ME, {
	"S2C_TeamBattle_NotifySelectItem",
	".cs.S2C_TeamBattle_NotifySelectItem",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTITEM_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYSELECTITEM_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYUSEITEM_USER_ID_F, {
	"user_id",
	".cs.S2C_TeamBattle_NotifyUseItem.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYUSEITEM_ITEM_ID_F, {
	"item_id",
	".cs.S2C_TeamBattle_NotifyUseItem.item_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYUSEITEM_ITEM_NUM_F, {
	"item_num",
	".cs.S2C_TeamBattle_NotifyUseItem.item_num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYUSEITEM_ME, {
	"S2C_TeamBattle_NotifyUseItem",
	".cs.S2C_TeamBattle_NotifyUseItem",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYUSEITEM_USER_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYUSEITEM_ITEM_ID_F,
		var_0_10.S2C_TEAMBATTLE_NOTIFYUSEITEM_ITEM_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSHAREAWARDS_AWARDS_F, {
	"awards",
	".cs.S2C_TeamBattle_NotifyShareAwards.awards",
	1,
	0,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTIFYSHAREAWARDS_ME, {
	"S2C_TeamBattle_NotifyShareAwards",
	".cs.S2C_TeamBattle_NotifyShareAwards",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTIFYSHAREAWARDS_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTICEACTIVITY_ACTIVITY_F, {
	"activity",
	".cs.S2C_TeamBattle_NoticeActivity.activity",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_NOTICEACTIVITY_ME, {
	"S2C_TeamBattle_NoticeActivity",
	".cs.S2C_TeamBattle_NoticeActivity",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_NOTICEACTIVITY_ACTIVITY_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_TEAMINFO_ME, {
	"C2S_TeamBattle_TeamInfo",
	".cs.C2S_TeamBattle_TeamInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_TEAMINFO_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_TeamInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_TEAMINFO_TEAM_F, {
	"team",
	".cs.S2C_TeamBattle_TeamInfo.team",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_TEAMINFO_ME, {
	"S2C_TeamBattle_TeamInfo",
	".cs.S2C_TeamBattle_TeamInfo",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_TEAMINFO_RET_F,
		var_0_10.S2C_TEAMBATTLE_TEAMINFO_TEAM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_TEAMLIST_ME, {
	"C2S_TeamBattle_TeamList",
	".cs.C2S_TeamBattle_TeamList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_TEAMLIST_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_TeamList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_TEAMLIST_TEAMS_F, {
	"teams",
	".cs.S2C_TeamBattle_TeamList.teams",
	2,
	1,
	3,
	false,
	{},
	var_0_3.TEAMBATTLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_TEAMLIST_ME, {
	"S2C_TeamBattle_TeamList",
	".cs.S2C_TeamBattle_TeamList",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_TEAMLIST_RET_F,
		var_0_10.S2C_TEAMBATTLE_TEAMLIST_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_FINDTEAM_NAME_F, {
	"name",
	".cs.C2S_TeamBattle_FindTeam.name",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_FINDTEAM_ME, {
	"C2S_TeamBattle_FindTeam",
	".cs.C2S_TeamBattle_FindTeam",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_FINDTEAM_NAME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_FINDTEAM_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_FindTeam.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_FINDTEAM_TEAM_F, {
	"team",
	".cs.S2C_TeamBattle_FindTeam.team",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_FINDTEAM_ME, {
	"S2C_TeamBattle_FindTeam",
	".cs.S2C_TeamBattle_FindTeam",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_FINDTEAM_RET_F,
		var_0_10.S2C_TEAMBATTLE_FINDTEAM_TEAM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_CREATETEAM_TEAM_NAME_F, {
	"team_name",
	".cs.C2S_TeamBattle_CreateTeam.team_name",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_CREATETEAM_LEVEL_LIMIT_F, {
	"level_limit",
	".cs.C2S_TeamBattle_CreateTeam.level_limit",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_CREATETEAM_ME, {
	"C2S_TeamBattle_CreateTeam",
	".cs.C2S_TeamBattle_CreateTeam",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_CREATETEAM_TEAM_NAME_F,
		var_0_10.C2S_TEAMBATTLE_CREATETEAM_LEVEL_LIMIT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_CREATETEAM_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_CreateTeam.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_CREATETEAM_TEAM_F, {
	"team",
	".cs.S2C_TeamBattle_CreateTeam.team",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_CREATETEAM_ME, {
	"S2C_TeamBattle_CreateTeam",
	".cs.S2C_TeamBattle_CreateTeam",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_CREATETEAM_RET_F,
		var_0_10.S2C_TEAMBATTLE_CREATETEAM_TEAM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_SETTEAM_OPEN_F, {
	"open",
	".cs.C2S_TeamBattle_SetTeam.open",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_SETTEAM_ME, {
	"C2S_TeamBattle_SetTeam",
	".cs.C2S_TeamBattle_SetTeam",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_SETTEAM_OPEN_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SETTEAM_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_SetTeam.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SETTEAM_OPEN_F, {
	"open",
	".cs.S2C_TeamBattle_SetTeam.open",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_SETTEAM_ME, {
	"S2C_TeamBattle_SetTeam",
	".cs.S2C_TeamBattle_SetTeam",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_SETTEAM_RET_F,
		var_0_10.S2C_TEAMBATTLE_SETTEAM_OPEN_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_JOINTEAM_TEAM_ID_F, {
	"team_id",
	".cs.C2S_TeamBattle_JoinTeam.team_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_JOINTEAM_ME, {
	"C2S_TeamBattle_JoinTeam",
	".cs.C2S_TeamBattle_JoinTeam",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_JOINTEAM_TEAM_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_JOINTEAM_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_JoinTeam.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_JOINTEAM_TEAM_F, {
	"team",
	".cs.S2C_TeamBattle_JoinTeam.team",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_JOINTEAM_ME, {
	"S2C_TeamBattle_JoinTeam",
	".cs.S2C_TeamBattle_JoinTeam",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_JOINTEAM_RET_F,
		var_0_10.S2C_TEAMBATTLE_JOINTEAM_TEAM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_LEAVETEAM_ME, {
	"C2S_TeamBattle_LeaveTeam",
	".cs.C2S_TeamBattle_LeaveTeam",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_LEAVETEAM_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_LeaveTeam.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_LEAVETEAM_ME, {
	"S2C_TeamBattle_LeaveTeam",
	".cs.S2C_TeamBattle_LeaveTeam",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_LEAVETEAM_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TEAMBATTLE_KICKOUT_MEMBER_ID_F, {
	"member_id",
	".cs.C2S_TeamBattle_KickOut.member_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_KICKOUT_ME, {
	"C2S_TeamBattle_KickOut",
	".cs.C2S_TeamBattle_KickOut",
	{},
	{},
	{
		var_0_10.C2S_TEAMBATTLE_KICKOUT_MEMBER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_KICKOUT_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_KickOut.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_KICKOUT_MEMBER_ID_F, {
	"member_id",
	".cs.S2C_TeamBattle_KickOut.member_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_KICKOUT_ME, {
	"S2C_TeamBattle_KickOut",
	".cs.S2C_TeamBattle_KickOut",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_KICKOUT_RET_F,
		var_0_10.S2C_TEAMBATTLE_KICKOUT_MEMBER_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_KICKNOTICE_ME, {
	"S2C_TeamBattle_KickNotice",
	".cs.S2C_TeamBattle_KickNotice",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_UPDATETEAM_TEAM_F, {
	"team",
	".cs.S2C_TeamBattle_UpdateTeam.team",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_UPDATETEAM_ME, {
	"S2C_TeamBattle_UpdateTeam",
	".cs.S2C_TeamBattle_UpdateTeam",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_UPDATETEAM_TEAM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_TEAMRANK_ME, {
	"C2S_TeamBattle_TeamRank",
	".cs.C2S_TeamBattle_TeamRank",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_TEAMRANK_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_TeamRank.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_TEAMRANK_LIST_F, {
	"list",
	".cs.S2C_TeamBattle_TeamRank.list",
	2,
	1,
	3,
	false,
	{},
	var_0_3.TEAMBATTLETEAMRANK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_TEAMRANK_OWN_RANK_F, {
	"own_rank",
	".cs.S2C_TeamBattle_TeamRank.own_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_TEAMRANK_OWN_SCORE_F, {
	"own_score",
	".cs.S2C_TeamBattle_TeamRank.own_score",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_TEAMRANK_ME, {
	"S2C_TeamBattle_TeamRank",
	".cs.S2C_TeamBattle_TeamRank",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_TEAMRANK_RET_F,
		var_0_10.S2C_TEAMBATTLE_TEAMRANK_LIST_F,
		var_0_10.S2C_TEAMBATTLE_TEAMRANK_OWN_RANK_F,
		var_0_10.S2C_TEAMBATTLE_TEAMRANK_OWN_SCORE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_TEAMBATTLE_SERVERINFOS_ME, {
	"C2S_TeamBattle_ServerInfos",
	".cs.C2S_TeamBattle_ServerInfos",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SERVERINFOS_RET_F, {
	"ret",
	".cs.S2C_TeamBattle_ServerInfos.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SERVERINFOS_SERVER_INFOS_F, {
	"server_infos",
	".cs.S2C_TeamBattle_ServerInfos.server_infos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TEAMBATTLE_SERVERINFOS_SID_F, {
	"sid",
	".cs.S2C_TeamBattle_ServerInfos.sid",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TEAMBATTLE_SERVERINFOS_ME, {
	"S2C_TeamBattle_ServerInfos",
	".cs.S2C_TeamBattle_ServerInfos",
	{},
	{},
	{
		var_0_10.S2C_TEAMBATTLE_SERVERINFOS_RET_F,
		var_0_10.S2C_TEAMBATTLE_SERVERINFOS_SERVER_INFOS_F,
		var_0_10.S2C_TEAMBATTLE_SERVERINFOS_SID_F
	},
	false,
	{}
})

return var_0_10
