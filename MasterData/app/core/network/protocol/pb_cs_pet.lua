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
	C2S_PET_LEVELUP_ME = protobuf.Descriptor(),
	C2S_PET_LEVELUP_ID_F = protobuf.FieldDescriptor(),
	C2S_PET_LEVELUP_ITEM_ID_F = protobuf.FieldDescriptor(),
	C2S_PET_LEVELUP_ITEM_NUM_F = protobuf.FieldDescriptor(),
	S2C_PET_LEVELUP_ME = protobuf.Descriptor(),
	S2C_PET_LEVELUP_RET_F = protobuf.FieldDescriptor(),
	S2C_PET_LEVELUP_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_LEVELUP_ITEM_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_LEVELUP_ITEM_NUM_F = protobuf.FieldDescriptor(),
	C2S_PET_ONEKEY_LEVELUP_ME = protobuf.Descriptor(),
	C2S_PET_ONEKEY_LEVELUP_ID_F = protobuf.FieldDescriptor(),
	C2S_PET_ONEKEY_LEVELUP_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_PET_ONEKEY_LEVELUP_ME = protobuf.Descriptor(),
	S2C_PET_ONEKEY_LEVELUP_RET_F = protobuf.FieldDescriptor(),
	S2C_PET_ONEKEY_LEVELUP_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_ONEKEY_LEVELUP_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_PET_STARUP_ME = protobuf.Descriptor(),
	C2S_PET_STARUP_ID_F = protobuf.FieldDescriptor(),
	C2S_PET_STARUP_COST_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_STARUP_ME = protobuf.Descriptor(),
	S2C_PET_STARUP_RET_F = protobuf.FieldDescriptor(),
	S2C_PET_STARUP_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_STARUP_COST_ID_F = protobuf.FieldDescriptor(),
	C2S_PET_EQUIPMENT_UPGRADE_ME = protobuf.Descriptor(),
	C2S_PET_EQUIPMENT_UPGRADE_ID_F = protobuf.FieldDescriptor(),
	C2S_PET_EQUIPMENT_UPGRADE_CONSUMES_F = protobuf.FieldDescriptor(),
	S2C_PET_EQUIPMENT_UPGRADE_ME = protobuf.Descriptor(),
	S2C_PET_EQUIPMENT_UPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_PET_EQUIPMENT_UPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_EQUIPMENT_UPGRADE_CONSUMES_F = protobuf.FieldDescriptor(),
	C2S_PET_EQUIPMENT_FASTUPGRADE_ME = protobuf.Descriptor(),
	C2S_PET_EQUIPMENT_FASTUPGRADE_POSITIONS_F = protobuf.FieldDescriptor(),
	S2C_PET_EQUIPMENT_FASTUPGRADE_ME = protobuf.Descriptor(),
	S2C_PET_EQUIPMENT_FASTUPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_PET_EQUIPMENT_FASTUPGRADE_POSITIONS_F = protobuf.FieldDescriptor(),
	C2S_PET_EQUIPMENT_LOCK_ME = protobuf.Descriptor(),
	C2S_PET_EQUIPMENT_LOCK_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_EQUIPMENT_LOCK_ME = protobuf.Descriptor(),
	S2C_PET_EQUIPMENT_LOCK_RET_F = protobuf.FieldDescriptor(),
	S2C_PET_EQUIPMENT_LOCK_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_EQUIPMENT_LOCK_LOCKSTATUS_F = protobuf.FieldDescriptor(),
	C2S_PET_UR_HANDBOOKACTIVE_ME = protobuf.Descriptor(),
	C2S_PET_UR_HANDBOOKACTIVE_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_UR_HANDBOOKACTIVE_ME = protobuf.Descriptor(),
	S2C_PET_UR_HANDBOOKACTIVE_RET_F = protobuf.FieldDescriptor(),
	S2C_PET_UR_HANDBOOKACTIVE_ID_F = protobuf.FieldDescriptor(),
	C2S_PET_UR_HANDBOOKUPGRADE_ME = protobuf.Descriptor(),
	C2S_PET_UR_HANDBOOKUPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_UR_HANDBOOKUPGRADE_ME = protobuf.Descriptor(),
	S2C_PET_UR_HANDBOOKUPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_PET_UR_HANDBOOKUPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_UR_HANDBOOKUPGRADE_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_PET_STAGEUP_ME = protobuf.Descriptor(),
	C2S_PET_STAGEUP_ID_F = protobuf.FieldDescriptor(),
	C2S_PET_STAGEUP_NEXT_STAGE_F = protobuf.FieldDescriptor(),
	C2S_PET_STAGEUP_NEXT_NODE_F = protobuf.FieldDescriptor(),
	S2C_PET_STAGEUP_ME = protobuf.Descriptor(),
	S2C_PET_STAGEUP_RET_F = protobuf.FieldDescriptor(),
	S2C_PET_STAGEUP_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_STAGEUP_NEXT_STAGE_F = protobuf.FieldDescriptor(),
	S2C_PET_STAGEUP_NEXT_NODE_F = protobuf.FieldDescriptor(),
	C2S_PET_INHERITFORMATION_ME = protobuf.Descriptor(),
	C2S_PET_INHERITFORMATION_POS_F = protobuf.FieldDescriptor(),
	C2S_PET_INHERITFORMATION_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_INHERITFORMATION_ME = protobuf.Descriptor(),
	S2C_PET_INHERITFORMATION_RET_F = protobuf.FieldDescriptor(),
	S2C_PET_INHERITFORMATION_FORMATION_F = protobuf.FieldDescriptor(),
	S2C_PET_INHERITFORMATION_POS_F = protobuf.FieldDescriptor(),
	S2C_PET_INHERITFORMATION_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_INHERITFORMATION_AWARD_F = protobuf.FieldDescriptor(),
	C2S_PET_HANDBOOKINFO_ME = protobuf.Descriptor(),
	S2C_PET_HANDBOOKINFO_ME = protobuf.Descriptor(),
	S2C_PET_HANDBOOKINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_PET_HANDBOOKINFO_ID_F = protobuf.FieldDescriptor(),
	C2S_PET_HANDBOOKACTIVATE_ME = protobuf.Descriptor(),
	C2S_PET_HANDBOOKACTIVATE_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_HANDBOOKACTIVATE_ME = protobuf.Descriptor(),
	S2C_PET_HANDBOOKACTIVATE_RET_F = protobuf.FieldDescriptor(),
	S2C_PET_HANDBOOKACTIVATE_ID_F = protobuf.FieldDescriptor(),
	C2S_PET_HANDBOOKUPGRADE_ME = protobuf.Descriptor(),
	C2S_PET_HANDBOOKUPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_HANDBOOKUPGRADE_ME = protobuf.Descriptor(),
	S2C_PET_HANDBOOKUPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_PET_HANDBOOKUPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_PET_HANDBOOKUPGRADE_NEW_ID_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_LEVELUP_ID_F, {
	"id",
	".cs.C2S_Pet_LevelUp.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_LEVELUP_ITEM_ID_F, {
	"item_id",
	".cs.C2S_Pet_LevelUp.item_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_LEVELUP_ITEM_NUM_F, {
	"item_num",
	".cs.C2S_Pet_LevelUp.item_num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PET_LEVELUP_ME, {
	"C2S_Pet_LevelUp",
	".cs.C2S_Pet_LevelUp",
	{},
	{},
	{
		var_0_10.C2S_PET_LEVELUP_ID_F,
		var_0_10.C2S_PET_LEVELUP_ITEM_ID_F,
		var_0_10.C2S_PET_LEVELUP_ITEM_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_LEVELUP_RET_F, {
	"ret",
	".cs.S2C_Pet_LevelUp.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_LEVELUP_ID_F, {
	"id",
	".cs.S2C_Pet_LevelUp.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_LEVELUP_ITEM_ID_F, {
	"item_id",
	".cs.S2C_Pet_LevelUp.item_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_LEVELUP_ITEM_NUM_F, {
	"item_num",
	".cs.S2C_Pet_LevelUp.item_num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PET_LEVELUP_ME, {
	"S2C_Pet_LevelUp",
	".cs.S2C_Pet_LevelUp",
	{},
	{},
	{
		var_0_10.S2C_PET_LEVELUP_RET_F,
		var_0_10.S2C_PET_LEVELUP_ID_F,
		var_0_10.S2C_PET_LEVELUP_ITEM_ID_F,
		var_0_10.S2C_PET_LEVELUP_ITEM_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_ONEKEY_LEVELUP_ID_F, {
	"id",
	".cs.C2S_Pet_OneKey_LevelUp.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_ONEKEY_LEVELUP_LEVEL_F, {
	"level",
	".cs.C2S_Pet_OneKey_LevelUp.level",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PET_ONEKEY_LEVELUP_ME, {
	"C2S_Pet_OneKey_LevelUp",
	".cs.C2S_Pet_OneKey_LevelUp",
	{},
	{},
	{
		var_0_10.C2S_PET_ONEKEY_LEVELUP_ID_F,
		var_0_10.C2S_PET_ONEKEY_LEVELUP_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_ONEKEY_LEVELUP_RET_F, {
	"ret",
	".cs.S2C_Pet_OneKey_LevelUp.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_ONEKEY_LEVELUP_ID_F, {
	"id",
	".cs.S2C_Pet_OneKey_LevelUp.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_ONEKEY_LEVELUP_LEVEL_F, {
	"level",
	".cs.S2C_Pet_OneKey_LevelUp.level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PET_ONEKEY_LEVELUP_ME, {
	"S2C_Pet_OneKey_LevelUp",
	".cs.S2C_Pet_OneKey_LevelUp",
	{},
	{},
	{
		var_0_10.S2C_PET_ONEKEY_LEVELUP_RET_F,
		var_0_10.S2C_PET_ONEKEY_LEVELUP_ID_F,
		var_0_10.S2C_PET_ONEKEY_LEVELUP_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_STARUP_ID_F, {
	"id",
	".cs.C2S_Pet_StarUp.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_STARUP_COST_ID_F, {
	"cost_id",
	".cs.C2S_Pet_StarUp.cost_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PET_STARUP_ME, {
	"C2S_Pet_StarUp",
	".cs.C2S_Pet_StarUp",
	{},
	{},
	{
		var_0_10.C2S_PET_STARUP_ID_F,
		var_0_10.C2S_PET_STARUP_COST_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_STARUP_RET_F, {
	"ret",
	".cs.S2C_Pet_StarUp.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_STARUP_ID_F, {
	"id",
	".cs.S2C_Pet_StarUp.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_STARUP_COST_ID_F, {
	"cost_id",
	".cs.S2C_Pet_StarUp.cost_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PET_STARUP_ME, {
	"S2C_Pet_StarUp",
	".cs.S2C_Pet_StarUp",
	{},
	{},
	{
		var_0_10.S2C_PET_STARUP_RET_F,
		var_0_10.S2C_PET_STARUP_ID_F,
		var_0_10.S2C_PET_STARUP_COST_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_EQUIPMENT_UPGRADE_ID_F, {
	"id",
	".cs.C2S_Pet_Equipment_Upgrade.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_EQUIPMENT_UPGRADE_CONSUMES_F, {
	"consumes",
	".cs.C2S_Pet_Equipment_Upgrade.consumes",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PET_EQUIPMENT_UPGRADE_ME, {
	"C2S_Pet_Equipment_Upgrade",
	".cs.C2S_Pet_Equipment_Upgrade",
	{},
	{},
	{
		var_0_10.C2S_PET_EQUIPMENT_UPGRADE_ID_F,
		var_0_10.C2S_PET_EQUIPMENT_UPGRADE_CONSUMES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_EQUIPMENT_UPGRADE_RET_F, {
	"ret",
	".cs.S2C_Pet_Equipment_Upgrade.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_EQUIPMENT_UPGRADE_ID_F, {
	"id",
	".cs.S2C_Pet_Equipment_Upgrade.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_EQUIPMENT_UPGRADE_CONSUMES_F, {
	"consumes",
	".cs.S2C_Pet_Equipment_Upgrade.consumes",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PET_EQUIPMENT_UPGRADE_ME, {
	"S2C_Pet_Equipment_Upgrade",
	".cs.S2C_Pet_Equipment_Upgrade",
	{},
	{},
	{
		var_0_10.S2C_PET_EQUIPMENT_UPGRADE_RET_F,
		var_0_10.S2C_PET_EQUIPMENT_UPGRADE_ID_F,
		var_0_10.S2C_PET_EQUIPMENT_UPGRADE_CONSUMES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_EQUIPMENT_FASTUPGRADE_POSITIONS_F, {
	"positions",
	".cs.C2S_Pet_Equipment_FastUpgrade.positions",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PET_EQUIPMENT_FASTUPGRADE_ME, {
	"C2S_Pet_Equipment_FastUpgrade",
	".cs.C2S_Pet_Equipment_FastUpgrade",
	{},
	{},
	{
		var_0_10.C2S_PET_EQUIPMENT_FASTUPGRADE_POSITIONS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_EQUIPMENT_FASTUPGRADE_RET_F, {
	"ret",
	".cs.S2C_Pet_Equipment_FastUpgrade.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_EQUIPMENT_FASTUPGRADE_POSITIONS_F, {
	"positions",
	".cs.S2C_Pet_Equipment_FastUpgrade.positions",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PET_EQUIPMENT_FASTUPGRADE_ME, {
	"S2C_Pet_Equipment_FastUpgrade",
	".cs.S2C_Pet_Equipment_FastUpgrade",
	{},
	{},
	{
		var_0_10.S2C_PET_EQUIPMENT_FASTUPGRADE_RET_F,
		var_0_10.S2C_PET_EQUIPMENT_FASTUPGRADE_POSITIONS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_EQUIPMENT_LOCK_ID_F, {
	"id",
	".cs.C2S_Pet_Equipment_Lock.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PET_EQUIPMENT_LOCK_ME, {
	"C2S_Pet_Equipment_Lock",
	".cs.C2S_Pet_Equipment_Lock",
	{},
	{},
	{
		var_0_10.C2S_PET_EQUIPMENT_LOCK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_EQUIPMENT_LOCK_RET_F, {
	"ret",
	".cs.S2C_Pet_Equipment_Lock.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_EQUIPMENT_LOCK_ID_F, {
	"id",
	".cs.S2C_Pet_Equipment_Lock.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_EQUIPMENT_LOCK_LOCKSTATUS_F, {
	"lockStatus",
	".cs.S2C_Pet_Equipment_Lock.lockStatus",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PET_EQUIPMENT_LOCK_ME, {
	"S2C_Pet_Equipment_Lock",
	".cs.S2C_Pet_Equipment_Lock",
	{},
	{},
	{
		var_0_10.S2C_PET_EQUIPMENT_LOCK_RET_F,
		var_0_10.S2C_PET_EQUIPMENT_LOCK_ID_F,
		var_0_10.S2C_PET_EQUIPMENT_LOCK_LOCKSTATUS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_UR_HANDBOOKACTIVE_ID_F, {
	"id",
	".cs.C2S_Pet_UR_HandbookActive.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PET_UR_HANDBOOKACTIVE_ME, {
	"C2S_Pet_UR_HandbookActive",
	".cs.C2S_Pet_UR_HandbookActive",
	{},
	{},
	{
		var_0_10.C2S_PET_UR_HANDBOOKACTIVE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_UR_HANDBOOKACTIVE_RET_F, {
	"ret",
	".cs.S2C_Pet_UR_HandbookActive.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_UR_HANDBOOKACTIVE_ID_F, {
	"id",
	".cs.S2C_Pet_UR_HandbookActive.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PET_UR_HANDBOOKACTIVE_ME, {
	"S2C_Pet_UR_HandbookActive",
	".cs.S2C_Pet_UR_HandbookActive",
	{},
	{},
	{
		var_0_10.S2C_PET_UR_HANDBOOKACTIVE_RET_F,
		var_0_10.S2C_PET_UR_HANDBOOKACTIVE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_UR_HANDBOOKUPGRADE_ID_F, {
	"id",
	".cs.C2S_Pet_UR_HandbookUpgrade.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PET_UR_HANDBOOKUPGRADE_ME, {
	"C2S_Pet_UR_HandbookUpgrade",
	".cs.C2S_Pet_UR_HandbookUpgrade",
	{},
	{},
	{
		var_0_10.C2S_PET_UR_HANDBOOKUPGRADE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_UR_HANDBOOKUPGRADE_RET_F, {
	"ret",
	".cs.S2C_Pet_UR_HandbookUpgrade.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_UR_HANDBOOKUPGRADE_ID_F, {
	"id",
	".cs.S2C_Pet_UR_HandbookUpgrade.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_UR_HANDBOOKUPGRADE_LEVEL_F, {
	"level",
	".cs.S2C_Pet_UR_HandbookUpgrade.level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PET_UR_HANDBOOKUPGRADE_ME, {
	"S2C_Pet_UR_HandbookUpgrade",
	".cs.S2C_Pet_UR_HandbookUpgrade",
	{},
	{},
	{
		var_0_10.S2C_PET_UR_HANDBOOKUPGRADE_RET_F,
		var_0_10.S2C_PET_UR_HANDBOOKUPGRADE_ID_F,
		var_0_10.S2C_PET_UR_HANDBOOKUPGRADE_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_STAGEUP_ID_F, {
	"id",
	".cs.C2S_Pet_StageUp.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_STAGEUP_NEXT_STAGE_F, {
	"next_stage",
	".cs.C2S_Pet_StageUp.next_stage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_STAGEUP_NEXT_NODE_F, {
	"next_node",
	".cs.C2S_Pet_StageUp.next_node",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PET_STAGEUP_ME, {
	"C2S_Pet_StageUp",
	".cs.C2S_Pet_StageUp",
	{},
	{},
	{
		var_0_10.C2S_PET_STAGEUP_ID_F,
		var_0_10.C2S_PET_STAGEUP_NEXT_STAGE_F,
		var_0_10.C2S_PET_STAGEUP_NEXT_NODE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_STAGEUP_RET_F, {
	"ret",
	".cs.S2C_Pet_StageUp.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_STAGEUP_ID_F, {
	"id",
	".cs.S2C_Pet_StageUp.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_STAGEUP_NEXT_STAGE_F, {
	"next_stage",
	".cs.S2C_Pet_StageUp.next_stage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_STAGEUP_NEXT_NODE_F, {
	"next_node",
	".cs.S2C_Pet_StageUp.next_node",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PET_STAGEUP_ME, {
	"S2C_Pet_StageUp",
	".cs.S2C_Pet_StageUp",
	{},
	{},
	{
		var_0_10.S2C_PET_STAGEUP_RET_F,
		var_0_10.S2C_PET_STAGEUP_ID_F,
		var_0_10.S2C_PET_STAGEUP_NEXT_STAGE_F,
		var_0_10.S2C_PET_STAGEUP_NEXT_NODE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_INHERITFORMATION_POS_F, {
	"pos",
	".cs.C2S_Pet_InheritFormation.pos",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_INHERITFORMATION_ID_F, {
	"id",
	".cs.C2S_Pet_InheritFormation.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PET_INHERITFORMATION_ME, {
	"C2S_Pet_InheritFormation",
	".cs.C2S_Pet_InheritFormation",
	{},
	{},
	{
		var_0_10.C2S_PET_INHERITFORMATION_POS_F,
		var_0_10.C2S_PET_INHERITFORMATION_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_INHERITFORMATION_RET_F, {
	"ret",
	".cs.S2C_Pet_InheritFormation.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_INHERITFORMATION_FORMATION_F, {
	"formation",
	".cs.S2C_Pet_InheritFormation.formation",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_INHERITFORMATION_POS_F, {
	"pos",
	".cs.S2C_Pet_InheritFormation.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_INHERITFORMATION_ID_F, {
	"id",
	".cs.S2C_Pet_InheritFormation.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_INHERITFORMATION_AWARD_F, {
	"award",
	".cs.S2C_Pet_InheritFormation.award",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PET_INHERITFORMATION_ME, {
	"S2C_Pet_InheritFormation",
	".cs.S2C_Pet_InheritFormation",
	{},
	{},
	{
		var_0_10.S2C_PET_INHERITFORMATION_RET_F,
		var_0_10.S2C_PET_INHERITFORMATION_FORMATION_F,
		var_0_10.S2C_PET_INHERITFORMATION_POS_F,
		var_0_10.S2C_PET_INHERITFORMATION_ID_F,
		var_0_10.S2C_PET_INHERITFORMATION_AWARD_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PET_HANDBOOKINFO_ME, {
	"C2S_Pet_HandbookInfo",
	".cs.C2S_Pet_HandbookInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_HANDBOOKINFO_RET_F, {
	"ret",
	".cs.S2C_Pet_HandbookInfo.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_HANDBOOKINFO_ID_F, {
	"id",
	".cs.S2C_Pet_HandbookInfo.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PET_HANDBOOKINFO_ME, {
	"S2C_Pet_HandbookInfo",
	".cs.S2C_Pet_HandbookInfo",
	{},
	{},
	{
		var_0_10.S2C_PET_HANDBOOKINFO_RET_F,
		var_0_10.S2C_PET_HANDBOOKINFO_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_HANDBOOKACTIVATE_ID_F, {
	"id",
	".cs.C2S_Pet_HandbookActivate.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PET_HANDBOOKACTIVATE_ME, {
	"C2S_Pet_HandbookActivate",
	".cs.C2S_Pet_HandbookActivate",
	{},
	{},
	{
		var_0_10.C2S_PET_HANDBOOKACTIVATE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_HANDBOOKACTIVATE_RET_F, {
	"ret",
	".cs.S2C_Pet_HandbookActivate.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_HANDBOOKACTIVATE_ID_F, {
	"id",
	".cs.S2C_Pet_HandbookActivate.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PET_HANDBOOKACTIVATE_ME, {
	"S2C_Pet_HandbookActivate",
	".cs.S2C_Pet_HandbookActivate",
	{},
	{},
	{
		var_0_10.S2C_PET_HANDBOOKACTIVATE_RET_F,
		var_0_10.S2C_PET_HANDBOOKACTIVATE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PET_HANDBOOKUPGRADE_ID_F, {
	"id",
	".cs.C2S_Pet_HandbookUpgrade.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_PET_HANDBOOKUPGRADE_ME, {
	"C2S_Pet_HandbookUpgrade",
	".cs.C2S_Pet_HandbookUpgrade",
	{},
	{},
	{
		var_0_10.C2S_PET_HANDBOOKUPGRADE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_HANDBOOKUPGRADE_RET_F, {
	"ret",
	".cs.S2C_Pet_HandbookUpgrade.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_HANDBOOKUPGRADE_ID_F, {
	"id",
	".cs.S2C_Pet_HandbookUpgrade.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PET_HANDBOOKUPGRADE_NEW_ID_F, {
	"new_id",
	".cs.S2C_Pet_HandbookUpgrade.new_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PET_HANDBOOKUPGRADE_ME, {
	"S2C_Pet_HandbookUpgrade",
	".cs.S2C_Pet_HandbookUpgrade",
	{},
	{},
	{
		var_0_10.S2C_PET_HANDBOOKUPGRADE_RET_F,
		var_0_10.S2C_PET_HANDBOOKUPGRADE_ID_F,
		var_0_10.S2C_PET_HANDBOOKUPGRADE_NEW_ID_F
	},
	false,
	{}
})

return var_0_10
