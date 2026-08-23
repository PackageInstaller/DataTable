local var_0_0 = ...
local protobuf = require("protobuf.protobuf")
local var_0_2 = (function(arg_1_0)
	if import then
		return import("." .. arg_1_0, var_0_0)
	else
		return require(arg_1_0)
	end
end)("pb_out_base")
local descriptor_helper = require("protobuf.descriptor_helper")
local var_0_4 = {
	DOMAIN = 12,
	GVE_BOSS = 11,
	TEAM_BATTLE_MONSTER = 10,
	TEAM_BATTLE_BOSS = 9,
	EXPLORATION_GUARD = 8,
	EXPLORATION_MONSTER = 7,
	MSG_S2C_ReplyBattleReport = 20000,
	MSG_C2S_CheckBattleResult = 20001,
	MSG_S2C_CheckBattleResult = 20002,
	MSG_C2S_ClientTestBattle = 20003,
	MSG_S2C_ClientTestBattle = 20004,
	MSG_S2C_CheckAsyncBattle = 20005,
	MSG_C2S_CheckAsyncBattle = 20006,
	MSG_S2C_ExecuteAsyncBattle = 20007,
	MSG_C2S_ExecuteAsyncBattle = 20008,
	MSG_C2S_BattleTestBegin = 20009,
	MSG_S2C_BattleTestBegin = 20010,
	MSG_S2C_BattleTestFinish = 20011,
	TOWER = 1,
	PEAK_ARENA = 2,
	PEAK_ARENA_MULTI = 3,
	EXPLORATION_BOSS = 4,
	THEME_BOSS = 5,
	SPIRE_BOSS = 6,
	ID_E = protobuf.EnumDescriptor(),
	ID_MSG_S2C_REPLYBATTLEREPORT_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_C2S_CHECKBATTLERESULT_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_S2C_CHECKBATTLERESULT_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_C2S_CLIENTTESTBATTLE_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_S2C_CLIENTTESTBATTLE_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_S2C_CHECKASYNCBATTLE_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_C2S_CHECKASYNCBATTLE_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_S2C_EXECUTEASYNCBATTLE_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_C2S_EXECUTEASYNCBATTLE_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_C2S_BATTLETESTBEGIN_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_S2C_BATTLETESTBEGIN_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_S2C_BATTLETESTFINISH_EI = protobuf.EnumValueDescriptor(),
	PLAY_ID_E = protobuf.EnumDescriptor(),
	PLAY_ID_TOWER_EI = protobuf.EnumValueDescriptor(),
	PLAY_ID_PEAK_ARENA_EI = protobuf.EnumValueDescriptor(),
	PLAY_ID_PEAK_ARENA_MULTI_EI = protobuf.EnumValueDescriptor(),
	PLAY_ID_EXPLORATION_BOSS_EI = protobuf.EnumValueDescriptor(),
	PLAY_ID_THEME_BOSS_EI = protobuf.EnumValueDescriptor(),
	PLAY_ID_SPIRE_BOSS_EI = protobuf.EnumValueDescriptor(),
	PLAY_ID_EXPLORATION_MONSTER_EI = protobuf.EnumValueDescriptor(),
	PLAY_ID_EXPLORATION_GUARD_EI = protobuf.EnumValueDescriptor(),
	PLAY_ID_TEAM_BATTLE_BOSS_EI = protobuf.EnumValueDescriptor(),
	PLAY_ID_TEAM_BATTLE_MONSTER_EI = protobuf.EnumValueDescriptor(),
	PLAY_ID_GVE_BOSS_EI = protobuf.EnumValueDescriptor(),
	PLAY_ID_DOMAIN_EI = protobuf.EnumValueDescriptor(),
	ATTR_ME = protobuf.Descriptor(),
	ATTR_TYPE_F = protobuf.FieldDescriptor(),
	ATTR_VALUE_F = protobuf.FieldDescriptor(),
	BATTLECOMBO_ME = protobuf.Descriptor(),
	BATTLECOMBO_TOKENS_F = protobuf.FieldDescriptor(),
	BATTLECOMBO_ATTRS_F = protobuf.FieldDescriptor(),
	BATTLECOMBO_LEVEL_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_ME = protobuf.Descriptor(),
	BATTLEUNIT_ID_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_POS_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_ATTRS_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_SKILLS_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_STAR_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_SKILL_LEVEL1_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_SKILL_LEVEL2_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_NAME_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_COMMON_SKILL_ID_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_ACTIVE_SKILL_ID_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_HP_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_ADVANCE_LEVEL_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_SKIN_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_SKIN_TS_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_ARTIFACTID_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_SKILL_LEVEL4_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_CARDID_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_DRESS_NUM_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_WINGID_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_MONSTER_LEVEL_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_FIGHT_VALUE_F = protobuf.FieldDescriptor(),
	BATTLEUNIT_RELIVE_ATTRS_F = protobuf.FieldDescriptor(),
	BATTLEATTR_ME = protobuf.Descriptor(),
	BATTLEATTR_ATTRS_F = protobuf.FieldDescriptor(),
	BATTLETEAM_ME = protobuf.Descriptor(),
	BATTLETEAM_UNITS_F = protobuf.FieldDescriptor(),
	BATTLETEAM_COMBO_F = protobuf.FieldDescriptor(),
	BATTLETEAM_FIGHT_VALUE_F = protobuf.FieldDescriptor(),
	BATTLETEAM_WAVE_F = protobuf.FieldDescriptor(),
	BATTLETEAM_IS_BOSS_F = protobuf.FieldDescriptor(),
	BATTLETEAM_DROPS_F = protobuf.FieldDescriptor(),
	BATTLETEAM_USER_F = protobuf.FieldDescriptor(),
	BATTLETEAM_TOTAL_HP_F = protobuf.FieldDescriptor(),
	BATTLETEAM_MULTIPLE_F = protobuf.FieldDescriptor(),
	BATTLETEAM_REBEL_TALENT_F = protobuf.FieldDescriptor(),
	BATTLETEAM_MONSTER_TEAM_ID_F = protobuf.FieldDescriptor(),
	BATTLETEAM_REBEL_ID_F = protobuf.FieldDescriptor(),
	BATTLETEAM_SHOWS_F = protobuf.FieldDescriptor(),
	BATTLETEAM_PETS_F = protobuf.FieldDescriptor(),
	BATTLETEAM_PASSIVE_SKILLS_F = protobuf.FieldDescriptor(),
	BATTLETEAM_MONSTER_TEAM_TYPE_F = protobuf.FieldDescriptor(),
	BATTLETEAM_HEALTH_BAR_F = protobuf.FieldDescriptor(),
	BATTLETEAM_PET_ADVANCE_BASE_IDS_F = protobuf.FieldDescriptor(),
	BATTLETEAM_PROFESSION_PASSIVE_SKILLS_F = protobuf.FieldDescriptor(),
	BATTLETEAM_SUCCUBAS_F = protobuf.FieldDescriptor(),
	BATTLETEAM_ELDER_BOSS_BUFF_F = protobuf.FieldDescriptor(),
	BATTLETEAM_TOTAL_CHARM_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_ME = protobuf.Descriptor(),
	BATTLEREPORT_BATTLE_ID_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_ATK_TYPE_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_IS_AUTO_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_RANDOM_SEED_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_OWN_TEAMS_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_ENEMY_TEAMS_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_WIN_CONDITION_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_RANDOM_SEEDS_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_REWARD_ID_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_ASSISTANCE_ID_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_PLAY_ID_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_FIRST_HAND_TEAM_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_MULTI_FIGHT_MODE_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_VICTORY_MODE_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_SPIRE_MAX_DAMAGE_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_SUCCUBA_BATTLE_CLOSE_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_BATTLE_QUALITY_MAGNIFICATION_F = protobuf.FieldDescriptor(),
	BATTLEREPORT_BATTLE_PARAMETER_MAGNIFICATION_F = protobuf.FieldDescriptor(),
	PLAYERCOMMAND_ME = protobuf.Descriptor(),
	PLAYERCOMMAND_IDENTITY_F = protobuf.FieldDescriptor(),
	PLAYERCOMMAND_ID_F = protobuf.FieldDescriptor(),
	PLAYERCOMMAND_ATTACK_COUNT_F = protobuf.FieldDescriptor(),
	PLAYERCOMMAND_TP_F = protobuf.FieldDescriptor(),
	UNITCHECK_ME = protobuf.Descriptor(),
	UNITCHECK_IDENTITY_F = protobuf.FieldDescriptor(),
	UNITCHECK_POS_F = protobuf.FieldDescriptor(),
	UNITCHECK_HP_F = protobuf.FieldDescriptor(),
	UNITCHECK_REBORN_COUNT_F = protobuf.FieldDescriptor(),
	BATTLEVIDEO_ME = protobuf.Descriptor(),
	BATTLEVIDEO_VERSION_F = protobuf.FieldDescriptor(),
	BATTLEVIDEO_BATTLE_REPORT_F = protobuf.FieldDescriptor(),
	BATTLEVIDEO_PLAYER_COMMAND_F = protobuf.FieldDescriptor(),
	ABNORMALBATTLE_ME = protobuf.Descriptor(),
	ABNORMALBATTLE_VERSION_F = protobuf.FieldDescriptor(),
	ABNORMALBATTLE_ATK_TYPE_F = protobuf.FieldDescriptor(),
	ABNORMALBATTLE_REASON_F = protobuf.FieldDescriptor(),
	ABNORMALBATTLE_BATTLE_REPORT_F = protobuf.FieldDescriptor(),
	ABNORMALBATTLE_BATTLE_RESULT_F = protobuf.FieldDescriptor(),
	BATTLERESULT_ME = protobuf.Descriptor(),
	BATTLERESULT_BATTLE_ID_F = protobuf.FieldDescriptor(),
	BATTLERESULT_IS_WIN_F = protobuf.FieldDescriptor(),
	BATTLERESULT_COMMAND_F = protobuf.FieldDescriptor(),
	BATTLERESULT_UNITS1_F = protobuf.FieldDescriptor(),
	BATTLERESULT_UNITS2_F = protobuf.FieldDescriptor(),
	BATTLERESULT_ROUND_F = protobuf.FieldDescriptor(),
	BATTLERESULT_RESULT_F = protobuf.FieldDescriptor(),
	BATTLERESULT_CUR_OWN_WAVE_F = protobuf.FieldDescriptor(),
	BATTLERESULT_CUR_ENEMY_WAVE_F = protobuf.FieldDescriptor(),
	BATTLERESULT_DATA_VERSION_F = protobuf.FieldDescriptor(),
	BATTLERESULT_OWN_NAME_F = protobuf.FieldDescriptor(),
	BATTLERESULT_ENEMY_NAME_F = protobuf.FieldDescriptor(),
	BATTLERESULT_OWN_TEAMS_F = protobuf.FieldDescriptor(),
	BATTLERESULT_ENEMY_TEAMS_F = protobuf.FieldDescriptor(),
	BATTLERESULT_ATTACK_TOTAL_DAMAGE_F = protobuf.FieldDescriptor(),
	BATTLERESULT_MULTI_RESULT_F = protobuf.FieldDescriptor(),
	BATTLERESULT_WAVE_UNITS_F = protobuf.FieldDescriptor(),
	BATTLERESULT_IS_REPORT_F = protobuf.FieldDescriptor(),
	BATTLEWAVEUNITRESULT_ME = protobuf.Descriptor(),
	BATTLEWAVEUNITRESULT_OWN_UNITS_F = protobuf.FieldDescriptor(),
	BATTLEWAVEUNITRESULT_ENEMY_UNITS_F = protobuf.FieldDescriptor(),
	BATTLEUNITRESULT_ME = protobuf.Descriptor(),
	BATTLEUNITRESULT_TYPE_F = protobuf.FieldDescriptor(),
	BATTLEUNITRESULT_ID_F = protobuf.FieldDescriptor(),
	BATTLEUNITRESULT_AVARTAR_ID_F = protobuf.FieldDescriptor(),
	BATTLEUNITRESULT_DAM_F = protobuf.FieldDescriptor(),
	BATTLEUNITRESULT_RECOVER_F = protobuf.FieldDescriptor(),
	BATTLEUNITRESULT_TAKE_DAM_F = protobuf.FieldDescriptor(),
	BATTLEUNITRESULT_SEQ_F = protobuf.FieldDescriptor(),
	BRIEFREPORT_ME = protobuf.Descriptor(),
	BRIEFREPORT_OWN_TEAMS_F = protobuf.FieldDescriptor(),
	BRIEFREPORT_ENEMY_TEAMS_F = protobuf.FieldDescriptor(),
	BRIEFREPORT_IS_WIN_F = protobuf.FieldDescriptor(),
	BRIEFREPORT_UNITS1_F = protobuf.FieldDescriptor(),
	BRIEFREPORT_UNITS2_F = protobuf.FieldDescriptor(),
	BRIEFREPORT_ROUND_F = protobuf.FieldDescriptor(),
	BRIEFREPORT_RESULT_F = protobuf.FieldDescriptor(),
	TOKENKNIGHTSHOW_ME = protobuf.Descriptor(),
	TOKENKNIGHTSHOW_BASE_ID_F = protobuf.FieldDescriptor(),
	TOKENKNIGHTSHOW_SKIN_ID_F = protobuf.FieldDescriptor(),
	TOKENKNIGHTSHOW_SKIN_TM_F = protobuf.FieldDescriptor(),
	CHECKRESULT_ME = protobuf.Descriptor(),
	CHECKRESULT_BATTLE_ID_F = protobuf.FieldDescriptor(),
	CHECKRESULT_IS_WIN_F = protobuf.FieldDescriptor(),
	CHECKRESULT_CHECK_F = protobuf.FieldDescriptor(),
	CHECKRESULT_UNITS1_F = protobuf.FieldDescriptor(),
	CHECKRESULT_UNITS2_F = protobuf.FieldDescriptor(),
	CHECKRESULT_LOG_F = protobuf.FieldDescriptor(),
	CHECKRESULT_RET_F = protobuf.FieldDescriptor(),
	CHECKRESULT_DATA_VERSION_F = protobuf.FieldDescriptor(),
	S2C_REPLYBATTLEREPORT_ME = protobuf.Descriptor(),
	S2C_REPLYBATTLEREPORT_REPORT_F = protobuf.FieldDescriptor(),
	C2S_CHECKBATTLERESULT_ME = protobuf.Descriptor(),
	C2S_CHECKBATTLERESULT_RESULT_F = protobuf.FieldDescriptor(),
	S2C_CHECKBATTLERESULT_ME = protobuf.Descriptor(),
	S2C_CHECKBATTLERESULT_RET_F = protobuf.FieldDescriptor(),
	S2C_CHECKBATTLERESULT_RESULT_F = protobuf.FieldDescriptor(),
	C2S_CLIENTTESTBATTLE_ME = protobuf.Descriptor(),
	C2S_CLIENTTESTBATTLE_REPORT_F = protobuf.FieldDescriptor(),
	C2S_CLIENTTESTBATTLE_RESULT_F = protobuf.FieldDescriptor(),
	S2C_CLIENTTESTBATTLE_ME = protobuf.Descriptor(),
	S2C_CLIENTTESTBATTLE_RET_F = protobuf.FieldDescriptor(),
	S2C_CLIENTTESTBATTLE_RESULT_F = protobuf.FieldDescriptor(),
	S2C_CHECKASYNCBATTLE_ME = protobuf.Descriptor(),
	S2C_CHECKASYNCBATTLE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_CHECKASYNCBATTLE_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_CHECKASYNCBATTLE_REPORT_F = protobuf.FieldDescriptor(),
	S2C_CHECKASYNCBATTLE_RESULT_F = protobuf.FieldDescriptor(),
	C2S_CHECKASYNCBATTLE_ME = protobuf.Descriptor(),
	C2S_CHECKASYNCBATTLE_RET_F = protobuf.FieldDescriptor(),
	C2S_CHECKASYNCBATTLE_USER_ID_F = protobuf.FieldDescriptor(),
	C2S_CHECKASYNCBATTLE_BATTLE_ID_F = protobuf.FieldDescriptor(),
	C2S_CHECKASYNCBATTLE_RESULT_F = protobuf.FieldDescriptor(),
	S2C_EXECUTEASYNCBATTLE_ME = protobuf.Descriptor(),
	S2C_EXECUTEASYNCBATTLE_USER_ID_F = protobuf.FieldDescriptor(),
	S2C_EXECUTEASYNCBATTLE_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_EXECUTEASYNCBATTLE_REPORT_F = protobuf.FieldDescriptor(),
	C2S_EXECUTEASYNCBATTLE_ME = protobuf.Descriptor(),
	C2S_EXECUTEASYNCBATTLE_RET_F = protobuf.FieldDescriptor(),
	C2S_EXECUTEASYNCBATTLE_USER_ID_F = protobuf.FieldDescriptor(),
	C2S_EXECUTEASYNCBATTLE_BATTLE_ID_F = protobuf.FieldDescriptor(),
	C2S_EXECUTEASYNCBATTLE_RESULT_F = protobuf.FieldDescriptor(),
	C2S_BATTLETESTBEGIN_ME = protobuf.Descriptor(),
	C2S_BATTLETESTBEGIN_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BATTLETESTBEGIN_ME = protobuf.Descriptor(),
	S2C_BATTLETESTBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_BATTLETESTBEGIN_TYPE_F = protobuf.FieldDescriptor(),
	S2C_BATTLETESTBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_BATTLETESTFINISH_ME = protobuf.Descriptor(),
	S2C_BATTLETESTFINISH_RET_F = protobuf.FieldDescriptor(),
	BATTLESUCCUBA_ME = protobuf.Descriptor(),
	BATTLESUCCUBA_ID_F = protobuf.FieldDescriptor(),
	BATTLESUCCUBA_POS_F = protobuf.FieldDescriptor(),
	BATTLESUCCUBA_LEVEL_F = protobuf.FieldDescriptor(),
	BATTLESUCCUBA_STAR_F = protobuf.FieldDescriptor(),
	BATTLESUCCUBA_CHARM_F = protobuf.FieldDescriptor(),
	BATTLESUCCUBA_NODE_F = protobuf.FieldDescriptor(),
	BATTLESUCCUBA_STAGE_F = protobuf.FieldDescriptor()
}

