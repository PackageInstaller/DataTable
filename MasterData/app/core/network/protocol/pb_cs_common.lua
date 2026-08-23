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
local var_0_6 = {
	EOPCARDMAGICALLY_E = protobuf.EnumDescriptor(),
	EOPCARDMAGICALLY_EOPCARDMAGICALLY_WEAR_EI = protobuf.EnumValueDescriptor(),
	EOPCARDMAGICALLY_EOPCARDMAGICALLY_UNWEAR_EI = protobuf.EnumValueDescriptor(),
	BULLETSCREENMESSAGE_ME = protobuf.Descriptor(),
	BULLETSCREENMESSAGE_USER_F = protobuf.FieldDescriptor(),
	BULLETSCREENMESSAGE_CONTENT_F = protobuf.FieldDescriptor(),
	BULLETSCREENMESSAGE_TIME_F = protobuf.FieldDescriptor(),
	BULLETSCREENMESSAGE_TALK_F = protobuf.FieldDescriptor(),
	BULLETSCREENMESSAGE_ARGS_F = protobuf.FieldDescriptor(),
	BULLETSCREENMESSAGE_PARAM1_F = protobuf.FieldDescriptor(),
	BULLETSCREENMESSAGE_SHARE_F = protobuf.FieldDescriptor(),
	BULLETSCREENMESSAGE_INVITE_ID_F = protobuf.FieldDescriptor(),
	BULLETSCREENMESSAGE_UNIQUE_ID_F = protobuf.FieldDescriptor(),
	C2S_BULLETSCREENGETINFO_ME = protobuf.Descriptor(),
	C2S_BULLETSCREENGETINFO_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BULLETSCREENGETINFO_ME = protobuf.Descriptor(),
	S2C_BULLETSCREENGETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_BULLETSCREENGETINFO_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BULLETSCREENGETINFO_MESSAGES_F = protobuf.FieldDescriptor(),
	C2S_BULLETSCREENSEND_ME = protobuf.Descriptor(),
	C2S_BULLETSCREENSEND_TYPE_F = protobuf.FieldDescriptor(),
	C2S_BULLETSCREENSEND_CONTENT_F = protobuf.FieldDescriptor(),
	C2S_BULLETSCREENSEND_LOOK_F = protobuf.FieldDescriptor(),
	C2S_BULLETSCREENSEND_PARAM1_F = protobuf.FieldDescriptor(),
	C2S_BULLETSCREENSEND_SHARE_F = protobuf.FieldDescriptor(),
	C2S_BULLETSCREENSEND_INVITE_ID_F = protobuf.FieldDescriptor(),
	C2S_BULLETSCREENSEND_UNIQUE_ID_F = protobuf.FieldDescriptor(),
	S2C_BULLETSCREENSEND_ME = protobuf.Descriptor(),
	S2C_BULLETSCREENSEND_RET_F = protobuf.FieldDescriptor(),
	S2C_BULLETSCREENSEND_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BULLETSCREENSEND_MESSAGE_F = protobuf.FieldDescriptor(),
	S2C_BULLETSCREENSEND_LOOK_F = protobuf.FieldDescriptor(),
	S2C_BULLETSCREENNOTIFY_ME = protobuf.Descriptor(),
	S2C_BULLETSCREENNOTIFY_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BULLETSCREENNOTIFY_MESSAGE_F = protobuf.FieldDescriptor(),
	C2S_TEST_ME = protobuf.Descriptor(),
	C2S_TEST_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_TEST_CONSUMES_F = protobuf.FieldDescriptor(),
	C2S_TEST_TOTAL_LOGIN_DAYS_F = protobuf.FieldDescriptor(),
	C2S_TEST_LOOP_F = protobuf.FieldDescriptor(),
	S2C_TEST_ME = protobuf.Descriptor(),
	S2C_TEST_RET_F = protobuf.FieldDescriptor(),
	EMPTY_MESSAGE_ME = protobuf.Descriptor(),
	C2S_FLUSH_ME = protobuf.Descriptor(),
	C2S_FLUSH_USER_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_RED_POINT_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_KNIGHT_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_FRAGMENT_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_ITEM_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_RESOURCE_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_FORMATION_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_UNITE_TOKEN_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_ADVANCE_EQUIPMENT_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_EQUIPMENT_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_TREASURE_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_DRESS_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_RED_PACKET_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_RANDOM_PLAYER_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_BIOGRAPHY_ITEM_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_SKIN_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_PRIVILEGE_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_ARTIFACT_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_CARD_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_CARDCOMPOS_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_WING_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_WING_REFINES_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_PET_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_PET_EQUIPMENT_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_KSOUL_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_FAVORABILITY_ITEM_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_FURNISHING_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_ACCOUNT_BIND_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_CHAT_RECORD_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_THEME_BIO_ITEM_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_GENE_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_EXPIRABLE_ITEM_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_WEDDING_VOW_F = protobuf.FieldDescriptor(),
	C2S_FLUSH_SUCCUBA_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_ME = protobuf.Descriptor(),
	S2C_FLUSH_RET_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_USER_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_RED_POINT_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_KNIGHT_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_FRAGMENT_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_ITEM_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_RESOURCE_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_FORMATION_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_UNITE_TOKEN_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_ADVANCE_EQUIPMENT_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_EQUIPMENT_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_TREASURE_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_DRESS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_RED_PACKET_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_RANDOM_PLAYER_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_BIOGRAPHY_ITEM_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_SKIN_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_PRIVILEGE_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_ARTIFACT_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_CARD_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_CARDCOMPOSE_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_WING_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_WING_REFINE_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_PET_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_PET_EQUIPMENT_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_KSOUL_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_FAVORABILITY_ITEM_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_FURNISHING_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_ACCOUNT_BIND_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_CHAT_RECORD_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_THEME_BIO_ITEM_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_GENE_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_EXPIRABLE_ITEM_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_WEDDING_VOW_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_SUCCUBA_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_FRAGMENTS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_ITEMS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_RESOURCES_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_FORMATIONS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_UNITE_TOKENS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_ADVANCE_EQUIPMENTS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_EQUIPMENTS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_TREASURES_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_DRESSES_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_RED_PACKETS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_RANDOM_PLAYERS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_BIOGRAPHY_ITEMS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_SKINS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_CARDS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_CARDCOMPOSES_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_WINGS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_WING_REFINES_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_FAVORABILITY_ITEMS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_FURNISHINGS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_ACCOUNT_BIND_RECORDS_F = protobuf.FieldDescriptor(),
	S2C_FLUSH_GENES_F = protobuf.FieldDescriptor(),
	C2S_FLUSHREDPOINT_ME = protobuf.Descriptor(),
	C2S_FLUSHREDPOINT_CROSS_MODULES_F = protobuf.FieldDescriptor(),
	S2C_FLUSHREDPOINT_ME = protobuf.Descriptor(),
	S2C_FLUSHREDPOINT_CROSS_MODULES_F = protobuf.FieldDescriptor(),
	S2C_FLUSHREDPOINT_RED_POINT_F = protobuf.FieldDescriptor(),
	S2C_FLUSHREDPOINT_CROSS_NEW_SLG_F = protobuf.FieldDescriptor(),
	S2C_FLUSHREDPOINT_CROSS_PEAK_ARENA_F = protobuf.FieldDescriptor(),
	S2C_FLUSHREDPOINT_CROSS_ANCIENT_F = protobuf.FieldDescriptor(),
	S2C_FLUSHKNIGHT_ME = protobuf.Descriptor(),
	S2C_FLUSHKNIGHT_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHKNIGHT_FINISH_F = protobuf.FieldDescriptor(),
	S2C_FLUSHEQUIPMENT_ME = protobuf.Descriptor(),
	S2C_FLUSHEQUIPMENT_EQUIPMENTS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHTREASURE_ME = protobuf.Descriptor(),
	S2C_FLUSHTREASURE_TREASURES_F = protobuf.FieldDescriptor(),
	S2C_FLUSHFRAGMENT_ME = protobuf.Descriptor(),
	S2C_FLUSHFRAGMENT_FRAGMENTS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHRESOURCE_ME = protobuf.Descriptor(),
	S2C_FLUSHRESOURCE_RESOURCES_F = protobuf.FieldDescriptor(),
	S2C_FLUSHFORMATION_ME = protobuf.Descriptor(),
	S2C_FLUSHFORMATION_FORMATIONS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHITEM_ME = protobuf.Descriptor(),
	S2C_FLUSHITEM_ITEMS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHADVANCEEQUIPMENT_ME = protobuf.Descriptor(),
	S2C_FLUSHADVANCEEQUIPMENT_ADVANCE_EQUIPMENTS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHUNITETOKEN_ME = protobuf.Descriptor(),
	S2C_FLUSHUNITETOKEN_UNITE_TOKENS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHDRESS_ME = protobuf.Descriptor(),
	S2C_FLUSHDRESS_DRESSES_F = protobuf.FieldDescriptor(),
	S2C_FLUSHSKIN_ME = protobuf.Descriptor(),
	S2C_FLUSHSKIN_SKINS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHREDPACKET_ME = protobuf.Descriptor(),
	S2C_FLUSHREDPACKET_RED_PACKETS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHRANDOMPLAYER_ME = protobuf.Descriptor(),
	S2C_FLUSHRANDOMPLAYER_RANDOM_PLAYERS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHBIOGRAPHYITEM_ME = protobuf.Descriptor(),
	S2C_FLUSHBIOGRAPHYITEM_BIOGRAPHY_ITEMS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHTHEMEBIOITEM_ME = protobuf.Descriptor(),
	S2C_FLUSHTHEMEBIOITEM_ITEMS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHPRIVILEGE_ME = protobuf.Descriptor(),
	S2C_FLUSHPRIVILEGE_IDS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHARTIFACT_ME = protobuf.Descriptor(),
	S2C_FLUSHARTIFACT_ARTIFACTS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHPET_ME = protobuf.Descriptor(),
	S2C_FLUSHPET_PETS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHPETEQUIPMENT_ME = protobuf.Descriptor(),
	S2C_FLUSHPETEQUIPMENT_PETEQUIPMENTS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHKSOUL_ME = protobuf.Descriptor(),
	S2C_FLUSHKSOUL_KSOULS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHFAVORABILITYITEM_ME = protobuf.Descriptor(),
	S2C_FLUSHFAVORABILITYITEM_FAVORABILITY_ITEM_F = protobuf.FieldDescriptor(),
	S2C_FLUSHFURNISHING_ME = protobuf.Descriptor(),
	S2C_FLUSHFURNISHING_FURNISHINGS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHACCOUNTBIND_ME = protobuf.Descriptor(),
	S2C_FLUSHACCOUNTBIND_AWARD_RECORD_F = protobuf.FieldDescriptor(),
	S2C_FLUSHEXPIRABLEITEM_ME = protobuf.Descriptor(),
	S2C_FLUSHEXPIRABLEITEM_ITEMS_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_ME = protobuf.Descriptor(),
	S2C_OPOBJECT_KNIGHT_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_ITEM_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_FRAGMENT_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_RESOURCE_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_UNITE_TOKEN_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_ADVANCE_EQUIPMENT_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_EQUIPMENT_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_TREASURE_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_DRESS_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_RED_PACKET_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_USER_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_BIOGRAPHY_ITEM_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_SKIN_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_ARTIFACT_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_CARD_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_CARDCOMPOSE_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_WING_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_REFINES_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_PET_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_PET_EQUIPMENT_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_KSOUL_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_FAVORABILITY_ITEM_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_FURNISHING_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_HALIDOM_BAG_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_THEME_BIO_ITEM_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_GENE_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_GENE_SEGMENT_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_EXPIRABLE_ITEM_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_PRECIOUS_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_SKIN_PART_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_SUCCUBA_F = protobuf.FieldDescriptor(),
	S2C_OPOBJECT_OUTPOST_ITEM_F = protobuf.FieldDescriptor(),
	C2S_MODIFYUSERINFO_ME = protobuf.Descriptor(),
	C2S_MODIFYUSERINFO_TYPE_F = protobuf.FieldDescriptor(),
	C2S_MODIFYUSERINFO_FRAME_F = protobuf.FieldDescriptor(),
	C2S_MODIFYUSERINFO_NAME_F = protobuf.FieldDescriptor(),
	C2S_MODIFYUSERINFO_SK_DRESS_F = protobuf.FieldDescriptor(),
	S2C_MODIFYUSERINFO_ME = protobuf.Descriptor(),
	S2C_MODIFYUSERINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_MODIFYUSERINFO_TYPE_F = protobuf.FieldDescriptor(),
	S2C_MODIFYUSERINFO_FRAME_F = protobuf.FieldDescriptor(),
	S2C_MODIFYUSERINFO_NAME_F = protobuf.FieldDescriptor(),
	S2C_MODIFYUSERINFO_SK_DRESS_F = protobuf.FieldDescriptor(),
	C2S_GETUSERSTATE_ME = protobuf.Descriptor(),
	C2S_GETUSERSTATE_MODULE_F = protobuf.FieldDescriptor(),
	S2C_GETUSERSTATE_ME = protobuf.Descriptor(),
	S2C_GETUSERSTATE_RET_F = protobuf.FieldDescriptor(),
	S2C_GETUSERSTATE_MODULE_F = protobuf.FieldDescriptor(),
	S2C_GETUSERSTATE_STATES_F = protobuf.FieldDescriptor(),
	C2S_GETMODULETASKINFO_ME = protobuf.Descriptor(),
	C2S_GETMODULETASKINFO_MODULE_ID_F = protobuf.FieldDescriptor(),
	S2C_GETMODULETASKINFO_ME = protobuf.Descriptor(),
	S2C_GETMODULETASKINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GETMODULETASKINFO_MODULE_ID_F = protobuf.FieldDescriptor(),
	S2C_GETMODULETASKINFO_COMMON_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GETMODULETASKINFO_DAILY_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GETMODULETASKINFO_WEEKLY_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GETMODULETASKINFO_COMMON_TASKS_F = protobuf.FieldDescriptor(),
	S2C_GETMODULETASKINFO_DAILY_TASKS_F = protobuf.FieldDescriptor(),
	S2C_GETMODULETASKINFO_WEEKLY_TASKS_F = protobuf.FieldDescriptor(),
	C2S_GETMODULETASKAWARD_ME = protobuf.Descriptor(),
	C2S_GETMODULETASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	C2S_GETMODULETASKAWARD_INDEX_F = protobuf.FieldDescriptor(),
	S2C_GETMODULETASKAWARD_ME = protobuf.Descriptor(),
	S2C_GETMODULETASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_GETMODULETASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_GETMODULETASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GETMODULETASKAWARD_INDEX_F = protobuf.FieldDescriptor(),
	C2S_TESTASYNCBATTLEBEGIN_ME = protobuf.Descriptor(),
	C2S_TESTASYNCBATTLEBEGIN_ENEMY_ID_F = protobuf.FieldDescriptor(),
	S2C_TESTASYNCBATTLEBEGIN_ME = protobuf.Descriptor(),
	S2C_TESTASYNCBATTLEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_TESTASYNCBATTLEBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_TESTASYNCBATTLEFINISH_ME = protobuf.Descriptor(),
	S2C_TESTASYNCBATTLEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_TESTASYNCBATTLEFINISH_RESULT_F = protobuf.FieldDescriptor(),
	S2C_CMDRET_ME = protobuf.Descriptor(),
	S2C_CMDRET_RET_F = protobuf.FieldDescriptor(),
	S2C_CMDRET_CMD_F = protobuf.FieldDescriptor(),
	C2S_GETUSERDETAILINFO_ME = protobuf.Descriptor(),
	C2S_GETUSERDETAILINFO_TP_F = protobuf.FieldDescriptor(),
	C2S_GETUSERDETAILINFO_PLAYER_ID_F = protobuf.FieldDescriptor(),
	C2S_GETUSERDETAILINFO_PLAYER_NAME_F = protobuf.FieldDescriptor(),
	S2C_GETUSERDETAILINFO_ME = protobuf.Descriptor(),
	S2C_GETUSERDETAILINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GETUSERDETAILINFO_TP_F = protobuf.FieldDescriptor(),
	S2C_GETUSERDETAILINFO_PLAYER_ID_F = protobuf.FieldDescriptor(),
	S2C_GETUSERDETAILINFO_PLAYER_NAME_F = protobuf.FieldDescriptor(),
	S2C_GETUSERDETAILINFO_PLAYER_F = protobuf.FieldDescriptor(),
	S2C_GETUSERDETAILINFO_GROW_F = protobuf.FieldDescriptor(),
	C2S_NOTIFYUSERVIEWDETAIL_ME = protobuf.Descriptor(),
	C2S_NOTIFYUSERVIEWDETAIL_TARGET_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_NOTIFYUSERVIEWDETAIL_ME = protobuf.Descriptor(),
	S2C_NOTIFYUSERVIEWDETAIL_VIEW_USER_F = protobuf.FieldDescriptor(),
	BATTLERESSHARETITLE_ME = protobuf.Descriptor(),
	BATTLERESSHARETITLE_OWN_NAME_F = protobuf.FieldDescriptor(),
	BATTLERESSHARETITLE_ENEMY_NAME_F = protobuf.FieldDescriptor(),
	BATTLERESSHARETITLE_OWN_ID_F = protobuf.FieldDescriptor(),
	BATTLERESSHAREINFO_ME = protobuf.Descriptor(),
	BATTLERESSHAREINFO_SHARE_TITLE_F = protobuf.FieldDescriptor(),
	BATTLERESSHAREINFO_IS_WIN_F = protobuf.FieldDescriptor(),
	BATTLERESSHAREINFO_OWN_TEAMS_F = protobuf.FieldDescriptor(),
	BATTLERESSHAREINFO_ENEMY_TEAMS_F = protobuf.FieldDescriptor(),
	CHATSHARE_ME = protobuf.Descriptor(),
	CHATSHARE_SHARE_TYPE_F = protobuf.FieldDescriptor(),
	CHATSHARE_ID_F = protobuf.FieldDescriptor(),
	CHATSHARE_BATTLE_RES_SHARE_TITLE_F = protobuf.FieldDescriptor(),
	CHATSHARE_BATTLE_RES_SHARE_INFO_F = protobuf.FieldDescriptor(),
	CHATSHARE_RECRUIT_AWARDS_F = protobuf.FieldDescriptor(),
	CHATSHARE_PRESET_FORMATION_INFO_F = protobuf.FieldDescriptor(),
	C2S_CHAT_ME = protobuf.Descriptor(),
	C2S_CHAT_CHANNEL_F = protobuf.FieldDescriptor(),
	C2S_CHAT_CONTENT_F = protobuf.FieldDescriptor(),
	C2S_CHAT_NAME_F = protobuf.FieldDescriptor(),
	C2S_CHAT_INVITE_ID_F = protobuf.FieldDescriptor(),
	C2S_CHAT_UNIQUE_ID_F = protobuf.FieldDescriptor(),
	C2S_CHAT_PARAM1_F = protobuf.FieldDescriptor(),
	C2S_CHAT_SHARE_F = protobuf.FieldDescriptor(),
	C2S_CHAT_SUB_TYPE_F = protobuf.FieldDescriptor(),
	C2S_CHAT_VOICE_PATH_F = protobuf.FieldDescriptor(),
	C2S_CHAT_VOICE_TIME_F = protobuf.FieldDescriptor(),
	C2S_CHAT_VOICE_PARAM_F = protobuf.FieldDescriptor(),
	C2S_CHAT_LOOK_F = protobuf.FieldDescriptor(),
	S2C_CHAT_ME = protobuf.Descriptor(),
	S2C_CHAT_RET_F = protobuf.FieldDescriptor(),
	S2C_CHAT_FORBID_TIME_F = protobuf.FieldDescriptor(),
	S2C_CHAT_WORLD_LEFT_TIME_F = protobuf.FieldDescriptor(),
	S2C_CHAT_SHARE_F = protobuf.FieldDescriptor(),
	S2C_CHATBROADCAST_ME = protobuf.Descriptor(),
	S2C_CHATBROADCAST_CHANNEL_F = protobuf.FieldDescriptor(),
	S2C_CHATBROADCAST_CONTENT_F = protobuf.FieldDescriptor(),
	S2C_CHATBROADCAST_USER_F = protobuf.FieldDescriptor(),
	S2C_CHATBROADCAST_INVITE_ID_F = protobuf.FieldDescriptor(),
	S2C_CHATBROADCAST_UNIQUE_ID_F = protobuf.FieldDescriptor(),
	S2C_CHATBROADCAST_PARAM1_F = protobuf.FieldDescriptor(),
	S2C_CHATBROADCAST_SPECIAL_ID_F = protobuf.FieldDescriptor(),
	S2C_CHATBROADCAST_SPECIAL_PARAMS_F = protobuf.FieldDescriptor(),
	S2C_CHATBROADCAST_SHARE_F = protobuf.FieldDescriptor(),
	S2C_CHATBROADCAST_CLEAR_F = protobuf.FieldDescriptor(),
	S2C_CHATBROADCAST_SUB_TYPE_F = protobuf.FieldDescriptor(),
	S2C_CHATBROADCAST_VOICE_PATH_F = protobuf.FieldDescriptor(),
	S2C_CHATBROADCAST_VOICE_TIME_F = protobuf.FieldDescriptor(),
	S2C_CHATBROADCAST_VOICE_PARAM_F = protobuf.FieldDescriptor(),
	S2C_CHATBROADCAST_LOOK_F = protobuf.FieldDescriptor(),
	S2C_CHATBROADCAST_TALK_F = protobuf.FieldDescriptor(),
	CHATCONTENT_ME = protobuf.Descriptor(),
	CHATCONTENT_CHANNEL_F = protobuf.FieldDescriptor(),
	CHATCONTENT_CONTENT_F = protobuf.FieldDescriptor(),
	CHATCONTENT_USER_F = protobuf.FieldDescriptor(),
	CHATCONTENT_INVITE_ID_F = protobuf.FieldDescriptor(),
	CHATCONTENT_UNIQUE_ID_F = protobuf.FieldDescriptor(),
	CHATCONTENT_PARAM1_F = protobuf.FieldDescriptor(),
	CHATCONTENT_SPECIAL_ID_F = protobuf.FieldDescriptor(),
	CHATCONTENT_SPECIAL_PARAMS_F = protobuf.FieldDescriptor(),
	CHATCONTENT_SHARE_F = protobuf.FieldDescriptor(),
	CHATCONTENT_CLEAR_F = protobuf.FieldDescriptor(),
	CHATCONTENT_SUB_TYPE_F = protobuf.FieldDescriptor(),
	CHATCONTENT_VOICE_PATH_F = protobuf.FieldDescriptor(),
	CHATCONTENT_VOICE_TIME_F = protobuf.FieldDescriptor(),
	CHATCONTENT_VOICE_PARAM_F = protobuf.FieldDescriptor(),
	CHATCONTENT_LOOK_F = protobuf.FieldDescriptor(),
	CHATCONTENT_TALK_F = protobuf.FieldDescriptor(),
	CHATCONTENT_TIME_STAMP_F = protobuf.FieldDescriptor(),
	C2S_GETCOMMONRANKLIST_ME = protobuf.Descriptor(),
	C2S_GETCOMMONRANKLIST_ID_F = protobuf.FieldDescriptor(),
	C2S_GETCOMMONRANKLIST_SIZE_F = protobuf.FieldDescriptor(),
	C2S_GETCOMMONRANKLIST_SPECIFY_RANKS_F = protobuf.FieldDescriptor(),
	S2C_GETCOMMONRANKLIST_ME = protobuf.Descriptor(),
	S2C_GETCOMMONRANKLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_GETCOMMONRANKLIST_ID_F = protobuf.FieldDescriptor(),
	S2C_GETCOMMONRANKLIST_SIZE_F = protobuf.FieldDescriptor(),
	S2C_GETCOMMONRANKLIST_SELF_RANK_F = protobuf.FieldDescriptor(),
	S2C_GETCOMMONRANKLIST_RANK_UNITS_F = protobuf.FieldDescriptor(),
	S2C_GETCOMMONRANKLIST_FINISH_F = protobuf.FieldDescriptor(),
	S2C_GETCOMMONRANKLIST_SPECIFY_RANK_UNITS_F = protobuf.FieldDescriptor(),
	C2S_SYNCTIME_ME = protobuf.Descriptor(),
	C2S_SYNCTIME_CLIENT_TIME_F = protobuf.FieldDescriptor(),
	S2C_SYNCTIME_ME = protobuf.Descriptor(),
	S2C_SYNCTIME_RET_F = protobuf.FieldDescriptor(),
	S2C_SYNCTIME_CLIENT_TIME_F = protobuf.FieldDescriptor(),
	S2C_SYNCTIME_SERVER_TIME_F = protobuf.FieldDescriptor(),
	S2C_SYNCTIME_ZONE_F = protobuf.FieldDescriptor(),
	S2C_SYNCTIME_OPEN_F = protobuf.FieldDescriptor(),
	C2S_SELL_ME = protobuf.Descriptor(),
	C2S_SELL_CONSUMES_F = protobuf.FieldDescriptor(),
	S2C_SELL_ME = protobuf.Descriptor(),
	S2C_SELL_RET_F = protobuf.FieldDescriptor(),
	S2C_SELL_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_GETCOMMONPLAYNUM_ME = protobuf.Descriptor(),
	S2C_GETCOMMONPLAYNUM_ME = protobuf.Descriptor(),
	S2C_GETCOMMONPLAYNUM_RET_F = protobuf.FieldDescriptor(),
	S2C_GETCOMMONPLAYNUM_INFOS_F = protobuf.FieldDescriptor(),
	C2S_BUYCOMMONPLAYNUM_ME = protobuf.Descriptor(),
	C2S_BUYCOMMONPLAYNUM_ID_F = protobuf.FieldDescriptor(),
	C2S_BUYCOMMONPLAYNUM_NUM_F = protobuf.FieldDescriptor(),
	S2C_BUYCOMMONPLAYNUM_ME = protobuf.Descriptor(),
	S2C_BUYCOMMONPLAYNUM_RET_F = protobuf.FieldDescriptor(),
	S2C_BUYCOMMONPLAYNUM_INFO_F = protobuf.FieldDescriptor(),
	S2C_FLUSHCOMMONPLAYNUM_ME = protobuf.Descriptor(),
	S2C_FLUSHCOMMONPLAYNUM_RET_F = protobuf.FieldDescriptor(),
	S2C_FLUSHCOMMONPLAYNUM_INFO_F = protobuf.FieldDescriptor(),
	S2C_FLUSHCOMMONPLAYNUM_IS_ADD_F = protobuf.FieldDescriptor(),
	S2C_ACTIONSTATUSFLUSH_ME = protobuf.Descriptor(),
	S2C_ACTIONSTATUSFLUSH_TP_F = protobuf.FieldDescriptor(),
	S2C_ACTIONSTATUSFLUSH_STATUS_F = protobuf.FieldDescriptor(),
	C2S_GETUSERCONFIG_ME = protobuf.Descriptor(),
	S2C_GETUSERCONFIG_ME = protobuf.Descriptor(),
	S2C_GETUSERCONFIG_RET_F = protobuf.FieldDescriptor(),
	S2C_GETUSERCONFIG_CONFIG_F = protobuf.FieldDescriptor(),
	C2S_SETUSERCONFIG_ME = protobuf.Descriptor(),
	C2S_SETUSERCONFIG_TP_F = protobuf.FieldDescriptor(),
	C2S_SETUSERCONFIG_CONFIG_F = protobuf.FieldDescriptor(),
	S2C_SETUSERCONFIG_ME = protobuf.Descriptor(),
	S2C_SETUSERCONFIG_RET_F = protobuf.FieldDescriptor(),
	S2C_SETUSERCONFIG_CONFIG_F = protobuf.FieldDescriptor(),
	S2C_SETUSERCONFIG_LANGUAGE_F = protobuf.FieldDescriptor(),
	S2C_NOTICE_ME = protobuf.Descriptor(),
	S2C_NOTICE_ID_F = protobuf.FieldDescriptor(),
	S2C_NOTICE_PARAMS_F = protobuf.FieldDescriptor(),
	S2C_NOTICE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_NOTICE_FROM_USER_ID_F = protobuf.FieldDescriptor(),
	C2S_GETBATTLEVIDEO_ME = protobuf.Descriptor(),
	C2S_GETBATTLEVIDEO_BATTLE_ID_F = protobuf.FieldDescriptor(),
	C2S_GETBATTLEVIDEO_TP_F = protobuf.FieldDescriptor(),
	S2C_GETBATTLEVIDEO_ME = protobuf.Descriptor(),
	S2C_GETBATTLEVIDEO_RET_F = protobuf.FieldDescriptor(),
	S2C_GETBATTLEVIDEO_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_GETBATTLEVIDEO_BATTLE_VIDEO_F = protobuf.FieldDescriptor(),
	C2S_GETBATTLERECORD_ME = protobuf.Descriptor(),
	C2S_GETBATTLERECORD_FUNCTION_ID_F = protobuf.FieldDescriptor(),
	C2S_GETBATTLERECORD_RECORD_ID_F = protobuf.FieldDescriptor(),
	S2C_GETBATTLERECORD_ME = protobuf.Descriptor(),
	S2C_GETBATTLERECORD_RET_F = protobuf.FieldDescriptor(),
	S2C_GETBATTLERECORD_FUNCTION_ID_F = protobuf.FieldDescriptor(),
	S2C_GETBATTLERECORD_RECORD_ID_F = protobuf.FieldDescriptor(),
	S2C_GETBATTLERECORD_RECORDS_F = protobuf.FieldDescriptor(),
	C2S_GETUSERBATTLETEAM_ME = protobuf.Descriptor(),
	C2S_GETUSERBATTLETEAM_PLAYERS_F = protobuf.FieldDescriptor(),
	S2C_GETUSERBATTLETEAM_ME = protobuf.Descriptor(),
	S2C_GETUSERBATTLETEAM_RET_F = protobuf.FieldDescriptor(),
	S2C_GETUSERBATTLETEAM_TEAMS_F = protobuf.FieldDescriptor(),
	C2S_UPDATERANDOMPLAYER_ME = protobuf.Descriptor(),
	S2C_UPDATERANDOMPLAYER_ME = protobuf.Descriptor(),
	S2C_UPDATERANDOMPLAYER_RET_F = protobuf.FieldDescriptor(),
	S2C_UPDATERANDOMPLAYER_RANDOM_PLAYERS_F = protobuf.FieldDescriptor(),
	C2S_SYNCPROTO_ME = protobuf.Descriptor(),
	C2S_SYNCPROTO_CLIENT_ID_F = protobuf.FieldDescriptor(),
	C2S_SYNCPROTO_SERVER_ID_F = protobuf.FieldDescriptor(),
	S2C_SYNCPROTO_ME = protobuf.Descriptor(),
	S2C_SYNCPROTO_CLIENT_ID_F = protobuf.FieldDescriptor(),
	S2C_SYNCPROTO_SERVER_ID_F = protobuf.FieldDescriptor(),
	S2C_GIFTNOTIFY_ME = protobuf.Descriptor(),
	S2C_GIFTNOTIFY_RET_F = protobuf.FieldDescriptor(),
	S2C_GIFTNOTIFY_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ANTIADDICTIONNOTIFY_ME = protobuf.Descriptor(),
	S2C_ANTIADDICTIONNOTIFY_GAME_TIME_F = protobuf.FieldDescriptor(),
	S2C_ANTIADDICTIONNOTIFY_IS_FCM_F = protobuf.FieldDescriptor(),
	S2C_ANTIADDICTIONNOTIFY_IS_ADULT_F = protobuf.FieldDescriptor(),
	S2C_ANTIADDICTIONNOTIFY_IS_WARNING_F = protobuf.FieldDescriptor(),
	S2C_ANTIADDICTIONNOTIFY_REMAINING_TIME_F = protobuf.FieldDescriptor(),
	S2C_ANTIADDICTIONNOTIFY_FCM_STATUS_F = protobuf.FieldDescriptor(),
	C2S_GETCHATSHARE_ME = protobuf.Descriptor(),
	C2S_GETCHATSHARE_SHARE_TYPE_F = protobuf.FieldDescriptor(),
	C2S_GETCHATSHARE_OWN_ID_F = protobuf.FieldDescriptor(),
	C2S_GETCHATSHARE_ID_F = protobuf.FieldDescriptor(),
	S2C_GETCHATSHARE_ME = protobuf.Descriptor(),
	S2C_GETCHATSHARE_RET_F = protobuf.FieldDescriptor(),
	S2C_GETCHATSHARE_SHARE_INFO_F = protobuf.FieldDescriptor(),
	C2S_FRAMEINFO_ME = protobuf.Descriptor(),
	S2C_FRAMEINFO_ME = protobuf.Descriptor(),
	S2C_FRAMEINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_FRAMEINFO_IDS_F = protobuf.FieldDescriptor(),
	S2C_FRAMEINFO_AVATA_IDS_F = protobuf.FieldDescriptor(),
	S2C_FRAMEINFO_LIMIT_FRAMES_F = protobuf.FieldDescriptor(),
	S2C_FRAMEINFO_LIMIT_AVATAS_F = protobuf.FieldDescriptor(),
	C2S_GIFTCODE_ME = protobuf.Descriptor(),
	C2S_GIFTCODE_CODE_F = protobuf.FieldDescriptor(),
	S2C_GIFTCODE_ME = protobuf.Descriptor(),
	S2C_GIFTCODE_RET_F = protobuf.FieldDescriptor(),
	S2C_GIFTCODE_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_ICONCLICK_ME = protobuf.Descriptor(),
	C2S_ICONCLICK_ICON_ID_F = protobuf.FieldDescriptor(),
	S2C_ICONCLICK_ME = protobuf.Descriptor(),
	S2C_ICONCLICK_RET_F = protobuf.FieldDescriptor(),
	C2S_RFRESHRESOURCE_ME = protobuf.Descriptor(),
	C2S_RFRESHRESOURCE_ID_F = protobuf.FieldDescriptor(),
	S2C_RFRESHRESOURCE_ME = protobuf.Descriptor(),
	S2C_RFRESHRESOURCE_RET_F = protobuf.FieldDescriptor(),
	S2C_RFRESHRESOURCE_RESOURCES_F = protobuf.FieldDescriptor(),
	S2C_FLUSHCARDCOMPOSE_ME = protobuf.Descriptor(),
	S2C_FLUSHCARDCOMPOSE_CARD_COMPOSE_F = protobuf.FieldDescriptor(),
	S2C_FLUSHCARD_ME = protobuf.Descriptor(),
	S2C_FLUSHCARD_CARDS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHWING_ME = protobuf.Descriptor(),
	S2C_FLUSHWING_WING_F = protobuf.FieldDescriptor(),
	S2C_FLUSHWING_WING_REFINES_F = protobuf.FieldDescriptor(),
	C2S_GETMODULEONEKEYTASKAWARD_ME = protobuf.Descriptor(),
	C2S_GETMODULEONEKEYTASKAWARD_MODULE_ID_F = protobuf.FieldDescriptor(),
	S2C_GETMODULEONEKEYTASKAWARD_ME = protobuf.Descriptor(),
	S2C_GETMODULEONEKEYTASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_GETMODULEONEKEYTASKAWARD_MODULE_ID_F = protobuf.FieldDescriptor(),
	S2C_GETMODULEONEKEYTASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_LOGINEND_ME = protobuf.Descriptor(),
	S2C_LOGINEND_ME = protobuf.Descriptor(),
	C2S_SKINSHOPGMINFO_ME = protobuf.Descriptor(),
	S2C_SKINSHOPGMINFO_ME = protobuf.Descriptor(),
	S2C_SKINSHOPGMINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_SKINSHOPGMINFO_INFOS_F = protobuf.FieldDescriptor(),
	CHATRECORD_ME = protobuf.Descriptor(),
	CHATRECORD_CHANNEL_ID_F = protobuf.FieldDescriptor(),
	CHATRECORD_SUB_ID_F = protobuf.FieldDescriptor(),
	CHATRECORD_CONTENTS_F = protobuf.FieldDescriptor(),
	C2S_CHATRECORDGETINFO_ME = protobuf.Descriptor(),
	C2S_CHATRECORDGETINFO_CHANNEL_F = protobuf.FieldDescriptor(),
	S2C_CHATRECORDGETINFO_ME = protobuf.Descriptor(),
	S2C_CHATRECORDGETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_CHATRECORDGETINFO_RECORDS_F = protobuf.FieldDescriptor(),
	C2S_GETUSERSNAPSHOT_ME = protobuf.Descriptor(),
	C2S_GETUSERSNAPSHOT_USER_IDS_F = protobuf.FieldDescriptor(),
	S2C_GETUSERSNAPSHOT_ME = protobuf.Descriptor(),
	S2C_GETUSERSNAPSHOT_RET_F = protobuf.FieldDescriptor(),
	S2C_GETUSERSNAPSHOT_USER_IDS_F = protobuf.FieldDescriptor(),
	S2C_GETUSERSNAPSHOT_SNAPSHOTS_F = protobuf.FieldDescriptor(),
	C2S_GETGUILDSNAPSHOT_ME = protobuf.Descriptor(),
	C2S_GETGUILDSNAPSHOT_GUILD_IDS_F = protobuf.FieldDescriptor(),
	S2C_GETGUILDSNAPSHOT_ME = protobuf.Descriptor(),
	S2C_GETGUILDSNAPSHOT_RET_F = protobuf.FieldDescriptor(),
	S2C_GETGUILDSNAPSHOT_GUILD_IDS_F = protobuf.FieldDescriptor(),
	S2C_GETGUILDSNAPSHOT_SNAPSHOTS_F = protobuf.FieldDescriptor(),
	PACKETHEAD_ME = protobuf.Descriptor(),
	PACKETHEAD_LENGTH_F = protobuf.FieldDescriptor(),
	PACKETHEAD_CMD_F = protobuf.FieldDescriptor(),
	PACKETHEAD_UID_F = protobuf.FieldDescriptor(),
	PACKETHEAD_SID_F = protobuf.FieldDescriptor(),
	PACKETHEAD_CID_F = protobuf.FieldDescriptor(),
	S2C_SPLITPACKET_ME = protobuf.Descriptor(),
	S2C_SPLITPACKET_ORIGIN_PH_F = protobuf.FieldDescriptor(),
	S2C_SPLITPACKET_ORIGIN_ID_F = protobuf.FieldDescriptor(),
	S2C_SPLITPACKET_CURRENT_F = protobuf.FieldDescriptor(),
	S2C_SPLITPACKET_TOTAL_F = protobuf.FieldDescriptor(),
	S2C_SPLITPACKET_DATA_F = protobuf.FieldDescriptor(),
	C2S_TEAMBATTLEENTER_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLEENTER_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLEENTER_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLEENTER_MAP_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLEENTER_ROOM_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLEENTER_USER_DATA_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLEENTER_EVENTS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLEENTER_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLEENTER_CHALLENGE_RESULT_F = protobuf.FieldDescriptor(),
	TEAMBATTLECHALLENGERESULT_ME = protobuf.Descriptor(),
	TEAMBATTLECHALLENGERESULT_ROOM_ID_F = protobuf.FieldDescriptor(),
	TEAMBATTLECHALLENGERESULT_GRID_ID_F = protobuf.FieldDescriptor(),
	TEAMBATTLECHALLENGERESULT_MONSTER_TP_F = protobuf.FieldDescriptor(),
	TEAMBATTLECHALLENGERESULT_IS_WIN_F = protobuf.FieldDescriptor(),
	TEAMBATTLECHALLENGERESULT_RESULT_F = protobuf.FieldDescriptor(),
	TEAMBATTLECHALLENGERESULT_AWARDS_F = protobuf.FieldDescriptor(),
	TEAMBATTLECHALLENGERESULT_ENEMY_HP_LIST_F = protobuf.FieldDescriptor(),
	TEAMBATTLECHALLENGERESULT_KNIGHT_HP_LIST_F = protobuf.FieldDescriptor(),
	TEAMBATTLECHALLENGERESULT_CHALLENGE_TIME_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLECHALLENGERESULT_ME = protobuf.Descriptor(),
	S2C_TEAMBATTLECHALLENGERESULT_RET_F = protobuf.FieldDescriptor(),
	S2C_TEAMBATTLECHALLENGERESULT_CHALLENGE_RESULT_F = protobuf.FieldDescriptor(),
	S2C_FLUSHSKINPART_ME = protobuf.Descriptor(),
	S2C_FLUSHSKINPART_SKIN_PARTS_F = protobuf.FieldDescriptor(),
	S2C_FLUSHSERVERCONFIG_ME = protobuf.Descriptor(),
	S2C_FLUSHSERVERCONFIG_CONFIG_F = protobuf.FieldDescriptor()
}

