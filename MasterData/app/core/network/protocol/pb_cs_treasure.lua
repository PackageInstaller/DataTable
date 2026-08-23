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
	C2S_TREASURE_UPGRADE_ME = protobuf.Descriptor(),
	C2S_TREASURE_UPGRADE_ID_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_UPGRADE_CONSUME_LIST_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_UPGRADE_ME = protobuf.Descriptor(),
	S2C_TREASURE_UPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_UPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_UPGRADE_CONSUME_LIST_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_UPGRADE_ONELEVEL_ME = protobuf.Descriptor(),
	C2S_TREASURE_UPGRADE_ONELEVEL_ID_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_UPGRADE_ONELEVEL_COST_RED_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_UPGRADE_ONELEVEL_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_UPGRADE_ONELEVEL_ME = protobuf.Descriptor(),
	S2C_TREASURE_UPGRADE_ONELEVEL_RET_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_UPGRADE_ONELEVEL_ID_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_UPGRADE_ONELEVEL_COST_RED_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_UPGRADE_ONELEVEL_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_REFINING_ME = protobuf.Descriptor(),
	C2S_TREASURE_REFINING_ID_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_REFINING_CONSUME_LIST_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_REFINING_ME = protobuf.Descriptor(),
	S2C_TREASURE_REFINING_RET_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_REFINING_ID_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_REFINING_CONSUME_LIST_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_GLYPH_ME = protobuf.Descriptor(),
	C2S_TREASURE_GLYPH_ID_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_GLYPH_ME = protobuf.Descriptor(),
	S2C_TREASURE_GLYPH_RET_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_GLYPH_ID_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_GOLDEN_ME = protobuf.Descriptor(),
	C2S_TREASURE_GOLDEN_ID_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_GOLDEN_ME = protobuf.Descriptor(),
	S2C_TREASURE_GOLDEN_RET_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_GOLDEN_ID_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_GOLDEN_BASE_ID_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_LUCK_ME = protobuf.Descriptor(),
	C2S_TREASURE_LUCK_IDS_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_LUCK_ME = protobuf.Descriptor(),
	S2C_TREASURE_LUCK_RET_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_LUCK_IDS_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_PURIFY_ME = protobuf.Descriptor(),
	C2S_TREASURE_PURIFY_ID_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_PURIFY_LOCK_CONSUME_TYPE_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_PURIFY_CONSUME_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_PURIFY_ME = protobuf.Descriptor(),
	S2C_TREASURE_PURIFY_RET_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_PURIFY_ID_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_PURIFY_CONSUME_TYPE_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_PURIFY_PURIFY_COUNT_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_PURIFY_HOLES_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_PURIFY_REPLACE_ME = protobuf.Descriptor(),
	C2S_TREASURE_PURIFY_REPLACE_ID_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_PURIFY_REPLACE_REPLACE_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_PURIFY_REPLACE_ME = protobuf.Descriptor(),
	S2C_TREASURE_PURIFY_REPLACE_RET_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_PURIFY_REPLACE_ID_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_PURIFY_REPLACE_HOLES_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_PURIFY_LOCK_ME = protobuf.Descriptor(),
	C2S_TREASURE_PURIFY_LOCK_ID_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_PURIFY_LOCK_POS_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_PURIFY_LOCK_LOCK_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_PURIFY_LOCK_ME = protobuf.Descriptor(),
	S2C_TREASURE_PURIFY_LOCK_RET_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_PURIFY_LOCK_ID_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_PURIFY_LOCK_POS_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_PURIFY_LOCK_LOCK_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_INHERITFORMATION_ME = protobuf.Descriptor(),
	C2S_TREASURE_INHERITFORMATION_POS_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_INHERITFORMATION_ID_F = protobuf.FieldDescriptor(),
	C2S_TREASURE_INHERITFORMATION_CHANGE_PURIFY_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_INHERITFORMATION_ME = protobuf.Descriptor(),
	S2C_TREASURE_INHERITFORMATION_RET_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_INHERITFORMATION_FORMATION_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_INHERITFORMATION_POS_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_INHERITFORMATION_ID_F = protobuf.FieldDescriptor(),
	S2C_TREASURE_INHERITFORMATION_AWARD_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_UPGRADE_ID_F, {
	"id",
	".cs.C2S_Treasure_Upgrade.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_UPGRADE_CONSUME_LIST_F, {
	"consume_list",
	".cs.C2S_Treasure_Upgrade.consume_list",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TREASURE_UPGRADE_ME, {
	"C2S_Treasure_Upgrade",
	".cs.C2S_Treasure_Upgrade",
	{},
	{},
	{
		var_0_10.C2S_TREASURE_UPGRADE_ID_F,
		var_0_10.C2S_TREASURE_UPGRADE_CONSUME_LIST_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_UPGRADE_RET_F, {
	"ret",
	".cs.S2C_Treasure_Upgrade.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_UPGRADE_ID_F, {
	"id",
	".cs.S2C_Treasure_Upgrade.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_UPGRADE_CONSUME_LIST_F, {
	"consume_list",
	".cs.S2C_Treasure_Upgrade.consume_list",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TREASURE_UPGRADE_ME, {
	"S2C_Treasure_Upgrade",
	".cs.S2C_Treasure_Upgrade",
	{},
	{},
	{
		var_0_10.S2C_TREASURE_UPGRADE_RET_F,
		var_0_10.S2C_TREASURE_UPGRADE_ID_F,
		var_0_10.S2C_TREASURE_UPGRADE_CONSUME_LIST_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_UPGRADE_ONELEVEL_ID_F, {
	"id",
	".cs.C2S_Treasure_Upgrade_OneLevel.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_UPGRADE_ONELEVEL_COST_RED_F, {
	"cost_red",
	".cs.C2S_Treasure_Upgrade_OneLevel.cost_red",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_UPGRADE_ONELEVEL_LEVEL_F, {
	"level",
	".cs.C2S_Treasure_Upgrade_OneLevel.level",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TREASURE_UPGRADE_ONELEVEL_ME, {
	"C2S_Treasure_Upgrade_OneLevel",
	".cs.C2S_Treasure_Upgrade_OneLevel",
	{},
	{},
	{
		var_0_10.C2S_TREASURE_UPGRADE_ONELEVEL_ID_F,
		var_0_10.C2S_TREASURE_UPGRADE_ONELEVEL_COST_RED_F,
		var_0_10.C2S_TREASURE_UPGRADE_ONELEVEL_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_UPGRADE_ONELEVEL_RET_F, {
	"ret",
	".cs.S2C_Treasure_Upgrade_OneLevel.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_UPGRADE_ONELEVEL_ID_F, {
	"id",
	".cs.S2C_Treasure_Upgrade_OneLevel.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_UPGRADE_ONELEVEL_COST_RED_F, {
	"cost_red",
	".cs.S2C_Treasure_Upgrade_OneLevel.cost_red",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_UPGRADE_ONELEVEL_LEVEL_F, {
	"level",
	".cs.S2C_Treasure_Upgrade_OneLevel.level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TREASURE_UPGRADE_ONELEVEL_ME, {
	"S2C_Treasure_Upgrade_OneLevel",
	".cs.S2C_Treasure_Upgrade_OneLevel",
	{},
	{},
	{
		var_0_10.S2C_TREASURE_UPGRADE_ONELEVEL_RET_F,
		var_0_10.S2C_TREASURE_UPGRADE_ONELEVEL_ID_F,
		var_0_10.S2C_TREASURE_UPGRADE_ONELEVEL_COST_RED_F,
		var_0_10.S2C_TREASURE_UPGRADE_ONELEVEL_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_REFINING_ID_F, {
	"id",
	".cs.C2S_Treasure_Refining.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_REFINING_CONSUME_LIST_F, {
	"consume_list",
	".cs.C2S_Treasure_Refining.consume_list",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TREASURE_REFINING_ME, {
	"C2S_Treasure_Refining",
	".cs.C2S_Treasure_Refining",
	{},
	{},
	{
		var_0_10.C2S_TREASURE_REFINING_ID_F,
		var_0_10.C2S_TREASURE_REFINING_CONSUME_LIST_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_REFINING_RET_F, {
	"ret",
	".cs.S2C_Treasure_Refining.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_REFINING_ID_F, {
	"id",
	".cs.S2C_Treasure_Refining.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_REFINING_CONSUME_LIST_F, {
	"consume_list",
	".cs.S2C_Treasure_Refining.consume_list",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TREASURE_REFINING_ME, {
	"S2C_Treasure_Refining",
	".cs.S2C_Treasure_Refining",
	{},
	{},
	{
		var_0_10.S2C_TREASURE_REFINING_RET_F,
		var_0_10.S2C_TREASURE_REFINING_ID_F,
		var_0_10.S2C_TREASURE_REFINING_CONSUME_LIST_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_GLYPH_ID_F, {
	"id",
	".cs.C2S_Treasure_Glyph.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TREASURE_GLYPH_ME, {
	"C2S_Treasure_Glyph",
	".cs.C2S_Treasure_Glyph",
	{},
	{},
	{
		var_0_10.C2S_TREASURE_GLYPH_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_GLYPH_RET_F, {
	"ret",
	".cs.S2C_Treasure_Glyph.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_GLYPH_ID_F, {
	"id",
	".cs.S2C_Treasure_Glyph.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TREASURE_GLYPH_ME, {
	"S2C_Treasure_Glyph",
	".cs.S2C_Treasure_Glyph",
	{},
	{},
	{
		var_0_10.S2C_TREASURE_GLYPH_RET_F,
		var_0_10.S2C_TREASURE_GLYPH_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_GOLDEN_ID_F, {
	"id",
	".cs.C2S_Treasure_Golden.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TREASURE_GOLDEN_ME, {
	"C2S_Treasure_Golden",
	".cs.C2S_Treasure_Golden",
	{},
	{},
	{
		var_0_10.C2S_TREASURE_GOLDEN_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_GOLDEN_RET_F, {
	"ret",
	".cs.S2C_Treasure_Golden.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_GOLDEN_ID_F, {
	"id",
	".cs.S2C_Treasure_Golden.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_GOLDEN_BASE_ID_F, {
	"base_id",
	".cs.S2C_Treasure_Golden.base_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TREASURE_GOLDEN_ME, {
	"S2C_Treasure_Golden",
	".cs.S2C_Treasure_Golden",
	{},
	{},
	{
		var_0_10.S2C_TREASURE_GOLDEN_RET_F,
		var_0_10.S2C_TREASURE_GOLDEN_ID_F,
		var_0_10.S2C_TREASURE_GOLDEN_BASE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_LUCK_IDS_F, {
	"ids",
	".cs.C2S_Treasure_Luck.ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TREASURE_LUCK_ME, {
	"C2S_Treasure_Luck",
	".cs.C2S_Treasure_Luck",
	{},
	{},
	{
		var_0_10.C2S_TREASURE_LUCK_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_LUCK_RET_F, {
	"ret",
	".cs.S2C_Treasure_Luck.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_LUCK_IDS_F, {
	"ids",
	".cs.S2C_Treasure_Luck.ids",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TREASURE_LUCK_ME, {
	"S2C_Treasure_Luck",
	".cs.S2C_Treasure_Luck",
	{},
	{},
	{
		var_0_10.S2C_TREASURE_LUCK_RET_F,
		var_0_10.S2C_TREASURE_LUCK_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_PURIFY_ID_F, {
	"id",
	".cs.C2S_Treasure_Purify.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_PURIFY_LOCK_CONSUME_TYPE_F, {
	"lock_consume_type",
	".cs.C2S_Treasure_Purify.lock_consume_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_PURIFY_CONSUME_TYPE_F, {
	"consume_type",
	".cs.C2S_Treasure_Purify.consume_type",
	4,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_TREASURE_PURIFY_ME, {
	"C2S_Treasure_Purify",
	".cs.C2S_Treasure_Purify",
	{},
	{},
	{
		var_0_10.C2S_TREASURE_PURIFY_ID_F,
		var_0_10.C2S_TREASURE_PURIFY_LOCK_CONSUME_TYPE_F,
		var_0_10.C2S_TREASURE_PURIFY_CONSUME_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_PURIFY_RET_F, {
	"ret",
	".cs.S2C_Treasure_Purify.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_PURIFY_ID_F, {
	"id",
	".cs.S2C_Treasure_Purify.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_PURIFY_CONSUME_TYPE_F, {
	"consume_type",
	".cs.S2C_Treasure_Purify.consume_type",
	4,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_PURIFY_PURIFY_COUNT_F, {
	"purify_count",
	".cs.S2C_Treasure_Purify.purify_count",
	5,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_PURIFY_HOLES_F, {
	"holes",
	".cs.S2C_Treasure_Purify.holes",
	6,
	4,
	3,
	false,
	{},
	var_0_3.TREASUREHOLE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TREASURE_PURIFY_ME, {
	"S2C_Treasure_Purify",
	".cs.S2C_Treasure_Purify",
	{},
	{},
	{
		var_0_10.S2C_TREASURE_PURIFY_RET_F,
		var_0_10.S2C_TREASURE_PURIFY_ID_F,
		var_0_10.S2C_TREASURE_PURIFY_CONSUME_TYPE_F,
		var_0_10.S2C_TREASURE_PURIFY_PURIFY_COUNT_F,
		var_0_10.S2C_TREASURE_PURIFY_HOLES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_PURIFY_REPLACE_ID_F, {
	"id",
	".cs.C2S_Treasure_Purify_Replace.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_PURIFY_REPLACE_REPLACE_F, {
	"replace",
	".cs.C2S_Treasure_Purify_Replace.replace",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TREASURE_PURIFY_REPLACE_ME, {
	"C2S_Treasure_Purify_Replace",
	".cs.C2S_Treasure_Purify_Replace",
	{},
	{},
	{
		var_0_10.C2S_TREASURE_PURIFY_REPLACE_ID_F,
		var_0_10.C2S_TREASURE_PURIFY_REPLACE_REPLACE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_PURIFY_REPLACE_RET_F, {
	"ret",
	".cs.S2C_Treasure_Purify_Replace.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_PURIFY_REPLACE_ID_F, {
	"id",
	".cs.S2C_Treasure_Purify_Replace.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_PURIFY_REPLACE_HOLES_F, {
	"holes",
	".cs.S2C_Treasure_Purify_Replace.holes",
	3,
	2,
	3,
	false,
	{},
	var_0_3.TREASUREHOLE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TREASURE_PURIFY_REPLACE_ME, {
	"S2C_Treasure_Purify_Replace",
	".cs.S2C_Treasure_Purify_Replace",
	{},
	{},
	{
		var_0_10.S2C_TREASURE_PURIFY_REPLACE_RET_F,
		var_0_10.S2C_TREASURE_PURIFY_REPLACE_ID_F,
		var_0_10.S2C_TREASURE_PURIFY_REPLACE_HOLES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_PURIFY_LOCK_ID_F, {
	"id",
	".cs.C2S_Treasure_Purify_Lock.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_PURIFY_LOCK_POS_F, {
	"pos",
	".cs.C2S_Treasure_Purify_Lock.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_PURIFY_LOCK_LOCK_F, {
	"lock",
	".cs.C2S_Treasure_Purify_Lock.lock",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TREASURE_PURIFY_LOCK_ME, {
	"C2S_Treasure_Purify_Lock",
	".cs.C2S_Treasure_Purify_Lock",
	{},
	{},
	{
		var_0_10.C2S_TREASURE_PURIFY_LOCK_ID_F,
		var_0_10.C2S_TREASURE_PURIFY_LOCK_POS_F,
		var_0_10.C2S_TREASURE_PURIFY_LOCK_LOCK_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_PURIFY_LOCK_RET_F, {
	"ret",
	".cs.S2C_Treasure_Purify_Lock.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_PURIFY_LOCK_ID_F, {
	"id",
	".cs.S2C_Treasure_Purify_Lock.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_PURIFY_LOCK_POS_F, {
	"pos",
	".cs.S2C_Treasure_Purify_Lock.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_PURIFY_LOCK_LOCK_F, {
	"lock",
	".cs.S2C_Treasure_Purify_Lock.lock",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TREASURE_PURIFY_LOCK_ME, {
	"S2C_Treasure_Purify_Lock",
	".cs.S2C_Treasure_Purify_Lock",
	{},
	{},
	{
		var_0_10.S2C_TREASURE_PURIFY_LOCK_RET_F,
		var_0_10.S2C_TREASURE_PURIFY_LOCK_ID_F,
		var_0_10.S2C_TREASURE_PURIFY_LOCK_POS_F,
		var_0_10.S2C_TREASURE_PURIFY_LOCK_LOCK_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_INHERITFORMATION_POS_F, {
	"pos",
	".cs.C2S_Treasure_InheritFormation.pos",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_INHERITFORMATION_ID_F, {
	"id",
	".cs.C2S_Treasure_InheritFormation.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREASURE_INHERITFORMATION_CHANGE_PURIFY_F, {
	"change_purify",
	".cs.C2S_Treasure_InheritFormation.change_purify",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TREASURE_INHERITFORMATION_ME, {
	"C2S_Treasure_InheritFormation",
	".cs.C2S_Treasure_InheritFormation",
	{},
	{},
	{
		var_0_10.C2S_TREASURE_INHERITFORMATION_POS_F,
		var_0_10.C2S_TREASURE_INHERITFORMATION_ID_F,
		var_0_10.C2S_TREASURE_INHERITFORMATION_CHANGE_PURIFY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_INHERITFORMATION_RET_F, {
	"ret",
	".cs.S2C_Treasure_InheritFormation.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_INHERITFORMATION_FORMATION_F, {
	"formation",
	".cs.S2C_Treasure_InheritFormation.formation",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_INHERITFORMATION_POS_F, {
	"pos",
	".cs.S2C_Treasure_InheritFormation.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_INHERITFORMATION_ID_F, {
	"id",
	".cs.S2C_Treasure_InheritFormation.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREASURE_INHERITFORMATION_AWARD_F, {
	"award",
	".cs.S2C_Treasure_InheritFormation.award",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TREASURE_INHERITFORMATION_ME, {
	"S2C_Treasure_InheritFormation",
	".cs.S2C_Treasure_InheritFormation",
	{},
	{},
	{
		var_0_10.S2C_TREASURE_INHERITFORMATION_RET_F,
		var_0_10.S2C_TREASURE_INHERITFORMATION_FORMATION_F,
		var_0_10.S2C_TREASURE_INHERITFORMATION_POS_F,
		var_0_10.S2C_TREASURE_INHERITFORMATION_ID_F,
		var_0_10.S2C_TREASURE_INHERITFORMATION_AWARD_F
	},
	false,
	{}
})

return var_0_10
