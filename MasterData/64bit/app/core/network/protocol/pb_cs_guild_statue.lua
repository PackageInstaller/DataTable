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
	C2S_GUILDSTATUE_GETINFO_ME = protobuf.Descriptor(),
	S2C_GUILDSTATUE_GETINFO_ME = protobuf.Descriptor(),
	S2C_GUILDSTATUE_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_GETINFO_STATUE_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_GETINFO_AWARDED_STAGE_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_GETINFO_STONE_USED_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_GETINFO_CONTRIBUTES_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_GETINFO_TOTAL_PROGRESS_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_GETINFO_ISAWARD_F = protobuf.FieldDescriptor(),
	C2S_GUILDSTATUE_DOCAST_ME = protobuf.Descriptor(),
	C2S_GUILDSTATUE_DOCAST_TYPE_F = protobuf.FieldDescriptor(),
	C2S_GUILDSTATUE_DOCAST_VALUE_F = protobuf.FieldDescriptor(),
	C2S_GUILDSTATUE_DOCAST_STONE_F = protobuf.FieldDescriptor(),
	C2S_GUILDSTATUE_DOCAST_CAST_TYPE_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_DOCAST_ME = protobuf.Descriptor(),
	S2C_GUILDSTATUE_DOCAST_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_DOCAST_TYPE_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_DOCAST_VALUE_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_DOCAST_STONE_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_DOCAST_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_DOCAST_STATUE_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_DOCAST_UPGRADE_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_DOCAST_STONE_USED_F = protobuf.FieldDescriptor(),
	C2S_GUILDSTATUE_GETSTAGEAWARD_ME = protobuf.Descriptor(),
	C2S_GUILDSTATUE_GETSTAGEAWARD_TYPE_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_GETSTAGEAWARD_ME = protobuf.Descriptor(),
	S2C_GUILDSTATUE_GETSTAGEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_GETSTAGEAWARD_TYPE_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_GETSTAGEAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_GETSTAGEAWARD_AWARDED_STAGE_F = protobuf.FieldDescriptor(),
	C2S_GUILDSTATUE_GETFINALAWARD_ME = protobuf.Descriptor(),
	S2C_GUILDSTATUE_GETFINALAWARD_ME = protobuf.Descriptor(),
	S2C_GUILDSTATUE_GETFINALAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_GETFINALAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_PUSH_ME = protobuf.Descriptor(),
	S2C_GUILDSTATUE_PUSH_NAME_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_PUSH_BASE_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_PUSH_TYPE_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_PUSH_VALUE_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_PUSH_UPGRADE_F = protobuf.FieldDescriptor(),
	C2S_GUILDSTATUE_ONEKEYSTAGEAWARD_ME = protobuf.Descriptor(),
	S2C_GUILDSTATUE_ONEKEYSTAGEAWARD_ME = protobuf.Descriptor(),
	S2C_GUILDSTATUE_ONEKEYSTAGEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_ONEKEYSTAGEAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_ONEKEYSTAGEAWARD_AWARDED_STAGE_F = protobuf.FieldDescriptor(),
	C2S_GUILDSTATUE_FASTFINISH_ME = protobuf.Descriptor(),
	S2C_GUILDSTATUE_FASTFINISH_ME = protobuf.Descriptor(),
	S2C_GUILDSTATUE_FASTFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_FASTFINISH_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_FASTFINISH_STATUE_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_FASTFINISH_UPGRADE_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_FASTFINISH_STONE_USED_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_FASTFINISH_AWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_FASTFINISH_STONE_USED_CURR_F = protobuf.FieldDescriptor(),
	S2C_GUILDSTATUE_FASTFINISH_CAN_AWARD_WORSHIP_STATUE_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDSTATUE_GETINFO_ME, {
	"C2S_GuildStatue_GetInfo",
	".cs.C2S_GuildStatue_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_GETINFO_RET_F, {
	"ret",
	".cs.S2C_GuildStatue_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_GETINFO_STATUE_F, {
	"statue",
	".cs.S2C_GuildStatue_GetInfo.statue",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.GUILDSTATUE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_GETINFO_AWARDED_STAGE_F, {
	"awarded_stage",
	".cs.S2C_GuildStatue_GetInfo.awarded_stage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_GETINFO_STONE_USED_F, {
	"stone_used",
	".cs.S2C_GuildStatue_GetInfo.stone_used",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_GETINFO_CONTRIBUTES_F, {
	"contributes",
	".cs.S2C_GuildStatue_GetInfo.contributes",
	5,
	4,
	3,
	false,
	{},
	var_0_3.GUILDSTATUECONTRIBUTE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_GETINFO_TOTAL_PROGRESS_F, {
	"total_progress",
	".cs.S2C_GuildStatue_GetInfo.total_progress",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_GETINFO_ISAWARD_F, {
	"isAward",
	".cs.S2C_GuildStatue_GetInfo.isAward",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDSTATUE_GETINFO_ME, {
	"S2C_GuildStatue_GetInfo",
	".cs.S2C_GuildStatue_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_GUILDSTATUE_GETINFO_RET_F,
		var_0_10.S2C_GUILDSTATUE_GETINFO_STATUE_F,
		var_0_10.S2C_GUILDSTATUE_GETINFO_AWARDED_STAGE_F,
		var_0_10.S2C_GUILDSTATUE_GETINFO_STONE_USED_F,
		var_0_10.S2C_GUILDSTATUE_GETINFO_CONTRIBUTES_F,
		var_0_10.S2C_GUILDSTATUE_GETINFO_TOTAL_PROGRESS_F,
		var_0_10.S2C_GUILDSTATUE_GETINFO_ISAWARD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDSTATUE_DOCAST_TYPE_F, {
	"type",
	".cs.C2S_GuildStatue_DoCast.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDSTATUE_DOCAST_VALUE_F, {
	"value",
	".cs.C2S_GuildStatue_DoCast.value",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDSTATUE_DOCAST_STONE_F, {
	"stone",
	".cs.C2S_GuildStatue_DoCast.stone",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDSTATUE_DOCAST_CAST_TYPE_F, {
	"cast_type",
	".cs.C2S_GuildStatue_DoCast.cast_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDSTATUE_DOCAST_ME, {
	"C2S_GuildStatue_DoCast",
	".cs.C2S_GuildStatue_DoCast",
	{},
	{},
	{
		var_0_10.C2S_GUILDSTATUE_DOCAST_TYPE_F,
		var_0_10.C2S_GUILDSTATUE_DOCAST_VALUE_F,
		var_0_10.C2S_GUILDSTATUE_DOCAST_STONE_F,
		var_0_10.C2S_GUILDSTATUE_DOCAST_CAST_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_DOCAST_RET_F, {
	"ret",
	".cs.S2C_GuildStatue_DoCast.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_DOCAST_TYPE_F, {
	"type",
	".cs.S2C_GuildStatue_DoCast.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_DOCAST_VALUE_F, {
	"value",
	".cs.S2C_GuildStatue_DoCast.value",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_DOCAST_STONE_F, {
	"stone",
	".cs.S2C_GuildStatue_DoCast.stone",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_DOCAST_AWARDS_F, {
	"awards",
	".cs.S2C_GuildStatue_DoCast.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_DOCAST_STATUE_F, {
	"statue",
	".cs.S2C_GuildStatue_DoCast.statue",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.GUILDSTATUE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_DOCAST_UPGRADE_F, {
	"upgrade",
	".cs.S2C_GuildStatue_DoCast.upgrade",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_DOCAST_STONE_USED_F, {
	"stone_used",
	".cs.S2C_GuildStatue_DoCast.stone_used",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDSTATUE_DOCAST_ME, {
	"S2C_GuildStatue_DoCast",
	".cs.S2C_GuildStatue_DoCast",
	{},
	{},
	{
		var_0_10.S2C_GUILDSTATUE_DOCAST_RET_F,
		var_0_10.S2C_GUILDSTATUE_DOCAST_TYPE_F,
		var_0_10.S2C_GUILDSTATUE_DOCAST_VALUE_F,
		var_0_10.S2C_GUILDSTATUE_DOCAST_STONE_F,
		var_0_10.S2C_GUILDSTATUE_DOCAST_AWARDS_F,
		var_0_10.S2C_GUILDSTATUE_DOCAST_STATUE_F,
		var_0_10.S2C_GUILDSTATUE_DOCAST_UPGRADE_F,
		var_0_10.S2C_GUILDSTATUE_DOCAST_STONE_USED_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_GUILDSTATUE_GETSTAGEAWARD_TYPE_F, {
	"type",
	".cs.C2S_GuildStatue_GetStageAward.type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDSTATUE_GETSTAGEAWARD_ME, {
	"C2S_GuildStatue_GetStageAward",
	".cs.C2S_GuildStatue_GetStageAward",
	{},
	{},
	{
		var_0_10.C2S_GUILDSTATUE_GETSTAGEAWARD_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_GETSTAGEAWARD_RET_F, {
	"ret",
	".cs.S2C_GuildStatue_GetStageAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_GETSTAGEAWARD_TYPE_F, {
	"type",
	".cs.S2C_GuildStatue_GetStageAward.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_GETSTAGEAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_GuildStatue_GetStageAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_GETSTAGEAWARD_AWARDED_STAGE_F, {
	"awarded_stage",
	".cs.S2C_GuildStatue_GetStageAward.awarded_stage",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDSTATUE_GETSTAGEAWARD_ME, {
	"S2C_GuildStatue_GetStageAward",
	".cs.S2C_GuildStatue_GetStageAward",
	{},
	{},
	{
		var_0_10.S2C_GUILDSTATUE_GETSTAGEAWARD_RET_F,
		var_0_10.S2C_GUILDSTATUE_GETSTAGEAWARD_TYPE_F,
		var_0_10.S2C_GUILDSTATUE_GETSTAGEAWARD_AWARDS_F,
		var_0_10.S2C_GUILDSTATUE_GETSTAGEAWARD_AWARDED_STAGE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDSTATUE_GETFINALAWARD_ME, {
	"C2S_GuildStatue_GetFinalAward",
	".cs.C2S_GuildStatue_GetFinalAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_GETFINALAWARD_RET_F, {
	"ret",
	".cs.S2C_GuildStatue_GetFinalAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_GETFINALAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_GuildStatue_GetFinalAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDSTATUE_GETFINALAWARD_ME, {
	"S2C_GuildStatue_GetFinalAward",
	".cs.S2C_GuildStatue_GetFinalAward",
	{},
	{},
	{
		var_0_10.S2C_GUILDSTATUE_GETFINALAWARD_RET_F,
		var_0_10.S2C_GUILDSTATUE_GETFINALAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_PUSH_NAME_F, {
	"name",
	".cs.S2C_GuildStatue_Push.name",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_PUSH_BASE_ID_F, {
	"base_id",
	".cs.S2C_GuildStatue_Push.base_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_PUSH_TYPE_F, {
	"type",
	".cs.S2C_GuildStatue_Push.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_PUSH_VALUE_F, {
	"value",
	".cs.S2C_GuildStatue_Push.value",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_PUSH_UPGRADE_F, {
	"upgrade",
	".cs.S2C_GuildStatue_Push.upgrade",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDSTATUE_PUSH_ME, {
	"S2C_GuildStatue_Push",
	".cs.S2C_GuildStatue_Push",
	{},
	{},
	{
		var_0_10.S2C_GUILDSTATUE_PUSH_NAME_F,
		var_0_10.S2C_GUILDSTATUE_PUSH_BASE_ID_F,
		var_0_10.S2C_GUILDSTATUE_PUSH_TYPE_F,
		var_0_10.S2C_GUILDSTATUE_PUSH_VALUE_F,
		var_0_10.S2C_GUILDSTATUE_PUSH_UPGRADE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDSTATUE_ONEKEYSTAGEAWARD_ME, {
	"C2S_GuildStatue_OneKeyStageAward",
	".cs.C2S_GuildStatue_OneKeyStageAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_ONEKEYSTAGEAWARD_RET_F, {
	"ret",
	".cs.S2C_GuildStatue_OneKeyStageAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_ONEKEYSTAGEAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_GuildStatue_OneKeyStageAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_ONEKEYSTAGEAWARD_AWARDED_STAGE_F, {
	"awarded_stage",
	".cs.S2C_GuildStatue_OneKeyStageAward.awarded_stage",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDSTATUE_ONEKEYSTAGEAWARD_ME, {
	"S2C_GuildStatue_OneKeyStageAward",
	".cs.S2C_GuildStatue_OneKeyStageAward",
	{},
	{},
	{
		var_0_10.S2C_GUILDSTATUE_ONEKEYSTAGEAWARD_RET_F,
		var_0_10.S2C_GUILDSTATUE_ONEKEYSTAGEAWARD_AWARDS_F,
		var_0_10.S2C_GUILDSTATUE_ONEKEYSTAGEAWARD_AWARDED_STAGE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_GUILDSTATUE_FASTFINISH_ME, {
	"C2S_GuildStatue_FastFinish",
	".cs.C2S_GuildStatue_FastFinish",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_FASTFINISH_RET_F, {
	"ret",
	".cs.S2C_GuildStatue_FastFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_FASTFINISH_AWARDS_F, {
	"awards",
	".cs.S2C_GuildStatue_FastFinish.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_FASTFINISH_STATUE_F, {
	"statue",
	".cs.S2C_GuildStatue_FastFinish.statue",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.GUILDSTATUE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_FASTFINISH_UPGRADE_F, {
	"upgrade",
	".cs.S2C_GuildStatue_FastFinish.upgrade",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_FASTFINISH_STONE_USED_F, {
	"stone_used",
	".cs.S2C_GuildStatue_FastFinish.stone_used",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_FASTFINISH_AWARD_ID_F, {
	"award_id",
	".cs.S2C_GuildStatue_FastFinish.award_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_FASTFINISH_STONE_USED_CURR_F, {
	"stone_used_curr",
	".cs.S2C_GuildStatue_FastFinish.stone_used_curr",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_GUILDSTATUE_FASTFINISH_CAN_AWARD_WORSHIP_STATUE_F, {
	"can_award_worship_statue",
	".cs.S2C_GuildStatue_FastFinish.can_award_worship_statue",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_GUILDSTATUE_FASTFINISH_ME, {
	"S2C_GuildStatue_FastFinish",
	".cs.S2C_GuildStatue_FastFinish",
	{},
	{},
	{
		var_0_10.S2C_GUILDSTATUE_FASTFINISH_RET_F,
		var_0_10.S2C_GUILDSTATUE_FASTFINISH_AWARDS_F,
		var_0_10.S2C_GUILDSTATUE_FASTFINISH_STATUE_F,
		var_0_10.S2C_GUILDSTATUE_FASTFINISH_UPGRADE_F,
		var_0_10.S2C_GUILDSTATUE_FASTFINISH_STONE_USED_F,
		var_0_10.S2C_GUILDSTATUE_FASTFINISH_AWARD_ID_F,
		var_0_10.S2C_GUILDSTATUE_FASTFINISH_STONE_USED_CURR_F,
		var_0_10.S2C_GUILDSTATUE_FASTFINISH_CAN_AWARD_WORSHIP_STATUE_F
	},
	false,
	{}
})

return var_0_10
