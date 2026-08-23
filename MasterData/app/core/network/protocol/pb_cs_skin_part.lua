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
	C2S_SKINPART_GETINFO_ME = protobuf.Descriptor(),
	S2C_SKINPART_GETINFO_ME = protobuf.Descriptor(),
	S2C_SKINPART_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_SKINPART_GETINFO_SKIN_PARTS_F = protobuf.FieldDescriptor(),
	S2C_SKINPART_GETINFO_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_SKINPART_LEVELUP_ME = protobuf.Descriptor(),
	C2S_SKINPART_LEVELUP_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	C2S_SKINPART_LEVELUP_TARGET_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_SKINPART_LEVELUP_ME = protobuf.Descriptor(),
	S2C_SKINPART_LEVELUP_RET_F = protobuf.FieldDescriptor(),
	S2C_SKINPART_LEVELUP_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	S2C_SKINPART_LEVELUP_TARGET_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_SKINPART_STAGEUP_ME = protobuf.Descriptor(),
	C2S_SKINPART_STAGEUP_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	C2S_SKINPART_STAGEUP_TARGET_STAGE_F = protobuf.FieldDescriptor(),
	S2C_SKINPART_STAGEUP_ME = protobuf.Descriptor(),
	S2C_SKINPART_STAGEUP_RET_F = protobuf.FieldDescriptor(),
	S2C_SKINPART_STAGEUP_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	S2C_SKINPART_STAGEUP_TARGET_STAGE_F = protobuf.FieldDescriptor(),
	C2S_SKINPART_WEAR_ME = protobuf.Descriptor(),
	C2S_SKINPART_WEAR_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	S2C_SKINPART_WEAR_ME = protobuf.Descriptor(),
	S2C_SKINPART_WEAR_RET_F = protobuf.FieldDescriptor(),
	S2C_SKINPART_WEAR_ADVANCE_ID_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_SKINPART_GETINFO_ME, {
	"C2S_SkinPart_GetInfo",
	".cs.C2S_SkinPart_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SKINPART_GETINFO_RET_F, {
	"ret",
	".cs.S2C_SkinPart_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SKINPART_GETINFO_SKIN_PARTS_F, {
	"skin_parts",
	".cs.S2C_SkinPart_GetInfo.skin_parts",
	2,
	1,
	3,
	false,
	{},
	var_0_3.USERSKINPART_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SKINPART_GETINFO_AWARDS_F, {
	"awards",
	".cs.S2C_SkinPart_GetInfo.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SKINPART_GETINFO_ME, {
	"S2C_SkinPart_GetInfo",
	".cs.S2C_SkinPart_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_SKINPART_GETINFO_RET_F,
		var_0_10.S2C_SKINPART_GETINFO_SKIN_PARTS_F,
		var_0_10.S2C_SKINPART_GETINFO_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SKINPART_LEVELUP_ADVANCE_ID_F, {
	"advance_id",
	".cs.C2S_SkinPart_LevelUp.advance_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SKINPART_LEVELUP_TARGET_LEVEL_F, {
	"target_level",
	".cs.C2S_SkinPart_LevelUp.target_level",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_SKINPART_LEVELUP_ME, {
	"C2S_SkinPart_LevelUp",
	".cs.C2S_SkinPart_LevelUp",
	{},
	{},
	{
		var_0_10.C2S_SKINPART_LEVELUP_ADVANCE_ID_F,
		var_0_10.C2S_SKINPART_LEVELUP_TARGET_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SKINPART_LEVELUP_RET_F, {
	"ret",
	".cs.S2C_SkinPart_LevelUp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SKINPART_LEVELUP_ADVANCE_ID_F, {
	"advance_id",
	".cs.S2C_SkinPart_LevelUp.advance_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SKINPART_LEVELUP_TARGET_LEVEL_F, {
	"target_level",
	".cs.S2C_SkinPart_LevelUp.target_level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SKINPART_LEVELUP_ME, {
	"S2C_SkinPart_LevelUp",
	".cs.S2C_SkinPart_LevelUp",
	{},
	{},
	{
		var_0_10.S2C_SKINPART_LEVELUP_RET_F,
		var_0_10.S2C_SKINPART_LEVELUP_ADVANCE_ID_F,
		var_0_10.S2C_SKINPART_LEVELUP_TARGET_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SKINPART_STAGEUP_ADVANCE_ID_F, {
	"advance_id",
	".cs.C2S_SkinPart_StageUp.advance_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SKINPART_STAGEUP_TARGET_STAGE_F, {
	"target_stage",
	".cs.C2S_SkinPart_StageUp.target_stage",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_SKINPART_STAGEUP_ME, {
	"C2S_SkinPart_StageUp",
	".cs.C2S_SkinPart_StageUp",
	{},
	{},
	{
		var_0_10.C2S_SKINPART_STAGEUP_ADVANCE_ID_F,
		var_0_10.C2S_SKINPART_STAGEUP_TARGET_STAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SKINPART_STAGEUP_RET_F, {
	"ret",
	".cs.S2C_SkinPart_StageUp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SKINPART_STAGEUP_ADVANCE_ID_F, {
	"advance_id",
	".cs.S2C_SkinPart_StageUp.advance_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SKINPART_STAGEUP_TARGET_STAGE_F, {
	"target_stage",
	".cs.S2C_SkinPart_StageUp.target_stage",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SKINPART_STAGEUP_ME, {
	"S2C_SkinPart_StageUp",
	".cs.S2C_SkinPart_StageUp",
	{},
	{},
	{
		var_0_10.S2C_SKINPART_STAGEUP_RET_F,
		var_0_10.S2C_SKINPART_STAGEUP_ADVANCE_ID_F,
		var_0_10.S2C_SKINPART_STAGEUP_TARGET_STAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SKINPART_WEAR_ADVANCE_ID_F, {
	"advance_id",
	".cs.C2S_SkinPart_Wear.advance_id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.C2S_SKINPART_WEAR_ME, {
	"C2S_SkinPart_Wear",
	".cs.C2S_SkinPart_Wear",
	{},
	{},
	{
		var_0_10.C2S_SKINPART_WEAR_ADVANCE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SKINPART_WEAR_RET_F, {
	"ret",
	".cs.S2C_SkinPart_Wear.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SKINPART_WEAR_ADVANCE_ID_F, {
	"advance_id",
	".cs.S2C_SkinPart_Wear.advance_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SKINPART_WEAR_ME, {
	"S2C_SkinPart_Wear",
	".cs.S2C_SkinPart_Wear",
	{},
	{},
	{
		var_0_10.S2C_SKINPART_WEAR_RET_F,
		var_0_10.S2C_SKINPART_WEAR_ADVANCE_ID_F
	},
	false,
	{}
})

return var_0_10
