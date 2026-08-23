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
	C2S_FORMATION_CHANGEPOSITION_ME = protobuf.Descriptor(),
	C2S_FORMATION_CHANGEPOSITION_POSITION_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_CHANGEPOSITION_ME = protobuf.Descriptor(),
	S2C_FORMATION_CHANGEPOSITION_RET_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_CHANGEPOSITION_FORMATION_F = protobuf.FieldDescriptor(),
	C2S_FORMATION_CHANGEFORMATION_ME = protobuf.Descriptor(),
	C2S_FORMATION_CHANGEFORMATION_TP_F = protobuf.FieldDescriptor(),
	C2S_FORMATION_CHANGEFORMATION_POS_F = protobuf.FieldDescriptor(),
	C2S_FORMATION_CHANGEFORMATION_ID_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_CHANGEFORMATION_ME = protobuf.Descriptor(),
	S2C_FORMATION_CHANGEFORMATION_RET_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_CHANGEFORMATION_FORMATION_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_CHANGEFORMATION_TP_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_CHANGEFORMATION_POS_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_CHANGEFORMATION_ID_F = protobuf.FieldDescriptor(),
	C2S_FORMATION_MODIFYNAME_ME = protobuf.Descriptor(),
	C2S_FORMATION_MODIFYNAME_NAME_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_MODIFYNAME_ME = protobuf.Descriptor(),
	S2C_FORMATION_MODIFYNAME_RET_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_MODIFYNAME_NAME_F = protobuf.FieldDescriptor(),
	C2S_FORMATION_SAVE_ME = protobuf.Descriptor(),
	C2S_FORMATION_SAVE_TP_F = protobuf.FieldDescriptor(),
	C2S_FORMATION_SAVE_FORMATIONS_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_SAVE_ME = protobuf.Descriptor(),
	S2C_FORMATION_SAVE_RET_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_SAVE_FORMATIONS_F = protobuf.FieldDescriptor(),
	C2S_FORMATION_GET_ME = protobuf.Descriptor(),
	C2S_FORMATION_GET_TP_F = protobuf.FieldDescriptor(),
	C2S_FORMATION_GET_SEQ_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_GET_ME = protobuf.Descriptor(),
	S2C_FORMATION_GET_RET_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_GET_FORMATIONS_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_FIGHTVALUE_ME = protobuf.Descriptor(),
	S2C_FORMATION_FIGHTVALUE_RET_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_FIGHTVALUE_TP_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_FIGHTVALUE_SEQ_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_FIGHTVALUE_FIGHT_VALUE_F = protobuf.FieldDescriptor(),
	C2S_FORMATION_GETOTHER_ME = protobuf.Descriptor(),
	C2S_FORMATION_GETOTHER_TARGET_ID_F = protobuf.FieldDescriptor(),
	C2S_FORMATION_GETOTHER_TP_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_GETOTHER_ME = protobuf.Descriptor(),
	S2C_FORMATION_GETOTHER_RET_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_GETOTHER_TARGET_ID_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_GETOTHER_TP_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_GETOTHER_FORMATIONS_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_GETOTHER_KNIGHTS_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_GETOTHER_ARTIFACTS_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_GETOTHER_UNITE_TOKENS_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_GETOTHER_FOG_SEALS_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_GETOTHER_PETS_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_GETOTHER_PRECIOUS_SUITS_F = protobuf.FieldDescriptor(),
	S2C_FORMATION_GETOTHER_SUCCUBAES_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FORMATION_CHANGEPOSITION_POSITION_F, {
	"position",
	".cs.C2S_Formation_ChangePosition.position",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FORMATION_CHANGEPOSITION_ME, {
	"C2S_Formation_ChangePosition",
	".cs.C2S_Formation_ChangePosition",
	{},
	{},
	{
		var_0_10.C2S_FORMATION_CHANGEPOSITION_POSITION_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_CHANGEPOSITION_RET_F, {
	"ret",
	".cs.S2C_Formation_ChangePosition.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_CHANGEPOSITION_FORMATION_F, {
	"formation",
	".cs.S2C_Formation_ChangePosition.formation",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FORMATION_CHANGEPOSITION_ME, {
	"S2C_Formation_ChangePosition",
	".cs.S2C_Formation_ChangePosition",
	{},
	{},
	{
		var_0_10.S2C_FORMATION_CHANGEPOSITION_RET_F,
		var_0_10.S2C_FORMATION_CHANGEPOSITION_FORMATION_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FORMATION_CHANGEFORMATION_TP_F, {
	"tp",
	".cs.C2S_Formation_ChangeFormation.tp",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FORMATION_CHANGEFORMATION_POS_F, {
	"pos",
	".cs.C2S_Formation_ChangeFormation.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FORMATION_CHANGEFORMATION_ID_F, {
	"id",
	".cs.C2S_Formation_ChangeFormation.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FORMATION_CHANGEFORMATION_ME, {
	"C2S_Formation_ChangeFormation",
	".cs.C2S_Formation_ChangeFormation",
	{},
	{},
	{
		var_0_10.C2S_FORMATION_CHANGEFORMATION_TP_F,
		var_0_10.C2S_FORMATION_CHANGEFORMATION_POS_F,
		var_0_10.C2S_FORMATION_CHANGEFORMATION_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_CHANGEFORMATION_RET_F, {
	"ret",
	".cs.S2C_Formation_ChangeFormation.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_CHANGEFORMATION_FORMATION_F, {
	"formation",
	".cs.S2C_Formation_ChangeFormation.formation",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_CHANGEFORMATION_TP_F, {
	"tp",
	".cs.S2C_Formation_ChangeFormation.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_CHANGEFORMATION_POS_F, {
	"pos",
	".cs.S2C_Formation_ChangeFormation.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_CHANGEFORMATION_ID_F, {
	"id",
	".cs.S2C_Formation_ChangeFormation.id",
	5,
	4,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FORMATION_CHANGEFORMATION_ME, {
	"S2C_Formation_ChangeFormation",
	".cs.S2C_Formation_ChangeFormation",
	{},
	{},
	{
		var_0_10.S2C_FORMATION_CHANGEFORMATION_RET_F,
		var_0_10.S2C_FORMATION_CHANGEFORMATION_FORMATION_F,
		var_0_10.S2C_FORMATION_CHANGEFORMATION_TP_F,
		var_0_10.S2C_FORMATION_CHANGEFORMATION_POS_F,
		var_0_10.S2C_FORMATION_CHANGEFORMATION_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FORMATION_MODIFYNAME_NAME_F, {
	"name",
	".cs.C2S_Formation_ModifyName.name",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FORMATION_MODIFYNAME_ME, {
	"C2S_Formation_ModifyName",
	".cs.C2S_Formation_ModifyName",
	{},
	{},
	{
		var_0_10.C2S_FORMATION_MODIFYNAME_NAME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_MODIFYNAME_RET_F, {
	"ret",
	".cs.S2C_Formation_ModifyName.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_MODIFYNAME_NAME_F, {
	"name",
	".cs.S2C_Formation_ModifyName.name",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FORMATION_MODIFYNAME_ME, {
	"S2C_Formation_ModifyName",
	".cs.S2C_Formation_ModifyName",
	{},
	{},
	{
		var_0_10.S2C_FORMATION_MODIFYNAME_RET_F,
		var_0_10.S2C_FORMATION_MODIFYNAME_NAME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FORMATION_SAVE_TP_F, {
	"tp",
	".cs.C2S_Formation_Save.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FORMATION_SAVE_FORMATIONS_F, {
	"formations",
	".cs.C2S_Formation_Save.formations",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FORMATION_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.C2S_FORMATION_SAVE_ME, {
	"C2S_Formation_Save",
	".cs.C2S_Formation_Save",
	{},
	{},
	{
		var_0_10.C2S_FORMATION_SAVE_TP_F,
		var_0_10.C2S_FORMATION_SAVE_FORMATIONS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_SAVE_RET_F, {
	"ret",
	".cs.S2C_Formation_Save.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_SAVE_FORMATIONS_F, {
	"formations",
	".cs.S2C_Formation_Save.formations",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FORMATION_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FORMATION_SAVE_ME, {
	"S2C_Formation_Save",
	".cs.S2C_Formation_Save",
	{},
	{},
	{
		var_0_10.S2C_FORMATION_SAVE_RET_F,
		var_0_10.S2C_FORMATION_SAVE_FORMATIONS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FORMATION_GET_TP_F, {
	"tp",
	".cs.C2S_Formation_Get.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FORMATION_GET_SEQ_F, {
	"seq",
	".cs.C2S_Formation_Get.seq",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FORMATION_GET_ME, {
	"C2S_Formation_Get",
	".cs.C2S_Formation_Get",
	{},
	{},
	{
		var_0_10.C2S_FORMATION_GET_TP_F,
		var_0_10.C2S_FORMATION_GET_SEQ_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_GET_RET_F, {
	"ret",
	".cs.S2C_Formation_Get.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_GET_FORMATIONS_F, {
	"formations",
	".cs.S2C_Formation_Get.formations",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FORMATION_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FORMATION_GET_ME, {
	"S2C_Formation_Get",
	".cs.S2C_Formation_Get",
	{},
	{},
	{
		var_0_10.S2C_FORMATION_GET_RET_F,
		var_0_10.S2C_FORMATION_GET_FORMATIONS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_FIGHTVALUE_RET_F, {
	"ret",
	".cs.S2C_Formation_FightValue.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_FIGHTVALUE_TP_F, {
	"tp",
	".cs.S2C_Formation_FightValue.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_FIGHTVALUE_SEQ_F, {
	"seq",
	".cs.S2C_Formation_FightValue.seq",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_FIGHTVALUE_FIGHT_VALUE_F, {
	"fight_value",
	".cs.S2C_Formation_FightValue.fight_value",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_FORMATION_FIGHTVALUE_ME, {
	"S2C_Formation_FightValue",
	".cs.S2C_Formation_FightValue",
	{},
	{},
	{
		var_0_10.S2C_FORMATION_FIGHTVALUE_RET_F,
		var_0_10.S2C_FORMATION_FIGHTVALUE_TP_F,
		var_0_10.S2C_FORMATION_FIGHTVALUE_SEQ_F,
		var_0_10.S2C_FORMATION_FIGHTVALUE_FIGHT_VALUE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FORMATION_GETOTHER_TARGET_ID_F, {
	"target_id",
	".cs.C2S_Formation_GetOther.target_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_FORMATION_GETOTHER_TP_F, {
	"tp",
	".cs.C2S_Formation_GetOther.tp",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_FORMATION_GETOTHER_ME, {
	"C2S_Formation_GetOther",
	".cs.C2S_Formation_GetOther",
	{},
	{},
	{
		var_0_10.C2S_FORMATION_GETOTHER_TARGET_ID_F,
		var_0_10.C2S_FORMATION_GETOTHER_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_GETOTHER_RET_F, {
	"ret",
	".cs.S2C_Formation_GetOther.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_GETOTHER_TARGET_ID_F, {
	"target_id",
	".cs.S2C_Formation_GetOther.target_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_GETOTHER_TP_F, {
	"tp",
	".cs.S2C_Formation_GetOther.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_GETOTHER_FORMATIONS_F, {
	"formations",
	".cs.S2C_Formation_GetOther.formations",
	4,
	3,
	3,
	false,
	{},
	var_0_3.FORMATION_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_GETOTHER_KNIGHTS_F, {
	"knights",
	".cs.S2C_Formation_GetOther.knights",
	5,
	4,
	3,
	false,
	{},
	var_0_3.KNIGHT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_GETOTHER_ARTIFACTS_F, {
	"artifacts",
	".cs.S2C_Formation_GetOther.artifacts",
	6,
	5,
	3,
	false,
	{},
	var_0_3.ARTIFACT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_GETOTHER_UNITE_TOKENS_F, {
	"unite_tokens",
	".cs.S2C_Formation_GetOther.unite_tokens",
	7,
	6,
	3,
	false,
	{},
	var_0_3.UNITETOKEN_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_GETOTHER_FOG_SEALS_F, {
	"fog_seals",
	".cs.S2C_Formation_GetOther.fog_seals",
	8,
	7,
	3,
	false,
	{},
	var_0_3.FOGSEAL_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_GETOTHER_PETS_F, {
	"pets",
	".cs.S2C_Formation_GetOther.pets",
	9,
	8,
	3,
	false,
	{},
	var_0_3.PET_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_GETOTHER_PRECIOUS_SUITS_F, {
	"precious_suits",
	".cs.S2C_Formation_GetOther.precious_suits",
	10,
	9,
	3,
	false,
	{},
	var_0_3.PRECIOUSSUIT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_FORMATION_GETOTHER_SUCCUBAES_F, {
	"succubaes",
	".cs.S2C_Formation_GetOther.succubaes",
	11,
	10,
	3,
	false,
	{},
	var_0_3.SUCCUBA_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_FORMATION_GETOTHER_ME, {
	"S2C_Formation_GetOther",
	".cs.S2C_Formation_GetOther",
	{},
	{},
	{
		var_0_10.S2C_FORMATION_GETOTHER_RET_F,
		var_0_10.S2C_FORMATION_GETOTHER_TARGET_ID_F,
		var_0_10.S2C_FORMATION_GETOTHER_TP_F,
		var_0_10.S2C_FORMATION_GETOTHER_FORMATIONS_F,
		var_0_10.S2C_FORMATION_GETOTHER_KNIGHTS_F,
		var_0_10.S2C_FORMATION_GETOTHER_ARTIFACTS_F,
		var_0_10.S2C_FORMATION_GETOTHER_UNITE_TOKENS_F,
		var_0_10.S2C_FORMATION_GETOTHER_FOG_SEALS_F,
		var_0_10.S2C_FORMATION_GETOTHER_PETS_F,
		var_0_10.S2C_FORMATION_GETOTHER_PRECIOUS_SUITS_F,
		var_0_10.S2C_FORMATION_GETOTHER_SUCCUBAES_F
	},
	false,
	{}
})

return var_0_10