descriptor_helper.enumValueDescriptorFunc(var_0_6.EOPCARDMAGICALLY_EOPCARDMAGICALLY_WEAR_EI, {
	"eOpCardMagically_Wear",
	0,
	1
})
descriptor_helper.enumValueDescriptorFunc(var_0_6.EOPCARDMAGICALLY_EOPCARDMAGICALLY_UNWEAR_EI, {
	"eOpCardMagically_unWear",
	1,
	2
})
descriptor_helper.enumDescriptorFunc(var_0_6.EOPCARDMAGICALLY_E, {
	"eOpCardMagically",
	".cs.eOpCardMagically",
	{
		var_0_6.EOPCARDMAGICALLY_EOPCARDMAGICALLY_WEAR_EI,
		var_0_6.EOPCARDMAGICALLY_EOPCARDMAGICALLY_UNWEAR_EI
	}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.BULLETSCREENMESSAGE_USER_F, {
	"user",
	".cs.BulletScreenMessage.user",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.USERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.BULLETSCREENMESSAGE_CONTENT_F, {
	"content",
	".cs.BulletScreenMessage.content",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.BULLETSCREENMESSAGE_TIME_F, {
	"time",
	".cs.BulletScreenMessage.time",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.BULLETSCREENMESSAGE_TALK_F, {
	"talk",
	".cs.BulletScreenMessage.talk",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.BULLETSCREENMESSAGE_ARGS_F, {
	"args",
	".cs.BulletScreenMessage.args",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_6.BULLETSCREENMESSAGE_PARAM1_F, {
	"param1",
	".cs.BulletScreenMessage.param1",
	6,
	5,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_6.BULLETSCREENMESSAGE_SHARE_F, {
	"share",
	".cs.BulletScreenMessage.share",
	7,
	6,
	1,
	false,
	nil,
	var_0_6.CHATSHARE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.BULLETSCREENMESSAGE_INVITE_ID_F, {
	"invite_id",
	".cs.BulletScreenMessage.invite_id",
	8,
	7,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_6.BULLETSCREENMESSAGE_UNIQUE_ID_F, {
	"unique_id",
	".cs.BulletScreenMessage.unique_id",
	9,
	8,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_6.BULLETSCREENMESSAGE_ME, {
	"BulletScreenMessage",
	".cs.BulletScreenMessage",
	{},
	{},
	{
		var_0_6.BULLETSCREENMESSAGE_USER_F,
		var_0_6.BULLETSCREENMESSAGE_CONTENT_F,
		var_0_6.BULLETSCREENMESSAGE_TIME_F,
		var_0_6.BULLETSCREENMESSAGE_TALK_F,
		var_0_6.BULLETSCREENMESSAGE_ARGS_F,
		var_0_6.BULLETSCREENMESSAGE_PARAM1_F,
		var_0_6.BULLETSCREENMESSAGE_SHARE_F,
		var_0_6.BULLETSCREENMESSAGE_INVITE_ID_F,
		var_0_6.BULLETSCREENMESSAGE_UNIQUE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_BULLETSCREENGETINFO_TYPE_F, {
	"type",
	".cs.C2S_BulletScreenGetInfo.type",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_BULLETSCREENGETINFO_ME, {
	"C2S_BulletScreenGetInfo",
	".cs.C2S_BulletScreenGetInfo",
	{},
	{},
	{
		var_0_6.C2S_BULLETSCREENGETINFO_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_BULLETSCREENGETINFO_RET_F, {
	"ret",
	".cs.S2C_BulletScreenGetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_BULLETSCREENGETINFO_TYPE_F, {
	"type",
	".cs.S2C_BulletScreenGetInfo.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_BULLETSCREENGETINFO_MESSAGES_F, {
	"messages",
	".cs.S2C_BulletScreenGetInfo.messages",
	3,
	2,
	3,
	false,
	{},
	var_0_6.BULLETSCREENMESSAGE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_BULLETSCREENGETINFO_ME, {
	"S2C_BulletScreenGetInfo",
	".cs.S2C_BulletScreenGetInfo",
	{},
	{},
	{
		var_0_6.S2C_BULLETSCREENGETINFO_RET_F,
		var_0_6.S2C_BULLETSCREENGETINFO_TYPE_F,
		var_0_6.S2C_BULLETSCREENGETINFO_MESSAGES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_BULLETSCREENSEND_TYPE_F, {
	"type",
	".cs.C2S_BulletScreenSend.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_BULLETSCREENSEND_CONTENT_F, {
	"content",
	".cs.C2S_BulletScreenSend.content",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_BULLETSCREENSEND_LOOK_F, {
	"look",
	".cs.C2S_BulletScreenSend.look",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_BULLETSCREENSEND_PARAM1_F, {
	"param1",
	".cs.C2S_BulletScreenSend.param1",
	4,
	3,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_BULLETSCREENSEND_SHARE_F, {
	"share",
	".cs.C2S_BulletScreenSend.share",
	5,
	4,
	1,
	false,
	nil,
	var_0_6.CHATSHARE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_BULLETSCREENSEND_INVITE_ID_F, {
	"invite_id",
	".cs.C2S_BulletScreenSend.invite_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_BULLETSCREENSEND_UNIQUE_ID_F, {
	"unique_id",
	".cs.C2S_BulletScreenSend.unique_id",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_BULLETSCREENSEND_ME, {
	"C2S_BulletScreenSend",
	".cs.C2S_BulletScreenSend",
	{},
	{},
	{
		var_0_6.C2S_BULLETSCREENSEND_TYPE_F,
		var_0_6.C2S_BULLETSCREENSEND_CONTENT_F,
		var_0_6.C2S_BULLETSCREENSEND_LOOK_F,
		var_0_6.C2S_BULLETSCREENSEND_PARAM1_F,
		var_0_6.C2S_BULLETSCREENSEND_SHARE_F,
		var_0_6.C2S_BULLETSCREENSEND_INVITE_ID_F,
		var_0_6.C2S_BULLETSCREENSEND_UNIQUE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_BULLETSCREENSEND_RET_F, {
	"ret",
	".cs.S2C_BulletScreenSend.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_BULLETSCREENSEND_TYPE_F, {
	"type",
	".cs.S2C_BulletScreenSend.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_BULLETSCREENSEND_MESSAGE_F, {
	"message",
	".cs.S2C_BulletScreenSend.message",
	3,
	2,
	1,
	false,
	nil,
	var_0_6.BULLETSCREENMESSAGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_BULLETSCREENSEND_LOOK_F, {
	"look",
	".cs.S2C_BulletScreenSend.look",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_BULLETSCREENSEND_ME, {
	"S2C_BulletScreenSend",
	".cs.S2C_BulletScreenSend",
	{},
	{},
	{
		var_0_6.S2C_BULLETSCREENSEND_RET_F,
		var_0_6.S2C_BULLETSCREENSEND_TYPE_F,
		var_0_6.S2C_BULLETSCREENSEND_MESSAGE_F,
		var_0_6.S2C_BULLETSCREENSEND_LOOK_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_BULLETSCREENNOTIFY_TYPE_F, {
	"type",
	".cs.S2C_BulletScreenNotify.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_BULLETSCREENNOTIFY_MESSAGE_F, {
	"message",
	".cs.S2C_BulletScreenNotify.message",
	2,
	1,
	1,
	false,
	nil,
	var_0_6.BULLETSCREENMESSAGE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_BULLETSCREENNOTIFY_ME, {
	"S2C_BulletScreenNotify",
	".cs.S2C_BulletScreenNotify",
	{},
	{},
	{
		var_0_6.S2C_BULLETSCREENNOTIFY_TYPE_F,
		var_0_6.S2C_BULLETSCREENNOTIFY_MESSAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_TEST_AWARDS_F, {
	"awards",
	".cs.C2S_Test.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_TEST_CONSUMES_F, {
	"consumes",
	".cs.C2S_Test.consumes",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_TEST_TOTAL_LOGIN_DAYS_F, {
	"total_login_days",
	".cs.C2S_Test.total_login_days",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_TEST_LOOP_F, {
	"loop",
	".cs.C2S_Test.loop",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_TEST_ME, {
	"C2S_Test",
	".cs.C2S_Test",
	{},
	{},
	{
		var_0_6.C2S_TEST_AWARDS_F,
		var_0_6.C2S_TEST_CONSUMES_F,
		var_0_6.C2S_TEST_TOTAL_LOGIN_DAYS_F,
		var_0_6.C2S_TEST_LOOP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_TEST_RET_F, {
	"ret",
	".cs.S2C_Test.ret",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_TEST_ME, {
	"S2C_Test",
	".cs.S2C_Test",
	{},
	{},
	{
		var_0_6.S2C_TEST_RET_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_6.EMPTY_MESSAGE_ME, {
	"Empty_Message",
	".cs.Empty_Message",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_USER_F, {
	"user",
	".cs.C2S_Flush.user",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_RED_POINT_F, {
	"red_point",
	".cs.C2S_Flush.red_point",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_KNIGHT_F, {
	"knight",
	".cs.C2S_Flush.knight",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_FRAGMENT_F, {
	"fragment",
	".cs.C2S_Flush.fragment",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_ITEM_F, {
	"item",
	".cs.C2S_Flush.item",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_RESOURCE_F, {
	"resource",
	".cs.C2S_Flush.resource",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_FORMATION_F, {
	"formation",
	".cs.C2S_Flush.formation",
	7,
	6,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_UNITE_TOKEN_F, {
	"unite_token",
	".cs.C2S_Flush.unite_token",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_ADVANCE_EQUIPMENT_F, {
	"advance_equipment",
	".cs.C2S_Flush.advance_equipment",
	9,
	8,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_EQUIPMENT_F, {
	"equipment",
	".cs.C2S_Flush.equipment",
	10,
	9,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_TREASURE_F, {
	"treasure",
	".cs.C2S_Flush.treasure",
	11,
	10,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_DRESS_F, {
	"dress",
	".cs.C2S_Flush.dress",
	12,
	11,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_RED_PACKET_F, {
	"red_packet",
	".cs.C2S_Flush.red_packet",
	13,
	12,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_RANDOM_PLAYER_F, {
	"random_player",
	".cs.C2S_Flush.random_player",
	14,
	13,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_BIOGRAPHY_ITEM_F, {
	"biography_item",
	".cs.C2S_Flush.biography_item",
	15,
	14,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_SKIN_F, {
	"skin",
	".cs.C2S_Flush.skin",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_PRIVILEGE_F, {
	"privilege",
	".cs.C2S_Flush.privilege",
	17,
	16,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_ARTIFACT_F, {
	"artifact",
	".cs.C2S_Flush.artifact",
	18,
	17,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_CARD_F, {
	"card",
	".cs.C2S_Flush.card",
	19,
	18,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_CARDCOMPOS_F, {
	"cardcompos",
	".cs.C2S_Flush.cardcompos",
	20,
	19,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_WING_F, {
	"wing",
	".cs.C2S_Flush.wing",
	21,
	20,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_WING_REFINES_F, {
	"wing_refines",
	".cs.C2S_Flush.wing_refines",
	22,
	21,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_PET_F, {
	"pet",
	".cs.C2S_Flush.pet",
	23,
	22,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_PET_EQUIPMENT_F, {
	"pet_equipment",
	".cs.C2S_Flush.pet_equipment",
	24,
	23,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_KSOUL_F, {
	"kSoul",
	".cs.C2S_Flush.kSoul",
	25,
	24,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_FAVORABILITY_ITEM_F, {
	"favorability_item",
	".cs.C2S_Flush.favorability_item",
	26,
	25,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_FURNISHING_F, {
	"furnishing",
	".cs.C2S_Flush.furnishing",
	27,
	26,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_ACCOUNT_BIND_F, {
	"account_bind",
	".cs.C2S_Flush.account_bind",
	28,
	27,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_CHAT_RECORD_F, {
	"chat_record",
	".cs.C2S_Flush.chat_record",
	29,
	28,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_THEME_BIO_ITEM_F, {
	"theme_bio_item",
	".cs.C2S_Flush.theme_bio_item",
	30,
	29,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_GENE_F, {
	"Gene",
	".cs.C2S_Flush.Gene",
	31,
	30,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_EXPIRABLE_ITEM_F, {
	"expirable_item",
	".cs.C2S_Flush.expirable_item",
	32,
	31,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_WEDDING_VOW_F, {
	"wedding_vow",
	".cs.C2S_Flush.wedding_vow",
	33,
	32,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSH_SUCCUBA_F, {
	"succuba",
	".cs.C2S_Flush.succuba",
	34,
	33,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.descriptorFunc(var_0_6.C2S_FLUSH_ME, {
	"C2S_Flush",
	".cs.C2S_Flush",
	{},
	{},
	{
		var_0_6.C2S_FLUSH_USER_F,
		var_0_6.C2S_FLUSH_RED_POINT_F,
		var_0_6.C2S_FLUSH_KNIGHT_F,
		var_0_6.C2S_FLUSH_FRAGMENT_F,
		var_0_6.C2S_FLUSH_ITEM_F,
		var_0_6.C2S_FLUSH_RESOURCE_F,
		var_0_6.C2S_FLUSH_FORMATION_F,
		var_0_6.C2S_FLUSH_UNITE_TOKEN_F,
		var_0_6.C2S_FLUSH_ADVANCE_EQUIPMENT_F,
		var_0_6.C2S_FLUSH_EQUIPMENT_F,
		var_0_6.C2S_FLUSH_TREASURE_F,
		var_0_6.C2S_FLUSH_DRESS_F,
		var_0_6.C2S_FLUSH_RED_PACKET_F,
		var_0_6.C2S_FLUSH_RANDOM_PLAYER_F,
		var_0_6.C2S_FLUSH_BIOGRAPHY_ITEM_F,
		var_0_6.C2S_FLUSH_SKIN_F,
		var_0_6.C2S_FLUSH_PRIVILEGE_F,
		var_0_6.C2S_FLUSH_ARTIFACT_F,
		var_0_6.C2S_FLUSH_CARD_F,
		var_0_6.C2S_FLUSH_CARDCOMPOS_F,
		var_0_6.C2S_FLUSH_WING_F,
		var_0_6.C2S_FLUSH_WING_REFINES_F,
		var_0_6.C2S_FLUSH_PET_F,
		var_0_6.C2S_FLUSH_PET_EQUIPMENT_F,
		var_0_6.C2S_FLUSH_KSOUL_F,
		var_0_6.C2S_FLUSH_FAVORABILITY_ITEM_F,
		var_0_6.C2S_FLUSH_FURNISHING_F,
		var_0_6.C2S_FLUSH_ACCOUNT_BIND_F,
		var_0_6.C2S_FLUSH_CHAT_RECORD_F,
		var_0_6.C2S_FLUSH_THEME_BIO_ITEM_F,
		var_0_6.C2S_FLUSH_GENE_F,
		var_0_6.C2S_FLUSH_EXPIRABLE_ITEM_F,
		var_0_6.C2S_FLUSH_WEDDING_VOW_F,
		var_0_6.C2S_FLUSH_SUCCUBA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_RET_F, {
	"ret",
	".cs.S2C_Flush.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_USER_F, {
	"user",
	".cs.S2C_Flush.user",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_RED_POINT_F, {
	"red_point",
	".cs.S2C_Flush.red_point",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_KNIGHT_F, {
	"knight",
	".cs.S2C_Flush.knight",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_FRAGMENT_F, {
	"fragment",
	".cs.S2C_Flush.fragment",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_ITEM_F, {
	"item",
	".cs.S2C_Flush.item",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_RESOURCE_F, {
	"resource",
	".cs.S2C_Flush.resource",
	7,
	6,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_FORMATION_F, {
	"formation",
	".cs.S2C_Flush.formation",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_UNITE_TOKEN_F, {
	"unite_token",
	".cs.S2C_Flush.unite_token",
	9,
	8,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_ADVANCE_EQUIPMENT_F, {
	"advance_equipment",
	".cs.S2C_Flush.advance_equipment",
	10,
	9,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_EQUIPMENT_F, {
	"equipment",
	".cs.S2C_Flush.equipment",
	11,
	10,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_TREASURE_F, {
	"treasure",
	".cs.S2C_Flush.treasure",
	12,
	11,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_DRESS_F, {
	"dress",
	".cs.S2C_Flush.dress",
	13,
	12,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_RED_PACKET_F, {
	"red_packet",
	".cs.S2C_Flush.red_packet",
	14,
	13,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_RANDOM_PLAYER_F, {
	"random_player",
	".cs.S2C_Flush.random_player",
	15,
	14,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_BIOGRAPHY_ITEM_F, {
	"biography_item",
	".cs.S2C_Flush.biography_item",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_SKIN_F, {
	"skin",
	".cs.S2C_Flush.skin",
	17,
	16,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_PRIVILEGE_F, {
	"privilege",
	".cs.S2C_Flush.privilege",
	18,
	17,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_ARTIFACT_F, {
	"artifact",
	".cs.S2C_Flush.artifact",
	19,
	18,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_CARD_F, {
	"card",
	".cs.S2C_Flush.card",
	20,
	19,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_CARDCOMPOSE_F, {
	"cardcompose",
	".cs.S2C_Flush.cardcompose",
	21,
	20,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_WING_F, {
	"wing",
	".cs.S2C_Flush.wing",
	22,
	21,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_WING_REFINE_F, {
	"wing_refine",
	".cs.S2C_Flush.wing_refine",
	23,
	22,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_PET_F, {
	"pet",
	".cs.S2C_Flush.pet",
	24,
	23,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_PET_EQUIPMENT_F, {
	"pet_equipment",
	".cs.S2C_Flush.pet_equipment",
	25,
	24,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_KSOUL_F, {
	"kSoul",
	".cs.S2C_Flush.kSoul",
	26,
	25,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_FAVORABILITY_ITEM_F, {
	"favorability_item",
	".cs.S2C_Flush.favorability_item",
	27,
	26,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_FURNISHING_F, {
	"furnishing",
	".cs.S2C_Flush.furnishing",
	28,
	27,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_ACCOUNT_BIND_F, {
	"account_bind",
	".cs.S2C_Flush.account_bind",
	29,
	28,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_CHAT_RECORD_F, {
	"chat_record",
	".cs.S2C_Flush.chat_record",
	30,
	29,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_THEME_BIO_ITEM_F, {
	"theme_bio_item",
	".cs.S2C_Flush.theme_bio_item",
	31,
	30,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_GENE_F, {
	"Gene",
	".cs.S2C_Flush.Gene",
	32,
	31,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_EXPIRABLE_ITEM_F, {
	"expirable_item",
	".cs.S2C_Flush.expirable_item",
	33,
	32,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_WEDDING_VOW_F, {
	"wedding_vow",
	".cs.S2C_Flush.wedding_vow",
	34,
	33,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_SUCCUBA_F, {
	"succuba",
	".cs.S2C_Flush.succuba",
	35,
	34,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_KNIGHTS_F, {
	"knights",
	".cs.S2C_Flush.knights",
	104,
	35,
	3,
	false,
	{},
	var_0_3.KNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_FRAGMENTS_F, {
	"fragments",
	".cs.S2C_Flush.fragments",
	105,
	36,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_ITEMS_F, {
	"items",
	".cs.S2C_Flush.items",
	106,
	37,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_RESOURCES_F, {
	"resources",
	".cs.S2C_Flush.resources",
	107,
	38,
	3,
	false,
	{},
	var_0_3.RESOURCE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_FORMATIONS_F, {
	"formations",
	".cs.S2C_Flush.formations",
	108,
	39,
	1,
	false,
	nil,
	var_0_3.FORMATION_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_UNITE_TOKENS_F, {
	"unite_tokens",
	".cs.S2C_Flush.unite_tokens",
	109,
	40,
	3,
	false,
	{},
	var_0_3.UNITETOKEN_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_ADVANCE_EQUIPMENTS_F, {
	"advance_equipments",
	".cs.S2C_Flush.advance_equipments",
	110,
	41,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_EQUIPMENTS_F, {
	"equipments",
	".cs.S2C_Flush.equipments",
	111,
	42,
	3,
	false,
	{},
	var_0_3.EQUIPMENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_TREASURES_F, {
	"treasures",
	".cs.S2C_Flush.treasures",
	112,
	43,
	3,
	false,
	{},
	var_0_3.TREASURE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_DRESSES_F, {
	"dresses",
	".cs.S2C_Flush.dresses",
	113,
	44,
	3,
	false,
	{},
	var_0_3.DRESS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_RED_PACKETS_F, {
	"red_packets",
	".cs.S2C_Flush.red_packets",
	114,
	45,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_RANDOM_PLAYERS_F, {
	"random_players",
	".cs.S2C_Flush.random_players",
	115,
	46,
	3,
	false,
	{},
	var_0_3.USERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_BIOGRAPHY_ITEMS_F, {
	"biography_items",
	".cs.S2C_Flush.biography_items",
	116,
	47,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_SKINS_F, {
	"skins",
	".cs.S2C_Flush.skins",
	117,
	48,
	3,
	false,
	{},
	var_0_3.SKIN_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_CARDS_F, {
	"cards",
	".cs.S2C_Flush.cards",
	118,
	49,
	3,
	false,
	{},
	var_0_3.CARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_CARDCOMPOSES_F, {
	"cardcomposes",
	".cs.S2C_Flush.cardcomposes",
	119,
	50,
	3,
	false,
	{},
	var_0_3.CARDCOMPOSE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_WINGS_F, {
	"wings",
	".cs.S2C_Flush.wings",
	120,
	51,
	3,
	false,
	{},
	var_0_3.WING_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_WING_REFINES_F, {
	"wing_refines",
	".cs.S2C_Flush.wing_refines",
	121,
	52,
	3,
	false,
	{},
	var_0_3.WINGREFINE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_FAVORABILITY_ITEMS_F, {
	"favorability_items",
	".cs.S2C_Flush.favorability_items",
	122,
	53,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_FURNISHINGS_F, {
	"furnishings",
	".cs.S2C_Flush.furnishings",
	123,
	54,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_ACCOUNT_BIND_RECORDS_F, {
	"account_bind_records",
	".cs.S2C_Flush.account_bind_records",
	124,
	55,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSH_GENES_F, {
	"genes",
	".cs.S2C_Flush.genes",
	125,
	56,
	3,
	false,
	{},
	var_0_3.GENE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSH_ME, {
	"S2C_Flush",
	".cs.S2C_Flush",
	{},
	{},
	{
		var_0_6.S2C_FLUSH_RET_F,
		var_0_6.S2C_FLUSH_USER_F,
		var_0_6.S2C_FLUSH_RED_POINT_F,
		var_0_6.S2C_FLUSH_KNIGHT_F,
		var_0_6.S2C_FLUSH_FRAGMENT_F,
		var_0_6.S2C_FLUSH_ITEM_F,
		var_0_6.S2C_FLUSH_RESOURCE_F,
		var_0_6.S2C_FLUSH_FORMATION_F,
		var_0_6.S2C_FLUSH_UNITE_TOKEN_F,
		var_0_6.S2C_FLUSH_ADVANCE_EQUIPMENT_F,
		var_0_6.S2C_FLUSH_EQUIPMENT_F,
		var_0_6.S2C_FLUSH_TREASURE_F,
		var_0_6.S2C_FLUSH_DRESS_F,
		var_0_6.S2C_FLUSH_RED_PACKET_F,
		var_0_6.S2C_FLUSH_RANDOM_PLAYER_F,
		var_0_6.S2C_FLUSH_BIOGRAPHY_ITEM_F,
		var_0_6.S2C_FLUSH_SKIN_F,
		var_0_6.S2C_FLUSH_PRIVILEGE_F,
		var_0_6.S2C_FLUSH_ARTIFACT_F,
		var_0_6.S2C_FLUSH_CARD_F,
		var_0_6.S2C_FLUSH_CARDCOMPOSE_F,
		var_0_6.S2C_FLUSH_WING_F,
		var_0_6.S2C_FLUSH_WING_REFINE_F,
		var_0_6.S2C_FLUSH_PET_F,
		var_0_6.S2C_FLUSH_PET_EQUIPMENT_F,
		var_0_6.S2C_FLUSH_KSOUL_F,
		var_0_6.S2C_FLUSH_FAVORABILITY_ITEM_F,
		var_0_6.S2C_FLUSH_FURNISHING_F,
		var_0_6.S2C_FLUSH_ACCOUNT_BIND_F,
		var_0_6.S2C_FLUSH_CHAT_RECORD_F,
		var_0_6.S2C_FLUSH_THEME_BIO_ITEM_F,
		var_0_6.S2C_FLUSH_GENE_F,
		var_0_6.S2C_FLUSH_EXPIRABLE_ITEM_F,
		var_0_6.S2C_FLUSH_WEDDING_VOW_F,
		var_0_6.S2C_FLUSH_SUCCUBA_F,
		var_0_6.S2C_FLUSH_KNIGHTS_F,
		var_0_6.S2C_FLUSH_FRAGMENTS_F,
		var_0_6.S2C_FLUSH_ITEMS_F,
		var_0_6.S2C_FLUSH_RESOURCES_F,
		var_0_6.S2C_FLUSH_FORMATIONS_F,
		var_0_6.S2C_FLUSH_UNITE_TOKENS_F,
		var_0_6.S2C_FLUSH_ADVANCE_EQUIPMENTS_F,
		var_0_6.S2C_FLUSH_EQUIPMENTS_F,
		var_0_6.S2C_FLUSH_TREASURES_F,
		var_0_6.S2C_FLUSH_DRESSES_F,
		var_0_6.S2C_FLUSH_RED_PACKETS_F,
		var_0_6.S2C_FLUSH_RANDOM_PLAYERS_F,
		var_0_6.S2C_FLUSH_BIOGRAPHY_ITEMS_F,
		var_0_6.S2C_FLUSH_SKINS_F,
		var_0_6.S2C_FLUSH_CARDS_F,
		var_0_6.S2C_FLUSH_CARDCOMPOSES_F,
		var_0_6.S2C_FLUSH_WINGS_F,
		var_0_6.S2C_FLUSH_WING_REFINES_F,
		var_0_6.S2C_FLUSH_FAVORABILITY_ITEMS_F,
		var_0_6.S2C_FLUSH_FURNISHINGS_F,
		var_0_6.S2C_FLUSH_ACCOUNT_BIND_RECORDS_F,
		var_0_6.S2C_FLUSH_GENES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_FLUSHREDPOINT_CROSS_MODULES_F, {
	"cross_modules",
	".cs.C2S_FlushRedPoint.cross_modules",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_FLUSHREDPOINT_ME, {
	"C2S_FlushRedPoint",
	".cs.C2S_FlushRedPoint",
	{},
	{},
	{
		var_0_6.C2S_FLUSHREDPOINT_CROSS_MODULES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHREDPOINT_CROSS_MODULES_F, {
	"cross_modules",
	".cs.S2C_FlushRedPoint.cross_modules",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHREDPOINT_RED_POINT_F, {
	"red_point",
	".cs.S2C_FlushRedPoint.red_point",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.REDPOINT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHREDPOINT_CROSS_NEW_SLG_F, {
	"cross_new_slg",
	".cs.S2C_FlushRedPoint.cross_new_slg",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.NEWSLGCROSSREDPOINT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHREDPOINT_CROSS_PEAK_ARENA_F, {
	"cross_peak_arena",
	".cs.S2C_FlushRedPoint.cross_peak_arena",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.PEAKARENACROSSHINT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHREDPOINT_CROSS_ANCIENT_F, {
	"cross_ancient",
	".cs.S2C_FlushRedPoint.cross_ancient",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.ANCIENTCROSSREDPOINT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHREDPOINT_ME, {
	"S2C_FlushRedPoint",
	".cs.S2C_FlushRedPoint",
	{},
	{},
	{
		var_0_6.S2C_FLUSHREDPOINT_CROSS_MODULES_F,
		var_0_6.S2C_FLUSHREDPOINT_RED_POINT_F,
		var_0_6.S2C_FLUSHREDPOINT_CROSS_NEW_SLG_F,
		var_0_6.S2C_FLUSHREDPOINT_CROSS_PEAK_ARENA_F,
		var_0_6.S2C_FLUSHREDPOINT_CROSS_ANCIENT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHKNIGHT_KNIGHTS_F, {
	"knights",
	".cs.S2C_FlushKnight.knights",
	1,
	0,
	3,
	false,
	{},
	var_0_3.KNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHKNIGHT_FINISH_F, {
	"finish",
	".cs.S2C_FlushKnight.finish",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHKNIGHT_ME, {
	"S2C_FlushKnight",
	".cs.S2C_FlushKnight",
	{},
	{},
	{
		var_0_6.S2C_FLUSHKNIGHT_KNIGHTS_F,
		var_0_6.S2C_FLUSHKNIGHT_FINISH_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHEQUIPMENT_EQUIPMENTS_F, {
	"equipments",
	".cs.S2C_FlushEquipment.equipments",
	1,
	0,
	3,
	false,
	{},
	var_0_3.EQUIPMENT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHEQUIPMENT_ME, {
	"S2C_FlushEquipment",
	".cs.S2C_FlushEquipment",
	{},
	{},
	{
		var_0_6.S2C_FLUSHEQUIPMENT_EQUIPMENTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHTREASURE_TREASURES_F, {
	"treasures",
	".cs.S2C_FlushTreasure.treasures",
	1,
	0,
	3,
	false,
	{},
	var_0_3.TREASURE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHTREASURE_ME, {
	"S2C_FlushTreasure",
	".cs.S2C_FlushTreasure",
	{},
	{},
	{
		var_0_6.S2C_FLUSHTREASURE_TREASURES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHFRAGMENT_FRAGMENTS_F, {
	"fragments",
	".cs.S2C_FlushFragment.fragments",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHFRAGMENT_ME, {
	"S2C_FlushFragment",
	".cs.S2C_FlushFragment",
	{},
	{},
	{
		var_0_6.S2C_FLUSHFRAGMENT_FRAGMENTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHRESOURCE_RESOURCES_F, {
	"resources",
	".cs.S2C_FlushResource.resources",
	1,
	0,
	3,
	false,
	{},
	var_0_3.RESOURCE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHRESOURCE_ME, {
	"S2C_FlushResource",
	".cs.S2C_FlushResource",
	{},
	{},
	{
		var_0_6.S2C_FLUSHRESOURCE_RESOURCES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHFORMATION_FORMATIONS_F, {
	"formations",
	".cs.S2C_FlushFormation.formations",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.FORMATION_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHFORMATION_ME, {
	"S2C_FlushFormation",
	".cs.S2C_FlushFormation",
	{},
	{},
	{
		var_0_6.S2C_FLUSHFORMATION_FORMATIONS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHITEM_ITEMS_F, {
	"items",
	".cs.S2C_FlushItem.items",
	1,
	0,
	3,
	false,
	{},
	var_0_3.TIMEITEM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHITEM_ME, {
	"S2C_FlushItem",
	".cs.S2C_FlushItem",
	{},
	{},
	{
		var_0_6.S2C_FLUSHITEM_ITEMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHADVANCEEQUIPMENT_ADVANCE_EQUIPMENTS_F, {
	"advance_equipments",
	".cs.S2C_FlushAdvanceEquipment.advance_equipments",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHADVANCEEQUIPMENT_ME, {
	"S2C_FlushAdvanceEquipment",
	".cs.S2C_FlushAdvanceEquipment",
	{},
	{},
	{
		var_0_6.S2C_FLUSHADVANCEEQUIPMENT_ADVANCE_EQUIPMENTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHUNITETOKEN_UNITE_TOKENS_F, {
	"unite_tokens",
	".cs.S2C_FlushUniteToken.unite_tokens",
	1,
	0,
	3,
	false,
	{},
	var_0_3.UNITETOKEN_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHUNITETOKEN_ME, {
	"S2C_FlushUniteToken",
	".cs.S2C_FlushUniteToken",
	{},
	{},
	{
		var_0_6.S2C_FLUSHUNITETOKEN_UNITE_TOKENS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHDRESS_DRESSES_F, {
	"dresses",
	".cs.S2C_FlushDress.dresses",
	1,
	0,
	3,
	false,
	{},
	var_0_3.DRESS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHDRESS_ME, {
	"S2C_FlushDress",
	".cs.S2C_FlushDress",
	{},
	{},
	{
		var_0_6.S2C_FLUSHDRESS_DRESSES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHSKIN_SKINS_F, {
	"skins",
	".cs.S2C_FlushSkin.skins",
	1,
	0,
	3,
	false,
	{},
	var_0_3.SKIN_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHSKIN_ME, {
	"S2C_FlushSkin",
	".cs.S2C_FlushSkin",
	{},
	{},
	{
		var_0_6.S2C_FLUSHSKIN_SKINS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHREDPACKET_RED_PACKETS_F, {
	"red_packets",
	".cs.S2C_FlushRedPacket.red_packets",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHREDPACKET_ME, {
	"S2C_FlushRedPacket",
	".cs.S2C_FlushRedPacket",
	{},
	{},
	{
		var_0_6.S2C_FLUSHREDPACKET_RED_PACKETS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHRANDOMPLAYER_RANDOM_PLAYERS_F, {
	"random_players",
	".cs.S2C_FlushRandomPlayer.random_players",
	1,
	0,
	3,
	false,
	{},
	var_0_3.USERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHRANDOMPLAYER_ME, {
	"S2C_FlushRandomPlayer",
	".cs.S2C_FlushRandomPlayer",
	{},
	{},
	{
		var_0_6.S2C_FLUSHRANDOMPLAYER_RANDOM_PLAYERS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHBIOGRAPHYITEM_BIOGRAPHY_ITEMS_F, {
	"biography_items",
	".cs.S2C_FlushBiographyItem.biography_items",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHBIOGRAPHYITEM_ME, {
	"S2C_FlushBiographyItem",
	".cs.S2C_FlushBiographyItem",
	{},
	{},
	{
		var_0_6.S2C_FLUSHBIOGRAPHYITEM_BIOGRAPHY_ITEMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHTHEMEBIOITEM_ITEMS_F, {
	"items",
	".cs.S2C_FlushThemeBioItem.items",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHTHEMEBIOITEM_ME, {
	"S2C_FlushThemeBioItem",
	".cs.S2C_FlushThemeBioItem",
	{},
	{},
	{
		var_0_6.S2C_FLUSHTHEMEBIOITEM_ITEMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHPRIVILEGE_IDS_F, {
	"ids",
	".cs.S2C_FlushPrivilege.ids",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHPRIVILEGE_ME, {
	"S2C_FlushPrivilege",
	".cs.S2C_FlushPrivilege",
	{},
	{},
	{
		var_0_6.S2C_FLUSHPRIVILEGE_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHARTIFACT_ARTIFACTS_F, {
	"artifacts",
	".cs.S2C_FlushArtifact.artifacts",
	1,
	0,
	3,
	false,
	{},
	var_0_3.ARTIFACT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHARTIFACT_ME, {
	"S2C_FlushArtifact",
	".cs.S2C_FlushArtifact",
	{},
	{},
	{
		var_0_6.S2C_FLUSHARTIFACT_ARTIFACTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHPET_PETS_F, {
	"pets",
	".cs.S2C_FlushPet.pets",
	1,
	0,
	3,
	false,
	{},
	var_0_3.PET_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHPET_ME, {
	"S2C_FlushPet",
	".cs.S2C_FlushPet",
	{},
	{},
	{
		var_0_6.S2C_FLUSHPET_PETS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHPETEQUIPMENT_PETEQUIPMENTS_F, {
	"petEquipments",
	".cs.S2C_FlushPetEquipment.petEquipments",
	1,
	0,
	3,
	false,
	{},
	var_0_3.PETEQUIPMENT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHPETEQUIPMENT_ME, {
	"S2C_FlushPetEquipment",
	".cs.S2C_FlushPetEquipment",
	{},
	{},
	{
		var_0_6.S2C_FLUSHPETEQUIPMENT_PETEQUIPMENTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHKSOUL_KSOULS_F, {
	"kSouls",
	".cs.S2C_FlushKSoul.kSouls",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHKSOUL_ME, {
	"S2C_FlushKSoul",
	".cs.S2C_FlushKSoul",
	{},
	{},
	{
		var_0_6.S2C_FLUSHKSOUL_KSOULS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHFAVORABILITYITEM_FAVORABILITY_ITEM_F, {
	"favorability_item",
	".cs.S2C_FlushFavorabilityItem.favorability_item",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHFAVORABILITYITEM_ME, {
	"S2C_FlushFavorabilityItem",
	".cs.S2C_FlushFavorabilityItem",
	{},
	{},
	{
		var_0_6.S2C_FLUSHFAVORABILITYITEM_FAVORABILITY_ITEM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHFURNISHING_FURNISHINGS_F, {
	"furnishings",
	".cs.S2C_FlushFurnishing.furnishings",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHFURNISHING_ME, {
	"S2C_FlushFurnishing",
	".cs.S2C_FlushFurnishing",
	{},
	{},
	{
		var_0_6.S2C_FLUSHFURNISHING_FURNISHINGS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHACCOUNTBIND_AWARD_RECORD_F, {
	"award_record",
	".cs.S2C_FlushAccountBind.award_record",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHACCOUNTBIND_ME, {
	"S2C_FlushAccountBind",
	".cs.S2C_FlushAccountBind",
	{},
	{},
	{
		var_0_6.S2C_FLUSHACCOUNTBIND_AWARD_RECORD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHEXPIRABLEITEM_ITEMS_F, {
	"items",
	".cs.S2C_FlushExpirableItem.items",
	1,
	0,
	3,
	false,
	{},
	var_0_3.EXPIRABLEITEM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHEXPIRABLEITEM_ME, {
	"S2C_FlushExpirableItem",
	".cs.S2C_FlushExpirableItem",
	{},
	{},
	{
		var_0_6.S2C_FLUSHEXPIRABLEITEM_ITEMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_KNIGHT_F, {
	"knight",
	".cs.S2C_OpObject.knight",
	2,
	0,
	1,
	false,
	nil,
	var_0_3.OPKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_ITEM_F, {
	"item",
	".cs.S2C_OpObject.item",
	3,
	1,
	1,
	false,
	nil,
	var_0_3.OPTIMEITEM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_FRAGMENT_F, {
	"fragment",
	".cs.S2C_OpObject.fragment",
	4,
	2,
	1,
	false,
	nil,
	var_0_3.OPKV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_RESOURCE_F, {
	"resource",
	".cs.S2C_OpObject.resource",
	5,
	3,
	1,
	false,
	nil,
	var_0_3.OPRESOURCE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_UNITE_TOKEN_F, {
	"unite_token",
	".cs.S2C_OpObject.unite_token",
	6,
	4,
	1,
	false,
	nil,
	var_0_3.OPUNITETOKEN_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_ADVANCE_EQUIPMENT_F, {
	"advance_equipment",
	".cs.S2C_OpObject.advance_equipment",
	7,
	5,
	1,
	false,
	nil,
	var_0_3.OPKV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_EQUIPMENT_F, {
	"equipment",
	".cs.S2C_OpObject.equipment",
	8,
	6,
	1,
	false,
	nil,
	var_0_3.OPEQUIPMENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_TREASURE_F, {
	"treasure",
	".cs.S2C_OpObject.treasure",
	9,
	7,
	1,
	false,
	nil,
	var_0_3.OPTREASURE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_DRESS_F, {
	"dress",
	".cs.S2C_OpObject.dress",
	10,
	8,
	1,
	false,
	nil,
	var_0_3.OPDRESS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_RED_PACKET_F, {
	"red_packet",
	".cs.S2C_OpObject.red_packet",
	11,
	9,
	1,
	false,
	nil,
	var_0_3.OPKV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_USER_F, {
	"user",
	".cs.S2C_OpObject.user",
	12,
	10,
	1,
	false,
	nil,
	var_0_3.USER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_BIOGRAPHY_ITEM_F, {
	"biography_item",
	".cs.S2C_OpObject.biography_item",
	13,
	11,
	1,
	false,
	nil,
	var_0_3.OPKV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_SKIN_F, {
	"skin",
	".cs.S2C_OpObject.skin",
	14,
	12,
	1,
	false,
	nil,
	var_0_3.OPSKIN_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_ARTIFACT_F, {
	"artifact",
	".cs.S2C_OpObject.artifact",
	16,
	13,
	1,
	false,
	nil,
	var_0_3.OPARTIFACT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_CARD_F, {
	"card",
	".cs.S2C_OpObject.card",
	19,
	14,
	1,
	false,
	nil,
	var_0_3.OPCARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_CARDCOMPOSE_F, {
	"cardcompose",
	".cs.S2C_OpObject.cardcompose",
	20,
	15,
	1,
	false,
	nil,
	var_0_3.OPCARDCOMPOSE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_WING_F, {
	"wing",
	".cs.S2C_OpObject.wing",
	21,
	16,
	1,
	false,
	nil,
	var_0_3.OPWING_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_REFINES_F, {
	"refines",
	".cs.S2C_OpObject.refines",
	22,
	17,
	1,
	false,
	nil,
	var_0_3.OPWINGREFINE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_PET_F, {
	"pet",
	".cs.S2C_OpObject.pet",
	23,
	18,
	1,
	false,
	nil,
	var_0_3.OPPET_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_PET_EQUIPMENT_F, {
	"pet_equipment",
	".cs.S2C_OpObject.pet_equipment",
	24,
	19,
	1,
	false,
	nil,
	var_0_3.OPPETEQUIPMENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_KSOUL_F, {
	"kSoul",
	".cs.S2C_OpObject.kSoul",
	25,
	20,
	1,
	false,
	nil,
	var_0_3.OPKV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_FAVORABILITY_ITEM_F, {
	"favorability_item",
	".cs.S2C_OpObject.favorability_item",
	27,
	21,
	1,
	false,
	nil,
	var_0_3.OPKV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_FURNISHING_F, {
	"furnishing",
	".cs.S2C_OpObject.furnishing",
	28,
	22,
	1,
	false,
	nil,
	var_0_3.OPKV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_HALIDOM_BAG_F, {
	"halidom_bag",
	".cs.S2C_OpObject.halidom_bag",
	29,
	23,
	1,
	false,
	nil,
	var_0_3.OPKV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_THEME_BIO_ITEM_F, {
	"theme_bio_item",
	".cs.S2C_OpObject.theme_bio_item",
	30,
	24,
	1,
	false,
	nil,
	var_0_3.OPKV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_GENE_F, {
	"gene",
	".cs.S2C_OpObject.gene",
	31,
	25,
	1,
	false,
	nil,
	var_0_3.OPGENE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_GENE_SEGMENT_F, {
	"gene_segment",
	".cs.S2C_OpObject.gene_segment",
	32,
	26,
	1,
	false,
	nil,
	var_0_3.OPGENESEGMENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_EXPIRABLE_ITEM_F, {
	"expirable_item",
	".cs.S2C_OpObject.expirable_item",
	33,
	27,
	1,
	false,
	nil,
	var_0_3.OPEXPIRABLEITEM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_PRECIOUS_F, {
	"precious",
	".cs.S2C_OpObject.precious",
	34,
	28,
	1,
	false,
	nil,
	var_0_3.OPPRECIOUS_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_SKIN_PART_F, {
	"skin_part",
	".cs.S2C_OpObject.skin_part",
	35,
	29,
	1,
	false,
	nil,
	var_0_3.OPUSERSKINPART_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_SUCCUBA_F, {
	"succuba",
	".cs.S2C_OpObject.succuba",
	36,
	30,
	1,
	false,
	nil,
	var_0_3.OPSUCCUBA_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_OPOBJECT_OUTPOST_ITEM_F, {
	"outpost_item",
	".cs.S2C_OpObject.outpost_item",
	37,
	31,
	1,
	false,
	nil,
	var_0_3.OPOUTPOSTITEM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_OPOBJECT_ME, {
	"S2C_OpObject",
	".cs.S2C_OpObject",
	{},
	{},
	{
		var_0_6.S2C_OPOBJECT_KNIGHT_F,
		var_0_6.S2C_OPOBJECT_ITEM_F,
		var_0_6.S2C_OPOBJECT_FRAGMENT_F,
		var_0_6.S2C_OPOBJECT_RESOURCE_F,
		var_0_6.S2C_OPOBJECT_UNITE_TOKEN_F,
		var_0_6.S2C_OPOBJECT_ADVANCE_EQUIPMENT_F,
		var_0_6.S2C_OPOBJECT_EQUIPMENT_F,
		var_0_6.S2C_OPOBJECT_TREASURE_F,
		var_0_6.S2C_OPOBJECT_DRESS_F,
		var_0_6.S2C_OPOBJECT_RED_PACKET_F,
		var_0_6.S2C_OPOBJECT_USER_F,
		var_0_6.S2C_OPOBJECT_BIOGRAPHY_ITEM_F,
		var_0_6.S2C_OPOBJECT_SKIN_F,
		var_0_6.S2C_OPOBJECT_ARTIFACT_F,
		var_0_6.S2C_OPOBJECT_CARD_F,
		var_0_6.S2C_OPOBJECT_CARDCOMPOSE_F,
		var_0_6.S2C_OPOBJECT_WING_F,
		var_0_6.S2C_OPOBJECT_REFINES_F,
		var_0_6.S2C_OPOBJECT_PET_F,
		var_0_6.S2C_OPOBJECT_PET_EQUIPMENT_F,
		var_0_6.S2C_OPOBJECT_KSOUL_F,
		var_0_6.S2C_OPOBJECT_FAVORABILITY_ITEM_F,
		var_0_6.S2C_OPOBJECT_FURNISHING_F,
		var_0_6.S2C_OPOBJECT_HALIDOM_BAG_F,
		var_0_6.S2C_OPOBJECT_THEME_BIO_ITEM_F,
		var_0_6.S2C_OPOBJECT_GENE_F,
		var_0_6.S2C_OPOBJECT_GENE_SEGMENT_F,
		var_0_6.S2C_OPOBJECT_EXPIRABLE_ITEM_F,
		var_0_6.S2C_OPOBJECT_PRECIOUS_F,
		var_0_6.S2C_OPOBJECT_SKIN_PART_F,
		var_0_6.S2C_OPOBJECT_SUCCUBA_F,
		var_0_6.S2C_OPOBJECT_OUTPOST_ITEM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_MODIFYUSERINFO_TYPE_F, {
	"type",
	".cs.C2S_ModifyUserInfo.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_MODIFYUSERINFO_FRAME_F, {
	"frame",
	".cs.C2S_ModifyUserInfo.frame",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_MODIFYUSERINFO_NAME_F, {
	"name",
	".cs.C2S_ModifyUserInfo.name",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_MODIFYUSERINFO_SK_DRESS_F, {
	"sk_dress",
	".cs.C2S_ModifyUserInfo.sk_dress",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_MODIFYUSERINFO_ME, {
	"C2S_ModifyUserInfo",
	".cs.C2S_ModifyUserInfo",
	{},
	{},
	{
		var_0_6.C2S_MODIFYUSERINFO_TYPE_F,
		var_0_6.C2S_MODIFYUSERINFO_FRAME_F,
		var_0_6.C2S_MODIFYUSERINFO_NAME_F,
		var_0_6.C2S_MODIFYUSERINFO_SK_DRESS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_MODIFYUSERINFO_RET_F, {
	"ret",
	".cs.S2C_ModifyUserInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_MODIFYUSERINFO_TYPE_F, {
	"type",
	".cs.S2C_ModifyUserInfo.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_MODIFYUSERINFO_FRAME_F, {
	"frame",
	".cs.S2C_ModifyUserInfo.frame",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_MODIFYUSERINFO_NAME_F, {
	"name",
	".cs.S2C_ModifyUserInfo.name",
	4,
	3,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_MODIFYUSERINFO_SK_DRESS_F, {
	"sk_dress",
	".cs.S2C_ModifyUserInfo.sk_dress",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_MODIFYUSERINFO_ME, {
	"S2C_ModifyUserInfo",
	".cs.S2C_ModifyUserInfo",
	{},
	{},
	{
		var_0_6.S2C_MODIFYUSERINFO_RET_F,
		var_0_6.S2C_MODIFYUSERINFO_TYPE_F,
		var_0_6.S2C_MODIFYUSERINFO_FRAME_F,
		var_0_6.S2C_MODIFYUSERINFO_NAME_F,
		var_0_6.S2C_MODIFYUSERINFO_SK_DRESS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETUSERSTATE_MODULE_F, {
	"module",
	".cs.C2S_GetUserState.module",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_GETUSERSTATE_ME, {
	"C2S_GetUserState",
	".cs.C2S_GetUserState",
	{},
	{},
	{
		var_0_6.C2S_GETUSERSTATE_MODULE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETUSERSTATE_RET_F, {
	"ret",
	".cs.S2C_GetUserState.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETUSERSTATE_MODULE_F, {
	"module",
	".cs.S2C_GetUserState.module",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETUSERSTATE_STATES_F, {
	"states",
	".cs.S2C_GetUserState.states",
	3,
	2,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_GETUSERSTATE_ME, {
	"S2C_GetUserState",
	".cs.S2C_GetUserState",
	{},
	{},
	{
		var_0_6.S2C_GETUSERSTATE_RET_F,
		var_0_6.S2C_GETUSERSTATE_MODULE_F,
		var_0_6.S2C_GETUSERSTATE_STATES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETMODULETASKINFO_MODULE_ID_F, {
	"module_id",
	".cs.C2S_GetModuleTaskInfo.module_id",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_GETMODULETASKINFO_ME, {
	"C2S_GetModuleTaskInfo",
	".cs.C2S_GetModuleTaskInfo",
	{},
	{},
	{
		var_0_6.C2S_GETMODULETASKINFO_MODULE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETMODULETASKINFO_RET_F, {
	"ret",
	".cs.S2C_GetModuleTaskInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETMODULETASKINFO_MODULE_ID_F, {
	"module_id",
	".cs.S2C_GetModuleTaskInfo.module_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETMODULETASKINFO_COMMON_AWARDS_F, {
	"common_awards",
	".cs.S2C_GetModuleTaskInfo.common_awards",
	3,
	2,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETMODULETASKINFO_DAILY_AWARDS_F, {
	"daily_awards",
	".cs.S2C_GetModuleTaskInfo.daily_awards",
	4,
	3,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETMODULETASKINFO_WEEKLY_AWARDS_F, {
	"weekly_awards",
	".cs.S2C_GetModuleTaskInfo.weekly_awards",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETMODULETASKINFO_COMMON_TASKS_F, {
	"common_tasks",
	".cs.S2C_GetModuleTaskInfo.common_tasks",
	6,
	5,
	3,
	false,
	{},
	var_0_3.TASKINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETMODULETASKINFO_DAILY_TASKS_F, {
	"daily_tasks",
	".cs.S2C_GetModuleTaskInfo.daily_tasks",
	7,
	6,
	3,
	false,
	{},
	var_0_3.TASKINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETMODULETASKINFO_WEEKLY_TASKS_F, {
	"weekly_tasks",
	".cs.S2C_GetModuleTaskInfo.weekly_tasks",
	8,
	7,
	3,
	false,
	{},
	var_0_3.TASKINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_GETMODULETASKINFO_ME, {
	"S2C_GetModuleTaskInfo",
	".cs.S2C_GetModuleTaskInfo",
	{},
	{},
	{
		var_0_6.S2C_GETMODULETASKINFO_RET_F,
		var_0_6.S2C_GETMODULETASKINFO_MODULE_ID_F,
		var_0_6.S2C_GETMODULETASKINFO_COMMON_AWARDS_F,
		var_0_6.S2C_GETMODULETASKINFO_DAILY_AWARDS_F,
		var_0_6.S2C_GETMODULETASKINFO_WEEKLY_AWARDS_F,
		var_0_6.S2C_GETMODULETASKINFO_COMMON_TASKS_F,
		var_0_6.S2C_GETMODULETASKINFO_DAILY_TASKS_F,
		var_0_6.S2C_GETMODULETASKINFO_WEEKLY_TASKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETMODULETASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.C2S_GetModuleTaskAward.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETMODULETASKAWARD_INDEX_F, {
	"index",
	".cs.C2S_GetModuleTaskAward.index",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_GETMODULETASKAWARD_ME, {
	"C2S_GetModuleTaskAward",
	".cs.C2S_GetModuleTaskAward",
	{},
	{},
	{
		var_0_6.C2S_GETMODULETASKAWARD_TASK_ID_F,
		var_0_6.C2S_GETMODULETASKAWARD_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETMODULETASKAWARD_RET_F, {
	"ret",
	".cs.S2C_GetModuleTaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETMODULETASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.S2C_GetModuleTaskAward.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETMODULETASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_GetModuleTaskAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETMODULETASKAWARD_INDEX_F, {
	"index",
	".cs.S2C_GetModuleTaskAward.index",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_GETMODULETASKAWARD_ME, {
	"S2C_GetModuleTaskAward",
	".cs.S2C_GetModuleTaskAward",
	{},
	{},
	{
		var_0_6.S2C_GETMODULETASKAWARD_RET_F,
		var_0_6.S2C_GETMODULETASKAWARD_TASK_ID_F,
		var_0_6.S2C_GETMODULETASKAWARD_AWARDS_F,
		var_0_6.S2C_GETMODULETASKAWARD_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_TESTASYNCBATTLEBEGIN_ENEMY_ID_F, {
	"enemy_id",
	".cs.C2S_TestAsyncBattleBegin.enemy_id",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_TESTASYNCBATTLEBEGIN_ME, {
	"C2S_TestAsyncBattleBegin",
	".cs.C2S_TestAsyncBattleBegin",
	{},
	{},
	{
		var_0_6.C2S_TESTASYNCBATTLEBEGIN_ENEMY_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_TESTASYNCBATTLEBEGIN_RET_F, {
	"ret",
	".cs.S2C_TestAsyncBattleBegin.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_TESTASYNCBATTLEBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_TestAsyncBattleBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_TESTASYNCBATTLEBEGIN_ME, {
	"S2C_TestAsyncBattleBegin",
	".cs.S2C_TestAsyncBattleBegin",
	{},
	{},
	{
		var_0_6.S2C_TESTASYNCBATTLEBEGIN_RET_F,
		var_0_6.S2C_TESTASYNCBATTLEBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_TESTASYNCBATTLEFINISH_RET_F, {
	"ret",
	".cs.S2C_TestAsyncBattleFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_TESTASYNCBATTLEFINISH_RESULT_F, {
	"result",
	".cs.S2C_TestAsyncBattleFinish.result",
	2,
	1,
	1,
	false,
	nil,
	var_0_4.CHECKRESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_TESTASYNCBATTLEFINISH_ME, {
	"S2C_TestAsyncBattleFinish",
	".cs.S2C_TestAsyncBattleFinish",
	{},
	{},
	{
		var_0_6.S2C_TESTASYNCBATTLEFINISH_RET_F,
		var_0_6.S2C_TESTASYNCBATTLEFINISH_RESULT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CMDRET_RET_F, {
	"ret",
	".cs.S2C_CmdRet.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CMDRET_CMD_F, {
	"cmd",
	".cs.S2C_CmdRet.cmd",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_CMDRET_ME, {
	"S2C_CmdRet",
	".cs.S2C_CmdRet",
	{},
	{},
	{
		var_0_6.S2C_CMDRET_RET_F,
		var_0_6.S2C_CMDRET_CMD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETUSERDETAILINFO_TP_F, {
	"tp",
	".cs.C2S_GetUserDetailInfo.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETUSERDETAILINFO_PLAYER_ID_F, {
	"player_id",
	".cs.C2S_GetUserDetailInfo.player_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETUSERDETAILINFO_PLAYER_NAME_F, {
	"player_name",
	".cs.C2S_GetUserDetailInfo.player_name",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_GETUSERDETAILINFO_ME, {
	"C2S_GetUserDetailInfo",
	".cs.C2S_GetUserDetailInfo",
	{},
	{},
	{
		var_0_6.C2S_GETUSERDETAILINFO_TP_F,
		var_0_6.C2S_GETUSERDETAILINFO_PLAYER_ID_F,
		var_0_6.C2S_GETUSERDETAILINFO_PLAYER_NAME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETUSERDETAILINFO_RET_F, {
	"ret",
	".cs.S2C_GetUserDetailInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETUSERDETAILINFO_TP_F, {
	"tp",
	".cs.S2C_GetUserDetailInfo.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETUSERDETAILINFO_PLAYER_ID_F, {
	"player_id",
	".cs.S2C_GetUserDetailInfo.player_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETUSERDETAILINFO_PLAYER_NAME_F, {
	"player_name",
	".cs.S2C_GetUserDetailInfo.player_name",
	4,
	3,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETUSERDETAILINFO_PLAYER_F, {
	"player",
	".cs.S2C_GetUserDetailInfo.player",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.BATTLEUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETUSERDETAILINFO_GROW_F, {
	"grow",
	".cs.S2C_GetUserDetailInfo.grow",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.USERGROWDATA_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_GETUSERDETAILINFO_ME, {
	"S2C_GetUserDetailInfo",
	".cs.S2C_GetUserDetailInfo",
	{},
	{},
	{
		var_0_6.S2C_GETUSERDETAILINFO_RET_F,
		var_0_6.S2C_GETUSERDETAILINFO_TP_F,
		var_0_6.S2C_GETUSERDETAILINFO_PLAYER_ID_F,
		var_0_6.S2C_GETUSERDETAILINFO_PLAYER_NAME_F,
		var_0_6.S2C_GETUSERDETAILINFO_PLAYER_F,
		var_0_6.S2C_GETUSERDETAILINFO_GROW_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_NOTIFYUSERVIEWDETAIL_TARGET_USER_ID_F, {
	"target_user_id",
	".cs.C2S_NotifyUserViewDetail.target_user_id",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_NOTIFYUSERVIEWDETAIL_ME, {
	"C2S_NotifyUserViewDetail",
	".cs.C2S_NotifyUserViewDetail",
	{},
	{},
	{
		var_0_6.C2S_NOTIFYUSERVIEWDETAIL_TARGET_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_NOTIFYUSERVIEWDETAIL_VIEW_USER_F, {
	"view_user",
	".cs.S2C_NotifyUserViewDetail.view_user",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.USERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_NOTIFYUSERVIEWDETAIL_ME, {
	"S2C_NotifyUserViewDetail",
	".cs.S2C_NotifyUserViewDetail",
	{},
	{},
	{
		var_0_6.S2C_NOTIFYUSERVIEWDETAIL_VIEW_USER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.BATTLERESSHARETITLE_OWN_NAME_F, {
	"own_name",
	".cs.BattleResShareTitle.own_name",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.BATTLERESSHARETITLE_ENEMY_NAME_F, {
	"enemy_name",
	".cs.BattleResShareTitle.enemy_name",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.BATTLERESSHARETITLE_OWN_ID_F, {
	"own_id",
	".cs.BattleResShareTitle.own_id",
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
descriptor_helper.descriptorFunc(var_0_6.BATTLERESSHARETITLE_ME, {
	"BattleResShareTitle",
	".cs.BattleResShareTitle",
	{},
	{},
	{
		var_0_6.BATTLERESSHARETITLE_OWN_NAME_F,
		var_0_6.BATTLERESSHARETITLE_ENEMY_NAME_F,
		var_0_6.BATTLERESSHARETITLE_OWN_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.BATTLERESSHAREINFO_SHARE_TITLE_F, {
	"share_title",
	".cs.BattleResShareInfo.share_title",
	1,
	0,
	2,
	false,
	nil,
	var_0_6.BATTLERESSHARETITLE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.BATTLERESSHAREINFO_IS_WIN_F, {
	"is_win",
	".cs.BattleResShareInfo.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.BATTLERESSHAREINFO_OWN_TEAMS_F, {
	"own_teams",
	".cs.BattleResShareInfo.own_teams",
	3,
	2,
	3,
	false,
	{},
	var_0_4.BATTLEUNITRESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.BATTLERESSHAREINFO_ENEMY_TEAMS_F, {
	"enemy_teams",
	".cs.BattleResShareInfo.enemy_teams",
	4,
	3,
	3,
	false,
	{},
	var_0_4.BATTLEUNITRESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.BATTLERESSHAREINFO_ME, {
	"BattleResShareInfo",
	".cs.BattleResShareInfo",
	{},
	{},
	{
		var_0_6.BATTLERESSHAREINFO_SHARE_TITLE_F,
		var_0_6.BATTLERESSHAREINFO_IS_WIN_F,
		var_0_6.BATTLERESSHAREINFO_OWN_TEAMS_F,
		var_0_6.BATTLERESSHAREINFO_ENEMY_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATSHARE_SHARE_TYPE_F, {
	"share_type",
	".cs.ChatShare.share_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATSHARE_ID_F, {
	"id",
	".cs.ChatShare.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATSHARE_BATTLE_RES_SHARE_TITLE_F, {
	"battle_res_share_title",
	".cs.ChatShare.battle_res_share_title",
	3,
	2,
	1,
	false,
	nil,
	var_0_6.BATTLERESSHARETITLE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATSHARE_BATTLE_RES_SHARE_INFO_F, {
	"battle_res_share_info",
	".cs.ChatShare.battle_res_share_info",
	4,
	3,
	1,
	false,
	nil,
	var_0_6.BATTLERESSHAREINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATSHARE_RECRUIT_AWARDS_F, {
	"recruit_awards",
	".cs.ChatShare.recruit_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATSHARE_PRESET_FORMATION_INFO_F, {
	"preset_formation_info",
	".cs.ChatShare.preset_formation_info",
	6,
	5,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_6.CHATSHARE_ME, {
	"ChatShare",
	".cs.ChatShare",
	{},
	{},
	{
		var_0_6.CHATSHARE_SHARE_TYPE_F,
		var_0_6.CHATSHARE_ID_F,
		var_0_6.CHATSHARE_BATTLE_RES_SHARE_TITLE_F,
		var_0_6.CHATSHARE_BATTLE_RES_SHARE_INFO_F,
		var_0_6.CHATSHARE_RECRUIT_AWARDS_F,
		var_0_6.CHATSHARE_PRESET_FORMATION_INFO_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_CHAT_CHANNEL_F, {
	"channel",
	".cs.C2S_Chat.channel",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_CHAT_CONTENT_F, {
	"content",
	".cs.C2S_Chat.content",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_CHAT_NAME_F, {
	"name",
	".cs.C2S_Chat.name",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_CHAT_INVITE_ID_F, {
	"invite_id",
	".cs.C2S_Chat.invite_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_CHAT_UNIQUE_ID_F, {
	"unique_id",
	".cs.C2S_Chat.unique_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_CHAT_PARAM1_F, {
	"param1",
	".cs.C2S_Chat.param1",
	6,
	5,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_CHAT_SHARE_F, {
	"share",
	".cs.C2S_Chat.share",
	7,
	6,
	1,
	false,
	nil,
	var_0_6.CHATSHARE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_CHAT_SUB_TYPE_F, {
	"sub_type",
	".cs.C2S_Chat.sub_type",
	8,
	7,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_CHAT_VOICE_PATH_F, {
	"voice_path",
	".cs.C2S_Chat.voice_path",
	9,
	8,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_CHAT_VOICE_TIME_F, {
	"voice_time",
	".cs.C2S_Chat.voice_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_CHAT_VOICE_PARAM_F, {
	"voice_param",
	".cs.C2S_Chat.voice_param",
	11,
	10,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_CHAT_LOOK_F, {
	"look",
	".cs.C2S_Chat.look",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_CHAT_ME, {
	"C2S_Chat",
	".cs.C2S_Chat",
	{},
	{},
	{
		var_0_6.C2S_CHAT_CHANNEL_F,
		var_0_6.C2S_CHAT_CONTENT_F,
		var_0_6.C2S_CHAT_NAME_F,
		var_0_6.C2S_CHAT_INVITE_ID_F,
		var_0_6.C2S_CHAT_UNIQUE_ID_F,
		var_0_6.C2S_CHAT_PARAM1_F,
		var_0_6.C2S_CHAT_SHARE_F,
		var_0_6.C2S_CHAT_SUB_TYPE_F,
		var_0_6.C2S_CHAT_VOICE_PATH_F,
		var_0_6.C2S_CHAT_VOICE_TIME_F,
		var_0_6.C2S_CHAT_VOICE_PARAM_F,
		var_0_6.C2S_CHAT_LOOK_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHAT_RET_F, {
	"ret",
	".cs.S2C_Chat.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHAT_FORBID_TIME_F, {
	"forbid_time",
	".cs.S2C_Chat.forbid_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHAT_WORLD_LEFT_TIME_F, {
	"world_left_time",
	".cs.S2C_Chat.world_left_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHAT_SHARE_F, {
	"share",
	".cs.S2C_Chat.share",
	4,
	3,
	1,
	false,
	nil,
	var_0_6.CHATSHARE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_CHAT_ME, {
	"S2C_Chat",
	".cs.S2C_Chat",
	{},
	{},
	{
		var_0_6.S2C_CHAT_RET_F,
		var_0_6.S2C_CHAT_FORBID_TIME_F,
		var_0_6.S2C_CHAT_WORLD_LEFT_TIME_F,
		var_0_6.S2C_CHAT_SHARE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATBROADCAST_CHANNEL_F, {
	"channel",
	".cs.S2C_ChatBroadcast.channel",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATBROADCAST_CONTENT_F, {
	"content",
	".cs.S2C_ChatBroadcast.content",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATBROADCAST_USER_F, {
	"user",
	".cs.S2C_ChatBroadcast.user",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.USERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATBROADCAST_INVITE_ID_F, {
	"invite_id",
	".cs.S2C_ChatBroadcast.invite_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATBROADCAST_UNIQUE_ID_F, {
	"unique_id",
	".cs.S2C_ChatBroadcast.unique_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATBROADCAST_PARAM1_F, {
	"param1",
	".cs.S2C_ChatBroadcast.param1",
	6,
	5,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATBROADCAST_SPECIAL_ID_F, {
	"special_id",
	".cs.S2C_ChatBroadcast.special_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATBROADCAST_SPECIAL_PARAMS_F, {
	"special_params",
	".cs.S2C_ChatBroadcast.special_params",
	8,
	7,
	3,
	false,
	{},
	var_0_3.STRINGMAP_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATBROADCAST_SHARE_F, {
	"share",
	".cs.S2C_ChatBroadcast.share",
	9,
	8,
	1,
	false,
	nil,
	var_0_6.CHATSHARE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATBROADCAST_CLEAR_F, {
	"clear",
	".cs.S2C_ChatBroadcast.clear",
	10,
	9,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATBROADCAST_SUB_TYPE_F, {
	"sub_type",
	".cs.S2C_ChatBroadcast.sub_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATBROADCAST_VOICE_PATH_F, {
	"voice_path",
	".cs.S2C_ChatBroadcast.voice_path",
	12,
	11,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATBROADCAST_VOICE_TIME_F, {
	"voice_time",
	".cs.S2C_ChatBroadcast.voice_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATBROADCAST_VOICE_PARAM_F, {
	"voice_param",
	".cs.S2C_ChatBroadcast.voice_param",
	14,
	13,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATBROADCAST_LOOK_F, {
	"look",
	".cs.S2C_ChatBroadcast.look",
	15,
	14,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATBROADCAST_TALK_F, {
	"talk",
	".cs.S2C_ChatBroadcast.talk",
	16,
	15,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_6.S2C_CHATBROADCAST_ME, {
	"S2C_ChatBroadcast",
	".cs.S2C_ChatBroadcast",
	{},
	{},
	{
		var_0_6.S2C_CHATBROADCAST_CHANNEL_F,
		var_0_6.S2C_CHATBROADCAST_CONTENT_F,
		var_0_6.S2C_CHATBROADCAST_USER_F,
		var_0_6.S2C_CHATBROADCAST_INVITE_ID_F,
		var_0_6.S2C_CHATBROADCAST_UNIQUE_ID_F,
		var_0_6.S2C_CHATBROADCAST_PARAM1_F,
		var_0_6.S2C_CHATBROADCAST_SPECIAL_ID_F,
		var_0_6.S2C_CHATBROADCAST_SPECIAL_PARAMS_F,
		var_0_6.S2C_CHATBROADCAST_SHARE_F,
		var_0_6.S2C_CHATBROADCAST_CLEAR_F,
		var_0_6.S2C_CHATBROADCAST_SUB_TYPE_F,
		var_0_6.S2C_CHATBROADCAST_VOICE_PATH_F,
		var_0_6.S2C_CHATBROADCAST_VOICE_TIME_F,
		var_0_6.S2C_CHATBROADCAST_VOICE_PARAM_F,
		var_0_6.S2C_CHATBROADCAST_LOOK_F,
		var_0_6.S2C_CHATBROADCAST_TALK_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_CHANNEL_F, {
	"channel",
	".cs.ChatContent.channel",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_CONTENT_F, {
	"content",
	".cs.ChatContent.content",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_USER_F, {
	"user",
	".cs.ChatContent.user",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.USERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_INVITE_ID_F, {
	"invite_id",
	".cs.ChatContent.invite_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_UNIQUE_ID_F, {
	"unique_id",
	".cs.ChatContent.unique_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_PARAM1_F, {
	"param1",
	".cs.ChatContent.param1",
	6,
	5,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_SPECIAL_ID_F, {
	"special_id",
	".cs.ChatContent.special_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_SPECIAL_PARAMS_F, {
	"special_params",
	".cs.ChatContent.special_params",
	8,
	7,
	3,
	false,
	{},
	var_0_3.STRINGMAP_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_SHARE_F, {
	"share",
	".cs.ChatContent.share",
	9,
	8,
	1,
	false,
	nil,
	var_0_6.CHATSHARE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_CLEAR_F, {
	"clear",
	".cs.ChatContent.clear",
	10,
	9,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_SUB_TYPE_F, {
	"sub_type",
	".cs.ChatContent.sub_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_VOICE_PATH_F, {
	"voice_path",
	".cs.ChatContent.voice_path",
	12,
	11,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_VOICE_TIME_F, {
	"voice_time",
	".cs.ChatContent.voice_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_VOICE_PARAM_F, {
	"voice_param",
	".cs.ChatContent.voice_param",
	14,
	13,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_LOOK_F, {
	"look",
	".cs.ChatContent.look",
	15,
	14,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_TALK_F, {
	"talk",
	".cs.ChatContent.talk",
	16,
	15,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATCONTENT_TIME_STAMP_F, {
	"time_stamp",
	".cs.ChatContent.time_stamp",
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
descriptor_helper.descriptorFunc(var_0_6.CHATCONTENT_ME, {
	"ChatContent",
	".cs.ChatContent",
	{},
	{},
	{
		var_0_6.CHATCONTENT_CHANNEL_F,
		var_0_6.CHATCONTENT_CONTENT_F,
		var_0_6.CHATCONTENT_USER_F,
		var_0_6.CHATCONTENT_INVITE_ID_F,
		var_0_6.CHATCONTENT_UNIQUE_ID_F,
		var_0_6.CHATCONTENT_PARAM1_F,
		var_0_6.CHATCONTENT_SPECIAL_ID_F,
		var_0_6.CHATCONTENT_SPECIAL_PARAMS_F,
		var_0_6.CHATCONTENT_SHARE_F,
		var_0_6.CHATCONTENT_CLEAR_F,
		var_0_6.CHATCONTENT_SUB_TYPE_F,
		var_0_6.CHATCONTENT_VOICE_PATH_F,
		var_0_6.CHATCONTENT_VOICE_TIME_F,
		var_0_6.CHATCONTENT_VOICE_PARAM_F,
		var_0_6.CHATCONTENT_LOOK_F,
		var_0_6.CHATCONTENT_TALK_F,
		var_0_6.CHATCONTENT_TIME_STAMP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETCOMMONRANKLIST_ID_F, {
	"id",
	".cs.C2S_GetCommonRankList.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETCOMMONRANKLIST_SIZE_F, {
	"size",
	".cs.C2S_GetCommonRankList.size",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETCOMMONRANKLIST_SPECIFY_RANKS_F, {
	"specify_ranks",
	".cs.C2S_GetCommonRankList.specify_ranks",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_GETCOMMONRANKLIST_ME, {
	"C2S_GetCommonRankList",
	".cs.C2S_GetCommonRankList",
	{},
	{},
	{
		var_0_6.C2S_GETCOMMONRANKLIST_ID_F,
		var_0_6.C2S_GETCOMMONRANKLIST_SIZE_F,
		var_0_6.C2S_GETCOMMONRANKLIST_SPECIFY_RANKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETCOMMONRANKLIST_RET_F, {
	"ret",
	".cs.S2C_GetCommonRankList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETCOMMONRANKLIST_ID_F, {
	"id",
	".cs.S2C_GetCommonRankList.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETCOMMONRANKLIST_SIZE_F, {
	"size",
	".cs.S2C_GetCommonRankList.size",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETCOMMONRANKLIST_SELF_RANK_F, {
	"self_rank",
	".cs.S2C_GetCommonRankList.self_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETCOMMONRANKLIST_RANK_UNITS_F, {
	"rank_units",
	".cs.S2C_GetCommonRankList.rank_units",
	5,
	4,
	3,
	false,
	{},
	var_0_3.RANKUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETCOMMONRANKLIST_FINISH_F, {
	"finish",
	".cs.S2C_GetCommonRankList.finish",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETCOMMONRANKLIST_SPECIFY_RANK_UNITS_F, {
	"specify_rank_units",
	".cs.S2C_GetCommonRankList.specify_rank_units",
	7,
	6,
	3,
	false,
	{},
	var_0_3.RANKUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_GETCOMMONRANKLIST_ME, {
	"S2C_GetCommonRankList",
	".cs.S2C_GetCommonRankList",
	{},
	{},
	{
		var_0_6.S2C_GETCOMMONRANKLIST_RET_F,
		var_0_6.S2C_GETCOMMONRANKLIST_ID_F,
		var_0_6.S2C_GETCOMMONRANKLIST_SIZE_F,
		var_0_6.S2C_GETCOMMONRANKLIST_SELF_RANK_F,
		var_0_6.S2C_GETCOMMONRANKLIST_RANK_UNITS_F,
		var_0_6.S2C_GETCOMMONRANKLIST_FINISH_F,
		var_0_6.S2C_GETCOMMONRANKLIST_SPECIFY_RANK_UNITS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_SYNCTIME_CLIENT_TIME_F, {
	"client_time",
	".cs.C2S_SyncTime.client_time",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_SYNCTIME_ME, {
	"C2S_SyncTime",
	".cs.C2S_SyncTime",
	{},
	{},
	{
		var_0_6.C2S_SYNCTIME_CLIENT_TIME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SYNCTIME_RET_F, {
	"ret",
	".cs.S2C_SyncTime.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SYNCTIME_CLIENT_TIME_F, {
	"client_time",
	".cs.S2C_SyncTime.client_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SYNCTIME_SERVER_TIME_F, {
	"server_time",
	".cs.S2C_SyncTime.server_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SYNCTIME_ZONE_F, {
	"zone",
	".cs.S2C_SyncTime.zone",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SYNCTIME_OPEN_F, {
	"open",
	".cs.S2C_SyncTime.open",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_SYNCTIME_ME, {
	"S2C_SyncTime",
	".cs.S2C_SyncTime",
	{},
	{},
	{
		var_0_6.S2C_SYNCTIME_RET_F,
		var_0_6.S2C_SYNCTIME_CLIENT_TIME_F,
		var_0_6.S2C_SYNCTIME_SERVER_TIME_F,
		var_0_6.S2C_SYNCTIME_ZONE_F,
		var_0_6.S2C_SYNCTIME_OPEN_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_SELL_CONSUMES_F, {
	"consumes",
	".cs.C2S_Sell.consumes",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_SELL_ME, {
	"C2S_Sell",
	".cs.C2S_Sell",
	{},
	{},
	{
		var_0_6.C2S_SELL_CONSUMES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SELL_RET_F, {
	"ret",
	".cs.S2C_Sell.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SELL_AWARDS_F, {
	"awards",
	".cs.S2C_Sell.awards",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_SELL_ME, {
	"S2C_Sell",
	".cs.S2C_Sell",
	{},
	{},
	{
		var_0_6.S2C_SELL_RET_F,
		var_0_6.S2C_SELL_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_6.C2S_GETCOMMONPLAYNUM_ME, {
	"C2S_GetCommonPlayNum",
	".cs.C2S_GetCommonPlayNum",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETCOMMONPLAYNUM_RET_F, {
	"ret",
	".cs.S2C_GetCommonPlayNum.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETCOMMONPLAYNUM_INFOS_F, {
	"infos",
	".cs.S2C_GetCommonPlayNum.infos",
	2,
	1,
	3,
	false,
	{},
	var_0_3.COMMONPLAYNUM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_GETCOMMONPLAYNUM_ME, {
	"S2C_GetCommonPlayNum",
	".cs.S2C_GetCommonPlayNum",
	{},
	{},
	{
		var_0_6.S2C_GETCOMMONPLAYNUM_RET_F,
		var_0_6.S2C_GETCOMMONPLAYNUM_INFOS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_BUYCOMMONPLAYNUM_ID_F, {
	"id",
	".cs.C2S_BuyCommonPlayNum.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_BUYCOMMONPLAYNUM_NUM_F, {
	"num",
	".cs.C2S_BuyCommonPlayNum.num",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_BUYCOMMONPLAYNUM_ME, {
	"C2S_BuyCommonPlayNum",
	".cs.C2S_BuyCommonPlayNum",
	{},
	{},
	{
		var_0_6.C2S_BUYCOMMONPLAYNUM_ID_F,
		var_0_6.C2S_BUYCOMMONPLAYNUM_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_BUYCOMMONPLAYNUM_RET_F, {
	"ret",
	".cs.S2C_BuyCommonPlayNum.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_BUYCOMMONPLAYNUM_INFO_F, {
	"info",
	".cs.S2C_BuyCommonPlayNum.info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.COMMONPLAYNUM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_BUYCOMMONPLAYNUM_ME, {
	"S2C_BuyCommonPlayNum",
	".cs.S2C_BuyCommonPlayNum",
	{},
	{},
	{
		var_0_6.S2C_BUYCOMMONPLAYNUM_RET_F,
		var_0_6.S2C_BUYCOMMONPLAYNUM_INFO_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHCOMMONPLAYNUM_RET_F, {
	"ret",
	".cs.S2C_FlushCommonPlayNum.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHCOMMONPLAYNUM_INFO_F, {
	"info",
	".cs.S2C_FlushCommonPlayNum.info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.COMMONPLAYNUM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHCOMMONPLAYNUM_IS_ADD_F, {
	"is_add",
	".cs.S2C_FlushCommonPlayNum.is_add",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHCOMMONPLAYNUM_ME, {
	"S2C_FlushCommonPlayNum",
	".cs.S2C_FlushCommonPlayNum",
	{},
	{},
	{
		var_0_6.S2C_FLUSHCOMMONPLAYNUM_RET_F,
		var_0_6.S2C_FLUSHCOMMONPLAYNUM_INFO_F,
		var_0_6.S2C_FLUSHCOMMONPLAYNUM_IS_ADD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_ACTIONSTATUSFLUSH_TP_F, {
	"tp",
	".cs.S2C_ActionStatusFlush.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_ACTIONSTATUSFLUSH_STATUS_F, {
	"status",
	".cs.S2C_ActionStatusFlush.status",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.STATUS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_ACTIONSTATUSFLUSH_ME, {
	"S2C_ActionStatusFlush",
	".cs.S2C_ActionStatusFlush",
	{},
	{},
	{
		var_0_6.S2C_ACTIONSTATUSFLUSH_TP_F,
		var_0_6.S2C_ACTIONSTATUSFLUSH_STATUS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_6.C2S_GETUSERCONFIG_ME, {
	"C2S_GetUserConfig",
	".cs.C2S_GetUserConfig",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETUSERCONFIG_RET_F, {
	"ret",
	".cs.S2C_GetUserConfig.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETUSERCONFIG_CONFIG_F, {
	"config",
	".cs.S2C_GetUserConfig.config",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.USERCONFIG_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_GETUSERCONFIG_ME, {
	"S2C_GetUserConfig",
	".cs.S2C_GetUserConfig",
	{},
	{},
	{
		var_0_6.S2C_GETUSERCONFIG_RET_F,
		var_0_6.S2C_GETUSERCONFIG_CONFIG_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_SETUSERCONFIG_TP_F, {
	"tp",
	".cs.C2S_SetUserConfig.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_SETUSERCONFIG_CONFIG_F, {
	"config",
	".cs.C2S_SetUserConfig.config",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.USERCONFIG_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.C2S_SETUSERCONFIG_ME, {
	"C2S_SetUserConfig",
	".cs.C2S_SetUserConfig",
	{},
	{},
	{
		var_0_6.C2S_SETUSERCONFIG_TP_F,
		var_0_6.C2S_SETUSERCONFIG_CONFIG_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SETUSERCONFIG_RET_F, {
	"ret",
	".cs.S2C_SetUserConfig.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SETUSERCONFIG_CONFIG_F, {
	"config",
	".cs.S2C_SetUserConfig.config",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.USERCONFIG_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SETUSERCONFIG_LANGUAGE_F, {
	"language",
	".cs.S2C_SetUserConfig.language",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_SETUSERCONFIG_ME, {
	"S2C_SetUserConfig",
	".cs.S2C_SetUserConfig",
	{},
	{},
	{
		var_0_6.S2C_SETUSERCONFIG_RET_F,
		var_0_6.S2C_SETUSERCONFIG_CONFIG_F,
		var_0_6.S2C_SETUSERCONFIG_LANGUAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_NOTICE_ID_F, {
	"id",
	".cs.S2C_Notice.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_NOTICE_PARAMS_F, {
	"params",
	".cs.S2C_Notice.params",
	2,
	1,
	3,
	false,
	{},
	var_0_3.STRINGMAP_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_NOTICE_AWARDS_F, {
	"awards",
	".cs.S2C_Notice.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_NOTICE_FROM_USER_ID_F, {
	"from_user_id",
	".cs.S2C_Notice.from_user_id",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_NOTICE_ME, {
	"S2C_Notice",
	".cs.S2C_Notice",
	{},
	{},
	{
		var_0_6.S2C_NOTICE_ID_F,
		var_0_6.S2C_NOTICE_PARAMS_F,
		var_0_6.S2C_NOTICE_AWARDS_F,
		var_0_6.S2C_NOTICE_FROM_USER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETBATTLEVIDEO_BATTLE_ID_F, {
	"battle_id",
	".cs.C2S_GetBattleVideo.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETBATTLEVIDEO_TP_F, {
	"tp",
	".cs.C2S_GetBattleVideo.tp",
	3,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_6.C2S_GETBATTLEVIDEO_ME, {
	"C2S_GetBattleVideo",
	".cs.C2S_GetBattleVideo",
	{},
	{},
	{
		var_0_6.C2S_GETBATTLEVIDEO_BATTLE_ID_F,
		var_0_6.C2S_GETBATTLEVIDEO_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETBATTLEVIDEO_RET_F, {
	"ret",
	".cs.S2C_GetBattleVideo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETBATTLEVIDEO_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_GetBattleVideo.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETBATTLEVIDEO_BATTLE_VIDEO_F, {
	"battle_video",
	".cs.S2C_GetBattleVideo.battle_video",
	3,
	2,
	1,
	false,
	nil,
	var_0_4.BATTLEVIDEO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_GETBATTLEVIDEO_ME, {
	"S2C_GetBattleVideo",
	".cs.S2C_GetBattleVideo",
	{},
	{},
	{
		var_0_6.S2C_GETBATTLEVIDEO_RET_F,
		var_0_6.S2C_GETBATTLEVIDEO_BATTLE_ID_F,
		var_0_6.S2C_GETBATTLEVIDEO_BATTLE_VIDEO_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETBATTLERECORD_FUNCTION_ID_F, {
	"function_id",
	".cs.C2S_GetBattleRecord.function_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETBATTLERECORD_RECORD_ID_F, {
	"record_id",
	".cs.C2S_GetBattleRecord.record_id",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_GETBATTLERECORD_ME, {
	"C2S_GetBattleRecord",
	".cs.C2S_GetBattleRecord",
	{},
	{},
	{
		var_0_6.C2S_GETBATTLERECORD_FUNCTION_ID_F,
		var_0_6.C2S_GETBATTLERECORD_RECORD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETBATTLERECORD_RET_F, {
	"ret",
	".cs.S2C_GetBattleRecord.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETBATTLERECORD_FUNCTION_ID_F, {
	"function_id",
	".cs.S2C_GetBattleRecord.function_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETBATTLERECORD_RECORD_ID_F, {
	"record_id",
	".cs.S2C_GetBattleRecord.record_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETBATTLERECORD_RECORDS_F, {
	"records",
	".cs.S2C_GetBattleRecord.records",
	4,
	3,
	3,
	false,
	{},
	var_0_3.BATTLERECORD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_GETBATTLERECORD_ME, {
	"S2C_GetBattleRecord",
	".cs.S2C_GetBattleRecord",
	{},
	{},
	{
		var_0_6.S2C_GETBATTLERECORD_RET_F,
		var_0_6.S2C_GETBATTLERECORD_FUNCTION_ID_F,
		var_0_6.S2C_GETBATTLERECORD_RECORD_ID_F,
		var_0_6.S2C_GETBATTLERECORD_RECORDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETUSERBATTLETEAM_PLAYERS_F, {
	"players",
	".cs.C2S_GetUserBattleTeam.players",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_GETUSERBATTLETEAM_ME, {
	"C2S_GetUserBattleTeam",
	".cs.C2S_GetUserBattleTeam",
	{},
	{},
	{
		var_0_6.C2S_GETUSERBATTLETEAM_PLAYERS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETUSERBATTLETEAM_RET_F, {
	"ret",
	".cs.S2C_GetUserBattleTeam.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETUSERBATTLETEAM_TEAMS_F, {
	"teams",
	".cs.S2C_GetUserBattleTeam.teams",
	2,
	1,
	3,
	false,
	{},
	var_0_4.BATTLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_GETUSERBATTLETEAM_ME, {
	"S2C_GetUserBattleTeam",
	".cs.S2C_GetUserBattleTeam",
	{},
	{},
	{
		var_0_6.S2C_GETUSERBATTLETEAM_RET_F,
		var_0_6.S2C_GETUSERBATTLETEAM_TEAMS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_6.C2S_UPDATERANDOMPLAYER_ME, {
	"C2S_UpdateRandomPlayer",
	".cs.C2S_UpdateRandomPlayer",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_UPDATERANDOMPLAYER_RET_F, {
	"ret",
	".cs.S2C_UpdateRandomPlayer.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_UPDATERANDOMPLAYER_RANDOM_PLAYERS_F, {
	"random_players",
	".cs.S2C_UpdateRandomPlayer.random_players",
	2,
	1,
	3,
	false,
	{},
	var_0_3.USERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_UPDATERANDOMPLAYER_ME, {
	"S2C_UpdateRandomPlayer",
	".cs.S2C_UpdateRandomPlayer",
	{},
	{},
	{
		var_0_6.S2C_UPDATERANDOMPLAYER_RET_F,
		var_0_6.S2C_UPDATERANDOMPLAYER_RANDOM_PLAYERS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_SYNCPROTO_CLIENT_ID_F, {
	"client_id",
	".cs.C2S_SyncProto.client_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_SYNCPROTO_SERVER_ID_F, {
	"server_id",
	".cs.C2S_SyncProto.server_id",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_SYNCPROTO_ME, {
	"C2S_SyncProto",
	".cs.C2S_SyncProto",
	{},
	{},
	{
		var_0_6.C2S_SYNCPROTO_CLIENT_ID_F,
		var_0_6.C2S_SYNCPROTO_SERVER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SYNCPROTO_CLIENT_ID_F, {
	"client_id",
	".cs.S2C_SyncProto.client_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SYNCPROTO_SERVER_ID_F, {
	"server_id",
	".cs.S2C_SyncProto.server_id",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_SYNCPROTO_ME, {
	"S2C_SyncProto",
	".cs.S2C_SyncProto",
	{},
	{},
	{
		var_0_6.S2C_SYNCPROTO_CLIENT_ID_F,
		var_0_6.S2C_SYNCPROTO_SERVER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GIFTNOTIFY_RET_F, {
	"ret",
	".cs.S2C_GiftNotify.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GIFTNOTIFY_AWARDS_F, {
	"awards",
	".cs.S2C_GiftNotify.awards",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_GIFTNOTIFY_ME, {
	"S2C_GiftNotify",
	".cs.S2C_GiftNotify",
	{},
	{},
	{
		var_0_6.S2C_GIFTNOTIFY_RET_F,
		var_0_6.S2C_GIFTNOTIFY_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_ANTIADDICTIONNOTIFY_GAME_TIME_F, {
	"game_time",
	".cs.S2C_AntiAddictionNotify.game_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_ANTIADDICTIONNOTIFY_IS_FCM_F, {
	"is_fcm",
	".cs.S2C_AntiAddictionNotify.is_fcm",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_ANTIADDICTIONNOTIFY_IS_ADULT_F, {
	"is_adult",
	".cs.S2C_AntiAddictionNotify.is_adult",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_ANTIADDICTIONNOTIFY_IS_WARNING_F, {
	"is_warning",
	".cs.S2C_AntiAddictionNotify.is_warning",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_ANTIADDICTIONNOTIFY_REMAINING_TIME_F, {
	"remaining_time",
	".cs.S2C_AntiAddictionNotify.remaining_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_ANTIADDICTIONNOTIFY_FCM_STATUS_F, {
	"fcm_status",
	".cs.S2C_AntiAddictionNotify.fcm_status",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_ANTIADDICTIONNOTIFY_ME, {
	"S2C_AntiAddictionNotify",
	".cs.S2C_AntiAddictionNotify",
	{},
	{},
	{
		var_0_6.S2C_ANTIADDICTIONNOTIFY_GAME_TIME_F,
		var_0_6.S2C_ANTIADDICTIONNOTIFY_IS_FCM_F,
		var_0_6.S2C_ANTIADDICTIONNOTIFY_IS_ADULT_F,
		var_0_6.S2C_ANTIADDICTIONNOTIFY_IS_WARNING_F,
		var_0_6.S2C_ANTIADDICTIONNOTIFY_REMAINING_TIME_F,
		var_0_6.S2C_ANTIADDICTIONNOTIFY_FCM_STATUS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETCHATSHARE_SHARE_TYPE_F, {
	"share_type",
	".cs.C2S_GetChatShare.share_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETCHATSHARE_OWN_ID_F, {
	"own_id",
	".cs.C2S_GetChatShare.own_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETCHATSHARE_ID_F, {
	"id",
	".cs.C2S_GetChatShare.id",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_GETCHATSHARE_ME, {
	"C2S_GetChatShare",
	".cs.C2S_GetChatShare",
	{},
	{},
	{
		var_0_6.C2S_GETCHATSHARE_SHARE_TYPE_F,
		var_0_6.C2S_GETCHATSHARE_OWN_ID_F,
		var_0_6.C2S_GETCHATSHARE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETCHATSHARE_RET_F, {
	"ret",
	".cs.S2C_GetChatShare.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETCHATSHARE_SHARE_INFO_F, {
	"share_info",
	".cs.S2C_GetChatShare.share_info",
	3,
	1,
	1,
	false,
	nil,
	var_0_6.CHATSHARE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_GETCHATSHARE_ME, {
	"S2C_GetChatShare",
	".cs.S2C_GetChatShare",
	{},
	{},
	{
		var_0_6.S2C_GETCHATSHARE_RET_F,
		var_0_6.S2C_GETCHATSHARE_SHARE_INFO_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_6.C2S_FRAMEINFO_ME, {
	"C2S_FrameInfo",
	".cs.C2S_FrameInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FRAMEINFO_RET_F, {
	"ret",
	".cs.S2C_FrameInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FRAMEINFO_IDS_F, {
	"ids",
	".cs.S2C_FrameInfo.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FRAMEINFO_AVATA_IDS_F, {
	"avata_ids",
	".cs.S2C_FrameInfo.avata_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FRAMEINFO_LIMIT_FRAMES_F, {
	"limit_frames",
	".cs.S2C_FrameInfo.limit_frames",
	4,
	3,
	3,
	false,
	{},
	var_0_3.LIMITFRAMEINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FRAMEINFO_LIMIT_AVATAS_F, {
	"limit_avatas",
	".cs.S2C_FrameInfo.limit_avatas",
	5,
	4,
	3,
	false,
	{},
	var_0_3.LIMITAVATAINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FRAMEINFO_ME, {
	"S2C_FrameInfo",
	".cs.S2C_FrameInfo",
	{},
	{},
	{
		var_0_6.S2C_FRAMEINFO_RET_F,
		var_0_6.S2C_FRAMEINFO_IDS_F,
		var_0_6.S2C_FRAMEINFO_AVATA_IDS_F,
		var_0_6.S2C_FRAMEINFO_LIMIT_FRAMES_F,
		var_0_6.S2C_FRAMEINFO_LIMIT_AVATAS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GIFTCODE_CODE_F, {
	"code",
	".cs.C2S_GiftCode.code",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_GIFTCODE_ME, {
	"C2S_GiftCode",
	".cs.C2S_GiftCode",
	{},
	{},
	{
		var_0_6.C2S_GIFTCODE_CODE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GIFTCODE_RET_F, {
	"ret",
	".cs.S2C_GiftCode.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GIFTCODE_AWARDS_F, {
	"awards",
	".cs.S2C_GiftCode.awards",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_GIFTCODE_ME, {
	"S2C_GiftCode",
	".cs.S2C_GiftCode",
	{},
	{},
	{
		var_0_6.S2C_GIFTCODE_RET_F,
		var_0_6.S2C_GIFTCODE_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_ICONCLICK_ICON_ID_F, {
	"icon_id",
	".cs.C2S_IconClick.icon_id",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_ICONCLICK_ME, {
	"C2S_IconClick",
	".cs.C2S_IconClick",
	{},
	{},
	{
		var_0_6.C2S_ICONCLICK_ICON_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_ICONCLICK_RET_F, {
	"ret",
	".cs.S2C_IconClick.ret",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_ICONCLICK_ME, {
	"S2C_IconClick",
	".cs.S2C_IconClick",
	{},
	{},
	{
		var_0_6.S2C_ICONCLICK_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_RFRESHRESOURCE_ID_F, {
	"id",
	".cs.C2S_RfreshResource.id",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_RFRESHRESOURCE_ME, {
	"C2S_RfreshResource",
	".cs.C2S_RfreshResource",
	{},
	{},
	{
		var_0_6.C2S_RFRESHRESOURCE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_RFRESHRESOURCE_RET_F, {
	"ret",
	".cs.S2C_RfreshResource.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_RFRESHRESOURCE_RESOURCES_F, {
	"resources",
	".cs.S2C_RfreshResource.resources",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.RESOURCE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_RFRESHRESOURCE_ME, {
	"S2C_RfreshResource",
	".cs.S2C_RfreshResource",
	{},
	{},
	{
		var_0_6.S2C_RFRESHRESOURCE_RET_F,
		var_0_6.S2C_RFRESHRESOURCE_RESOURCES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHCARDCOMPOSE_CARD_COMPOSE_F, {
	"card_compose",
	".cs.S2C_FlushCardCompose.card_compose",
	1,
	0,
	3,
	false,
	{},
	var_0_3.CARDCOMPOSE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHCARDCOMPOSE_ME, {
	"S2C_FlushCardCompose",
	".cs.S2C_FlushCardCompose",
	{},
	{},
	{
		var_0_6.S2C_FLUSHCARDCOMPOSE_CARD_COMPOSE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHCARD_CARDS_F, {
	"cards",
	".cs.S2C_FlushCard.cards",
	1,
	0,
	3,
	false,
	{},
	var_0_3.CARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHCARD_ME, {
	"S2C_FlushCard",
	".cs.S2C_FlushCard",
	{},
	{},
	{
		var_0_6.S2C_FLUSHCARD_CARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHWING_WING_F, {
	"wing",
	".cs.S2C_FlushWing.wing",
	1,
	0,
	3,
	false,
	{},
	var_0_3.WING_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHWING_WING_REFINES_F, {
	"wing_refines",
	".cs.S2C_FlushWing.wing_refines",
	2,
	1,
	3,
	false,
	{},
	var_0_3.WINGREFINE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHWING_ME, {
	"S2C_FlushWing",
	".cs.S2C_FlushWing",
	{},
	{},
	{
		var_0_6.S2C_FLUSHWING_WING_F,
		var_0_6.S2C_FLUSHWING_WING_REFINES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETMODULEONEKEYTASKAWARD_MODULE_ID_F, {
	"module_id",
	".cs.C2S_GetModuleOneKeyTaskAward.module_id",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_GETMODULEONEKEYTASKAWARD_ME, {
	"C2S_GetModuleOneKeyTaskAward",
	".cs.C2S_GetModuleOneKeyTaskAward",
	{},
	{},
	{
		var_0_6.C2S_GETMODULEONEKEYTASKAWARD_MODULE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETMODULEONEKEYTASKAWARD_RET_F, {
	"ret",
	".cs.S2C_GetModuleOneKeyTaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETMODULEONEKEYTASKAWARD_MODULE_ID_F, {
	"module_id",
	".cs.S2C_GetModuleOneKeyTaskAward.module_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETMODULEONEKEYTASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_GetModuleOneKeyTaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_6.S2C_GETMODULEONEKEYTASKAWARD_ME, {
	"S2C_GetModuleOneKeyTaskAward",
	".cs.S2C_GetModuleOneKeyTaskAward",
	{},
	{},
	{
		var_0_6.S2C_GETMODULEONEKEYTASKAWARD_RET_F,
		var_0_6.S2C_GETMODULEONEKEYTASKAWARD_MODULE_ID_F,
		var_0_6.S2C_GETMODULEONEKEYTASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_6.C2S_LOGINEND_ME, {
	"C2S_LoginEnd",
	".cs.C2S_LoginEnd",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_6.S2C_LOGINEND_ME, {
	"S2C_LoginEnd",
	".cs.S2C_LoginEnd",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_6.C2S_SKINSHOPGMINFO_ME, {
	"C2S_SkinShopGMInfo",
	".cs.C2S_SkinShopGMInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SKINSHOPGMINFO_RET_F, {
	"ret",
	".cs.S2C_SkinShopGMInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SKINSHOPGMINFO_INFOS_F, {
	"infos",
	".cs.S2C_SkinShopGMInfo.infos",
	2,
	1,
	3,
	false,
	{},
	var_0_3.SKINSHOPGMINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_SKINSHOPGMINFO_ME, {
	"S2C_SkinShopGMInfo",
	".cs.S2C_SkinShopGMInfo",
	{},
	{},
	{
		var_0_6.S2C_SKINSHOPGMINFO_RET_F,
		var_0_6.S2C_SKINSHOPGMINFO_INFOS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATRECORD_CHANNEL_ID_F, {
	"channel_id",
	".cs.ChatRecord.channel_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATRECORD_SUB_ID_F, {
	"sub_id",
	".cs.ChatRecord.sub_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.CHATRECORD_CONTENTS_F, {
	"contents",
	".cs.ChatRecord.contents",
	3,
	2,
	3,
	false,
	{},
	var_0_6.CHATCONTENT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.CHATRECORD_ME, {
	"ChatRecord",
	".cs.ChatRecord",
	{},
	{},
	{
		var_0_6.CHATRECORD_CHANNEL_ID_F,
		var_0_6.CHATRECORD_SUB_ID_F,
		var_0_6.CHATRECORD_CONTENTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_CHATRECORDGETINFO_CHANNEL_F, {
	"channel",
	".cs.C2S_ChatRecordGetInfo.channel",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_CHATRECORDGETINFO_ME, {
	"C2S_ChatRecordGetInfo",
	".cs.C2S_ChatRecordGetInfo",
	{},
	{},
	{
		var_0_6.C2S_CHATRECORDGETINFO_CHANNEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATRECORDGETINFO_RET_F, {
	"ret",
	".cs.S2C_ChatRecordGetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_CHATRECORDGETINFO_RECORDS_F, {
	"records",
	".cs.S2C_ChatRecordGetInfo.records",
	2,
	1,
	1,
	false,
	nil,
	var_0_6.CHATRECORD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_CHATRECORDGETINFO_ME, {
	"S2C_ChatRecordGetInfo",
	".cs.S2C_ChatRecordGetInfo",
	{},
	{},
	{
		var_0_6.S2C_CHATRECORDGETINFO_RET_F,
		var_0_6.S2C_CHATRECORDGETINFO_RECORDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETUSERSNAPSHOT_USER_IDS_F, {
	"user_ids",
	".cs.C2S_GetUserSnapShot.user_ids",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_GETUSERSNAPSHOT_ME, {
	"C2S_GetUserSnapShot",
	".cs.C2S_GetUserSnapShot",
	{},
	{},
	{
		var_0_6.C2S_GETUSERSNAPSHOT_USER_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETUSERSNAPSHOT_RET_F, {
	"ret",
	".cs.S2C_GetUserSnapShot.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETUSERSNAPSHOT_USER_IDS_F, {
	"user_ids",
	".cs.S2C_GetUserSnapShot.user_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETUSERSNAPSHOT_SNAPSHOTS_F, {
	"snapshots",
	".cs.S2C_GetUserSnapShot.snapshots",
	3,
	2,
	3,
	false,
	{},
	var_0_3.USERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_GETUSERSNAPSHOT_ME, {
	"S2C_GetUserSnapShot",
	".cs.S2C_GetUserSnapShot",
	{},
	{},
	{
		var_0_6.S2C_GETUSERSNAPSHOT_RET_F,
		var_0_6.S2C_GETUSERSNAPSHOT_USER_IDS_F,
		var_0_6.S2C_GETUSERSNAPSHOT_SNAPSHOTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.C2S_GETGUILDSNAPSHOT_GUILD_IDS_F, {
	"guild_ids",
	".cs.C2S_GetGuildSnapShot.guild_ids",
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
descriptor_helper.descriptorFunc(var_0_6.C2S_GETGUILDSNAPSHOT_ME, {
	"C2S_GetGuildSnapShot",
	".cs.C2S_GetGuildSnapShot",
	{},
	{},
	{
		var_0_6.C2S_GETGUILDSNAPSHOT_GUILD_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETGUILDSNAPSHOT_RET_F, {
	"ret",
	".cs.S2C_GetGuildSnapShot.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETGUILDSNAPSHOT_GUILD_IDS_F, {
	"guild_ids",
	".cs.S2C_GetGuildSnapShot.guild_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_GETGUILDSNAPSHOT_SNAPSHOTS_F, {
	"snapshots",
	".cs.S2C_GetGuildSnapShot.snapshots",
	3,
	2,
	3,
	false,
	{},
	var_0_3.GUILDSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_GETGUILDSNAPSHOT_ME, {
	"S2C_GetGuildSnapShot",
	".cs.S2C_GetGuildSnapShot",
	{},
	{},
	{
		var_0_6.S2C_GETGUILDSNAPSHOT_RET_F,
		var_0_6.S2C_GETGUILDSNAPSHOT_GUILD_IDS_F,
		var_0_6.S2C_GETGUILDSNAPSHOT_SNAPSHOTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.PACKETHEAD_LENGTH_F, {
	"length",
	".cs.PacketHead.length",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.PACKETHEAD_CMD_F, {
	"cmd",
	".cs.PacketHead.cmd",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.PACKETHEAD_UID_F, {
	"uid",
	".cs.PacketHead.uid",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.PACKETHEAD_SID_F, {
	"sid",
	".cs.PacketHead.sid",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.PACKETHEAD_CID_F, {
	"cid",
	".cs.PacketHead.cid",
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
descriptor_helper.descriptorFunc(var_0_6.PACKETHEAD_ME, {
	"PacketHead",
	".cs.PacketHead",
	{},
	{},
	{
		var_0_6.PACKETHEAD_LENGTH_F,
		var_0_6.PACKETHEAD_CMD_F,
		var_0_6.PACKETHEAD_UID_F,
		var_0_6.PACKETHEAD_SID_F,
		var_0_6.PACKETHEAD_CID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SPLITPACKET_ORIGIN_PH_F, {
	"origin_ph",
	".cs.S2C_SplitPacket.origin_ph",
	1,
	0,
	1,
	false,
	nil,
	var_0_6.PACKETHEAD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SPLITPACKET_ORIGIN_ID_F, {
	"origin_id",
	".cs.S2C_SplitPacket.origin_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SPLITPACKET_CURRENT_F, {
	"current",
	".cs.S2C_SplitPacket.current",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SPLITPACKET_TOTAL_F, {
	"total",
	".cs.S2C_SplitPacket.total",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_SPLITPACKET_DATA_F, {
	"data",
	".cs.S2C_SplitPacket.data",
	5,
	4,
	1,
	false,
	"",
	nil,
	nil,
	12,
	9
})
descriptor_helper.descriptorFunc(var_0_6.S2C_SPLITPACKET_ME, {
	"S2C_SplitPacket",
	".cs.S2C_SplitPacket",
	{},
	{},
	{
		var_0_6.S2C_SPLITPACKET_ORIGIN_PH_F,
		var_0_6.S2C_SPLITPACKET_ORIGIN_ID_F,
		var_0_6.S2C_SPLITPACKET_CURRENT_F,
		var_0_6.S2C_SPLITPACKET_TOTAL_F,
		var_0_6.S2C_SPLITPACKET_DATA_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_6.C2S_TEAMBATTLEENTER_ME, {
	"C2S_TeamBattleEnter",
	".cs.C2S_TeamBattleEnter",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_TEAMBATTLEENTER_RET_F, {
	"ret",
	".cs.S2C_TeamBattleEnter.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_TEAMBATTLEENTER_MAP_F, {
	"map",
	".cs.S2C_TeamBattleEnter.map",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEMAP_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_TEAMBATTLEENTER_ROOM_F, {
	"room",
	".cs.S2C_TeamBattleEnter.room",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_TEAMBATTLEENTER_USER_DATA_F, {
	"user_data",
	".cs.S2C_TeamBattleEnter.user_data",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.TEAMBATTLEUSERDATA_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_TEAMBATTLEENTER_EVENTS_F, {
	"events",
	".cs.S2C_TeamBattleEnter.events",
	5,
	4,
	3,
	false,
	{},
	var_0_3.TEAMBATTLEEVENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_TEAMBATTLEENTER_KNIGHTS_F, {
	"knights",
	".cs.S2C_TeamBattleEnter.knights",
	6,
	5,
	3,
	false,
	{},
	var_0_3.TEAMBATTLEKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_TEAMBATTLEENTER_CHALLENGE_RESULT_F, {
	"challenge_result",
	".cs.S2C_TeamBattleEnter.challenge_result",
	7,
	6,
	1,
	false,
	nil,
	var_0_6.TEAMBATTLECHALLENGERESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_TEAMBATTLEENTER_ME, {
	"S2C_TeamBattleEnter",
	".cs.S2C_TeamBattleEnter",
	{},
	{},
	{
		var_0_6.S2C_TEAMBATTLEENTER_RET_F,
		var_0_6.S2C_TEAMBATTLEENTER_MAP_F,
		var_0_6.S2C_TEAMBATTLEENTER_ROOM_F,
		var_0_6.S2C_TEAMBATTLEENTER_USER_DATA_F,
		var_0_6.S2C_TEAMBATTLEENTER_EVENTS_F,
		var_0_6.S2C_TEAMBATTLEENTER_KNIGHTS_F,
		var_0_6.S2C_TEAMBATTLEENTER_CHALLENGE_RESULT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.TEAMBATTLECHALLENGERESULT_ROOM_ID_F, {
	"room_id",
	".cs.TeamBattleChallengeResult.room_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.TEAMBATTLECHALLENGERESULT_GRID_ID_F, {
	"grid_id",
	".cs.TeamBattleChallengeResult.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.TEAMBATTLECHALLENGERESULT_MONSTER_TP_F, {
	"monster_tp",
	".cs.TeamBattleChallengeResult.monster_tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.TEAMBATTLECHALLENGERESULT_IS_WIN_F, {
	"is_win",
	".cs.TeamBattleChallengeResult.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.TEAMBATTLECHALLENGERESULT_RESULT_F, {
	"result",
	".cs.TeamBattleChallengeResult.result",
	5,
	4,
	1,
	false,
	nil,
	var_0_4.BATTLERESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.TEAMBATTLECHALLENGERESULT_AWARDS_F, {
	"awards",
	".cs.TeamBattleChallengeResult.awards",
	6,
	5,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.TEAMBATTLECHALLENGERESULT_ENEMY_HP_LIST_F, {
	"enemy_hp_list",
	".cs.TeamBattleChallengeResult.enemy_hp_list",
	7,
	6,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_6.TEAMBATTLECHALLENGERESULT_KNIGHT_HP_LIST_F, {
	"knight_hp_list",
	".cs.TeamBattleChallengeResult.knight_hp_list",
	8,
	7,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_6.TEAMBATTLECHALLENGERESULT_CHALLENGE_TIME_F, {
	"challenge_time",
	".cs.TeamBattleChallengeResult.challenge_time",
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
descriptor_helper.descriptorFunc(var_0_6.TEAMBATTLECHALLENGERESULT_ME, {
	"TeamBattleChallengeResult",
	".cs.TeamBattleChallengeResult",
	{},
	{},
	{
		var_0_6.TEAMBATTLECHALLENGERESULT_ROOM_ID_F,
		var_0_6.TEAMBATTLECHALLENGERESULT_GRID_ID_F,
		var_0_6.TEAMBATTLECHALLENGERESULT_MONSTER_TP_F,
		var_0_6.TEAMBATTLECHALLENGERESULT_IS_WIN_F,
		var_0_6.TEAMBATTLECHALLENGERESULT_RESULT_F,
		var_0_6.TEAMBATTLECHALLENGERESULT_AWARDS_F,
		var_0_6.TEAMBATTLECHALLENGERESULT_ENEMY_HP_LIST_F,
		var_0_6.TEAMBATTLECHALLENGERESULT_KNIGHT_HP_LIST_F,
		var_0_6.TEAMBATTLECHALLENGERESULT_CHALLENGE_TIME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_TEAMBATTLECHALLENGERESULT_RET_F, {
	"ret",
	".cs.S2C_TeamBattleChallengeResult.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_TEAMBATTLECHALLENGERESULT_CHALLENGE_RESULT_F, {
	"challenge_result",
	".cs.S2C_TeamBattleChallengeResult.challenge_result",
	2,
	1,
	1,
	false,
	nil,
	var_0_6.TEAMBATTLECHALLENGERESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_TEAMBATTLECHALLENGERESULT_ME, {
	"S2C_TeamBattleChallengeResult",
	".cs.S2C_TeamBattleChallengeResult",
	{},
	{},
	{
		var_0_6.S2C_TEAMBATTLECHALLENGERESULT_RET_F,
		var_0_6.S2C_TEAMBATTLECHALLENGERESULT_CHALLENGE_RESULT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHSKINPART_SKIN_PARTS_F, {
	"skin_parts",
	".cs.S2C_FlushSkinPart.skin_parts",
	2,
	0,
	3,
	false,
	{},
	var_0_3.USERSKINPART_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHSKINPART_ME, {
	"S2C_FlushSkinPart",
	".cs.S2C_FlushSkinPart",
	{},
	{},
	{
		var_0_6.S2C_FLUSHSKINPART_SKIN_PARTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_6.S2C_FLUSHSERVERCONFIG_CONFIG_F, {
	"config",
	".cs.S2C_FlushServerConfig.config",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.SERVERCONFIG_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_6.S2C_FLUSHSERVERCONFIG_ME, {
	"S2C_FlushServerConfig",
	".cs.S2C_FlushServerConfig",
	{},
	{},
	{
		var_0_6.S2C_FLUSHSERVERCONFIG_CONFIG_F
	},
	false,
	{}
})

return var_0_6
