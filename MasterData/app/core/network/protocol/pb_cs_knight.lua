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
	C2S_KNIGHT_GETFIGHTVALUE_ME = protobuf.Descriptor(),
	C2S_KNIGHT_GETFIGHTVALUE_IDS_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_GETFIGHTVALUE_ME = protobuf.Descriptor(),
	S2C_KNIGHT_GETFIGHTVALUE_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_GETFIGHTVALUE_IDS_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_UPGRADE_ME = protobuf.Descriptor(),
	C2S_KNIGHT_UPGRADE_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_UPGRADE_ITEM_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_UPGRADE_ITEM_NUM_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_UPGRADE_ME = protobuf.Descriptor(),
	S2C_KNIGHT_UPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_UPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_UPGRADE_ITEM_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_UPGRADE_ITEM_NUM_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_STARINCREASE_ME = protobuf.Descriptor(),
	C2S_KNIGHT_STARINCREASE_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_STARINCREASE_ALL_PURPOSE_FRAG_NUM_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_STARINCREASE_ME = protobuf.Descriptor(),
	S2C_KNIGHT_STARINCREASE_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_STARINCREASE_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_STARINCREASE_ALL_PURPOSE_FRAG_NUM_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_STARINCREASE_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_STARTRAIN_ME = protobuf.Descriptor(),
	C2S_KNIGHT_STARTRAIN_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_STARTRAIN_NUM_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_STARTRAIN_ME = protobuf.Descriptor(),
	S2C_KNIGHT_STARTRAIN_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_STARTRAIN_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_STARTRAIN_NUM_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_STARTRAINCONFIRM_ME = protobuf.Descriptor(),
	C2S_KNIGHT_STARTRAINCONFIRM_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_STARTRAINCONFIRM_CONFIRM_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_STARTRAINCONFIRM_ME = protobuf.Descriptor(),
	S2C_KNIGHT_STARTRAINCONFIRM_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_STARTRAINCONFIRM_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_STARTRAINCONFIRM_CONFIRM_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_STARTRAINUPGRADE_ME = protobuf.Descriptor(),
	C2S_KNIGHT_STARTRAINUPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_STARTRAINUPGRADE_ME = protobuf.Descriptor(),
	S2C_KNIGHT_STARTRAINUPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_STARTRAINUPGRADE_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_ADVANCEEQUIP_ME = protobuf.Descriptor(),
	C2S_KNIGHT_ADVANCEEQUIP_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_ADVANCEEQUIP_POS_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_ADVANCEEQUIP_ME = protobuf.Descriptor(),
	S2C_KNIGHT_ADVANCEEQUIP_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_ADVANCEEQUIP_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_ADVANCEEQUIP_POS_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_ADVANCEUPGRADE_ME = protobuf.Descriptor(),
	C2S_KNIGHT_ADVANCEUPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_ADVANCEUPGRADE_ME = protobuf.Descriptor(),
	S2C_KNIGHT_ADVANCEUPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_ADVANCEUPGRADE_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_ADVANCECOMPOSE_ME = protobuf.Descriptor(),
	C2S_KNIGHT_ADVANCECOMPOSE_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_ADVANCECOMPOSE_NUM_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_ADVANCECOMPOSE_PATH_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_ADVANCECOMPOSE_ME = protobuf.Descriptor(),
	S2C_KNIGHT_ADVANCECOMPOSE_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_ADVANCECOMPOSE_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_ADVANCECOMPOSE_NUM_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_ADVANCECOMPOSE_PATH_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_ADVANCECOMPOSEONEKEY_ME = protobuf.Descriptor(),
	C2S_KNIGHT_ADVANCECOMPOSEONEKEY_COMPOSE_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_ADVANCECOMPOSEONEKEY_EQUIP_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_ADVANCECOMPOSEONEKEY_ME = protobuf.Descriptor(),
	S2C_KNIGHT_ADVANCECOMPOSEONEKEY_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_ADVANCECOMPOSEONEKEY_COMPOSE_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_ADVANCECOMPOSEONEKEY_EQUIP_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_UPGRADEONELEVEL_ME = protobuf.Descriptor(),
	C2S_KNIGHT_UPGRADEONELEVEL_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_UPGRADEONELEVEL_ME = protobuf.Descriptor(),
	S2C_KNIGHT_UPGRADEONELEVEL_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_UPGRADEONELEVEL_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_ONEKEY_UPGRADE_ME = protobuf.Descriptor(),
	C2S_KNIGHT_ONEKEY_UPGRADE_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_ONEKEY_UPGRADE_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_ONEKEY_UPGRADE_ME = protobuf.Descriptor(),
	S2C_KNIGHT_ONEKEY_UPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_ONEKEY_UPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_ONEKEY_UPGRADE_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_FAVORABILITYUPGRADE_ME = protobuf.Descriptor(),
	C2S_KNIGHT_FAVORABILITYUPGRADE_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_FAVORABILITYUPGRADE_USE_ITEMS_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_FAVORABILITYUPGRADE_ME = protobuf.Descriptor(),
	S2C_KNIGHT_FAVORABILITYUPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_FAVORABILITYUPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_FAVORABILITYUPGRADE_USE_ITEMS_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_FAVORABILITYBREAK_ME = protobuf.Descriptor(),
	C2S_KNIGHT_FAVORABILITYBREAK_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_FAVORABILITYBREAK_ME = protobuf.Descriptor(),
	S2C_KNIGHT_FAVORABILITYBREAK_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_FAVORABILITYBREAK_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_FAVORABILITYONEKEYUPGRADE_ME = protobuf.Descriptor(),
	C2S_KNIGHT_FAVORABILITYONEKEYUPGRADE_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_FAVORABILITYONEKEYUPGRADE_USE_ITEMS_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_FAVORABILITYONEKEYUPGRADE_ONLY_USE_LIKE_ITEM_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE_ME = protobuf.Descriptor(),
	S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE_USE_ITEMS_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE_ONLY_USE_LIKE_ITEM_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_AWAKE_NEXT_ME = protobuf.Descriptor(),
	C2S_KNIGHT_AWAKE_NEXT_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_AWAKE_NEXT_ME = protobuf.Descriptor(),
	S2C_KNIGHT_AWAKE_NEXT_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_AWAKE_NEXT_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_AWAKE_CANCEL_ME = protobuf.Descriptor(),
	C2S_KNIGHT_AWAKE_CANCEL_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_AWAKE_CANCEL_ME = protobuf.Descriptor(),
	S2C_KNIGHT_AWAKE_CANCEL_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_AWAKE_CANCEL_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_PENDANT_UP_ME = protobuf.Descriptor(),
	C2S_KNIGHT_PENDANT_UP_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_PENDANT_UP_ME = protobuf.Descriptor(),
	S2C_KNIGHT_PENDANT_UP_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_PENDANT_UP_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_INHERITFORMATION_ME = protobuf.Descriptor(),
	C2S_KNIGHT_INHERITFORMATION_POS_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_INHERITFORMATION_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_INHERITFORMATION_ME = protobuf.Descriptor(),
	S2C_KNIGHT_INHERITFORMATION_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_INHERITFORMATION_FORMATION_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_INHERITFORMATION_POS_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_INHERITFORMATION_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_INHERITFORMATION_AWARD_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_GETBYSOURCE_ME = protobuf.Descriptor(),
	C2S_KNIGHT_GETBYSOURCE_SOURCE_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_GETBYSOURCE_ME = protobuf.Descriptor(),
	S2C_KNIGHT_GETBYSOURCE_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_GETBYSOURCE_SOURCE_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_GETBYSOURCE_KNIGHTS_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_MR_SUPPORTACTIVE_ME = protobuf.Descriptor(),
	C2S_KNIGHT_MR_SUPPORTACTIVE_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_MR_SUPPORTACTIVE_TARGET_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_MR_SUPPORTACTIVE_ME = protobuf.Descriptor(),
	S2C_KNIGHT_MR_SUPPORTACTIVE_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_MR_SUPPORTACTIVE_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_MR_SUPPORTACTIVE_TARGET_ID_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_MR_SUPPORTUP_ME = protobuf.Descriptor(),
	C2S_KNIGHT_MR_SUPPORTUP_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_MR_SUPPORTUP_ME = protobuf.Descriptor(),
	S2C_KNIGHT_MR_SUPPORTUP_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_MR_SUPPORTUP_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_MR_SUPPORTUP_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_KNIGHT_MR_SUPPORTSKILLUP_ME = protobuf.Descriptor(),
	C2S_KNIGHT_MR_SUPPORTSKILLUP_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_MR_SUPPORTSKILLUP_ME = protobuf.Descriptor(),
	S2C_KNIGHT_MR_SUPPORTSKILLUP_RET_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_MR_SUPPORTSKILLUP_KNIGHT_ID_F = protobuf.FieldDescriptor(),
	S2C_KNIGHT_MR_SUPPORTSKILLUP_SKILL_LEVEL_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_GETFIGHTVALUE_IDS_F, {
	"ids",
	".cs.C2S_Knight_GetFightValue.ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_GETFIGHTVALUE_ME, {
	"C2S_Knight_GetFightValue",
	".cs.C2S_Knight_GetFightValue",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_GETFIGHTVALUE_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_GETFIGHTVALUE_RET_F, {
	"ret",
	".cs.S2C_Knight_GetFightValue.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_GETFIGHTVALUE_IDS_F, {
	"ids",
	".cs.S2C_Knight_GetFightValue.ids",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_GETFIGHTVALUE_ME, {
	"S2C_Knight_GetFightValue",
	".cs.S2C_Knight_GetFightValue",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_GETFIGHTVALUE_RET_F,
		var_0_10.S2C_KNIGHT_GETFIGHTVALUE_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_UPGRADE_ID_F, {
	"id",
	".cs.C2S_Knight_Upgrade.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_UPGRADE_ITEM_ID_F, {
	"item_id",
	".cs.C2S_Knight_Upgrade.item_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_UPGRADE_ITEM_NUM_F, {
	"item_num",
	".cs.C2S_Knight_Upgrade.item_num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_UPGRADE_ME, {
	"C2S_Knight_Upgrade",
	".cs.C2S_Knight_Upgrade",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_UPGRADE_ID_F,
		var_0_10.C2S_KNIGHT_UPGRADE_ITEM_ID_F,
		var_0_10.C2S_KNIGHT_UPGRADE_ITEM_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_UPGRADE_RET_F, {
	"ret",
	".cs.S2C_Knight_Upgrade.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_UPGRADE_ID_F, {
	"id",
	".cs.S2C_Knight_Upgrade.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_UPGRADE_ITEM_ID_F, {
	"item_id",
	".cs.S2C_Knight_Upgrade.item_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_UPGRADE_ITEM_NUM_F, {
	"item_num",
	".cs.S2C_Knight_Upgrade.item_num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_UPGRADE_ME, {
	"S2C_Knight_Upgrade",
	".cs.S2C_Knight_Upgrade",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_UPGRADE_RET_F,
		var_0_10.S2C_KNIGHT_UPGRADE_ID_F,
		var_0_10.S2C_KNIGHT_UPGRADE_ITEM_ID_F,
		var_0_10.S2C_KNIGHT_UPGRADE_ITEM_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_STARINCREASE_ID_F, {
	"id",
	".cs.C2S_Knight_StarIncrease.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_STARINCREASE_ALL_PURPOSE_FRAG_NUM_F, {
	"all_purpose_frag_num",
	".cs.C2S_Knight_StarIncrease.all_purpose_frag_num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_STARINCREASE_ME, {
	"C2S_Knight_StarIncrease",
	".cs.C2S_Knight_StarIncrease",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_STARINCREASE_ID_F,
		var_0_10.C2S_KNIGHT_STARINCREASE_ALL_PURPOSE_FRAG_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_STARINCREASE_RET_F, {
	"ret",
	".cs.S2C_Knight_StarIncrease.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_STARINCREASE_ID_F, {
	"id",
	".cs.S2C_Knight_StarIncrease.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_STARINCREASE_ALL_PURPOSE_FRAG_NUM_F, {
	"all_purpose_frag_num",
	".cs.S2C_Knight_StarIncrease.all_purpose_frag_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_STARINCREASE_AWARDS_F, {
	"awards",
	".cs.S2C_Knight_StarIncrease.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_STARINCREASE_ME, {
	"S2C_Knight_StarIncrease",
	".cs.S2C_Knight_StarIncrease",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_STARINCREASE_RET_F,
		var_0_10.S2C_KNIGHT_STARINCREASE_ID_F,
		var_0_10.S2C_KNIGHT_STARINCREASE_ALL_PURPOSE_FRAG_NUM_F,
		var_0_10.S2C_KNIGHT_STARINCREASE_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_STARTRAIN_ID_F, {
	"id",
	".cs.C2S_Knight_StarTrain.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_STARTRAIN_NUM_F, {
	"num",
	".cs.C2S_Knight_StarTrain.num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_STARTRAIN_ME, {
	"C2S_Knight_StarTrain",
	".cs.C2S_Knight_StarTrain",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_STARTRAIN_ID_F,
		var_0_10.C2S_KNIGHT_STARTRAIN_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_STARTRAIN_RET_F, {
	"ret",
	".cs.S2C_Knight_StarTrain.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_STARTRAIN_ID_F, {
	"id",
	".cs.S2C_Knight_StarTrain.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_STARTRAIN_NUM_F, {
	"num",
	".cs.S2C_Knight_StarTrain.num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_STARTRAIN_ME, {
	"S2C_Knight_StarTrain",
	".cs.S2C_Knight_StarTrain",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_STARTRAIN_RET_F,
		var_0_10.S2C_KNIGHT_STARTRAIN_ID_F,
		var_0_10.S2C_KNIGHT_STARTRAIN_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_STARTRAINCONFIRM_ID_F, {
	"id",
	".cs.C2S_Knight_StarTrainConfirm.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_STARTRAINCONFIRM_CONFIRM_F, {
	"confirm",
	".cs.C2S_Knight_StarTrainConfirm.confirm",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_STARTRAINCONFIRM_ME, {
	"C2S_Knight_StarTrainConfirm",
	".cs.C2S_Knight_StarTrainConfirm",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_STARTRAINCONFIRM_ID_F,
		var_0_10.C2S_KNIGHT_STARTRAINCONFIRM_CONFIRM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_STARTRAINCONFIRM_RET_F, {
	"ret",
	".cs.S2C_Knight_StarTrainConfirm.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_STARTRAINCONFIRM_ID_F, {
	"id",
	".cs.S2C_Knight_StarTrainConfirm.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_STARTRAINCONFIRM_CONFIRM_F, {
	"confirm",
	".cs.S2C_Knight_StarTrainConfirm.confirm",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_STARTRAINCONFIRM_ME, {
	"S2C_Knight_StarTrainConfirm",
	".cs.S2C_Knight_StarTrainConfirm",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_STARTRAINCONFIRM_RET_F,
		var_0_10.S2C_KNIGHT_STARTRAINCONFIRM_ID_F,
		var_0_10.S2C_KNIGHT_STARTRAINCONFIRM_CONFIRM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_STARTRAINUPGRADE_ID_F, {
	"id",
	".cs.C2S_Knight_StarTrainUpgrade.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_STARTRAINUPGRADE_ME, {
	"C2S_Knight_StarTrainUpgrade",
	".cs.C2S_Knight_StarTrainUpgrade",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_STARTRAINUPGRADE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_STARTRAINUPGRADE_RET_F, {
	"ret",
	".cs.S2C_Knight_StarTrainUpgrade.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_STARTRAINUPGRADE_ID_F, {
	"id",
	".cs.S2C_Knight_StarTrainUpgrade.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_STARTRAINUPGRADE_ME, {
	"S2C_Knight_StarTrainUpgrade",
	".cs.S2C_Knight_StarTrainUpgrade",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_STARTRAINUPGRADE_RET_F,
		var_0_10.S2C_KNIGHT_STARTRAINUPGRADE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_ADVANCEEQUIP_ID_F, {
	"id",
	".cs.C2S_Knight_AdvanceEquip.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_ADVANCEEQUIP_POS_F, {
	"pos",
	".cs.C2S_Knight_AdvanceEquip.pos",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_ADVANCEEQUIP_ME, {
	"C2S_Knight_AdvanceEquip",
	".cs.C2S_Knight_AdvanceEquip",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_ADVANCEEQUIP_ID_F,
		var_0_10.C2S_KNIGHT_ADVANCEEQUIP_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_ADVANCEEQUIP_RET_F, {
	"ret",
	".cs.S2C_Knight_AdvanceEquip.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_ADVANCEEQUIP_ID_F, {
	"id",
	".cs.S2C_Knight_AdvanceEquip.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_ADVANCEEQUIP_POS_F, {
	"pos",
	".cs.S2C_Knight_AdvanceEquip.pos",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_ADVANCEEQUIP_ME, {
	"S2C_Knight_AdvanceEquip",
	".cs.S2C_Knight_AdvanceEquip",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_ADVANCEEQUIP_RET_F,
		var_0_10.S2C_KNIGHT_ADVANCEEQUIP_ID_F,
		var_0_10.S2C_KNIGHT_ADVANCEEQUIP_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_ADVANCEUPGRADE_ID_F, {
	"id",
	".cs.C2S_Knight_AdvanceUpgrade.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_ADVANCEUPGRADE_ME, {
	"C2S_Knight_AdvanceUpgrade",
	".cs.C2S_Knight_AdvanceUpgrade",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_ADVANCEUPGRADE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_ADVANCEUPGRADE_RET_F, {
	"ret",
	".cs.S2C_Knight_AdvanceUpgrade.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_ADVANCEUPGRADE_ID_F, {
	"id",
	".cs.S2C_Knight_AdvanceUpgrade.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_ADVANCEUPGRADE_ME, {
	"S2C_Knight_AdvanceUpgrade",
	".cs.S2C_Knight_AdvanceUpgrade",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_ADVANCEUPGRADE_RET_F,
		var_0_10.S2C_KNIGHT_ADVANCEUPGRADE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_ADVANCECOMPOSE_ID_F, {
	"id",
	".cs.C2S_Knight_AdvanceCompose.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_ADVANCECOMPOSE_NUM_F, {
	"num",
	".cs.C2S_Knight_AdvanceCompose.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_ADVANCECOMPOSE_PATH_ID_F, {
	"path_id",
	".cs.C2S_Knight_AdvanceCompose.path_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_ADVANCECOMPOSE_ME, {
	"C2S_Knight_AdvanceCompose",
	".cs.C2S_Knight_AdvanceCompose",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_ADVANCECOMPOSE_ID_F,
		var_0_10.C2S_KNIGHT_ADVANCECOMPOSE_NUM_F,
		var_0_10.C2S_KNIGHT_ADVANCECOMPOSE_PATH_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_ADVANCECOMPOSE_RET_F, {
	"ret",
	".cs.S2C_Knight_AdvanceCompose.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_ADVANCECOMPOSE_ID_F, {
	"id",
	".cs.S2C_Knight_AdvanceCompose.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_ADVANCECOMPOSE_NUM_F, {
	"num",
	".cs.S2C_Knight_AdvanceCompose.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_ADVANCECOMPOSE_PATH_ID_F, {
	"path_id",
	".cs.S2C_Knight_AdvanceCompose.path_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_ADVANCECOMPOSE_ME, {
	"S2C_Knight_AdvanceCompose",
	".cs.S2C_Knight_AdvanceCompose",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_ADVANCECOMPOSE_RET_F,
		var_0_10.S2C_KNIGHT_ADVANCECOMPOSE_ID_F,
		var_0_10.S2C_KNIGHT_ADVANCECOMPOSE_NUM_F,
		var_0_10.S2C_KNIGHT_ADVANCECOMPOSE_PATH_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_ADVANCECOMPOSEONEKEY_COMPOSE_F, {
	"compose",
	".cs.C2S_Knight_AdvanceComposeOneKey.compose",
	1,
	0,
	3,
	false,
	{},
	var_0_10.C2S_KNIGHT_ADVANCECOMPOSE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_ADVANCECOMPOSEONEKEY_EQUIP_F, {
	"equip",
	".cs.C2S_Knight_AdvanceComposeOneKey.equip",
	2,
	1,
	1,
	false,
	nil,
	var_0_10.C2S_KNIGHT_ADVANCEEQUIP_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_ADVANCECOMPOSEONEKEY_ME, {
	"C2S_Knight_AdvanceComposeOneKey",
	".cs.C2S_Knight_AdvanceComposeOneKey",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_ADVANCECOMPOSEONEKEY_COMPOSE_F,
		var_0_10.C2S_KNIGHT_ADVANCECOMPOSEONEKEY_EQUIP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_ADVANCECOMPOSEONEKEY_RET_F, {
	"ret",
	".cs.S2C_Knight_AdvanceComposeOneKey.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_ADVANCECOMPOSEONEKEY_COMPOSE_F, {
	"compose",
	".cs.S2C_Knight_AdvanceComposeOneKey.compose",
	2,
	1,
	3,
	false,
	{},
	var_0_10.C2S_KNIGHT_ADVANCECOMPOSE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_ADVANCECOMPOSEONEKEY_EQUIP_F, {
	"equip",
	".cs.S2C_Knight_AdvanceComposeOneKey.equip",
	3,
	2,
	1,
	false,
	nil,
	var_0_10.C2S_KNIGHT_ADVANCEEQUIP_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_ADVANCECOMPOSEONEKEY_ME, {
	"S2C_Knight_AdvanceComposeOneKey",
	".cs.S2C_Knight_AdvanceComposeOneKey",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_ADVANCECOMPOSEONEKEY_RET_F,
		var_0_10.S2C_KNIGHT_ADVANCECOMPOSEONEKEY_COMPOSE_F,
		var_0_10.S2C_KNIGHT_ADVANCECOMPOSEONEKEY_EQUIP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_UPGRADEONELEVEL_ID_F, {
	"id",
	".cs.C2S_Knight_UpgradeOneLevel.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_UPGRADEONELEVEL_ME, {
	"C2S_Knight_UpgradeOneLevel",
	".cs.C2S_Knight_UpgradeOneLevel",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_UPGRADEONELEVEL_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_UPGRADEONELEVEL_RET_F, {
	"ret",
	".cs.S2C_Knight_UpgradeOneLevel.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_UPGRADEONELEVEL_ID_F, {
	"id",
	".cs.S2C_Knight_UpgradeOneLevel.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_UPGRADEONELEVEL_ME, {
	"S2C_Knight_UpgradeOneLevel",
	".cs.S2C_Knight_UpgradeOneLevel",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_UPGRADEONELEVEL_RET_F,
		var_0_10.S2C_KNIGHT_UPGRADEONELEVEL_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_ONEKEY_UPGRADE_ID_F, {
	"id",
	".cs.C2S_Knight_OneKey_Upgrade.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_ONEKEY_UPGRADE_LEVEL_F, {
	"level",
	".cs.C2S_Knight_OneKey_Upgrade.level",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_ONEKEY_UPGRADE_ME, {
	"C2S_Knight_OneKey_Upgrade",
	".cs.C2S_Knight_OneKey_Upgrade",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_ONEKEY_UPGRADE_ID_F,
		var_0_10.C2S_KNIGHT_ONEKEY_UPGRADE_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_ONEKEY_UPGRADE_RET_F, {
	"ret",
	".cs.S2C_Knight_OneKey_Upgrade.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_ONEKEY_UPGRADE_ID_F, {
	"id",
	".cs.S2C_Knight_OneKey_Upgrade.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_ONEKEY_UPGRADE_LEVEL_F, {
	"level",
	".cs.S2C_Knight_OneKey_Upgrade.level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_ONEKEY_UPGRADE_ME, {
	"S2C_Knight_OneKey_Upgrade",
	".cs.S2C_Knight_OneKey_Upgrade",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_ONEKEY_UPGRADE_RET_F,
		var_0_10.S2C_KNIGHT_ONEKEY_UPGRADE_ID_F,
		var_0_10.S2C_KNIGHT_ONEKEY_UPGRADE_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_FAVORABILITYUPGRADE_ID_F, {
	"id",
	".cs.C2S_Knight_FavorabilityUpgrade.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_FAVORABILITYUPGRADE_USE_ITEMS_F, {
	"use_items",
	".cs.C2S_Knight_FavorabilityUpgrade.use_items",
	2,
	1,
	3,
	false,
	{},
	var_0_3.OPFAVORABILITYUPGRADEUSEITEMS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_FAVORABILITYUPGRADE_ME, {
	"C2S_Knight_FavorabilityUpgrade",
	".cs.C2S_Knight_FavorabilityUpgrade",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_FAVORABILITYUPGRADE_ID_F,
		var_0_10.C2S_KNIGHT_FAVORABILITYUPGRADE_USE_ITEMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_FAVORABILITYUPGRADE_RET_F, {
	"ret",
	".cs.S2C_Knight_FavorabilityUpgrade.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_FAVORABILITYUPGRADE_ID_F, {
	"id",
	".cs.S2C_Knight_FavorabilityUpgrade.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_FAVORABILITYUPGRADE_USE_ITEMS_F, {
	"use_items",
	".cs.S2C_Knight_FavorabilityUpgrade.use_items",
	3,
	2,
	3,
	false,
	{},
	var_0_3.OPFAVORABILITYUPGRADEUSEITEMS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_FAVORABILITYUPGRADE_ME, {
	"S2C_Knight_FavorabilityUpgrade",
	".cs.S2C_Knight_FavorabilityUpgrade",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_FAVORABILITYUPGRADE_RET_F,
		var_0_10.S2C_KNIGHT_FAVORABILITYUPGRADE_ID_F,
		var_0_10.S2C_KNIGHT_FAVORABILITYUPGRADE_USE_ITEMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_FAVORABILITYBREAK_ID_F, {
	"id",
	".cs.C2S_Knight_FavorabilityBreak.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_FAVORABILITYBREAK_ME, {
	"C2S_Knight_FavorabilityBreak",
	".cs.C2S_Knight_FavorabilityBreak",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_FAVORABILITYBREAK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_FAVORABILITYBREAK_RET_F, {
	"ret",
	".cs.S2C_Knight_FavorabilityBreak.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_FAVORABILITYBREAK_ID_F, {
	"id",
	".cs.S2C_Knight_FavorabilityBreak.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_FAVORABILITYBREAK_ME, {
	"S2C_Knight_FavorabilityBreak",
	".cs.S2C_Knight_FavorabilityBreak",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_FAVORABILITYBREAK_RET_F,
		var_0_10.S2C_KNIGHT_FAVORABILITYBREAK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_FAVORABILITYONEKEYUPGRADE_ID_F, {
	"id",
	".cs.C2S_Knight_FavorabilityOneKeyUpgrade.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_FAVORABILITYONEKEYUPGRADE_USE_ITEMS_F, {
	"use_items",
	".cs.C2S_Knight_FavorabilityOneKeyUpgrade.use_items",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_FAVORABILITYONEKEYUPGRADE_ONLY_USE_LIKE_ITEM_F, {
	"only_use_like_item",
	".cs.C2S_Knight_FavorabilityOneKeyUpgrade.only_use_like_item",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_FAVORABILITYONEKEYUPGRADE_ME, {
	"C2S_Knight_FavorabilityOneKeyUpgrade",
	".cs.C2S_Knight_FavorabilityOneKeyUpgrade",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_FAVORABILITYONEKEYUPGRADE_ID_F,
		var_0_10.C2S_KNIGHT_FAVORABILITYONEKEYUPGRADE_USE_ITEMS_F,
		var_0_10.C2S_KNIGHT_FAVORABILITYONEKEYUPGRADE_ONLY_USE_LIKE_ITEM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE_RET_F, {
	"ret",
	".cs.S2C_Knight_FavorabilityOneKeyUpgrade.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE_ID_F, {
	"id",
	".cs.S2C_Knight_FavorabilityOneKeyUpgrade.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE_USE_ITEMS_F, {
	"use_items",
	".cs.S2C_Knight_FavorabilityOneKeyUpgrade.use_items",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE_ONLY_USE_LIKE_ITEM_F, {
	"only_use_like_item",
	".cs.S2C_Knight_FavorabilityOneKeyUpgrade.only_use_like_item",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE_ME, {
	"S2C_Knight_FavorabilityOneKeyUpgrade",
	".cs.S2C_Knight_FavorabilityOneKeyUpgrade",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE_RET_F,
		var_0_10.S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE_ID_F,
		var_0_10.S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE_USE_ITEMS_F,
		var_0_10.S2C_KNIGHT_FAVORABILITYONEKEYUPGRADE_ONLY_USE_LIKE_ITEM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_AWAKE_NEXT_ID_F, {
	"id",
	".cs.C2S_Knight_Awake_Next.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_AWAKE_NEXT_ME, {
	"C2S_Knight_Awake_Next",
	".cs.C2S_Knight_Awake_Next",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_AWAKE_NEXT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_AWAKE_NEXT_RET_F, {
	"ret",
	".cs.S2C_Knight_Awake_Next.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_AWAKE_NEXT_ID_F, {
	"id",
	".cs.S2C_Knight_Awake_Next.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_AWAKE_NEXT_ME, {
	"S2C_Knight_Awake_Next",
	".cs.S2C_Knight_Awake_Next",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_AWAKE_NEXT_RET_F,
		var_0_10.S2C_KNIGHT_AWAKE_NEXT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_AWAKE_CANCEL_ID_F, {
	"id",
	".cs.C2S_Knight_Awake_Cancel.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_AWAKE_CANCEL_ME, {
	"C2S_Knight_Awake_Cancel",
	".cs.C2S_Knight_Awake_Cancel",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_AWAKE_CANCEL_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_AWAKE_CANCEL_RET_F, {
	"ret",
	".cs.S2C_Knight_Awake_Cancel.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_AWAKE_CANCEL_ID_F, {
	"id",
	".cs.S2C_Knight_Awake_Cancel.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_AWAKE_CANCEL_ME, {
	"S2C_Knight_Awake_Cancel",
	".cs.S2C_Knight_Awake_Cancel",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_AWAKE_CANCEL_RET_F,
		var_0_10.S2C_KNIGHT_AWAKE_CANCEL_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_PENDANT_UP_ID_F, {
	"id",
	".cs.C2S_Knight_Pendant_Up.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_PENDANT_UP_ME, {
	"C2S_Knight_Pendant_Up",
	".cs.C2S_Knight_Pendant_Up",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_PENDANT_UP_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_PENDANT_UP_RET_F, {
	"ret",
	".cs.S2C_Knight_Pendant_Up.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_PENDANT_UP_ID_F, {
	"id",
	".cs.S2C_Knight_Pendant_Up.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_PENDANT_UP_ME, {
	"S2C_Knight_Pendant_Up",
	".cs.S2C_Knight_Pendant_Up",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_PENDANT_UP_RET_F,
		var_0_10.S2C_KNIGHT_PENDANT_UP_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_INHERITFORMATION_POS_F, {
	"pos",
	".cs.C2S_Knight_InheritFormation.pos",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_INHERITFORMATION_ID_F, {
	"id",
	".cs.C2S_Knight_InheritFormation.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_INHERITFORMATION_ME, {
	"C2S_Knight_InheritFormation",
	".cs.C2S_Knight_InheritFormation",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_INHERITFORMATION_POS_F,
		var_0_10.C2S_KNIGHT_INHERITFORMATION_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_INHERITFORMATION_RET_F, {
	"ret",
	".cs.S2C_Knight_InheritFormation.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_INHERITFORMATION_FORMATION_F, {
	"formation",
	".cs.S2C_Knight_InheritFormation.formation",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.FORMATION_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_INHERITFORMATION_POS_F, {
	"pos",
	".cs.S2C_Knight_InheritFormation.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_INHERITFORMATION_ID_F, {
	"id",
	".cs.S2C_Knight_InheritFormation.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_INHERITFORMATION_AWARD_F, {
	"award",
	".cs.S2C_Knight_InheritFormation.award",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_INHERITFORMATION_ME, {
	"S2C_Knight_InheritFormation",
	".cs.S2C_Knight_InheritFormation",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_INHERITFORMATION_RET_F,
		var_0_10.S2C_KNIGHT_INHERITFORMATION_FORMATION_F,
		var_0_10.S2C_KNIGHT_INHERITFORMATION_POS_F,
		var_0_10.S2C_KNIGHT_INHERITFORMATION_ID_F,
		var_0_10.S2C_KNIGHT_INHERITFORMATION_AWARD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_GETBYSOURCE_SOURCE_F, {
	"source",
	".cs.C2S_Knight_GetBySource.source",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_GETBYSOURCE_ME, {
	"C2S_Knight_GetBySource",
	".cs.C2S_Knight_GetBySource",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_GETBYSOURCE_SOURCE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_GETBYSOURCE_RET_F, {
	"ret",
	".cs.S2C_Knight_GetBySource.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_GETBYSOURCE_SOURCE_F, {
	"source",
	".cs.S2C_Knight_GetBySource.source",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_GETBYSOURCE_KNIGHTS_F, {
	"knights",
	".cs.S2C_Knight_GetBySource.knights",
	3,
	2,
	3,
	false,
	{},
	var_0_3.KNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_GETBYSOURCE_ME, {
	"S2C_Knight_GetBySource",
	".cs.S2C_Knight_GetBySource",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_GETBYSOURCE_RET_F,
		var_0_10.S2C_KNIGHT_GETBYSOURCE_SOURCE_F,
		var_0_10.S2C_KNIGHT_GETBYSOURCE_KNIGHTS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_MR_SUPPORTACTIVE_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_Knight_MR_SupportActive.knight_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_MR_SUPPORTACTIVE_TARGET_ID_F, {
	"target_id",
	".cs.C2S_Knight_MR_SupportActive.target_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_MR_SUPPORTACTIVE_ME, {
	"C2S_Knight_MR_SupportActive",
	".cs.C2S_Knight_MR_SupportActive",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_MR_SUPPORTACTIVE_KNIGHT_ID_F,
		var_0_10.C2S_KNIGHT_MR_SUPPORTACTIVE_TARGET_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_MR_SUPPORTACTIVE_RET_F, {
	"ret",
	".cs.S2C_Knight_MR_SupportActive.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_MR_SUPPORTACTIVE_KNIGHT_ID_F, {
	"knight_id",
	".cs.S2C_Knight_MR_SupportActive.knight_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_MR_SUPPORTACTIVE_TARGET_ID_F, {
	"target_id",
	".cs.S2C_Knight_MR_SupportActive.target_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_MR_SUPPORTACTIVE_ME, {
	"S2C_Knight_MR_SupportActive",
	".cs.S2C_Knight_MR_SupportActive",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_MR_SUPPORTACTIVE_RET_F,
		var_0_10.S2C_KNIGHT_MR_SUPPORTACTIVE_KNIGHT_ID_F,
		var_0_10.S2C_KNIGHT_MR_SUPPORTACTIVE_TARGET_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_MR_SUPPORTUP_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_Knight_MR_SupportUp.knight_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_MR_SUPPORTUP_ME, {
	"C2S_Knight_MR_SupportUp",
	".cs.C2S_Knight_MR_SupportUp",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_MR_SUPPORTUP_KNIGHT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_MR_SUPPORTUP_RET_F, {
	"ret",
	".cs.S2C_Knight_MR_SupportUp.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_MR_SUPPORTUP_KNIGHT_ID_F, {
	"knight_id",
	".cs.S2C_Knight_MR_SupportUp.knight_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_MR_SUPPORTUP_LEVEL_F, {
	"level",
	".cs.S2C_Knight_MR_SupportUp.level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_MR_SUPPORTUP_ME, {
	"S2C_Knight_MR_SupportUp",
	".cs.S2C_Knight_MR_SupportUp",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_MR_SUPPORTUP_RET_F,
		var_0_10.S2C_KNIGHT_MR_SUPPORTUP_KNIGHT_ID_F,
		var_0_10.S2C_KNIGHT_MR_SUPPORTUP_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_KNIGHT_MR_SUPPORTSKILLUP_KNIGHT_ID_F, {
	"knight_id",
	".cs.C2S_Knight_MR_SupportSkillUp.knight_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_KNIGHT_MR_SUPPORTSKILLUP_ME, {
	"C2S_Knight_MR_SupportSkillUp",
	".cs.C2S_Knight_MR_SupportSkillUp",
	{},
	{},
	{
		var_0_10.C2S_KNIGHT_MR_SUPPORTSKILLUP_KNIGHT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_MR_SUPPORTSKILLUP_RET_F, {
	"ret",
	".cs.S2C_Knight_MR_SupportSkillUp.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_MR_SUPPORTSKILLUP_KNIGHT_ID_F, {
	"knight_id",
	".cs.S2C_Knight_MR_SupportSkillUp.knight_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_KNIGHT_MR_SUPPORTSKILLUP_SKILL_LEVEL_F, {
	"skill_level",
	".cs.S2C_Knight_MR_SupportSkillUp.skill_level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_KNIGHT_MR_SUPPORTSKILLUP_ME, {
	"S2C_Knight_MR_SupportSkillUp",
	".cs.S2C_Knight_MR_SupportSkillUp",
	{},
	{},
	{
		var_0_10.S2C_KNIGHT_MR_SUPPORTSKILLUP_RET_F,
		var_0_10.S2C_KNIGHT_MR_SUPPORTSKILLUP_KNIGHT_ID_F,
		var_0_10.S2C_KNIGHT_MR_SUPPORTSKILLUP_SKILL_LEVEL_F
	},
	false,
	{}
})

return var_0_10
