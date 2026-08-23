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
	C2S_EQUIPMENT_UPGRADE_ME = protobuf.Descriptor(),
	C2S_EQUIPMENT_UPGRADE_ID_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_UPGRADE_TIMES_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_UPGRADE_ME = protobuf.Descriptor(),
	S2C_EQUIPMENT_UPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_UPGRADE_UPGRADE_TIMES_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_UPGRADE_CRI_TIMES_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_UPGRADE_BREAK_REASON_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_UPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_UPGRADE_TIMES_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_UPGRADE_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_UPGRADE_LAST_CRI_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_REFINING_ME = protobuf.Descriptor(),
	C2S_EQUIPMENT_REFINING_ID_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_REFINING_ITEM_ID_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_REFINING_NUM_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_REFINING_ME = protobuf.Descriptor(),
	S2C_EQUIPMENT_REFINING_RET_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_REFINING_ID_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_REFINING_ITEM_ID_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_REFINING_NUM_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_GLYPH_ME = protobuf.Descriptor(),
	C2S_EQUIPMENT_GLYPH_ID_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_GLYPH_ME = protobuf.Descriptor(),
	S2C_EQUIPMENT_GLYPH_RET_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_GLYPH_ID_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_CAST_ME = protobuf.Descriptor(),
	C2S_EQUIPMENT_CAST_CAST_TYPE_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_CAST_ID_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_CAST_ITEM_ID_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_CAST_COST_NUM_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_CAST_ME = protobuf.Descriptor(),
	S2C_EQUIPMENT_CAST_RET_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_CAST_CAST_TYPE_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_CAST_ID_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_CAST_CAST_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_CAST_CAST_EXP_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_CAST_ITEM_ID_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_CAST_COST_NUM_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_REFININGONELEVEL_ME = protobuf.Descriptor(),
	C2S_EQUIPMENT_REFININGONELEVEL_ID_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_REFININGONELEVEL_ADD_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_REFININGONELEVEL_ME = protobuf.Descriptor(),
	S2C_EQUIPMENT_REFININGONELEVEL_RET_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_REFININGONELEVEL_ID_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_REFININGONELEVEL_ADD_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_RESONANCE_UP_ME = protobuf.Descriptor(),
	C2S_EQUIPMENT_RESONANCE_UP_ID_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_RESONANCE_UP_CONSUME_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_RESONANCE_UP_ME = protobuf.Descriptor(),
	S2C_EQUIPMENT_RESONANCE_UP_RET_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_RESONANCE_UP_ID_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_RESONANCE_UP_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_RESONANCE_UP_EXP_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_MAGICALSTAGE_UP_ME = protobuf.Descriptor(),
	C2S_EQUIPMENT_MAGICALSTAGE_UP_ID_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_MAGICALSTAGE_UP_TARGET_STAGE_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_MAGICALSTAGE_UP_ME = protobuf.Descriptor(),
	S2C_EQUIPMENT_MAGICALSTAGE_UP_RET_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_MAGICALSTAGE_UP_ID_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_MAGICALSTAGE_UP_TARGET_STAGE_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_INHERITFORMATION_ME = protobuf.Descriptor(),
	C2S_EQUIPMENT_INHERITFORMATION_POS_F = protobuf.FieldDescriptor(),
	C2S_EQUIPMENT_INHERITFORMATION_ID_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_INHERITFORMATION_ME = protobuf.Descriptor(),
	S2C_EQUIPMENT_INHERITFORMATION_RET_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_INHERITFORMATION_FORMATION_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_INHERITFORMATION_POS_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_INHERITFORMATION_ID_F = protobuf.FieldDescriptor(),
	S2C_EQUIPMENT_INHERITFORMATION_AWARD_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_UPGRADE_ID_F, {
	"id",
	".cs.C2S_Equipment_Upgrade.id",
	3,
	0,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_UPGRADE_TIMES_F, {
	"times",
	".cs.C2S_Equipment_Upgrade.times",
	4,
	1,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_EQUIPMENT_UPGRADE_ME, {
	"C2S_Equipment_Upgrade",
	".cs.C2S_Equipment_Upgrade",
	{},
	{},
	{
		var_0_10.C2S_EQUIPMENT_UPGRADE_ID_F,
		var_0_10.C2S_EQUIPMENT_UPGRADE_TIMES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_UPGRADE_RET_F, {
	"ret",
	".cs.S2C_Equipment_Upgrade.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_UPGRADE_UPGRADE_TIMES_F, {
	"upgrade_times",
	".cs.S2C_Equipment_Upgrade.upgrade_times",
	4,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_UPGRADE_CRI_TIMES_F, {
	"cri_times",
	".cs.S2C_Equipment_Upgrade.cri_times",
	5,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_UPGRADE_BREAK_REASON_F, {
	"break_reason",
	".cs.S2C_Equipment_Upgrade.break_reason",
	6,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_UPGRADE_ID_F, {
	"id",
	".cs.S2C_Equipment_Upgrade.id",
	8,
	4,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_UPGRADE_TIMES_F, {
	"times",
	".cs.S2C_Equipment_Upgrade.times",
	9,
	5,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_UPGRADE_LEVEL_F, {
	"level",
	".cs.S2C_Equipment_Upgrade.level",
	10,
	6,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_UPGRADE_LAST_CRI_F, {
	"last_cri",
	".cs.S2C_Equipment_Upgrade.last_cri",
	11,
	7,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_EQUIPMENT_UPGRADE_ME, {
	"S2C_Equipment_Upgrade",
	".cs.S2C_Equipment_Upgrade",
	{},
	{},
	{
		var_0_10.S2C_EQUIPMENT_UPGRADE_RET_F,
		var_0_10.S2C_EQUIPMENT_UPGRADE_UPGRADE_TIMES_F,
		var_0_10.S2C_EQUIPMENT_UPGRADE_CRI_TIMES_F,
		var_0_10.S2C_EQUIPMENT_UPGRADE_BREAK_REASON_F,
		var_0_10.S2C_EQUIPMENT_UPGRADE_ID_F,
		var_0_10.S2C_EQUIPMENT_UPGRADE_TIMES_F,
		var_0_10.S2C_EQUIPMENT_UPGRADE_LEVEL_F,
		var_0_10.S2C_EQUIPMENT_UPGRADE_LAST_CRI_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_REFINING_ID_F, {
	"id",
	".cs.C2S_Equipment_Refining.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_REFINING_ITEM_ID_F, {
	"item_id",
	".cs.C2S_Equipment_Refining.item_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_REFINING_NUM_F, {
	"num",
	".cs.C2S_Equipment_Refining.num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_EQUIPMENT_REFINING_ME, {
	"C2S_Equipment_Refining",
	".cs.C2S_Equipment_Refining",
	{},
	{},
	{
		var_0_10.C2S_EQUIPMENT_REFINING_ID_F,
		var_0_10.C2S_EQUIPMENT_REFINING_ITEM_ID_F,
		var_0_10.C2S_EQUIPMENT_REFINING_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_REFINING_RET_F, {
	"ret",
	".cs.S2C_Equipment_Refining.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_REFINING_ID_F, {
	"id",
	".cs.S2C_Equipment_Refining.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_REFINING_ITEM_ID_F, {
	"item_id",
	".cs.S2C_Equipment_Refining.item_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_REFINING_NUM_F, {
	"num",
	".cs.S2C_Equipment_Refining.num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EQUIPMENT_REFINING_ME, {
	"S2C_Equipment_Refining",
	".cs.S2C_Equipment_Refining",
	{},
	{},
	{
		var_0_10.S2C_EQUIPMENT_REFINING_RET_F,
		var_0_10.S2C_EQUIPMENT_REFINING_ID_F,
		var_0_10.S2C_EQUIPMENT_REFINING_ITEM_ID_F,
		var_0_10.S2C_EQUIPMENT_REFINING_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_GLYPH_ID_F, {
	"id",
	".cs.C2S_Equipment_Glyph.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_EQUIPMENT_GLYPH_ME, {
	"C2S_Equipment_Glyph",
	".cs.C2S_Equipment_Glyph",
	{},
	{},
	{
		var_0_10.C2S_EQUIPMENT_GLYPH_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_GLYPH_RET_F, {
	"ret",
	".cs.S2C_Equipment_Glyph.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_GLYPH_ID_F, {
	"id",
	".cs.S2C_Equipment_Glyph.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EQUIPMENT_GLYPH_ME, {
	"S2C_Equipment_Glyph",
	".cs.S2C_Equipment_Glyph",
	{},
	{},
	{
		var_0_10.S2C_EQUIPMENT_GLYPH_RET_F,
		var_0_10.S2C_EQUIPMENT_GLYPH_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_CAST_CAST_TYPE_F, {
	"cast_type",
	".cs.C2S_Equipment_Cast.cast_type",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_CAST_ID_F, {
	"id",
	".cs.C2S_Equipment_Cast.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_CAST_ITEM_ID_F, {
	"item_id",
	".cs.C2S_Equipment_Cast.item_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_CAST_COST_NUM_F, {
	"cost_num",
	".cs.C2S_Equipment_Cast.cost_num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_EQUIPMENT_CAST_ME, {
	"C2S_Equipment_Cast",
	".cs.C2S_Equipment_Cast",
	{},
	{},
	{
		var_0_10.C2S_EQUIPMENT_CAST_CAST_TYPE_F,
		var_0_10.C2S_EQUIPMENT_CAST_ID_F,
		var_0_10.C2S_EQUIPMENT_CAST_ITEM_ID_F,
		var_0_10.C2S_EQUIPMENT_CAST_COST_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_CAST_RET_F, {
	"ret",
	".cs.S2C_Equipment_Cast.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_CAST_CAST_TYPE_F, {
	"cast_type",
	".cs.S2C_Equipment_Cast.cast_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_CAST_ID_F, {
	"id",
	".cs.S2C_Equipment_Cast.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_CAST_CAST_LEVEL_F, {
	"cast_level",
	".cs.S2C_Equipment_Cast.cast_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_CAST_CAST_EXP_F, {
	"cast_exp",
	".cs.S2C_Equipment_Cast.cast_exp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_CAST_ITEM_ID_F, {
	"item_id",
	".cs.S2C_Equipment_Cast.item_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_CAST_COST_NUM_F, {
	"cost_num",
	".cs.S2C_Equipment_Cast.cost_num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EQUIPMENT_CAST_ME, {
	"S2C_Equipment_Cast",
	".cs.S2C_Equipment_Cast",
	{},
	{},
	{
		var_0_10.S2C_EQUIPMENT_CAST_RET_F,
		var_0_10.S2C_EQUIPMENT_CAST_CAST_TYPE_F,
		var_0_10.S2C_EQUIPMENT_CAST_ID_F,
		var_0_10.S2C_EQUIPMENT_CAST_CAST_LEVEL_F,
		var_0_10.S2C_EQUIPMENT_CAST_CAST_EXP_F,
		var_0_10.S2C_EQUIPMENT_CAST_ITEM_ID_F,
		var_0_10.S2C_EQUIPMENT_CAST_COST_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_REFININGONELEVEL_ID_F, {
	"id",
	".cs.C2S_Equipment_RefiningOneLevel.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_REFININGONELEVEL_ADD_F, {
	"add",
	".cs.C2S_Equipment_RefiningOneLevel.add",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_EQUIPMENT_REFININGONELEVEL_ME, {
	"C2S_Equipment_RefiningOneLevel",
	".cs.C2S_Equipment_RefiningOneLevel",
	{},
	{},
	{
		var_0_10.C2S_EQUIPMENT_REFININGONELEVEL_ID_F,
		var_0_10.C2S_EQUIPMENT_REFININGONELEVEL_ADD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_REFININGONELEVEL_RET_F, {
	"ret",
	".cs.S2C_Equipment_RefiningOneLevel.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_REFININGONELEVEL_ID_F, {
	"id",
	".cs.S2C_Equipment_RefiningOneLevel.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_REFININGONELEVEL_ADD_F, {
	"add",
	".cs.S2C_Equipment_RefiningOneLevel.add",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EQUIPMENT_REFININGONELEVEL_ME, {
	"S2C_Equipment_RefiningOneLevel",
	".cs.S2C_Equipment_RefiningOneLevel",
	{},
	{},
	{
		var_0_10.S2C_EQUIPMENT_REFININGONELEVEL_RET_F,
		var_0_10.S2C_EQUIPMENT_REFININGONELEVEL_ID_F,
		var_0_10.S2C_EQUIPMENT_REFININGONELEVEL_ADD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_RESONANCE_UP_ID_F, {
	"id",
	".cs.C2S_Equipment_Resonance_Up.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_RESONANCE_UP_CONSUME_F, {
	"consume",
	".cs.C2S_Equipment_Resonance_Up.consume",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_EQUIPMENT_RESONANCE_UP_ME, {
	"C2S_Equipment_Resonance_Up",
	".cs.C2S_Equipment_Resonance_Up",
	{},
	{},
	{
		var_0_10.C2S_EQUIPMENT_RESONANCE_UP_ID_F,
		var_0_10.C2S_EQUIPMENT_RESONANCE_UP_CONSUME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_RESONANCE_UP_RET_F, {
	"ret",
	".cs.S2C_Equipment_Resonance_Up.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_RESONANCE_UP_ID_F, {
	"id",
	".cs.S2C_Equipment_Resonance_Up.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_RESONANCE_UP_LEVEL_F, {
	"level",
	".cs.S2C_Equipment_Resonance_Up.level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_RESONANCE_UP_EXP_F, {
	"exp",
	".cs.S2C_Equipment_Resonance_Up.exp",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EQUIPMENT_RESONANCE_UP_ME, {
	"S2C_Equipment_Resonance_Up",
	".cs.S2C_Equipment_Resonance_Up",
	{},
	{},
	{
		var_0_10.S2C_EQUIPMENT_RESONANCE_UP_RET_F,
		var_0_10.S2C_EQUIPMENT_RESONANCE_UP_ID_F,
		var_0_10.S2C_EQUIPMENT_RESONANCE_UP_LEVEL_F,
		var_0_10.S2C_EQUIPMENT_RESONANCE_UP_EXP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_MAGICALSTAGE_UP_ID_F, {
	"id",
	".cs.C2S_Equipment_MagicalStage_Up.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_MAGICALSTAGE_UP_TARGET_STAGE_F, {
	"target_stage",
	".cs.C2S_Equipment_MagicalStage_Up.target_stage",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_EQUIPMENT_MAGICALSTAGE_UP_ME, {
	"C2S_Equipment_MagicalStage_Up",
	".cs.C2S_Equipment_MagicalStage_Up",
	{},
	{},
	{
		var_0_10.C2S_EQUIPMENT_MAGICALSTAGE_UP_ID_F,
		var_0_10.C2S_EQUIPMENT_MAGICALSTAGE_UP_TARGET_STAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_MAGICALSTAGE_UP_RET_F, {
	"ret",
	".cs.S2C_Equipment_MagicalStage_Up.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_MAGICALSTAGE_UP_ID_F, {
	"id",
	".cs.S2C_Equipment_MagicalStage_Up.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_MAGICALSTAGE_UP_TARGET_STAGE_F, {
	"target_stage",
	".cs.S2C_Equipment_MagicalStage_Up.target_stage",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EQUIPMENT_MAGICALSTAGE_UP_ME, {
	"S2C_Equipment_MagicalStage_Up",
	".cs.S2C_Equipment_MagicalStage_Up",
	{},
	{},
	{
		var_0_10.S2C_EQUIPMENT_MAGICALSTAGE_UP_RET_F,
		var_0_10.S2C_EQUIPMENT_MAGICALSTAGE_UP_ID_F,
		var_0_10.S2C_EQUIPMENT_MAGICALSTAGE_UP_TARGET_STAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_INHERITFORMATION_POS_F, {
	"pos",
	".cs.C2S_Equipment_InheritFormation.pos",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_EQUIPMENT_INHERITFORMATION_ID_F, {
	"id",
	".cs.C2S_Equipment_InheritFormation.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_EQUIPMENT_INHERITFORMATION_ME, {
	"C2S_Equipment_InheritFormation",
	".cs.C2S_Equipment_InheritFormation",
	{},
	{},
	{
		var_0_10.C2S_EQUIPMENT_INHERITFORMATION_POS_F,
		var_0_10.C2S_EQUIPMENT_INHERITFORMATION_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_INHERITFORMATION_RET_F, {
	"ret",
	".cs.S2C_Equipment_InheritFormation.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_INHERITFORMATION_FORMATION_F, {
	"formation",
	".cs.S2C_Equipment_InheritFormation.formation",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_INHERITFORMATION_POS_F, {
	"pos",
	".cs.S2C_Equipment_InheritFormation.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_INHERITFORMATION_ID_F, {
	"id",
	".cs.S2C_Equipment_InheritFormation.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_EQUIPMENT_INHERITFORMATION_AWARD_F, {
	"award",
	".cs.S2C_Equipment_InheritFormation.award",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_EQUIPMENT_INHERITFORMATION_ME, {
	"S2C_Equipment_InheritFormation",
	".cs.S2C_Equipment_InheritFormation",
	{},
	{},
	{
		var_0_10.S2C_EQUIPMENT_INHERITFORMATION_RET_F,
		var_0_10.S2C_EQUIPMENT_INHERITFORMATION_FORMATION_F,
		var_0_10.S2C_EQUIPMENT_INHERITFORMATION_POS_F,
		var_0_10.S2C_EQUIPMENT_INHERITFORMATION_ID_F,
		var_0_10.S2C_EQUIPMENT_INHERITFORMATION_AWARD_F
	},
	false,
	{}
})

return var_0_10