descriptor_helper.enumValueDescriptorFunc(var_0_4.ID_MSG_S2C_REPLYBATTLEREPORT_EI, {
	"MSG_S2C_ReplyBattleReport",
	0,
	20000
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.ID_MSG_C2S_CHECKBATTLERESULT_EI, {
	"MSG_C2S_CheckBattleResult",
	1,
	20001
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.ID_MSG_S2C_CHECKBATTLERESULT_EI, {
	"MSG_S2C_CheckBattleResult",
	2,
	20002
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.ID_MSG_C2S_CLIENTTESTBATTLE_EI, {
	"MSG_C2S_ClientTestBattle",
	3,
	20003
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.ID_MSG_S2C_CLIENTTESTBATTLE_EI, {
	"MSG_S2C_ClientTestBattle",
	4,
	20004
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.ID_MSG_S2C_CHECKASYNCBATTLE_EI, {
	"MSG_S2C_CheckAsyncBattle",
	5,
	20005
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.ID_MSG_C2S_CHECKASYNCBATTLE_EI, {
	"MSG_C2S_CheckAsyncBattle",
	6,
	20006
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.ID_MSG_S2C_EXECUTEASYNCBATTLE_EI, {
	"MSG_S2C_ExecuteAsyncBattle",
	7,
	20007
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.ID_MSG_C2S_EXECUTEASYNCBATTLE_EI, {
	"MSG_C2S_ExecuteAsyncBattle",
	8,
	20008
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.ID_MSG_C2S_BATTLETESTBEGIN_EI, {
	"MSG_C2S_BattleTestBegin",
	9,
	20009
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.ID_MSG_S2C_BATTLETESTBEGIN_EI, {
	"MSG_S2C_BattleTestBegin",
	10,
	20010
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.ID_MSG_S2C_BATTLETESTFINISH_EI, {
	"MSG_S2C_BattleTestFinish",
	11,
	20011
})
descriptor_helper.enumDescriptorFunc(var_0_4.ID_E, {
	"ID",
	".bs.ID",
	{
		var_0_4.ID_MSG_S2C_REPLYBATTLEREPORT_EI,
		var_0_4.ID_MSG_C2S_CHECKBATTLERESULT_EI,
		var_0_4.ID_MSG_S2C_CHECKBATTLERESULT_EI,
		var_0_4.ID_MSG_C2S_CLIENTTESTBATTLE_EI,
		var_0_4.ID_MSG_S2C_CLIENTTESTBATTLE_EI,
		var_0_4.ID_MSG_S2C_CHECKASYNCBATTLE_EI,
		var_0_4.ID_MSG_C2S_CHECKASYNCBATTLE_EI,
		var_0_4.ID_MSG_S2C_EXECUTEASYNCBATTLE_EI,
		var_0_4.ID_MSG_C2S_EXECUTEASYNCBATTLE_EI,
		var_0_4.ID_MSG_C2S_BATTLETESTBEGIN_EI,
		var_0_4.ID_MSG_S2C_BATTLETESTBEGIN_EI,
		var_0_4.ID_MSG_S2C_BATTLETESTFINISH_EI
	}
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.PLAY_ID_TOWER_EI, {
	"TOWER",
	0,
	1
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.PLAY_ID_PEAK_ARENA_EI, {
	"PEAK_ARENA",
	1,
	2
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.PLAY_ID_PEAK_ARENA_MULTI_EI, {
	"PEAK_ARENA_MULTI",
	2,
	3
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.PLAY_ID_EXPLORATION_BOSS_EI, {
	"EXPLORATION_BOSS",
	3,
	4
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.PLAY_ID_THEME_BOSS_EI, {
	"THEME_BOSS",
	4,
	5
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.PLAY_ID_SPIRE_BOSS_EI, {
	"SPIRE_BOSS",
	5,
	6
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.PLAY_ID_EXPLORATION_MONSTER_EI, {
	"EXPLORATION_MONSTER",
	6,
	7
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.PLAY_ID_EXPLORATION_GUARD_EI, {
	"EXPLORATION_GUARD",
	7,
	8
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.PLAY_ID_TEAM_BATTLE_BOSS_EI, {
	"TEAM_BATTLE_BOSS",
	8,
	9
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.PLAY_ID_TEAM_BATTLE_MONSTER_EI, {
	"TEAM_BATTLE_MONSTER",
	9,
	10
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.PLAY_ID_GVE_BOSS_EI, {
	"GVE_BOSS",
	10,
	11
})
descriptor_helper.enumValueDescriptorFunc(var_0_4.PLAY_ID_DOMAIN_EI, {
	"DOMAIN",
	11,
	12
})
descriptor_helper.enumDescriptorFunc(var_0_4.PLAY_ID_E, {
	"PLAY_ID",
	".bs.PLAY_ID",
	{
		var_0_4.PLAY_ID_TOWER_EI,
		var_0_4.PLAY_ID_PEAK_ARENA_EI,
		var_0_4.PLAY_ID_PEAK_ARENA_MULTI_EI,
		var_0_4.PLAY_ID_EXPLORATION_BOSS_EI,
		var_0_4.PLAY_ID_THEME_BOSS_EI,
		var_0_4.PLAY_ID_SPIRE_BOSS_EI,
		var_0_4.PLAY_ID_EXPLORATION_MONSTER_EI,
		var_0_4.PLAY_ID_EXPLORATION_GUARD_EI,
		var_0_4.PLAY_ID_TEAM_BATTLE_BOSS_EI,
		var_0_4.PLAY_ID_TEAM_BATTLE_MONSTER_EI,
		var_0_4.PLAY_ID_GVE_BOSS_EI,
		var_0_4.PLAY_ID_DOMAIN_EI
	}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.ATTR_TYPE_F, {
	"type",
	".bs.Attr.type",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.ATTR_VALUE_F, {
	"value",
	".bs.Attr.value",
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
descriptor_helper.descriptorFunc(var_0_4.ATTR_ME, {
	"Attr",
	".bs.Attr",
	{},
	{},
	{
		var_0_4.ATTR_TYPE_F,
		var_0_4.ATTR_VALUE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLECOMBO_TOKENS_F, {
	"tokens",
	".bs.BattleCombo.tokens",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLECOMBO_ATTRS_F, {
	"attrs",
	".bs.BattleCombo.attrs",
	2,
	1,
	3,
	false,
	{},
	var_0_4.ATTR_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLECOMBO_LEVEL_F, {
	"level",
	".bs.BattleCombo.level",
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
descriptor_helper.descriptorFunc(var_0_4.BATTLECOMBO_ME, {
	"BattleCombo",
	".bs.BattleCombo",
	{},
	{},
	{
		var_0_4.BATTLECOMBO_TOKENS_F,
		var_0_4.BATTLECOMBO_ATTRS_F,
		var_0_4.BATTLECOMBO_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_ID_F, {
	"id",
	".bs.BattleUnit.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_POS_F, {
	"pos",
	".bs.BattleUnit.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_ATTRS_F, {
	"attrs",
	".bs.BattleUnit.attrs",
	3,
	2,
	3,
	false,
	{},
	var_0_4.ATTR_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_SKILLS_F, {
	"skills",
	".bs.BattleUnit.skills",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_STAR_F, {
	"star",
	".bs.BattleUnit.star",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_SKILL_LEVEL1_F, {
	"skill_level1",
	".bs.BattleUnit.skill_level1",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_SKILL_LEVEL2_F, {
	"skill_level2",
	".bs.BattleUnit.skill_level2",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_NAME_F, {
	"name",
	".bs.BattleUnit.name",
	8,
	7,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_COMMON_SKILL_ID_F, {
	"common_skill_id",
	".bs.BattleUnit.common_skill_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_ACTIVE_SKILL_ID_F, {
	"active_skill_id",
	".bs.BattleUnit.active_skill_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_HP_F, {
	"hp",
	".bs.BattleUnit.hp",
	11,
	10,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_ADVANCE_LEVEL_F, {
	"advance_level",
	".bs.BattleUnit.advance_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_SKIN_F, {
	"skin",
	".bs.BattleUnit.skin",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_SKIN_TS_F, {
	"skin_ts",
	".bs.BattleUnit.skin_ts",
	14,
	13,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_ARTIFACTID_F, {
	"artifactId",
	".bs.BattleUnit.artifactId",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_SKILL_LEVEL4_F, {
	"skill_level4",
	".bs.BattleUnit.skill_level4",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_CARDID_F, {
	"cardId",
	".bs.BattleUnit.cardId",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_DRESS_NUM_F, {
	"dress_num",
	".bs.BattleUnit.dress_num",
	18,
	17,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_WINGID_F, {
	"wingId",
	".bs.BattleUnit.wingId",
	19,
	18,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_MONSTER_LEVEL_F, {
	"monster_level",
	".bs.BattleUnit.monster_level",
	20,
	19,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_FIGHT_VALUE_F, {
	"fight_value",
	".bs.BattleUnit.fight_value",
	21,
	20,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNIT_RELIVE_ATTRS_F, {
	"relive_attrs",
	".bs.BattleUnit.relive_attrs",
	22,
	21,
	3,
	false,
	{},
	var_0_4.BATTLEATTR_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_4.BATTLEUNIT_ME, {
	"BattleUnit",
	".bs.BattleUnit",
	{},
	{},
	{
		var_0_4.BATTLEUNIT_ID_F,
		var_0_4.BATTLEUNIT_POS_F,
		var_0_4.BATTLEUNIT_ATTRS_F,
		var_0_4.BATTLEUNIT_SKILLS_F,
		var_0_4.BATTLEUNIT_STAR_F,
		var_0_4.BATTLEUNIT_SKILL_LEVEL1_F,
		var_0_4.BATTLEUNIT_SKILL_LEVEL2_F,
		var_0_4.BATTLEUNIT_NAME_F,
		var_0_4.BATTLEUNIT_COMMON_SKILL_ID_F,
		var_0_4.BATTLEUNIT_ACTIVE_SKILL_ID_F,
		var_0_4.BATTLEUNIT_HP_F,
		var_0_4.BATTLEUNIT_ADVANCE_LEVEL_F,
		var_0_4.BATTLEUNIT_SKIN_F,
		var_0_4.BATTLEUNIT_SKIN_TS_F,
		var_0_4.BATTLEUNIT_ARTIFACTID_F,
		var_0_4.BATTLEUNIT_SKILL_LEVEL4_F,
		var_0_4.BATTLEUNIT_CARDID_F,
		var_0_4.BATTLEUNIT_DRESS_NUM_F,
		var_0_4.BATTLEUNIT_WINGID_F,
		var_0_4.BATTLEUNIT_MONSTER_LEVEL_F,
		var_0_4.BATTLEUNIT_FIGHT_VALUE_F,
		var_0_4.BATTLEUNIT_RELIVE_ATTRS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEATTR_ATTRS_F, {
	"attrs",
	".bs.BattleAttr.attrs",
	1,
	0,
	3,
	false,
	{},
	var_0_4.ATTR_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_4.BATTLEATTR_ME, {
	"BattleAttr",
	".bs.BattleAttr",
	{},
	{},
	{
		var_0_4.BATTLEATTR_ATTRS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_UNITS_F, {
	"units",
	".bs.BattleTeam.units",
	1,
	0,
	3,
	false,
	{},
	var_0_4.BATTLEUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_COMBO_F, {
	"combo",
	".bs.BattleTeam.combo",
	2,
	1,
	2,
	false,
	nil,
	var_0_4.BATTLECOMBO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_FIGHT_VALUE_F, {
	"fight_value",
	".bs.BattleTeam.fight_value",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_WAVE_F, {
	"wave",
	".bs.BattleTeam.wave",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_IS_BOSS_F, {
	"is_boss",
	".bs.BattleTeam.is_boss",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_DROPS_F, {
	"drops",
	".bs.BattleTeam.drops",
	6,
	5,
	3,
	false,
	{},
	var_0_2.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_USER_F, {
	"user",
	".bs.BattleTeam.user",
	7,
	6,
	1,
	false,
	nil,
	var_0_2.USERSNAPSHOT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_TOTAL_HP_F, {
	"total_hp",
	".bs.BattleTeam.total_hp",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_MULTIPLE_F, {
	"multiple",
	".bs.BattleTeam.multiple",
	9,
	8,
	1,
	false,
	0,
	nil,
	nil,
	5,
	1
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_REBEL_TALENT_F, {
	"rebel_talent",
	".bs.BattleTeam.rebel_talent",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_MONSTER_TEAM_ID_F, {
	"monster_team_id",
	".bs.BattleTeam.monster_team_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_REBEL_ID_F, {
	"rebel_id",
	".bs.BattleTeam.rebel_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_SHOWS_F, {
	"shows",
	".bs.BattleTeam.shows",
	13,
	12,
	3,
	false,
	{},
	var_0_4.TOKENKNIGHTSHOW_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_PETS_F, {
	"pets",
	".bs.BattleTeam.pets",
	14,
	13,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_PASSIVE_SKILLS_F, {
	"passive_skills",
	".bs.BattleTeam.passive_skills",
	15,
	14,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_MONSTER_TEAM_TYPE_F, {
	"monster_team_type",
	".bs.BattleTeam.monster_team_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_HEALTH_BAR_F, {
	"health_bar",
	".bs.BattleTeam.health_bar",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_PET_ADVANCE_BASE_IDS_F, {
	"pet_advance_base_ids",
	".bs.BattleTeam.pet_advance_base_ids",
	18,
	17,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_PROFESSION_PASSIVE_SKILLS_F, {
	"profession_passive_skills",
	".bs.BattleTeam.profession_passive_skills",
	19,
	18,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_SUCCUBAS_F, {
	"succubas",
	".bs.BattleTeam.succubas",
	20,
	19,
	3,
	false,
	{},
	var_0_4.BATTLESUCCUBA_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_ELDER_BOSS_BUFF_F, {
	"elder_boss_buff",
	".bs.BattleTeam.elder_boss_buff",
	21,
	20,
	1,
	false,
	nil,
	var_0_2.KV2_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLETEAM_TOTAL_CHARM_F, {
	"total_charm",
	".bs.BattleTeam.total_charm",
	22,
	21,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_4.BATTLETEAM_ME, {
	"BattleTeam",
	".bs.BattleTeam",
	{},
	{},
	{
		var_0_4.BATTLETEAM_UNITS_F,
		var_0_4.BATTLETEAM_COMBO_F,
		var_0_4.BATTLETEAM_FIGHT_VALUE_F,
		var_0_4.BATTLETEAM_WAVE_F,
		var_0_4.BATTLETEAM_IS_BOSS_F,
		var_0_4.BATTLETEAM_DROPS_F,
		var_0_4.BATTLETEAM_USER_F,
		var_0_4.BATTLETEAM_TOTAL_HP_F,
		var_0_4.BATTLETEAM_MULTIPLE_F,
		var_0_4.BATTLETEAM_REBEL_TALENT_F,
		var_0_4.BATTLETEAM_MONSTER_TEAM_ID_F,
		var_0_4.BATTLETEAM_REBEL_ID_F,
		var_0_4.BATTLETEAM_SHOWS_F,
		var_0_4.BATTLETEAM_PETS_F,
		var_0_4.BATTLETEAM_PASSIVE_SKILLS_F,
		var_0_4.BATTLETEAM_MONSTER_TEAM_TYPE_F,
		var_0_4.BATTLETEAM_HEALTH_BAR_F,
		var_0_4.BATTLETEAM_PET_ADVANCE_BASE_IDS_F,
		var_0_4.BATTLETEAM_PROFESSION_PASSIVE_SKILLS_F,
		var_0_4.BATTLETEAM_SUCCUBAS_F,
		var_0_4.BATTLETEAM_ELDER_BOSS_BUFF_F,
		var_0_4.BATTLETEAM_TOTAL_CHARM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_BATTLE_ID_F, {
	"battle_id",
	".bs.BattleReport.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_ATK_TYPE_F, {
	"atk_type",
	".bs.BattleReport.atk_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_IS_AUTO_F, {
	"is_auto",
	".bs.BattleReport.is_auto",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_RANDOM_SEED_F, {
	"random_seed",
	".bs.BattleReport.random_seed",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_OWN_TEAMS_F, {
	"own_teams",
	".bs.BattleReport.own_teams",
	5,
	4,
	3,
	false,
	{},
	var_0_4.BATTLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_ENEMY_TEAMS_F, {
	"enemy_teams",
	".bs.BattleReport.enemy_teams",
	6,
	5,
	3,
	false,
	{},
	var_0_4.BATTLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_WIN_CONDITION_F, {
	"win_condition",
	".bs.BattleReport.win_condition",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_RANDOM_SEEDS_F, {
	"random_seeds",
	".bs.BattleReport.random_seeds",
	8,
	7,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_REWARD_ID_F, {
	"reward_id",
	".bs.BattleReport.reward_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_ASSISTANCE_ID_F, {
	"assistance_id",
	".bs.BattleReport.assistance_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_PLAY_ID_F, {
	"play_id",
	".bs.BattleReport.play_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_FIRST_HAND_TEAM_F, {
	"first_hand_team",
	".bs.BattleReport.first_hand_team",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_MULTI_FIGHT_MODE_F, {
	"multi_fight_mode",
	".bs.BattleReport.multi_fight_mode",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_VICTORY_MODE_F, {
	"victory_mode",
	".bs.BattleReport.victory_mode",
	14,
	13,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_SPIRE_MAX_DAMAGE_F, {
	"spire_max_damage",
	".bs.BattleReport.spire_max_damage",
	15,
	14,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_SUCCUBA_BATTLE_CLOSE_F, {
	"succuba_battle_close",
	".bs.BattleReport.succuba_battle_close",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_BATTLE_QUALITY_MAGNIFICATION_F, {
	"battle_quality_magnification",
	".bs.BattleReport.battle_quality_magnification",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEREPORT_BATTLE_PARAMETER_MAGNIFICATION_F, {
	"battle_parameter_magnification",
	".bs.BattleReport.battle_parameter_magnification",
	18,
	17,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_4.BATTLEREPORT_ME, {
	"BattleReport",
	".bs.BattleReport",
	{},
	{},
	{
		var_0_4.BATTLEREPORT_BATTLE_ID_F,
		var_0_4.BATTLEREPORT_ATK_TYPE_F,
		var_0_4.BATTLEREPORT_IS_AUTO_F,
		var_0_4.BATTLEREPORT_RANDOM_SEED_F,
		var_0_4.BATTLEREPORT_OWN_TEAMS_F,
		var_0_4.BATTLEREPORT_ENEMY_TEAMS_F,
		var_0_4.BATTLEREPORT_WIN_CONDITION_F,
		var_0_4.BATTLEREPORT_RANDOM_SEEDS_F,
		var_0_4.BATTLEREPORT_REWARD_ID_F,
		var_0_4.BATTLEREPORT_ASSISTANCE_ID_F,
		var_0_4.BATTLEREPORT_PLAY_ID_F,
		var_0_4.BATTLEREPORT_FIRST_HAND_TEAM_F,
		var_0_4.BATTLEREPORT_MULTI_FIGHT_MODE_F,
		var_0_4.BATTLEREPORT_VICTORY_MODE_F,
		var_0_4.BATTLEREPORT_SPIRE_MAX_DAMAGE_F,
		var_0_4.BATTLEREPORT_SUCCUBA_BATTLE_CLOSE_F,
		var_0_4.BATTLEREPORT_BATTLE_QUALITY_MAGNIFICATION_F,
		var_0_4.BATTLEREPORT_BATTLE_PARAMETER_MAGNIFICATION_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.PLAYERCOMMAND_IDENTITY_F, {
	"identity",
	".bs.PlayerCommand.identity",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.PLAYERCOMMAND_ID_F, {
	"id",
	".bs.PlayerCommand.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.PLAYERCOMMAND_ATTACK_COUNT_F, {
	"attack_count",
	".bs.PlayerCommand.attack_count",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.PLAYERCOMMAND_TP_F, {
	"tp",
	".bs.PlayerCommand.tp",
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
descriptor_helper.descriptorFunc(var_0_4.PLAYERCOMMAND_ME, {
	"PlayerCommand",
	".bs.PlayerCommand",
	{},
	{},
	{
		var_0_4.PLAYERCOMMAND_IDENTITY_F,
		var_0_4.PLAYERCOMMAND_ID_F,
		var_0_4.PLAYERCOMMAND_ATTACK_COUNT_F,
		var_0_4.PLAYERCOMMAND_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.UNITCHECK_IDENTITY_F, {
	"identity",
	".bs.UnitCheck.identity",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.UNITCHECK_POS_F, {
	"pos",
	".bs.UnitCheck.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.UNITCHECK_HP_F, {
	"hp",
	".bs.UnitCheck.hp",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.UNITCHECK_REBORN_COUNT_F, {
	"reborn_count",
	".bs.UnitCheck.reborn_count",
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
descriptor_helper.descriptorFunc(var_0_4.UNITCHECK_ME, {
	"UnitCheck",
	".bs.UnitCheck",
	{},
	{},
	{
		var_0_4.UNITCHECK_IDENTITY_F,
		var_0_4.UNITCHECK_POS_F,
		var_0_4.UNITCHECK_HP_F,
		var_0_4.UNITCHECK_REBORN_COUNT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEVIDEO_VERSION_F, {
	"version",
	".bs.BattleVideo.version",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEVIDEO_BATTLE_REPORT_F, {
	"battle_report",
	".bs.BattleVideo.battle_report",
	2,
	1,
	2,
	false,
	nil,
	var_0_4.BATTLEREPORT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEVIDEO_PLAYER_COMMAND_F, {
	"player_command",
	".bs.BattleVideo.player_command",
	3,
	2,
	3,
	false,
	{},
	var_0_4.PLAYERCOMMAND_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_4.BATTLEVIDEO_ME, {
	"BattleVideo",
	".bs.BattleVideo",
	{},
	{},
	{
		var_0_4.BATTLEVIDEO_VERSION_F,
		var_0_4.BATTLEVIDEO_BATTLE_REPORT_F,
		var_0_4.BATTLEVIDEO_PLAYER_COMMAND_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.ABNORMALBATTLE_VERSION_F, {
	"version",
	".bs.AbnormalBattle.version",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.ABNORMALBATTLE_ATK_TYPE_F, {
	"atk_type",
	".bs.AbnormalBattle.atk_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.ABNORMALBATTLE_REASON_F, {
	"reason",
	".bs.AbnormalBattle.reason",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.ABNORMALBATTLE_BATTLE_REPORT_F, {
	"battle_report",
	".bs.AbnormalBattle.battle_report",
	4,
	3,
	1,
	false,
	nil,
	var_0_4.BATTLEREPORT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.ABNORMALBATTLE_BATTLE_RESULT_F, {
	"battle_result",
	".bs.AbnormalBattle.battle_result",
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
descriptor_helper.descriptorFunc(var_0_4.ABNORMALBATTLE_ME, {
	"AbnormalBattle",
	".bs.AbnormalBattle",
	{},
	{},
	{
		var_0_4.ABNORMALBATTLE_VERSION_F,
		var_0_4.ABNORMALBATTLE_ATK_TYPE_F,
		var_0_4.ABNORMALBATTLE_REASON_F,
		var_0_4.ABNORMALBATTLE_BATTLE_REPORT_F,
		var_0_4.ABNORMALBATTLE_BATTLE_RESULT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_BATTLE_ID_F, {
	"battle_id",
	".bs.BattleResult.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_IS_WIN_F, {
	"is_win",
	".bs.BattleResult.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_COMMAND_F, {
	"command",
	".bs.BattleResult.command",
	3,
	2,
	3,
	false,
	{},
	var_0_4.PLAYERCOMMAND_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_UNITS1_F, {
	"units1",
	".bs.BattleResult.units1",
	4,
	3,
	3,
	false,
	{},
	var_0_4.UNITCHECK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_UNITS2_F, {
	"units2",
	".bs.BattleResult.units2",
	5,
	4,
	3,
	false,
	{},
	var_0_4.UNITCHECK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_ROUND_F, {
	"round",
	".bs.BattleResult.round",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_RESULT_F, {
	"result",
	".bs.BattleResult.result",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_CUR_OWN_WAVE_F, {
	"cur_own_wave",
	".bs.BattleResult.cur_own_wave",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_CUR_ENEMY_WAVE_F, {
	"cur_enemy_wave",
	".bs.BattleResult.cur_enemy_wave",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_DATA_VERSION_F, {
	"data_version",
	".bs.BattleResult.data_version",
	10,
	9,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_OWN_NAME_F, {
	"own_name",
	".bs.BattleResult.own_name",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_ENEMY_NAME_F, {
	"enemy_name",
	".bs.BattleResult.enemy_name",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_OWN_TEAMS_F, {
	"own_teams",
	".bs.BattleResult.own_teams",
	13,
	12,
	3,
	false,
	{},
	var_0_4.BATTLEUNITRESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_ENEMY_TEAMS_F, {
	"enemy_teams",
	".bs.BattleResult.enemy_teams",
	14,
	13,
	3,
	false,
	{},
	var_0_4.BATTLEUNITRESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_ATTACK_TOTAL_DAMAGE_F, {
	"attack_total_damage",
	".bs.BattleResult.attack_total_damage",
	15,
	14,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_MULTI_RESULT_F, {
	"multi_result",
	".bs.BattleResult.multi_result",
	16,
	15,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_WAVE_UNITS_F, {
	"wave_units",
	".bs.BattleResult.wave_units",
	17,
	16,
	3,
	false,
	{},
	var_0_4.BATTLEWAVEUNITRESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLERESULT_IS_REPORT_F, {
	"is_report",
	".bs.BattleResult.is_report",
	18,
	17,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_4.BATTLERESULT_ME, {
	"BattleResult",
	".bs.BattleResult",
	{},
	{},
	{
		var_0_4.BATTLERESULT_BATTLE_ID_F,
		var_0_4.BATTLERESULT_IS_WIN_F,
		var_0_4.BATTLERESULT_COMMAND_F,
		var_0_4.BATTLERESULT_UNITS1_F,
		var_0_4.BATTLERESULT_UNITS2_F,
		var_0_4.BATTLERESULT_ROUND_F,
		var_0_4.BATTLERESULT_RESULT_F,
		var_0_4.BATTLERESULT_CUR_OWN_WAVE_F,
		var_0_4.BATTLERESULT_CUR_ENEMY_WAVE_F,
		var_0_4.BATTLERESULT_DATA_VERSION_F,
		var_0_4.BATTLERESULT_OWN_NAME_F,
		var_0_4.BATTLERESULT_ENEMY_NAME_F,
		var_0_4.BATTLERESULT_OWN_TEAMS_F,
		var_0_4.BATTLERESULT_ENEMY_TEAMS_F,
		var_0_4.BATTLERESULT_ATTACK_TOTAL_DAMAGE_F,
		var_0_4.BATTLERESULT_MULTI_RESULT_F,
		var_0_4.BATTLERESULT_WAVE_UNITS_F,
		var_0_4.BATTLERESULT_IS_REPORT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEWAVEUNITRESULT_OWN_UNITS_F, {
	"own_units",
	".bs.BattleWaveUnitResult.own_units",
	1,
	0,
	3,
	false,
	{},
	var_0_4.UNITCHECK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEWAVEUNITRESULT_ENEMY_UNITS_F, {
	"enemy_units",
	".bs.BattleWaveUnitResult.enemy_units",
	2,
	1,
	3,
	false,
	{},
	var_0_4.UNITCHECK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_4.BATTLEWAVEUNITRESULT_ME, {
	"BattleWaveUnitResult",
	".bs.BattleWaveUnitResult",
	{},
	{},
	{
		var_0_4.BATTLEWAVEUNITRESULT_OWN_UNITS_F,
		var_0_4.BATTLEWAVEUNITRESULT_ENEMY_UNITS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNITRESULT_TYPE_F, {
	"type",
	".bs.BattleUnitResult.type",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNITRESULT_ID_F, {
	"id",
	".bs.BattleUnitResult.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNITRESULT_AVARTAR_ID_F, {
	"avartar_id",
	".bs.BattleUnitResult.avartar_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNITRESULT_DAM_F, {
	"dam",
	".bs.BattleUnitResult.dam",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNITRESULT_RECOVER_F, {
	"recover",
	".bs.BattleUnitResult.recover",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNITRESULT_TAKE_DAM_F, {
	"take_dam",
	".bs.BattleUnitResult.take_dam",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLEUNITRESULT_SEQ_F, {
	"seq",
	".bs.BattleUnitResult.seq",
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
descriptor_helper.descriptorFunc(var_0_4.BATTLEUNITRESULT_ME, {
	"BattleUnitResult",
	".bs.BattleUnitResult",
	{},
	{},
	{
		var_0_4.BATTLEUNITRESULT_TYPE_F,
		var_0_4.BATTLEUNITRESULT_ID_F,
		var_0_4.BATTLEUNITRESULT_AVARTAR_ID_F,
		var_0_4.BATTLEUNITRESULT_DAM_F,
		var_0_4.BATTLEUNITRESULT_RECOVER_F,
		var_0_4.BATTLEUNITRESULT_TAKE_DAM_F,
		var_0_4.BATTLEUNITRESULT_SEQ_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BRIEFREPORT_OWN_TEAMS_F, {
	"own_teams",
	".bs.BriefReport.own_teams",
	1,
	0,
	3,
	false,
	{},
	var_0_4.BATTLETEAM_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BRIEFREPORT_ENEMY_TEAMS_F, {
	"enemy_teams",
	".bs.BriefReport.enemy_teams",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BRIEFREPORT_IS_WIN_F, {
	"is_win",
	".bs.BriefReport.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BRIEFREPORT_UNITS1_F, {
	"units1",
	".bs.BriefReport.units1",
	4,
	3,
	3,
	false,
	{},
	var_0_4.UNITCHECK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BRIEFREPORT_UNITS2_F, {
	"units2",
	".bs.BriefReport.units2",
	5,
	4,
	3,
	false,
	{},
	var_0_4.UNITCHECK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BRIEFREPORT_ROUND_F, {
	"round",
	".bs.BriefReport.round",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BRIEFREPORT_RESULT_F, {
	"result",
	".bs.BriefReport.result",
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
descriptor_helper.descriptorFunc(var_0_4.BRIEFREPORT_ME, {
	"BriefReport",
	".bs.BriefReport",
	{},
	{},
	{
		var_0_4.BRIEFREPORT_OWN_TEAMS_F,
		var_0_4.BRIEFREPORT_ENEMY_TEAMS_F,
		var_0_4.BRIEFREPORT_IS_WIN_F,
		var_0_4.BRIEFREPORT_UNITS1_F,
		var_0_4.BRIEFREPORT_UNITS2_F,
		var_0_4.BRIEFREPORT_ROUND_F,
		var_0_4.BRIEFREPORT_RESULT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.TOKENKNIGHTSHOW_BASE_ID_F, {
	"base_id",
	".bs.TokenKnightShow.base_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.TOKENKNIGHTSHOW_SKIN_ID_F, {
	"skin_id",
	".bs.TokenKnightShow.skin_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.TOKENKNIGHTSHOW_SKIN_TM_F, {
	"skin_tm",
	".bs.TokenKnightShow.skin_tm",
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
descriptor_helper.descriptorFunc(var_0_4.TOKENKNIGHTSHOW_ME, {
	"TokenKnightShow",
	".bs.TokenKnightShow",
	{},
	{},
	{
		var_0_4.TOKENKNIGHTSHOW_BASE_ID_F,
		var_0_4.TOKENKNIGHTSHOW_SKIN_ID_F,
		var_0_4.TOKENKNIGHTSHOW_SKIN_TM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.CHECKRESULT_BATTLE_ID_F, {
	"battle_id",
	".bs.CheckResult.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.CHECKRESULT_IS_WIN_F, {
	"is_win",
	".bs.CheckResult.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.CHECKRESULT_CHECK_F, {
	"check",
	".bs.CheckResult.check",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.CHECKRESULT_UNITS1_F, {
	"units1",
	".bs.CheckResult.units1",
	4,
	3,
	3,
	false,
	{},
	var_0_4.UNITCHECK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.CHECKRESULT_UNITS2_F, {
	"units2",
	".bs.CheckResult.units2",
	5,
	4,
	3,
	false,
	{},
	var_0_4.UNITCHECK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_4.CHECKRESULT_LOG_F, {
	"log",
	".bs.CheckResult.log",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.CHECKRESULT_RET_F, {
	"ret",
	".bs.CheckResult.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.CHECKRESULT_DATA_VERSION_F, {
	"data_version",
	".bs.CheckResult.data_version",
	8,
	7,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_4.CHECKRESULT_ME, {
	"CheckResult",
	".bs.CheckResult",
	{},
	{},
	{
		var_0_4.CHECKRESULT_BATTLE_ID_F,
		var_0_4.CHECKRESULT_IS_WIN_F,
		var_0_4.CHECKRESULT_CHECK_F,
		var_0_4.CHECKRESULT_UNITS1_F,
		var_0_4.CHECKRESULT_UNITS2_F,
		var_0_4.CHECKRESULT_LOG_F,
		var_0_4.CHECKRESULT_RET_F,
		var_0_4.CHECKRESULT_DATA_VERSION_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.S2C_REPLYBATTLEREPORT_REPORT_F, {
	"report",
	".bs.S2C_ReplyBattleReport.report",
	1,
	0,
	2,
	false,
	"",
	nil,
	nil,
	12,
	9
})
descriptor_helper.descriptorFunc(var_0_4.S2C_REPLYBATTLEREPORT_ME, {
	"S2C_ReplyBattleReport",
	".bs.S2C_ReplyBattleReport",
	{},
	{},
	{
		var_0_4.S2C_REPLYBATTLEREPORT_REPORT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.C2S_CHECKBATTLERESULT_RESULT_F, {
	"result",
	".bs.C2S_CheckBattleResult.result",
	1,
	0,
	2,
	false,
	"",
	nil,
	nil,
	12,
	9
})
descriptor_helper.descriptorFunc(var_0_4.C2S_CHECKBATTLERESULT_ME, {
	"C2S_CheckBattleResult",
	".bs.C2S_CheckBattleResult",
	{},
	{},
	{
		var_0_4.C2S_CHECKBATTLERESULT_RESULT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.S2C_CHECKBATTLERESULT_RET_F, {
	"ret",
	".bs.S2C_CheckBattleResult.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.S2C_CHECKBATTLERESULT_RESULT_F, {
	"result",
	".bs.S2C_CheckBattleResult.result",
	2,
	1,
	1,
	false,
	"",
	nil,
	nil,
	12,
	9
})
descriptor_helper.descriptorFunc(var_0_4.S2C_CHECKBATTLERESULT_ME, {
	"S2C_CheckBattleResult",
	".bs.S2C_CheckBattleResult",
	{},
	{},
	{
		var_0_4.S2C_CHECKBATTLERESULT_RET_F,
		var_0_4.S2C_CHECKBATTLERESULT_RESULT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.C2S_CLIENTTESTBATTLE_REPORT_F, {
	"report",
	".bs.C2S_ClientTestBattle.report",
	1,
	0,
	2,
	false,
	"",
	nil,
	nil,
	12,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_4.C2S_CLIENTTESTBATTLE_RESULT_F, {
	"result",
	".bs.C2S_ClientTestBattle.result",
	2,
	1,
	2,
	false,
	"",
	nil,
	nil,
	12,
	9
})
descriptor_helper.descriptorFunc(var_0_4.C2S_CLIENTTESTBATTLE_ME, {
	"C2S_ClientTestBattle",
	".bs.C2S_ClientTestBattle",
	{},
	{},
	{
		var_0_4.C2S_CLIENTTESTBATTLE_REPORT_F,
		var_0_4.C2S_CLIENTTESTBATTLE_RESULT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.S2C_CLIENTTESTBATTLE_RET_F, {
	"ret",
	".bs.S2C_ClientTestBattle.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.S2C_CLIENTTESTBATTLE_RESULT_F, {
	"result",
	".bs.S2C_ClientTestBattle.result",
	2,
	1,
	1,
	false,
	"",
	nil,
	nil,
	12,
	9
})
descriptor_helper.descriptorFunc(var_0_4.S2C_CLIENTTESTBATTLE_ME, {
	"S2C_ClientTestBattle",
	".bs.S2C_ClientTestBattle",
	{},
	{},
	{
		var_0_4.S2C_CLIENTTESTBATTLE_RET_F,
		var_0_4.S2C_CLIENTTESTBATTLE_RESULT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.S2C_CHECKASYNCBATTLE_USER_ID_F, {
	"user_id",
	".bs.S2C_CheckAsyncBattle.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.S2C_CHECKASYNCBATTLE_BATTLE_ID_F, {
	"battle_id",
	".bs.S2C_CheckAsyncBattle.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.S2C_CHECKASYNCBATTLE_REPORT_F, {
	"report",
	".bs.S2C_CheckAsyncBattle.report",
	3,
	2,
	1,
	false,
	"",
	nil,
	nil,
	12,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_4.S2C_CHECKASYNCBATTLE_RESULT_F, {
	"result",
	".bs.S2C_CheckAsyncBattle.result",
	4,
	3,
	1,
	false,
	"",
	nil,
	nil,
	12,
	9
})
descriptor_helper.descriptorFunc(var_0_4.S2C_CHECKASYNCBATTLE_ME, {
	"S2C_CheckAsyncBattle",
	".bs.S2C_CheckAsyncBattle",
	{},
	{},
	{
		var_0_4.S2C_CHECKASYNCBATTLE_USER_ID_F,
		var_0_4.S2C_CHECKASYNCBATTLE_BATTLE_ID_F,
		var_0_4.S2C_CHECKASYNCBATTLE_REPORT_F,
		var_0_4.S2C_CHECKASYNCBATTLE_RESULT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.C2S_CHECKASYNCBATTLE_RET_F, {
	"ret",
	".bs.C2S_CheckAsyncBattle.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.C2S_CHECKASYNCBATTLE_USER_ID_F, {
	"user_id",
	".bs.C2S_CheckAsyncBattle.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.C2S_CHECKASYNCBATTLE_BATTLE_ID_F, {
	"battle_id",
	".bs.C2S_CheckAsyncBattle.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.C2S_CHECKASYNCBATTLE_RESULT_F, {
	"result",
	".bs.C2S_CheckAsyncBattle.result",
	4,
	3,
	1,
	false,
	"",
	nil,
	nil,
	12,
	9
})
descriptor_helper.descriptorFunc(var_0_4.C2S_CHECKASYNCBATTLE_ME, {
	"C2S_CheckAsyncBattle",
	".bs.C2S_CheckAsyncBattle",
	{},
	{},
	{
		var_0_4.C2S_CHECKASYNCBATTLE_RET_F,
		var_0_4.C2S_CHECKASYNCBATTLE_USER_ID_F,
		var_0_4.C2S_CHECKASYNCBATTLE_BATTLE_ID_F,
		var_0_4.C2S_CHECKASYNCBATTLE_RESULT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.S2C_EXECUTEASYNCBATTLE_USER_ID_F, {
	"user_id",
	".bs.S2C_ExecuteAsyncBattle.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.S2C_EXECUTEASYNCBATTLE_BATTLE_ID_F, {
	"battle_id",
	".bs.S2C_ExecuteAsyncBattle.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.S2C_EXECUTEASYNCBATTLE_REPORT_F, {
	"report",
	".bs.S2C_ExecuteAsyncBattle.report",
	3,
	2,
	1,
	false,
	"",
	nil,
	nil,
	12,
	9
})
descriptor_helper.descriptorFunc(var_0_4.S2C_EXECUTEASYNCBATTLE_ME, {
	"S2C_ExecuteAsyncBattle",
	".bs.S2C_ExecuteAsyncBattle",
	{},
	{},
	{
		var_0_4.S2C_EXECUTEASYNCBATTLE_USER_ID_F,
		var_0_4.S2C_EXECUTEASYNCBATTLE_BATTLE_ID_F,
		var_0_4.S2C_EXECUTEASYNCBATTLE_REPORT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.C2S_EXECUTEASYNCBATTLE_RET_F, {
	"ret",
	".bs.C2S_ExecuteAsyncBattle.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.C2S_EXECUTEASYNCBATTLE_USER_ID_F, {
	"user_id",
	".bs.C2S_ExecuteAsyncBattle.user_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.C2S_EXECUTEASYNCBATTLE_BATTLE_ID_F, {
	"battle_id",
	".bs.C2S_ExecuteAsyncBattle.battle_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.C2S_EXECUTEASYNCBATTLE_RESULT_F, {
	"result",
	".bs.C2S_ExecuteAsyncBattle.result",
	4,
	3,
	1,
	false,
	"",
	nil,
	nil,
	12,
	9
})
descriptor_helper.descriptorFunc(var_0_4.C2S_EXECUTEASYNCBATTLE_ME, {
	"C2S_ExecuteAsyncBattle",
	".bs.C2S_ExecuteAsyncBattle",
	{},
	{},
	{
		var_0_4.C2S_EXECUTEASYNCBATTLE_RET_F,
		var_0_4.C2S_EXECUTEASYNCBATTLE_USER_ID_F,
		var_0_4.C2S_EXECUTEASYNCBATTLE_BATTLE_ID_F,
		var_0_4.C2S_EXECUTEASYNCBATTLE_RESULT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.C2S_BATTLETESTBEGIN_TYPE_F, {
	"type",
	".bs.C2S_BattleTestBegin.type",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_4.C2S_BATTLETESTBEGIN_ME, {
	"C2S_BattleTestBegin",
	".bs.C2S_BattleTestBegin",
	{},
	{},
	{
		var_0_4.C2S_BATTLETESTBEGIN_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.S2C_BATTLETESTBEGIN_RET_F, {
	"ret",
	".bs.S2C_BattleTestBegin.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.S2C_BATTLETESTBEGIN_TYPE_F, {
	"type",
	".bs.S2C_BattleTestBegin.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.S2C_BATTLETESTBEGIN_BATTLE_ID_F, {
	"battle_id",
	".bs.S2C_BattleTestBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_4.S2C_BATTLETESTBEGIN_ME, {
	"S2C_BattleTestBegin",
	".bs.S2C_BattleTestBegin",
	{},
	{},
	{
		var_0_4.S2C_BATTLETESTBEGIN_RET_F,
		var_0_4.S2C_BATTLETESTBEGIN_TYPE_F,
		var_0_4.S2C_BATTLETESTBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.S2C_BATTLETESTFINISH_RET_F, {
	"ret",
	".bs.S2C_BattleTestFinish.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_4.S2C_BATTLETESTFINISH_ME, {
	"S2C_BattleTestFinish",
	".bs.S2C_BattleTestFinish",
	{},
	{},
	{
		var_0_4.S2C_BATTLETESTFINISH_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLESUCCUBA_ID_F, {
	"id",
	".bs.BattleSuccuba.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLESUCCUBA_POS_F, {
	"pos",
	".bs.BattleSuccuba.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLESUCCUBA_LEVEL_F, {
	"level",
	".bs.BattleSuccuba.level",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLESUCCUBA_STAR_F, {
	"star",
	".bs.BattleSuccuba.star",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLESUCCUBA_CHARM_F, {
	"charm",
	".bs.BattleSuccuba.charm",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLESUCCUBA_NODE_F, {
	"node",
	".bs.BattleSuccuba.node",
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
descriptor_helper.fieldDescriptorFunc(var_0_4.BATTLESUCCUBA_STAGE_F, {
	"stage",
	".bs.BattleSuccuba.stage",
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
descriptor_helper.descriptorFunc(var_0_4.BATTLESUCCUBA_ME, {
	"BattleSuccuba",
	".bs.BattleSuccuba",
	{},
	{},
	{
		var_0_4.BATTLESUCCUBA_ID_F,
		var_0_4.BATTLESUCCUBA_POS_F,
		var_0_4.BATTLESUCCUBA_LEVEL_F,
		var_0_4.BATTLESUCCUBA_STAR_F,
		var_0_4.BATTLESUCCUBA_CHARM_F,
		var_0_4.BATTLESUCCUBA_NODE_F,
		var_0_4.BATTLESUCCUBA_STAGE_F
	},
	false,
	{}
})

var_0_4.AbnormalBattle = protobuf.Message(var_0_4.ABNORMALBATTLE_ME)
var_0_4.Attr = protobuf.Message(var_0_4.ATTR_ME)
var_0_4.BattleAttr = protobuf.Message(var_0_4.BATTLEATTR_ME)
var_0_4.BattleCombo = protobuf.Message(var_0_4.BATTLECOMBO_ME)
var_0_4.BattleReport = protobuf.Message(var_0_4.BATTLEREPORT_ME)
var_0_4.BattleResult = protobuf.Message(var_0_4.BATTLERESULT_ME)
var_0_4.BattleSuccuba = protobuf.Message(var_0_4.BATTLESUCCUBA_ME)
var_0_4.BattleTeam = protobuf.Message(var_0_4.BATTLETEAM_ME)
var_0_4.BattleUnit = protobuf.Message(var_0_4.BATTLEUNIT_ME)
var_0_4.BattleUnitResult = protobuf.Message(var_0_4.BATTLEUNITRESULT_ME)
var_0_4.BattleVideo = protobuf.Message(var_0_4.BATTLEVIDEO_ME)
var_0_4.BattleWaveUnitResult = protobuf.Message(var_0_4.BATTLEWAVEUNITRESULT_ME)
var_0_4.BriefReport = protobuf.Message(var_0_4.BRIEFREPORT_ME)
var_0_4.C2S_BattleTestBegin = protobuf.Message(var_0_4.C2S_BATTLETESTBEGIN_ME)
var_0_4.C2S_CheckAsyncBattle = protobuf.Message(var_0_4.C2S_CHECKASYNCBATTLE_ME)
var_0_4.C2S_CheckBattleResult = protobuf.Message(var_0_4.C2S_CHECKBATTLERESULT_ME)
var_0_4.C2S_ClientTestBattle = protobuf.Message(var_0_4.C2S_CLIENTTESTBATTLE_ME)
var_0_4.C2S_ExecuteAsyncBattle = protobuf.Message(var_0_4.C2S_EXECUTEASYNCBATTLE_ME)
var_0_4.CheckResult = protobuf.Message(var_0_4.CHECKRESULT_ME)
var_0_4.PlayerCommand = protobuf.Message(var_0_4.PLAYERCOMMAND_ME)
var_0_4.S2C_BattleTestBegin = protobuf.Message(var_0_4.S2C_BATTLETESTBEGIN_ME)
var_0_4.S2C_BattleTestFinish = protobuf.Message(var_0_4.S2C_BATTLETESTFINISH_ME)
var_0_4.S2C_CheckAsyncBattle = protobuf.Message(var_0_4.S2C_CHECKASYNCBATTLE_ME)
var_0_4.S2C_CheckBattleResult = protobuf.Message(var_0_4.S2C_CHECKBATTLERESULT_ME)
var_0_4.S2C_ClientTestBattle = protobuf.Message(var_0_4.S2C_CLIENTTESTBATTLE_ME)
var_0_4.S2C_ExecuteAsyncBattle = protobuf.Message(var_0_4.S2C_EXECUTEASYNCBATTLE_ME)
var_0_4.S2C_ReplyBattleReport = protobuf.Message(var_0_4.S2C_REPLYBATTLEREPORT_ME)
var_0_4.TokenKnightShow = protobuf.Message(var_0_4.TOKENKNIGHTSHOW_ME)
var_0_4.UnitCheck = protobuf.Message(var_0_4.UNITCHECK_ME)

return var_0_4
