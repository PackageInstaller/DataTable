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
	C2S_FOG_GETINFO_ME = protobuf.Descriptor(),
	S2C_FOG_GETINFO_ME = protobuf.Descriptor(),
	S2C_FOG_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_ACTIVITY_SUB_ID_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_OPEN_DAY_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_START_TIME_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_END_TIME_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_EXPIRE_TIME_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_MIN_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_MAX_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_MAX_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_PHASE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_FOG_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_STAGE_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_PASS_WAVES_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_USE_KNIGHT_IDS_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_FOG_WAVES_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_RAND_CHOICE_IDS_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_CHOICE_ID_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_RAND_SEALS_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_PASS_STAGE_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_BUFFS_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_ORIGIN_STAGE_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_REPLACE_STAGE_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_USE_ARTIFACT_IDS_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_HISTORY_MAX_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_SEAL_RESET_TIMES_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_WEEKLY_BUFF_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_EXTRA_SEAL_TIMES_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_EXTRA_SEALS_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_EXTRA_STATE_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_FOREVER_MAX_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETINFO_ONEKEY_SEALS_F = protobuf.FieldDescriptor(),
	C2S_FOG_KNIGHTUP_ME = protobuf.Descriptor(),
	C2S_FOG_KNIGHTUP_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_FOG_KNIGHTUP_ME = protobuf.Descriptor(),
	S2C_FOG_KNIGHTUP_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_KNIGHTUP_FOG_KNIGHTS_F = protobuf.FieldDescriptor(),
	C2S_FOG_NEXTFLOOR_ME = protobuf.Descriptor(),
	S2C_FOG_NEXTFLOOR_ME = protobuf.Descriptor(),
	S2C_FOG_NEXTFLOOR_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_NEXTFLOOR_ORIGIN_STAGE_F = protobuf.FieldDescriptor(),
	S2C_FOG_NEXTFLOOR_REPLACE_STAGE_F = protobuf.FieldDescriptor(),
	C2S_FOG_CHOOSESTAGE_ME = protobuf.Descriptor(),
	C2S_FOG_CHOOSESTAGE_FLOOR_F = protobuf.FieldDescriptor(),
	C2S_FOG_CHOOSESTAGE_STAGE_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHOOSESTAGE_ME = protobuf.Descriptor(),
	S2C_FOG_CHOOSESTAGE_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHOOSESTAGE_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHOOSESTAGE_STAGE_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHOOSESTAGE_RAND_CHOICE_IDS_F = protobuf.FieldDescriptor(),
	C2S_FOG_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	C2S_FOG_CHALLENGEBEGIN_FLOOR_F = protobuf.FieldDescriptor(),
	C2S_FOG_CHALLENGEBEGIN_STAGE_F = protobuf.FieldDescriptor(),
	C2S_FOG_CHALLENGEBEGIN_WAVE_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHALLENGEBEGIN_ME = protobuf.Descriptor(),
	S2C_FOG_CHALLENGEBEGIN_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHALLENGEBEGIN_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHALLENGEBEGIN_STAGE_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHALLENGEBEGIN_WAVE_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHALLENGEBEGIN_BATTLE_ID_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHALLENGEFINISH_ME = protobuf.Descriptor(),
	S2C_FOG_CHALLENGEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHALLENGEFINISH_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHALLENGEFINISH_STAGE_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHALLENGEFINISH_WAVE_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHALLENGEFINISH_IS_WIN_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHALLENGEFINISH_KN_HPS_BEFORE_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHALLENGEFINISH_KN_HPS_AFTER_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHALLENGEFINISH_MONSTER_HPS_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHALLENGEFINISH_USE_KNIGHT_IDS_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHALLENGEFINISH_USE_ARTIFACT_IDS_F = protobuf.FieldDescriptor(),
	C2S_FOG_RECOVER_ME = protobuf.Descriptor(),
	C2S_FOG_RECOVER_FLOOR_F = protobuf.FieldDescriptor(),
	C2S_FOG_RECOVER_STAGE_F = protobuf.FieldDescriptor(),
	C2S_FOG_RECOVER_WAVE_F = protobuf.FieldDescriptor(),
	S2C_FOG_RECOVER_ME = protobuf.Descriptor(),
	S2C_FOG_RECOVER_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_RECOVER_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_RECOVER_STAGE_F = protobuf.FieldDescriptor(),
	S2C_FOG_RECOVER_WAVE_F = protobuf.FieldDescriptor(),
	S2C_FOG_RECOVER_FOG_KNIGHTS_F = protobuf.FieldDescriptor(),
	C2S_FOG_MAKECHOICE_ME = protobuf.Descriptor(),
	C2S_FOG_MAKECHOICE_CHOICE_ID_F = protobuf.FieldDescriptor(),
	C2S_FOG_MAKECHOICE_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_FOG_MAKECHOICE_ME = protobuf.Descriptor(),
	S2C_FOG_MAKECHOICE_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_MAKECHOICE_CHOICE_ID_F = protobuf.FieldDescriptor(),
	S2C_FOG_MAKECHOICE_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_FOG_MAKECHOICE_RAND_SEALS_F = protobuf.FieldDescriptor(),
	S2C_FOG_MAKECHOICE_FOG_KNIGHTS_F = protobuf.FieldDescriptor(),
	C2S_FOG_DEMONCONVERT_ME = protobuf.Descriptor(),
	C2S_FOG_DEMONCONVERT_TP_F = protobuf.FieldDescriptor(),
	S2C_FOG_DEMONCONVERT_ME = protobuf.Descriptor(),
	S2C_FOG_DEMONCONVERT_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_DEMONCONVERT_RAND_SEALS_F = protobuf.FieldDescriptor(),
	C2S_FOG_BACK_ME = protobuf.Descriptor(),
	C2S_FOG_BACK_TYPE_F = protobuf.FieldDescriptor(),
	C2S_FOG_BACK_FLOOR_F = protobuf.FieldDescriptor(),
	C2S_FOG_BACK_STAGE_F = protobuf.FieldDescriptor(),
	C2S_FOG_BACK_WAVE_F = protobuf.FieldDescriptor(),
	S2C_FOG_BACK_ME = protobuf.Descriptor(),
	S2C_FOG_BACK_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_BACK_TYPE_F = protobuf.FieldDescriptor(),
	S2C_FOG_BACK_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_BACK_STAGE_F = protobuf.FieldDescriptor(),
	S2C_FOG_BACK_WAVE_F = protobuf.FieldDescriptor(),
	S2C_FOG_BACK_FOG_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_FOG_BACK_FOG_WAVE_F = protobuf.FieldDescriptor(),
	S2C_FOG_BACK_USE_KNIGHT_IDS_F = protobuf.FieldDescriptor(),
	S2C_FOG_BACK_USE_ARTIFACT_IDS_F = protobuf.FieldDescriptor(),
	C2S_FOG_RANDSEALS_ME = protobuf.Descriptor(),
	C2S_FOG_RANDSEALS_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_RANDSEALS_ME = protobuf.Descriptor(),
	S2C_FOG_RANDSEALS_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_RANDSEALS_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_RANDSEALS_RAND_SEALS_F = protobuf.FieldDescriptor(),
	C2S_FOG_CHOOSESEAL_ME = protobuf.Descriptor(),
	C2S_FOG_CHOOSESEAL_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	C2S_FOG_CHOOSESEAL_SEAL_LEVEL_ID_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHOOSESEAL_ME = protobuf.Descriptor(),
	S2C_FOG_CHOOSESEAL_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHOOSESEAL_FOG_KNIGHT_F = protobuf.FieldDescriptor(),
	C2S_FOG_RESETSEALS_ME = protobuf.Descriptor(),
	C2S_FOG_RESETSEALS_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_RESETSEALS_ME = protobuf.Descriptor(),
	S2C_FOG_RESETSEALS_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_RESETSEALS_RAND_SEALS_F = protobuf.FieldDescriptor(),
	S2C_FOG_RESETSEALS_FLOOR_F = protobuf.FieldDescriptor(),
	C2S_FOG_FAST_ME = protobuf.Descriptor(),
	C2S_FOG_FAST_FLOOR_F = protobuf.FieldDescriptor(),
	C2S_FOG_FAST_FAST_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_FOG_FAST_ME = protobuf.Descriptor(),
	S2C_FOG_FAST_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_FAST_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_FAST_FOG_KNIGHTS_F = protobuf.FieldDescriptor(),
	C2S_FOG_PHASEAWARD_ME = protobuf.Descriptor(),
	C2S_FOG_PHASEAWARD_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_PHASEAWARD_ME = protobuf.Descriptor(),
	S2C_FOG_PHASEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_PHASEAWARD_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_PHASEAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_FOG_GIVEUP_ME = protobuf.Descriptor(),
	S2C_FOG_GIVEUP_ME = protobuf.Descriptor(),
	S2C_FOG_GIVEUP_RET_F = protobuf.FieldDescriptor(),
	C2S_FOG_GIVEUPSEAL_ME = protobuf.Descriptor(),
	S2C_FOG_GIVEUPSEAL_ME = protobuf.Descriptor(),
	S2C_FOG_GIVEUPSEAL_RET_F = protobuf.FieldDescriptor(),
	C2S_FOG_GIVEUPBACK_ME = protobuf.Descriptor(),
	C2S_FOG_GIVEUPBACK_WAVE_F = protobuf.FieldDescriptor(),
	S2C_FOG_GIVEUPBACK_ME = protobuf.Descriptor(),
	S2C_FOG_GIVEUPBACK_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_GIVEUPBACK_WAVE_F = protobuf.FieldDescriptor(),
	S2C_FOG_NOTICEFIRST_ME = protobuf.Descriptor(),
	S2C_FOG_NOTICEFIRST_FIRST_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_FOG_NOTICEFIRST_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_FOG_ADDKNIGHT_ME = protobuf.Descriptor(),
	C2S_FOG_ADDKNIGHT_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_FOG_ADDKNIGHT_ME = protobuf.Descriptor(),
	S2C_FOG_ADDKNIGHT_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_ADDKNIGHT_FOG_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_FOG_UPDATEBUFF_ME = protobuf.Descriptor(),
	S2C_FOG_UPDATEBUFF_BUFFS_F = protobuf.FieldDescriptor(),
	S2C_FOG_UPDATEKNIGHT_ME = protobuf.Descriptor(),
	S2C_FOG_UPDATEKNIGHT_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_FOG_NOTICEACTIVITY_ME = protobuf.Descriptor(),
	S2C_FOG_NOTICEACTIVITY_ACTIVITY_F = protobuf.FieldDescriptor(),
	C2S_FOG_RANDEXTRASEALS_ME = protobuf.Descriptor(),
	S2C_FOG_RANDEXTRASEALS_ME = protobuf.Descriptor(),
	S2C_FOG_RANDEXTRASEALS_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_RANDEXTRASEALS_EXTRA_SEALS_F = protobuf.FieldDescriptor(),
	C2S_FOG_CHOOSEEXTRASEAL_ME = protobuf.Descriptor(),
	C2S_FOG_CHOOSEEXTRASEAL_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	C2S_FOG_CHOOSEEXTRASEAL_SEAL_LEVEL_ID_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHOOSEEXTRASEAL_ME = protobuf.Descriptor(),
	S2C_FOG_CHOOSEEXTRASEAL_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_CHOOSEEXTRASEAL_FOG_KNIGHT_F = protobuf.FieldDescriptor(),
	C2S_FOG_GIVEUPEXTRASEAL_ME = protobuf.Descriptor(),
	S2C_FOG_GIVEUPEXTRASEAL_ME = protobuf.Descriptor(),
	S2C_FOG_GIVEUPEXTRASEAL_RET_F = protobuf.FieldDescriptor(),
	C2S_FOG_RESETEXTRASEALS_ME = protobuf.Descriptor(),
	S2C_FOG_RESETEXTRASEALS_ME = protobuf.Descriptor(),
	S2C_FOG_RESETEXTRASEALS_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_RESETEXTRASEALS_EXTRA_SEALS_F = protobuf.FieldDescriptor(),
	C2S_FOG_GETSERVERINFOS_ME = protobuf.Descriptor(),
	S2C_FOG_GETSERVERINFOS_ME = protobuf.Descriptor(),
	S2C_FOG_GETSERVERINFOS_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETSERVERINFOS_SERVER_INFOS_F = protobuf.FieldDescriptor(),
	S2C_FOG_GETSERVERINFOS_SID_F = protobuf.FieldDescriptor(),
	C2S_FOG_GUILDFLOOR_ME = protobuf.Descriptor(),
	S2C_FOG_GUILDFLOOR_ME = protobuf.Descriptor(),
	S2C_FOG_GUILDFLOOR_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_GUILDFLOOR_LIST_F = protobuf.FieldDescriptor(),
	C2S_FOG_GUILDFLOORUSER_ME = protobuf.Descriptor(),
	C2S_FOG_GUILDFLOORUSER_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_GUILDFLOORUSER_ME = protobuf.Descriptor(),
	S2C_FOG_GUILDFLOORUSER_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_GUILDFLOORUSER_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_GUILDFLOORUSER_LIST_F = protobuf.FieldDescriptor(),
	S2C_FOG_UPGRADELEVEL_ME = protobuf.Descriptor(),
	S2C_FOG_UPGRADELEVEL_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_UPGRADELEVEL_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_FOG_IDLEINFO_ME = protobuf.Descriptor(),
	S2C_FOG_IDLEINFO_ME = protobuf.Descriptor(),
	S2C_FOG_IDLEINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_IDLEINFO_IDLE_INFO_F = protobuf.FieldDescriptor(),
	C2S_FOG_IDLEAWARD_ME = protobuf.Descriptor(),
	S2C_FOG_IDLEAWARD_ME = protobuf.Descriptor(),
	S2C_FOG_IDLEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_IDLEAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_FOG_IDLEAWARD_IDLE_INFO_F = protobuf.FieldDescriptor(),
	S2C_FOG_IDLEAWARD_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_FOG_TALENT_GETINFO_ME = protobuf.Descriptor(),
	S2C_FOG_TALENT_GETINFO_ME = protobuf.Descriptor(),
	S2C_FOG_TALENT_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_GETINFO_NODES_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_GETINFO_ADDITION_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_GETINFO_CONSUME_F = protobuf.FieldDescriptor(),
	C2S_FOG_TALENT_UPGRADENODE_ME = protobuf.Descriptor(),
	C2S_FOG_TALENT_UPGRADENODE_NODE_ID_F = protobuf.FieldDescriptor(),
	C2S_FOG_TALENT_UPGRADENODE_NEXT_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_FOG_TALENT_UPGRADENODE_TAB_F = protobuf.FieldDescriptor(),
	C2S_FOG_TALENT_UPGRADENODE_LAYER_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_UPGRADENODE_ME = protobuf.Descriptor(),
	S2C_FOG_TALENT_UPGRADENODE_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_UPGRADENODE_NODE_ID_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_UPGRADENODE_NEXT_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_UPGRADENODE_TAB_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_UPGRADENODE_LAYER_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_UPGRADENODE_NODE_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_UPGRADENODE_ADDITION_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_UPGRADENODE_CONSUME_F = protobuf.FieldDescriptor(),
	C2S_FOG_TALENT_RESET_ME = protobuf.Descriptor(),
	C2S_FOG_TALENT_RESET_TAB_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_RESET_ME = protobuf.Descriptor(),
	S2C_FOG_TALENT_RESET_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_RESET_TAB_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_RESET_ADDITION_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_RESET_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_RESET_CONSUME_F = protobuf.FieldDescriptor(),
	C2S_FOG_TALENT_ATTRIBUTE_ME = protobuf.Descriptor(),
	S2C_FOG_TALENT_ATTRIBUTE_ME = protobuf.Descriptor(),
	S2C_FOG_TALENT_ATTRIBUTE_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_TALENT_ATTRIBUTE_ATTR_F = protobuf.FieldDescriptor(),
	C2S_FOG_ONEKEYSWEEP_ME = protobuf.Descriptor(),
	S2C_FOG_ONEKEYSWEEP_ME = protobuf.Descriptor(),
	S2C_FOG_ONEKEYSWEEP_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_ONEKEYSWEEP_CUR_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_ONEKEYSWEEP_SEALS_F = protobuf.FieldDescriptor(),
	C2S_FOG_ONEKEYCHOOSESEAL_ME = protobuf.Descriptor(),
	C2S_FOG_ONEKEYCHOOSESEAL_FLOOR_F = protobuf.FieldDescriptor(),
	C2S_FOG_ONEKEYCHOOSESEAL_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	C2S_FOG_ONEKEYCHOOSESEAL_SEAL_LEVEL_ID_F = protobuf.FieldDescriptor(),
	S2C_FOG_ONEKEYCHOOSESEAL_ME = protobuf.Descriptor(),
	S2C_FOG_ONEKEYCHOOSESEAL_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_ONEKEYCHOOSESEAL_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_ONEKEYCHOOSESEAL_FOG_KNIGHTS_F = protobuf.FieldDescriptor(),
	C2S_FOG_STAGESKIP_ME = protobuf.Descriptor(),
	C2S_FOG_STAGESKIP_FLOOR_F = protobuf.FieldDescriptor(),
	C2S_FOG_STAGESKIP_STAGE_F = protobuf.FieldDescriptor(),
	S2C_FOG_STAGESKIP_ME = protobuf.Descriptor(),
	S2C_FOG_STAGESKIP_RET_F = protobuf.FieldDescriptor(),
	S2C_FOG_STAGESKIP_FLOOR_F = protobuf.FieldDescriptor(),
	S2C_FOG_STAGESKIP_STAGE_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_GETINFO_ME, {
	"C2S_Fog_GetInfo",
	".cs.C2S_Fog_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Fog_GetInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_Fog_GetInfo.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_ACTIVITY_SUB_ID_F, {
	"activity_sub_id",
	".cs.S2C_Fog_GetInfo.activity_sub_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_OPEN_DAY_F, {
	"open_day",
	".cs.S2C_Fog_GetInfo.open_day",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_START_TIME_F, {
	"start_time",
	".cs.S2C_Fog_GetInfo.start_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_END_TIME_F, {
	"end_time",
	".cs.S2C_Fog_GetInfo.end_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_EXPIRE_TIME_F, {
	"expire_time",
	".cs.S2C_Fog_GetInfo.expire_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_MIN_LEVEL_F, {
	"min_level",
	".cs.S2C_Fog_GetInfo.min_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_MAX_LEVEL_F, {
	"max_level",
	".cs.S2C_Fog_GetInfo.max_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_MAX_FLOOR_F, {
	"max_floor",
	".cs.S2C_Fog_GetInfo.max_floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_PHASE_AWARDS_F, {
	"phase_awards",
	".cs.S2C_Fog_GetInfo.phase_awards",
	11,
	10,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_LEVEL_F, {
	"level",
	".cs.S2C_Fog_GetInfo.level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_FOG_KNIGHTS_F, {
	"fog_knights",
	".cs.S2C_Fog_GetInfo.fog_knights",
	13,
	12,
	3,
	false,
	{},
	var_0_3.FOGKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_FLOOR_F, {
	"floor",
	".cs.S2C_Fog_GetInfo.floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_STAGE_F, {
	"stage",
	".cs.S2C_Fog_GetInfo.stage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_PASS_WAVES_F, {
	"pass_waves",
	".cs.S2C_Fog_GetInfo.pass_waves",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_USE_KNIGHT_IDS_F, {
	"use_knight_ids",
	".cs.S2C_Fog_GetInfo.use_knight_ids",
	17,
	16,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_FOG_WAVES_F, {
	"fog_waves",
	".cs.S2C_Fog_GetInfo.fog_waves",
	18,
	17,
	3,
	false,
	{},
	var_0_3.FOGWAVE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_RAND_CHOICE_IDS_F, {
	"rand_choice_ids",
	".cs.S2C_Fog_GetInfo.rand_choice_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_CHOICE_ID_F, {
	"choice_id",
	".cs.S2C_Fog_GetInfo.choice_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_RAND_SEALS_F, {
	"rand_seals",
	".cs.S2C_Fog_GetInfo.rand_seals",
	21,
	20,
	3,
	false,
	{},
	var_0_3.FOGSEAL_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_PASS_STAGE_F, {
	"pass_stage",
	".cs.S2C_Fog_GetInfo.pass_stage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_BUFFS_F, {
	"buffs",
	".cs.S2C_Fog_GetInfo.buffs",
	23,
	22,
	3,
	false,
	{},
	var_0_3.FOGBUFF_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_ORIGIN_STAGE_F, {
	"origin_stage",
	".cs.S2C_Fog_GetInfo.origin_stage",
	24,
	23,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_REPLACE_STAGE_F, {
	"replace_stage",
	".cs.S2C_Fog_GetInfo.replace_stage",
	25,
	24,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_USE_ARTIFACT_IDS_F, {
	"use_artifact_ids",
	".cs.S2C_Fog_GetInfo.use_artifact_ids",
	26,
	25,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_HISTORY_MAX_FLOOR_F, {
	"history_max_floor",
	".cs.S2C_Fog_GetInfo.history_max_floor",
	27,
	26,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_SEAL_RESET_TIMES_F, {
	"seal_reset_times",
	".cs.S2C_Fog_GetInfo.seal_reset_times",
	28,
	27,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_WEEKLY_BUFF_F, {
	"weekly_buff",
	".cs.S2C_Fog_GetInfo.weekly_buff",
	29,
	28,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_EXTRA_SEAL_TIMES_F, {
	"extra_seal_times",
	".cs.S2C_Fog_GetInfo.extra_seal_times",
	30,
	29,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_EXTRA_SEALS_F, {
	"extra_seals",
	".cs.S2C_Fog_GetInfo.extra_seals",
	31,
	30,
	3,
	false,
	{},
	var_0_3.FOGSEAL_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_EXTRA_STATE_F, {
	"extra_state",
	".cs.S2C_Fog_GetInfo.extra_state",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_FOREVER_MAX_FLOOR_F, {
	"forever_max_floor",
	".cs.S2C_Fog_GetInfo.forever_max_floor",
	33,
	32,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETINFO_ONEKEY_SEALS_F, {
	"onekey_seals",
	".cs.S2C_Fog_GetInfo.onekey_seals",
	34,
	33,
	3,
	false,
	{},
	var_0_3.FOGFLOORSEAL_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_GETINFO_ME, {
	"S2C_Fog_GetInfo",
	".cs.S2C_Fog_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_FOG_GETINFO_RET_F,
		var_0_10.S2C_FOG_GETINFO_ACTIVITY_ID_F,
		var_0_10.S2C_FOG_GETINFO_ACTIVITY_SUB_ID_F,
		var_0_10.S2C_FOG_GETINFO_OPEN_DAY_F,
		var_0_10.S2C_FOG_GETINFO_START_TIME_F,
		var_0_10.S2C_FOG_GETINFO_END_TIME_F,
		var_0_10.S2C_FOG_GETINFO_EXPIRE_TIME_F,
		var_0_10.S2C_FOG_GETINFO_MIN_LEVEL_F,
		var_0_10.S2C_FOG_GETINFO_MAX_LEVEL_F,
		var_0_10.S2C_FOG_GETINFO_MAX_FLOOR_F,
		var_0_10.S2C_FOG_GETINFO_PHASE_AWARDS_F,
		var_0_10.S2C_FOG_GETINFO_LEVEL_F,
		var_0_10.S2C_FOG_GETINFO_FOG_KNIGHTS_F,
		var_0_10.S2C_FOG_GETINFO_FLOOR_F,
		var_0_10.S2C_FOG_GETINFO_STAGE_F,
		var_0_10.S2C_FOG_GETINFO_PASS_WAVES_F,
		var_0_10.S2C_FOG_GETINFO_USE_KNIGHT_IDS_F,
		var_0_10.S2C_FOG_GETINFO_FOG_WAVES_F,
		var_0_10.S2C_FOG_GETINFO_RAND_CHOICE_IDS_F,
		var_0_10.S2C_FOG_GETINFO_CHOICE_ID_F,
		var_0_10.S2C_FOG_GETINFO_RAND_SEALS_F,
		var_0_10.S2C_FOG_GETINFO_PASS_STAGE_F,
		var_0_10.S2C_FOG_GETINFO_BUFFS_F,
		var_0_10.S2C_FOG_GETINFO_ORIGIN_STAGE_F,
		var_0_10.S2C_FOG_GETINFO_REPLACE_STAGE_F,
		var_0_10.S2C_FOG_GETINFO_USE_ARTIFACT_IDS_F,
		var_0_10.S2C_FOG_GETINFO_HISTORY_MAX_FLOOR_F,
		var_0_10.S2C_FOG_GETINFO_SEAL_RESET_TIMES_F,
		var_0_10.S2C_FOG_GETINFO_WEEKLY_BUFF_F,
		var_0_10.S2C_FOG_GETINFO_EXTRA_SEAL_TIMES_F,
		var_0_10.S2C_FOG_GETINFO_EXTRA_SEALS_F,
		var_0_10.S2C_FOG_GETINFO_EXTRA_STATE_F,
		var_0_10.S2C_FOG_GETINFO_FOREVER_MAX_FLOOR_F,
		var_0_10.S2C_FOG_GETINFO_ONEKEY_SEALS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_KNIGHTUP_KNIGHTS_F, {
	"knights",
	".cs.C2S_Fog_KnightUp.knights",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_KNIGHTUP_ME, {
	"C2S_Fog_KnightUp",
	".cs.C2S_Fog_KnightUp",
	{},
	{},
	{
		var_0_10.C2S_FOG_KNIGHTUP_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_KNIGHTUP_RET_F, {
	"ret",
	".cs.S2C_Fog_KnightUp.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_KNIGHTUP_FOG_KNIGHTS_F, {
	"fog_knights",
	".cs.S2C_Fog_KnightUp.fog_knights",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FOGKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_KNIGHTUP_ME, {
	"S2C_Fog_KnightUp",
	".cs.S2C_Fog_KnightUp",
	{},
	{},
	{
		var_0_10.S2C_FOG_KNIGHTUP_RET_F,
		var_0_10.S2C_FOG_KNIGHTUP_FOG_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_NEXTFLOOR_ME, {
	"C2S_Fog_NextFloor",
	".cs.C2S_Fog_NextFloor",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_NEXTFLOOR_RET_F, {
	"ret",
	".cs.S2C_Fog_NextFloor.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_NEXTFLOOR_ORIGIN_STAGE_F, {
	"origin_stage",
	".cs.S2C_Fog_NextFloor.origin_stage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_NEXTFLOOR_REPLACE_STAGE_F, {
	"replace_stage",
	".cs.S2C_Fog_NextFloor.replace_stage",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_NEXTFLOOR_ME, {
	"S2C_Fog_NextFloor",
	".cs.S2C_Fog_NextFloor",
	{},
	{},
	{
		var_0_10.S2C_FOG_NEXTFLOOR_RET_F,
		var_0_10.S2C_FOG_NEXTFLOOR_ORIGIN_STAGE_F,
		var_0_10.S2C_FOG_NEXTFLOOR_REPLACE_STAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_CHOOSESTAGE_FLOOR_F, {
	"floor",
	".cs.C2S_Fog_ChooseStage.floor",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_CHOOSESTAGE_STAGE_F, {
	"stage",
	".cs.C2S_Fog_ChooseStage.stage",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_CHOOSESTAGE_ME, {
	"C2S_Fog_ChooseStage",
	".cs.C2S_Fog_ChooseStage",
	{},
	{},
	{
		var_0_10.C2S_FOG_CHOOSESTAGE_FLOOR_F,
		var_0_10.C2S_FOG_CHOOSESTAGE_STAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHOOSESTAGE_RET_F, {
	"ret",
	".cs.S2C_Fog_ChooseStage.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHOOSESTAGE_FLOOR_F, {
	"floor",
	".cs.S2C_Fog_ChooseStage.floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHOOSESTAGE_STAGE_F, {
	"stage",
	".cs.S2C_Fog_ChooseStage.stage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHOOSESTAGE_RAND_CHOICE_IDS_F, {
	"rand_choice_ids",
	".cs.S2C_Fog_ChooseStage.rand_choice_ids",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_CHOOSESTAGE_ME, {
	"S2C_Fog_ChooseStage",
	".cs.S2C_Fog_ChooseStage",
	{},
	{},
	{
		var_0_10.S2C_FOG_CHOOSESTAGE_RET_F,
		var_0_10.S2C_FOG_CHOOSESTAGE_FLOOR_F,
		var_0_10.S2C_FOG_CHOOSESTAGE_STAGE_F,
		var_0_10.S2C_FOG_CHOOSESTAGE_RAND_CHOICE_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_CHALLENGEBEGIN_FLOOR_F, {
	"floor",
	".cs.C2S_Fog_ChallengeBegin.floor",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_CHALLENGEBEGIN_STAGE_F, {
	"stage",
	".cs.C2S_Fog_ChallengeBegin.stage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_CHALLENGEBEGIN_WAVE_F, {
	"wave",
	".cs.C2S_Fog_ChallengeBegin.wave",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_CHALLENGEBEGIN_ME, {
	"C2S_Fog_ChallengeBegin",
	".cs.C2S_Fog_ChallengeBegin",
	{},
	{},
	{
		var_0_10.C2S_FOG_CHALLENGEBEGIN_FLOOR_F,
		var_0_10.C2S_FOG_CHALLENGEBEGIN_STAGE_F,
		var_0_10.C2S_FOG_CHALLENGEBEGIN_WAVE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHALLENGEBEGIN_RET_F, {
	"ret",
	".cs.S2C_Fog_ChallengeBegin.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHALLENGEBEGIN_FLOOR_F, {
	"floor",
	".cs.S2C_Fog_ChallengeBegin.floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHALLENGEBEGIN_STAGE_F, {
	"stage",
	".cs.S2C_Fog_ChallengeBegin.stage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHALLENGEBEGIN_WAVE_F, {
	"wave",
	".cs.S2C_Fog_ChallengeBegin.wave",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHALLENGEBEGIN_BATTLE_ID_F, {
	"battle_id",
	".cs.S2C_Fog_ChallengeBegin.battle_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_CHALLENGEBEGIN_ME, {
	"S2C_Fog_ChallengeBegin",
	".cs.S2C_Fog_ChallengeBegin",
	{},
	{},
	{
		var_0_10.S2C_FOG_CHALLENGEBEGIN_RET_F,
		var_0_10.S2C_FOG_CHALLENGEBEGIN_FLOOR_F,
		var_0_10.S2C_FOG_CHALLENGEBEGIN_STAGE_F,
		var_0_10.S2C_FOG_CHALLENGEBEGIN_WAVE_F,
		var_0_10.S2C_FOG_CHALLENGEBEGIN_BATTLE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHALLENGEFINISH_RET_F, {
	"ret",
	".cs.S2C_Fog_ChallengeFinish.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHALLENGEFINISH_FLOOR_F, {
	"floor",
	".cs.S2C_Fog_ChallengeFinish.floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHALLENGEFINISH_STAGE_F, {
	"stage",
	".cs.S2C_Fog_ChallengeFinish.stage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHALLENGEFINISH_WAVE_F, {
	"wave",
	".cs.S2C_Fog_ChallengeFinish.wave",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHALLENGEFINISH_IS_WIN_F, {
	"is_win",
	".cs.S2C_Fog_ChallengeFinish.is_win",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHALLENGEFINISH_KN_HPS_BEFORE_F, {
	"kn_hps_before",
	".cs.S2C_Fog_ChallengeFinish.kn_hps_before",
	6,
	5,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHALLENGEFINISH_KN_HPS_AFTER_F, {
	"kn_hps_after",
	".cs.S2C_Fog_ChallengeFinish.kn_hps_after",
	7,
	6,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHALLENGEFINISH_MONSTER_HPS_F, {
	"monster_hps",
	".cs.S2C_Fog_ChallengeFinish.monster_hps",
	8,
	7,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHALLENGEFINISH_USE_KNIGHT_IDS_F, {
	"use_knight_ids",
	".cs.S2C_Fog_ChallengeFinish.use_knight_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHALLENGEFINISH_USE_ARTIFACT_IDS_F, {
	"use_artifact_ids",
	".cs.S2C_Fog_ChallengeFinish.use_artifact_ids",
	10,
	9,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_CHALLENGEFINISH_ME, {
	"S2C_Fog_ChallengeFinish",
	".cs.S2C_Fog_ChallengeFinish",
	{},
	{},
	{
		var_0_10.S2C_FOG_CHALLENGEFINISH_RET_F,
		var_0_10.S2C_FOG_CHALLENGEFINISH_FLOOR_F,
		var_0_10.S2C_FOG_CHALLENGEFINISH_STAGE_F,
		var_0_10.S2C_FOG_CHALLENGEFINISH_WAVE_F,
		var_0_10.S2C_FOG_CHALLENGEFINISH_IS_WIN_F,
		var_0_10.S2C_FOG_CHALLENGEFINISH_KN_HPS_BEFORE_F,
		var_0_10.S2C_FOG_CHALLENGEFINISH_KN_HPS_AFTER_F,
		var_0_10.S2C_FOG_CHALLENGEFINISH_MONSTER_HPS_F,
		var_0_10.S2C_FOG_CHALLENGEFINISH_USE_KNIGHT_IDS_F,
		var_0_10.S2C_FOG_CHALLENGEFINISH_USE_ARTIFACT_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_RECOVER_FLOOR_F, {
	"floor",
	".cs.C2S_Fog_Recover.floor",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_RECOVER_STAGE_F, {
	"stage",
	".cs.C2S_Fog_Recover.stage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_RECOVER_WAVE_F, {
	"wave",
	".cs.C2S_Fog_Recover.wave",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_RECOVER_ME, {
	"C2S_Fog_Recover",
	".cs.C2S_Fog_Recover",
	{},
	{},
	{
		var_0_10.C2S_FOG_RECOVER_FLOOR_F,
		var_0_10.C2S_FOG_RECOVER_STAGE_F,
		var_0_10.C2S_FOG_RECOVER_WAVE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_RECOVER_RET_F, {
	"ret",
	".cs.S2C_Fog_Recover.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_RECOVER_FLOOR_F, {
	"floor",
	".cs.S2C_Fog_Recover.floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_RECOVER_STAGE_F, {
	"stage",
	".cs.S2C_Fog_Recover.stage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_RECOVER_WAVE_F, {
	"wave",
	".cs.S2C_Fog_Recover.wave",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_RECOVER_FOG_KNIGHTS_F, {
	"fog_knights",
	".cs.S2C_Fog_Recover.fog_knights",
	5,
	4,
	3,
	false,
	{},
	var_0_3.FOGKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_RECOVER_ME, {
	"S2C_Fog_Recover",
	".cs.S2C_Fog_Recover",
	{},
	{},
	{
		var_0_10.S2C_FOG_RECOVER_RET_F,
		var_0_10.S2C_FOG_RECOVER_FLOOR_F,
		var_0_10.S2C_FOG_RECOVER_STAGE_F,
		var_0_10.S2C_FOG_RECOVER_WAVE_F,
		var_0_10.S2C_FOG_RECOVER_FOG_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_MAKECHOICE_CHOICE_ID_F, {
	"choice_id",
	".cs.C2S_Fog_MakeChoice.choice_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_MAKECHOICE_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_Fog_MakeChoice.knight_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_MAKECHOICE_ME, {
	"C2S_Fog_MakeChoice",
	".cs.C2S_Fog_MakeChoice",
	{},
	{},
	{
		var_0_10.C2S_FOG_MAKECHOICE_CHOICE_ID_F,
		var_0_10.C2S_FOG_MAKECHOICE_KNIGHT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_MAKECHOICE_RET_F, {
	"ret",
	".cs.S2C_Fog_MakeChoice.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_MAKECHOICE_CHOICE_ID_F, {
	"choice_id",
	".cs.S2C_Fog_MakeChoice.choice_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_MAKECHOICE_KNIGHT_ID_F, {
	"knight_id",
	".cs.S2C_Fog_MakeChoice.knight_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_MAKECHOICE_RAND_SEALS_F, {
	"rand_seals",
	".cs.S2C_Fog_MakeChoice.rand_seals",
	4,
	3,
	3,
	false,
	{},
	var_0_3.FOGSEAL_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_MAKECHOICE_FOG_KNIGHTS_F, {
	"fog_knights",
	".cs.S2C_Fog_MakeChoice.fog_knights",
	5,
	4,
	3,
	false,
	{},
	var_0_3.FOGKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_MAKECHOICE_ME, {
	"S2C_Fog_MakeChoice",
	".cs.S2C_Fog_MakeChoice",
	{},
	{},
	{
		var_0_10.S2C_FOG_MAKECHOICE_RET_F,
		var_0_10.S2C_FOG_MAKECHOICE_CHOICE_ID_F,
		var_0_10.S2C_FOG_MAKECHOICE_KNIGHT_ID_F,
		var_0_10.S2C_FOG_MAKECHOICE_RAND_SEALS_F,
		var_0_10.S2C_FOG_MAKECHOICE_FOG_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_DEMONCONVERT_TP_F, {
	"tp",
	".cs.C2S_Fog_DemonConvert.tp",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_DEMONCONVERT_ME, {
	"C2S_Fog_DemonConvert",
	".cs.C2S_Fog_DemonConvert",
	{},
	{},
	{
		var_0_10.C2S_FOG_DEMONCONVERT_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_DEMONCONVERT_RET_F, {
	"ret",
	".cs.S2C_Fog_DemonConvert.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_DEMONCONVERT_RAND_SEALS_F, {
	"rand_seals",
	".cs.S2C_Fog_DemonConvert.rand_seals",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FOGSEAL_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_DEMONCONVERT_ME, {
	"S2C_Fog_DemonConvert",
	".cs.S2C_Fog_DemonConvert",
	{},
	{},
	{
		var_0_10.S2C_FOG_DEMONCONVERT_RET_F,
		var_0_10.S2C_FOG_DEMONCONVERT_RAND_SEALS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_BACK_TYPE_F, {
	"type",
	".cs.C2S_Fog_Back.type",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_BACK_FLOOR_F, {
	"floor",
	".cs.C2S_Fog_Back.floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_BACK_STAGE_F, {
	"stage",
	".cs.C2S_Fog_Back.stage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_BACK_WAVE_F, {
	"wave",
	".cs.C2S_Fog_Back.wave",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_BACK_ME, {
	"C2S_Fog_Back",
	".cs.C2S_Fog_Back",
	{},
	{},
	{
		var_0_10.C2S_FOG_BACK_TYPE_F,
		var_0_10.C2S_FOG_BACK_FLOOR_F,
		var_0_10.C2S_FOG_BACK_STAGE_F,
		var_0_10.C2S_FOG_BACK_WAVE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_BACK_RET_F, {
	"ret",
	".cs.S2C_Fog_Back.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_BACK_TYPE_F, {
	"type",
	".cs.S2C_Fog_Back.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_BACK_FLOOR_F, {
	"floor",
	".cs.S2C_Fog_Back.floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_BACK_STAGE_F, {
	"stage",
	".cs.S2C_Fog_Back.stage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_BACK_WAVE_F, {
	"wave",
	".cs.S2C_Fog_Back.wave",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_BACK_FOG_KNIGHTS_F, {
	"fog_knights",
	".cs.S2C_Fog_Back.fog_knights",
	6,
	5,
	3,
	false,
	{},
	var_0_3.FOGKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_BACK_FOG_WAVE_F, {
	"fog_wave",
	".cs.S2C_Fog_Back.fog_wave",
	7,
	6,
	1,
	false,
	nil,
	var_0_3.FOGWAVE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_BACK_USE_KNIGHT_IDS_F, {
	"use_knight_ids",
	".cs.S2C_Fog_Back.use_knight_ids",
	8,
	7,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_BACK_USE_ARTIFACT_IDS_F, {
	"use_artifact_ids",
	".cs.S2C_Fog_Back.use_artifact_ids",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_BACK_ME, {
	"S2C_Fog_Back",
	".cs.S2C_Fog_Back",
	{},
	{},
	{
		var_0_10.S2C_FOG_BACK_RET_F,
		var_0_10.S2C_FOG_BACK_TYPE_F,
		var_0_10.S2C_FOG_BACK_FLOOR_F,
		var_0_10.S2C_FOG_BACK_STAGE_F,
		var_0_10.S2C_FOG_BACK_WAVE_F,
		var_0_10.S2C_FOG_BACK_FOG_KNIGHTS_F,
		var_0_10.S2C_FOG_BACK_FOG_WAVE_F,
		var_0_10.S2C_FOG_BACK_USE_KNIGHT_IDS_F,
		var_0_10.S2C_FOG_BACK_USE_ARTIFACT_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_RANDSEALS_FLOOR_F, {
	"floor",
	".cs.C2S_Fog_RandSeals.floor",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_RANDSEALS_ME, {
	"C2S_Fog_RandSeals",
	".cs.C2S_Fog_RandSeals",
	{},
	{},
	{
		var_0_10.C2S_FOG_RANDSEALS_FLOOR_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_RANDSEALS_RET_F, {
	"ret",
	".cs.S2C_Fog_RandSeals.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_RANDSEALS_FLOOR_F, {
	"floor",
	".cs.S2C_Fog_RandSeals.floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_RANDSEALS_RAND_SEALS_F, {
	"rand_seals",
	".cs.S2C_Fog_RandSeals.rand_seals",
	3,
	2,
	3,
	false,
	{},
	var_0_3.FOGSEAL_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_RANDSEALS_ME, {
	"S2C_Fog_RandSeals",
	".cs.S2C_Fog_RandSeals",
	{},
	{},
	{
		var_0_10.S2C_FOG_RANDSEALS_RET_F,
		var_0_10.S2C_FOG_RANDSEALS_FLOOR_F,
		var_0_10.S2C_FOG_RANDSEALS_RAND_SEALS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_CHOOSESEAL_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_Fog_ChooseSeal.knight_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_CHOOSESEAL_SEAL_LEVEL_ID_F, {
	"seal_level_id",
	".cs.C2S_Fog_ChooseSeal.seal_level_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_CHOOSESEAL_ME, {
	"C2S_Fog_ChooseSeal",
	".cs.C2S_Fog_ChooseSeal",
	{},
	{},
	{
		var_0_10.C2S_FOG_CHOOSESEAL_KNIGHT_ID_F,
		var_0_10.C2S_FOG_CHOOSESEAL_SEAL_LEVEL_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHOOSESEAL_RET_F, {
	"ret",
	".cs.S2C_Fog_ChooseSeal.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHOOSESEAL_FOG_KNIGHT_F, {
	"fog_knight",
	".cs.S2C_Fog_ChooseSeal.fog_knight",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.FOGKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_CHOOSESEAL_ME, {
	"S2C_Fog_ChooseSeal",
	".cs.S2C_Fog_ChooseSeal",
	{},
	{},
	{
		var_0_10.S2C_FOG_CHOOSESEAL_RET_F,
		var_0_10.S2C_FOG_CHOOSESEAL_FOG_KNIGHT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_RESETSEALS_FLOOR_F, {
	"floor",
	".cs.C2S_Fog_ResetSeals.floor",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_RESETSEALS_ME, {
	"C2S_Fog_ResetSeals",
	".cs.C2S_Fog_ResetSeals",
	{},
	{},
	{
		var_0_10.C2S_FOG_RESETSEALS_FLOOR_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_RESETSEALS_RET_F, {
	"ret",
	".cs.S2C_Fog_ResetSeals.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_RESETSEALS_RAND_SEALS_F, {
	"rand_seals",
	".cs.S2C_Fog_ResetSeals.rand_seals",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FOGSEAL_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_RESETSEALS_FLOOR_F, {
	"floor",
	".cs.S2C_Fog_ResetSeals.floor",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_RESETSEALS_ME, {
	"S2C_Fog_ResetSeals",
	".cs.S2C_Fog_ResetSeals",
	{},
	{},
	{
		var_0_10.S2C_FOG_RESETSEALS_RET_F,
		var_0_10.S2C_FOG_RESETSEALS_RAND_SEALS_F,
		var_0_10.S2C_FOG_RESETSEALS_FLOOR_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_FAST_FLOOR_F, {
	"floor",
	".cs.C2S_Fog_Fast.floor",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_FAST_FAST_KNIGHTS_F, {
	"fast_knights",
	".cs.C2S_Fog_Fast.fast_knights",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FASTFOGKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_FAST_ME, {
	"C2S_Fog_Fast",
	".cs.C2S_Fog_Fast",
	{},
	{},
	{
		var_0_10.C2S_FOG_FAST_FLOOR_F,
		var_0_10.C2S_FOG_FAST_FAST_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_FAST_RET_F, {
	"ret",
	".cs.S2C_Fog_Fast.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_FAST_FLOOR_F, {
	"floor",
	".cs.S2C_Fog_Fast.floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_FAST_FOG_KNIGHTS_F, {
	"fog_knights",
	".cs.S2C_Fog_Fast.fog_knights",
	3,
	2,
	3,
	false,
	{},
	var_0_3.FOGKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_FAST_ME, {
	"S2C_Fog_Fast",
	".cs.S2C_Fog_Fast",
	{},
	{},
	{
		var_0_10.S2C_FOG_FAST_RET_F,
		var_0_10.S2C_FOG_FAST_FLOOR_F,
		var_0_10.S2C_FOG_FAST_FOG_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_PHASEAWARD_FLOOR_F, {
	"floor",
	".cs.C2S_Fog_PhaseAward.floor",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_PHASEAWARD_ME, {
	"C2S_Fog_PhaseAward",
	".cs.C2S_Fog_PhaseAward",
	{},
	{},
	{
		var_0_10.C2S_FOG_PHASEAWARD_FLOOR_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_PHASEAWARD_RET_F, {
	"ret",
	".cs.S2C_Fog_PhaseAward.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_PHASEAWARD_FLOOR_F, {
	"floor",
	".cs.S2C_Fog_PhaseAward.floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_PHASEAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Fog_PhaseAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_PHASEAWARD_ME, {
	"S2C_Fog_PhaseAward",
	".cs.S2C_Fog_PhaseAward",
	{},
	{},
	{
		var_0_10.S2C_FOG_PHASEAWARD_RET_F,
		var_0_10.S2C_FOG_PHASEAWARD_FLOOR_F,
		var_0_10.S2C_FOG_PHASEAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_GIVEUP_ME, {
	"C2S_Fog_GiveUp",
	".cs.C2S_Fog_GiveUp",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GIVEUP_RET_F, {
	"ret",
	".cs.S2C_Fog_GiveUp.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_GIVEUP_ME, {
	"S2C_Fog_GiveUp",
	".cs.S2C_Fog_GiveUp",
	{},
	{},
	{
		var_0_10.S2C_FOG_GIVEUP_RET_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_GIVEUPSEAL_ME, {
	"C2S_Fog_GiveUpSeal",
	".cs.C2S_Fog_GiveUpSeal",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GIVEUPSEAL_RET_F, {
	"ret",
	".cs.S2C_Fog_GiveUpSeal.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_GIVEUPSEAL_ME, {
	"S2C_Fog_GiveUpSeal",
	".cs.S2C_Fog_GiveUpSeal",
	{},
	{},
	{
		var_0_10.S2C_FOG_GIVEUPSEAL_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_GIVEUPBACK_WAVE_F, {
	"wave",
	".cs.C2S_Fog_GiveUpBack.wave",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_GIVEUPBACK_ME, {
	"C2S_Fog_GiveUpBack",
	".cs.C2S_Fog_GiveUpBack",
	{},
	{},
	{
		var_0_10.C2S_FOG_GIVEUPBACK_WAVE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GIVEUPBACK_RET_F, {
	"ret",
	".cs.S2C_Fog_GiveUpBack.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GIVEUPBACK_WAVE_F, {
	"wave",
	".cs.S2C_Fog_GiveUpBack.wave",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_GIVEUPBACK_ME, {
	"S2C_Fog_GiveUpBack",
	".cs.S2C_Fog_GiveUpBack",
	{},
	{},
	{
		var_0_10.S2C_FOG_GIVEUPBACK_RET_F,
		var_0_10.S2C_FOG_GIVEUPBACK_WAVE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_NOTICEFIRST_FIRST_AWARDS_F, {
	"first_awards",
	".cs.S2C_Fog_NoticeFirst.first_awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_NOTICEFIRST_LEVEL_F, {
	"level",
	".cs.S2C_Fog_NoticeFirst.level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_NOTICEFIRST_ME, {
	"S2C_Fog_NoticeFirst",
	".cs.S2C_Fog_NoticeFirst",
	{},
	{},
	{
		var_0_10.S2C_FOG_NOTICEFIRST_FIRST_AWARDS_F,
		var_0_10.S2C_FOG_NOTICEFIRST_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_ADDKNIGHT_KNIGHTS_F, {
	"knights",
	".cs.C2S_Fog_AddKnight.knights",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_ADDKNIGHT_ME, {
	"C2S_Fog_AddKnight",
	".cs.C2S_Fog_AddKnight",
	{},
	{},
	{
		var_0_10.C2S_FOG_ADDKNIGHT_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_ADDKNIGHT_RET_F, {
	"ret",
	".cs.S2C_Fog_AddKnight.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_ADDKNIGHT_FOG_KNIGHTS_F, {
	"fog_knights",
	".cs.S2C_Fog_AddKnight.fog_knights",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FOGKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_ADDKNIGHT_ME, {
	"S2C_Fog_AddKnight",
	".cs.S2C_Fog_AddKnight",
	{},
	{},
	{
		var_0_10.S2C_FOG_ADDKNIGHT_RET_F,
		var_0_10.S2C_FOG_ADDKNIGHT_FOG_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_UPDATEBUFF_BUFFS_F, {
	"buffs",
	".cs.S2C_Fog_UpdateBuff.buffs",
	1,
	0,
	3,
	false,
	{},
	var_0_3.FOGBUFF_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_UPDATEBUFF_ME, {
	"S2C_Fog_UpdateBuff",
	".cs.S2C_Fog_UpdateBuff",
	{},
	{},
	{
		var_0_10.S2C_FOG_UPDATEBUFF_BUFFS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_UPDATEKNIGHT_KNIGHTS_F, {
	"knights",
	".cs.S2C_Fog_UpdateKnight.knights",
	1,
	0,
	3,
	false,
	{},
	var_0_3.FOGKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_UPDATEKNIGHT_ME, {
	"S2C_Fog_UpdateKnight",
	".cs.S2C_Fog_UpdateKnight",
	{},
	{},
	{
		var_0_10.S2C_FOG_UPDATEKNIGHT_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_NOTICEACTIVITY_ACTIVITY_F, {
	"activity",
	".cs.S2C_Fog_NoticeActivity.activity",
	1,
	0,
	2,
	false,
	nil,
	var_0_3.FOGACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_NOTICEACTIVITY_ME, {
	"S2C_Fog_NoticeActivity",
	".cs.S2C_Fog_NoticeActivity",
	{},
	{},
	{
		var_0_10.S2C_FOG_NOTICEACTIVITY_ACTIVITY_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_RANDEXTRASEALS_ME, {
	"C2S_Fog_RandExtraSeals",
	".cs.C2S_Fog_RandExtraSeals",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_RANDEXTRASEALS_RET_F, {
	"ret",
	".cs.S2C_Fog_RandExtraSeals.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_RANDEXTRASEALS_EXTRA_SEALS_F, {
	"extra_seals",
	".cs.S2C_Fog_RandExtraSeals.extra_seals",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FOGSEAL_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_RANDEXTRASEALS_ME, {
	"S2C_Fog_RandExtraSeals",
	".cs.S2C_Fog_RandExtraSeals",
	{},
	{},
	{
		var_0_10.S2C_FOG_RANDEXTRASEALS_RET_F,
		var_0_10.S2C_FOG_RANDEXTRASEALS_EXTRA_SEALS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_CHOOSEEXTRASEAL_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_Fog_ChooseExtraSeal.knight_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_CHOOSEEXTRASEAL_SEAL_LEVEL_ID_F, {
	"seal_level_id",
	".cs.C2S_Fog_ChooseExtraSeal.seal_level_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_CHOOSEEXTRASEAL_ME, {
	"C2S_Fog_ChooseExtraSeal",
	".cs.C2S_Fog_ChooseExtraSeal",
	{},
	{},
	{
		var_0_10.C2S_FOG_CHOOSEEXTRASEAL_KNIGHT_ID_F,
		var_0_10.C2S_FOG_CHOOSEEXTRASEAL_SEAL_LEVEL_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHOOSEEXTRASEAL_RET_F, {
	"ret",
	".cs.S2C_Fog_ChooseExtraSeal.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_CHOOSEEXTRASEAL_FOG_KNIGHT_F, {
	"fog_knight",
	".cs.S2C_Fog_ChooseExtraSeal.fog_knight",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.FOGKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_CHOOSEEXTRASEAL_ME, {
	"S2C_Fog_ChooseExtraSeal",
	".cs.S2C_Fog_ChooseExtraSeal",
	{},
	{},
	{
		var_0_10.S2C_FOG_CHOOSEEXTRASEAL_RET_F,
		var_0_10.S2C_FOG_CHOOSEEXTRASEAL_FOG_KNIGHT_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_GIVEUPEXTRASEAL_ME, {
	"C2S_Fog_GiveUpExtraSeal",
	".cs.C2S_Fog_GiveUpExtraSeal",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GIVEUPEXTRASEAL_RET_F, {
	"ret",
	".cs.S2C_Fog_GiveUpExtraSeal.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_GIVEUPEXTRASEAL_ME, {
	"S2C_Fog_GiveUpExtraSeal",
	".cs.S2C_Fog_GiveUpExtraSeal",
	{},
	{},
	{
		var_0_10.S2C_FOG_GIVEUPEXTRASEAL_RET_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_RESETEXTRASEALS_ME, {
	"C2S_Fog_ResetExtraSeals",
	".cs.C2S_Fog_ResetExtraSeals",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_RESETEXTRASEALS_RET_F, {
	"ret",
	".cs.S2C_Fog_ResetExtraSeals.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_RESETEXTRASEALS_EXTRA_SEALS_F, {
	"extra_seals",
	".cs.S2C_Fog_ResetExtraSeals.extra_seals",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FOGSEAL_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_RESETEXTRASEALS_ME, {
	"S2C_Fog_ResetExtraSeals",
	".cs.S2C_Fog_ResetExtraSeals",
	{},
	{},
	{
		var_0_10.S2C_FOG_RESETEXTRASEALS_RET_F,
		var_0_10.S2C_FOG_RESETEXTRASEALS_EXTRA_SEALS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_GETSERVERINFOS_ME, {
	"C2S_Fog_GetServerInfos",
	".cs.C2S_Fog_GetServerInfos",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETSERVERINFOS_RET_F, {
	"ret",
	".cs.S2C_Fog_GetServerInfos.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETSERVERINFOS_SERVER_INFOS_F, {
	"server_infos",
	".cs.S2C_Fog_GetServerInfos.server_infos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GETSERVERINFOS_SID_F, {
	"sid",
	".cs.S2C_Fog_GetServerInfos.sid",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_GETSERVERINFOS_ME, {
	"S2C_Fog_GetServerInfos",
	".cs.S2C_Fog_GetServerInfos",
	{},
	{},
	{
		var_0_10.S2C_FOG_GETSERVERINFOS_RET_F,
		var_0_10.S2C_FOG_GETSERVERINFOS_SERVER_INFOS_F,
		var_0_10.S2C_FOG_GETSERVERINFOS_SID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_GUILDFLOOR_ME, {
	"C2S_Fog_GuildFloor",
	".cs.C2S_Fog_GuildFloor",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GUILDFLOOR_RET_F, {
	"ret",
	".cs.S2C_Fog_GuildFloor.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GUILDFLOOR_LIST_F, {
	"list",
	".cs.S2C_Fog_GuildFloor.list",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FOGGUILDFLOOR_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_GUILDFLOOR_ME, {
	"S2C_Fog_GuildFloor",
	".cs.S2C_Fog_GuildFloor",
	{},
	{},
	{
		var_0_10.S2C_FOG_GUILDFLOOR_RET_F,
		var_0_10.S2C_FOG_GUILDFLOOR_LIST_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_GUILDFLOORUSER_FLOOR_F, {
	"floor",
	".cs.C2S_Fog_GuildFloorUser.floor",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_GUILDFLOORUSER_ME, {
	"C2S_Fog_GuildFloorUser",
	".cs.C2S_Fog_GuildFloorUser",
	{},
	{},
	{
		var_0_10.C2S_FOG_GUILDFLOORUSER_FLOOR_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GUILDFLOORUSER_RET_F, {
	"ret",
	".cs.S2C_Fog_GuildFloorUser.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GUILDFLOORUSER_FLOOR_F, {
	"floor",
	".cs.S2C_Fog_GuildFloorUser.floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_GUILDFLOORUSER_LIST_F, {
	"list",
	".cs.S2C_Fog_GuildFloorUser.list",
	3,
	2,
	3,
	false,
	{},
	var_0_3.FOGGUILDFLOORUSER_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_GUILDFLOORUSER_ME, {
	"S2C_Fog_GuildFloorUser",
	".cs.S2C_Fog_GuildFloorUser",
	{},
	{},
	{
		var_0_10.S2C_FOG_GUILDFLOORUSER_RET_F,
		var_0_10.S2C_FOG_GUILDFLOORUSER_FLOOR_F,
		var_0_10.S2C_FOG_GUILDFLOORUSER_LIST_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_UPGRADELEVEL_RET_F, {
	"ret",
	".cs.S2C_Fog_UpgradeLevel.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_UPGRADELEVEL_LEVEL_F, {
	"level",
	".cs.S2C_Fog_UpgradeLevel.level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_UPGRADELEVEL_ME, {
	"S2C_Fog_UpgradeLevel",
	".cs.S2C_Fog_UpgradeLevel",
	{},
	{},
	{
		var_0_10.S2C_FOG_UPGRADELEVEL_RET_F,
		var_0_10.S2C_FOG_UPGRADELEVEL_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_IDLEINFO_ME, {
	"C2S_Fog_IdleInfo",
	".cs.C2S_Fog_IdleInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_IDLEINFO_RET_F, {
	"ret",
	".cs.S2C_Fog_IdleInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_IDLEINFO_IDLE_INFO_F, {
	"idle_info",
	".cs.S2C_Fog_IdleInfo.idle_info",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FOGIDLEINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_IDLEINFO_ME, {
	"S2C_Fog_IdleInfo",
	".cs.S2C_Fog_IdleInfo",
	{},
	{},
	{
		var_0_10.S2C_FOG_IDLEINFO_RET_F,
		var_0_10.S2C_FOG_IDLEINFO_IDLE_INFO_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_IDLEAWARD_ME, {
	"C2S_Fog_IdleAward",
	".cs.C2S_Fog_IdleAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_IDLEAWARD_RET_F, {
	"ret",
	".cs.S2C_Fog_IdleAward.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_IDLEAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Fog_IdleAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_IDLEAWARD_IDLE_INFO_F, {
	"idle_info",
	".cs.S2C_Fog_IdleAward.idle_info",
	3,
	2,
	3,
	false,
	{},
	var_0_3.FOGIDLEINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_IDLEAWARD_LEVEL_F, {
	"level",
	".cs.S2C_Fog_IdleAward.level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_IDLEAWARD_ME, {
	"S2C_Fog_IdleAward",
	".cs.S2C_Fog_IdleAward",
	{},
	{},
	{
		var_0_10.S2C_FOG_IDLEAWARD_RET_F,
		var_0_10.S2C_FOG_IDLEAWARD_AWARDS_F,
		var_0_10.S2C_FOG_IDLEAWARD_IDLE_INFO_F,
		var_0_10.S2C_FOG_IDLEAWARD_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_TALENT_GETINFO_ME, {
	"C2S_Fog_Talent_GetInfo",
	".cs.C2S_Fog_Talent_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Fog_Talent_GetInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_GETINFO_NODES_F, {
	"nodes",
	".cs.S2C_Fog_Talent_GetInfo.nodes",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_GETINFO_ADDITION_LEVEL_F, {
	"addition_level",
	".cs.S2C_Fog_Talent_GetInfo.addition_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_GETINFO_CONSUME_F, {
	"consume",
	".cs.S2C_Fog_Talent_GetInfo.consume",
	4,
	3,
	3,
	false,
	{},
	var_0_3.FOGTALENTCONSUME_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_TALENT_GETINFO_ME, {
	"S2C_Fog_Talent_GetInfo",
	".cs.S2C_Fog_Talent_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_FOG_TALENT_GETINFO_RET_F,
		var_0_10.S2C_FOG_TALENT_GETINFO_NODES_F,
		var_0_10.S2C_FOG_TALENT_GETINFO_ADDITION_LEVEL_F,
		var_0_10.S2C_FOG_TALENT_GETINFO_CONSUME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_TALENT_UPGRADENODE_NODE_ID_F, {
	"node_id",
	".cs.C2S_Fog_Talent_UpgradeNode.node_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_TALENT_UPGRADENODE_NEXT_LEVEL_F, {
	"next_level",
	".cs.C2S_Fog_Talent_UpgradeNode.next_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_TALENT_UPGRADENODE_TAB_F, {
	"tab",
	".cs.C2S_Fog_Talent_UpgradeNode.tab",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_TALENT_UPGRADENODE_LAYER_F, {
	"layer",
	".cs.C2S_Fog_Talent_UpgradeNode.layer",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_TALENT_UPGRADENODE_ME, {
	"C2S_Fog_Talent_UpgradeNode",
	".cs.C2S_Fog_Talent_UpgradeNode",
	{},
	{},
	{
		var_0_10.C2S_FOG_TALENT_UPGRADENODE_NODE_ID_F,
		var_0_10.C2S_FOG_TALENT_UPGRADENODE_NEXT_LEVEL_F,
		var_0_10.C2S_FOG_TALENT_UPGRADENODE_TAB_F,
		var_0_10.C2S_FOG_TALENT_UPGRADENODE_LAYER_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_UPGRADENODE_RET_F, {
	"ret",
	".cs.S2C_Fog_Talent_UpgradeNode.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_UPGRADENODE_NODE_ID_F, {
	"node_id",
	".cs.S2C_Fog_Talent_UpgradeNode.node_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_UPGRADENODE_NEXT_LEVEL_F, {
	"next_level",
	".cs.S2C_Fog_Talent_UpgradeNode.next_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_UPGRADENODE_TAB_F, {
	"tab",
	".cs.S2C_Fog_Talent_UpgradeNode.tab",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_UPGRADENODE_LAYER_F, {
	"layer",
	".cs.S2C_Fog_Talent_UpgradeNode.layer",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_UPGRADENODE_NODE_LEVEL_F, {
	"node_level",
	".cs.S2C_Fog_Talent_UpgradeNode.node_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_UPGRADENODE_ADDITION_LEVEL_F, {
	"addition_level",
	".cs.S2C_Fog_Talent_UpgradeNode.addition_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_UPGRADENODE_CONSUME_F, {
	"consume",
	".cs.S2C_Fog_Talent_UpgradeNode.consume",
	8,
	7,
	3,
	false,
	{},
	var_0_3.FOGTALENTCONSUME_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_TALENT_UPGRADENODE_ME, {
	"S2C_Fog_Talent_UpgradeNode",
	".cs.S2C_Fog_Talent_UpgradeNode",
	{},
	{},
	{
		var_0_10.S2C_FOG_TALENT_UPGRADENODE_RET_F,
		var_0_10.S2C_FOG_TALENT_UPGRADENODE_NODE_ID_F,
		var_0_10.S2C_FOG_TALENT_UPGRADENODE_NEXT_LEVEL_F,
		var_0_10.S2C_FOG_TALENT_UPGRADENODE_TAB_F,
		var_0_10.S2C_FOG_TALENT_UPGRADENODE_LAYER_F,
		var_0_10.S2C_FOG_TALENT_UPGRADENODE_NODE_LEVEL_F,
		var_0_10.S2C_FOG_TALENT_UPGRADENODE_ADDITION_LEVEL_F,
		var_0_10.S2C_FOG_TALENT_UPGRADENODE_CONSUME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_TALENT_RESET_TAB_F, {
	"tab",
	".cs.C2S_Fog_Talent_Reset.tab",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_TALENT_RESET_ME, {
	"C2S_Fog_Talent_Reset",
	".cs.C2S_Fog_Talent_Reset",
	{},
	{},
	{
		var_0_10.C2S_FOG_TALENT_RESET_TAB_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_RESET_RET_F, {
	"ret",
	".cs.S2C_Fog_Talent_Reset.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_RESET_TAB_F, {
	"tab",
	".cs.S2C_Fog_Talent_Reset.tab",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_RESET_ADDITION_LEVEL_F, {
	"addition_level",
	".cs.S2C_Fog_Talent_Reset.addition_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_RESET_AWARDS_F, {
	"awards",
	".cs.S2C_Fog_Talent_Reset.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_RESET_CONSUME_F, {
	"consume",
	".cs.S2C_Fog_Talent_Reset.consume",
	5,
	4,
	3,
	false,
	{},
	var_0_3.FOGTALENTCONSUME_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_TALENT_RESET_ME, {
	"S2C_Fog_Talent_Reset",
	".cs.S2C_Fog_Talent_Reset",
	{},
	{},
	{
		var_0_10.S2C_FOG_TALENT_RESET_RET_F,
		var_0_10.S2C_FOG_TALENT_RESET_TAB_F,
		var_0_10.S2C_FOG_TALENT_RESET_ADDITION_LEVEL_F,
		var_0_10.S2C_FOG_TALENT_RESET_AWARDS_F,
		var_0_10.S2C_FOG_TALENT_RESET_CONSUME_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_TALENT_ATTRIBUTE_ME, {
	"C2S_Fog_Talent_Attribute",
	".cs.C2S_Fog_Talent_Attribute",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_ATTRIBUTE_RET_F, {
	"ret",
	".cs.S2C_Fog_Talent_Attribute.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_TALENT_ATTRIBUTE_ATTR_F, {
	"attr",
	".cs.S2C_Fog_Talent_Attribute.attr",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_TALENT_ATTRIBUTE_ME, {
	"S2C_Fog_Talent_Attribute",
	".cs.S2C_Fog_Talent_Attribute",
	{},
	{},
	{
		var_0_10.S2C_FOG_TALENT_ATTRIBUTE_RET_F,
		var_0_10.S2C_FOG_TALENT_ATTRIBUTE_ATTR_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_ONEKEYSWEEP_ME, {
	"C2S_Fog_OneKeySweep",
	".cs.C2S_Fog_OneKeySweep",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_ONEKEYSWEEP_RET_F, {
	"ret",
	".cs.S2C_Fog_OneKeySweep.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_ONEKEYSWEEP_CUR_FLOOR_F, {
	"cur_floor",
	".cs.S2C_Fog_OneKeySweep.cur_floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_ONEKEYSWEEP_SEALS_F, {
	"seals",
	".cs.S2C_Fog_OneKeySweep.seals",
	3,
	2,
	3,
	false,
	{},
	var_0_3.FOGFLOORSEAL_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_ONEKEYSWEEP_ME, {
	"S2C_Fog_OneKeySweep",
	".cs.S2C_Fog_OneKeySweep",
	{},
	{},
	{
		var_0_10.S2C_FOG_ONEKEYSWEEP_RET_F,
		var_0_10.S2C_FOG_ONEKEYSWEEP_CUR_FLOOR_F,
		var_0_10.S2C_FOG_ONEKEYSWEEP_SEALS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_ONEKEYCHOOSESEAL_FLOOR_F, {
	"floor",
	".cs.C2S_Fog_OneKeyChooseSeal.floor",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_ONEKEYCHOOSESEAL_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_Fog_OneKeyChooseSeal.knight_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_ONEKEYCHOOSESEAL_SEAL_LEVEL_ID_F, {
	"seal_level_id",
	".cs.C2S_Fog_OneKeyChooseSeal.seal_level_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_ONEKEYCHOOSESEAL_ME, {
	"C2S_Fog_OneKeyChooseSeal",
	".cs.C2S_Fog_OneKeyChooseSeal",
	{},
	{},
	{
		var_0_10.C2S_FOG_ONEKEYCHOOSESEAL_FLOOR_F,
		var_0_10.C2S_FOG_ONEKEYCHOOSESEAL_KNIGHT_ID_F,
		var_0_10.C2S_FOG_ONEKEYCHOOSESEAL_SEAL_LEVEL_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_ONEKEYCHOOSESEAL_RET_F, {
	"ret",
	".cs.S2C_Fog_OneKeyChooseSeal.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_ONEKEYCHOOSESEAL_FLOOR_F, {
	"floor",
	".cs.S2C_Fog_OneKeyChooseSeal.floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_ONEKEYCHOOSESEAL_FOG_KNIGHTS_F, {
	"fog_knights",
	".cs.S2C_Fog_OneKeyChooseSeal.fog_knights",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.FOGKNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_ONEKEYCHOOSESEAL_ME, {
	"S2C_Fog_OneKeyChooseSeal",
	".cs.S2C_Fog_OneKeyChooseSeal",
	{},
	{},
	{
		var_0_10.S2C_FOG_ONEKEYCHOOSESEAL_RET_F,
		var_0_10.S2C_FOG_ONEKEYCHOOSESEAL_FLOOR_F,
		var_0_10.S2C_FOG_ONEKEYCHOOSESEAL_FOG_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_STAGESKIP_FLOOR_F, {
	"floor",
	".cs.C2S_Fog_StageSkip.floor",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FOG_STAGESKIP_STAGE_F, {
	"stage",
	".cs.C2S_Fog_StageSkip.stage",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FOG_STAGESKIP_ME, {
	"C2S_Fog_StageSkip",
	".cs.C2S_Fog_StageSkip",
	{},
	{},
	{
		var_0_10.C2S_FOG_STAGESKIP_FLOOR_F,
		var_0_10.C2S_FOG_STAGESKIP_STAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_STAGESKIP_RET_F, {
	"ret",
	".cs.S2C_Fog_StageSkip.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_STAGESKIP_FLOOR_F, {
	"floor",
	".cs.S2C_Fog_StageSkip.floor",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FOG_STAGESKIP_STAGE_F, {
	"stage",
	".cs.S2C_Fog_StageSkip.stage",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FOG_STAGESKIP_ME, {
	"S2C_Fog_StageSkip",
	".cs.S2C_Fog_StageSkip",
	{},
	{},
	{
		var_0_10.S2C_FOG_STAGESKIP_RET_F,
		var_0_10.S2C_FOG_STAGESKIP_FLOOR_F,
		var_0_10.S2C_FOG_STAGESKIP_STAGE_F
	},
	false,
	{}
})

return var_0_10
