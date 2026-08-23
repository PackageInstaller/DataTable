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
	C2S_ARTIFACT_LEVELUP_ME = protobuf.Descriptor(),
	C2S_ARTIFACT_LEVELUP_ID_F = protobuf.FieldDescriptor(),
	C2S_ARTIFACT_LEVELUP_TG_LV_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_LEVELUP_ME = protobuf.Descriptor(),
	S2C_ARTIFACT_LEVELUP_ID_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_LEVELUP_TG_LV_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_LEVELUP_RET_F = protobuf.FieldDescriptor(),
	C2S_ARTIFACT_STAR_ME = protobuf.Descriptor(),
	C2S_ARTIFACT_STAR_ID_F = protobuf.FieldDescriptor(),
	C2S_ARTIFACT_STAR_TG_STAR_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_STAR_ME = protobuf.Descriptor(),
	S2C_ARTIFACT_STAR_ID_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_STAR_TG_STAR_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_STAR_RET_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_STAR_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_ARTIFACT_DRAW_ME = protobuf.Descriptor(),
	C2S_ARTIFACT_DRAW_DRAW_TYPE_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_DRAW_ME = protobuf.Descriptor(),
	S2C_ARTIFACT_DRAW_DRAW_TYPE_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_DRAW_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_DRAW_INDEXS_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_DRAW_AWARD_INDEXS_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_DRAW_SCORE_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_DRAW_RET_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_DRAW_DAILY_NUM_F = protobuf.FieldDescriptor(),
	C2S_ARTIFACT_GETDRAW_ME = protobuf.Descriptor(),
	S2C_ARTIFACT_GETDRAW_ME = protobuf.Descriptor(),
	S2C_ARTIFACT_GETDRAW_RET_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_GETDRAW_ARTIFACT_RECRUIT_F = protobuf.FieldDescriptor(),
	C2S_ARTIFACT_DRAWREFRESH_ME = protobuf.Descriptor(),
	S2C_ARTIFACT_DRAWREFRESH_ME = protobuf.Descriptor(),
	S2C_ARTIFACT_DRAWREFRESH_RET_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_DRAWREFRESH_ID_F = protobuf.FieldDescriptor(),
	C2S_ARTIFACT_DRAWAWARD_ME = protobuf.Descriptor(),
	S2C_ARTIFACT_DRAWAWARD_ME = protobuf.Descriptor(),
	S2C_ARTIFACT_DRAWAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_DRAWAWARD_SCORE_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_DRAWAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_ARTIFACT_INHERITFORMATION_ME = protobuf.Descriptor(),
	C2S_ARTIFACT_INHERITFORMATION_POS_F = protobuf.FieldDescriptor(),
	C2S_ARTIFACT_INHERITFORMATION_ID_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_INHERITFORMATION_ME = protobuf.Descriptor(),
	S2C_ARTIFACT_INHERITFORMATION_RET_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_INHERITFORMATION_FORMATION_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_INHERITFORMATION_POS_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_INHERITFORMATION_ID_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_INHERITFORMATION_AWARD_F = protobuf.FieldDescriptor(),
	C2S_ARTIFACT_HANDBOOKACTIVATE_ME = protobuf.Descriptor(),
	C2S_ARTIFACT_HANDBOOKACTIVATE_ID_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_HANDBOOKACTIVATE_ME = protobuf.Descriptor(),
	S2C_ARTIFACT_HANDBOOKACTIVATE_RET_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_HANDBOOKACTIVATE_ID_F = protobuf.FieldDescriptor(),
	C2S_ARTIFACT_HANDBOOKUPGRADE_ME = protobuf.Descriptor(),
	C2S_ARTIFACT_HANDBOOKUPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_HANDBOOKUPGRADE_ME = protobuf.Descriptor(),
	S2C_ARTIFACT_HANDBOOKUPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_HANDBOOKUPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_HANDBOOKUPGRADE_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_ARTIFACT_SPIRITLEVELUP_ME = protobuf.Descriptor(),
	C2S_ARTIFACT_SPIRITLEVELUP_ID_F = protobuf.FieldDescriptor(),
	C2S_ARTIFACT_SPIRITLEVELUP_TARGET_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_SPIRITLEVELUP_ME = protobuf.Descriptor(),
	S2C_ARTIFACT_SPIRITLEVELUP_RET_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_SPIRITLEVELUP_ID_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_SPIRITLEVELUP_TARGET_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_ARTIFACT_SPIRITSTAGEUP_ME = protobuf.Descriptor(),
	C2S_ARTIFACT_SPIRITSTAGEUP_ID_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_SPIRITSTAGEUP_ME = protobuf.Descriptor(),
	S2C_ARTIFACT_SPIRITSTAGEUP_RET_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_SPIRITSTAGEUP_ID_F = protobuf.FieldDescriptor(),
	C2S_ARTIFACT_URHANDBOOK_ACTIVE_ME = protobuf.Descriptor(),
	C2S_ARTIFACT_URHANDBOOK_ACTIVE_ID_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_URHANDBOOK_ACTIVE_ME = protobuf.Descriptor(),
	S2C_ARTIFACT_URHANDBOOK_ACTIVE_RET_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_URHANDBOOK_ACTIVE_ID_F = protobuf.FieldDescriptor(),
	C2S_ARTIFACT_URHANDBOOK_UPGRADE_ME = protobuf.Descriptor(),
	C2S_ARTIFACT_URHANDBOOK_UPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_URHANDBOOK_UPGRADE_ME = protobuf.Descriptor(),
	S2C_ARTIFACT_URHANDBOOK_UPGRADE_RET_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_URHANDBOOK_UPGRADE_ID_F = protobuf.FieldDescriptor(),
	S2C_ARTIFACT_URHANDBOOK_UPGRADE_NEW_ID_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARTIFACT_LEVELUP_ID_F, {
	"id",
	".cs.C2S_Artifact_LevelUp.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARTIFACT_LEVELUP_TG_LV_F, {
	"tg_lv",
	".cs.C2S_Artifact_LevelUp.tg_lv",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ARTIFACT_LEVELUP_ME, {
	"C2S_Artifact_LevelUp",
	".cs.C2S_Artifact_LevelUp",
	{},
	{},
	{
		var_0_10.C2S_ARTIFACT_LEVELUP_ID_F,
		var_0_10.C2S_ARTIFACT_LEVELUP_TG_LV_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_LEVELUP_ID_F, {
	"id",
	".cs.S2C_Artifact_LevelUp.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_LEVELUP_TG_LV_F, {
	"tg_lv",
	".cs.S2C_Artifact_LevelUp.tg_lv",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_LEVELUP_RET_F, {
	"ret",
	".cs.S2C_Artifact_LevelUp.ret",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARTIFACT_LEVELUP_ME, {
	"S2C_Artifact_LevelUp",
	".cs.S2C_Artifact_LevelUp",
	{},
	{},
	{
		var_0_10.S2C_ARTIFACT_LEVELUP_ID_F,
		var_0_10.S2C_ARTIFACT_LEVELUP_TG_LV_F,
		var_0_10.S2C_ARTIFACT_LEVELUP_RET_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARTIFACT_STAR_ID_F, {
	"id",
	".cs.C2S_Artifact_Star.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARTIFACT_STAR_TG_STAR_F, {
	"tg_star",
	".cs.C2S_Artifact_Star.tg_star",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ARTIFACT_STAR_ME, {
	"C2S_Artifact_Star",
	".cs.C2S_Artifact_Star",
	{},
	{},
	{
		var_0_10.C2S_ARTIFACT_STAR_ID_F,
		var_0_10.C2S_ARTIFACT_STAR_TG_STAR_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_STAR_ID_F, {
	"id",
	".cs.S2C_Artifact_Star.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_STAR_TG_STAR_F, {
	"tg_star",
	".cs.S2C_Artifact_Star.tg_star",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_STAR_RET_F, {
	"ret",
	".cs.S2C_Artifact_Star.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_STAR_AWARDS_F, {
	"awards",
	".cs.S2C_Artifact_Star.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARTIFACT_STAR_ME, {
	"S2C_Artifact_Star",
	".cs.S2C_Artifact_Star",
	{},
	{},
	{
		var_0_10.S2C_ARTIFACT_STAR_ID_F,
		var_0_10.S2C_ARTIFACT_STAR_TG_STAR_F,
		var_0_10.S2C_ARTIFACT_STAR_RET_F,
		var_0_10.S2C_ARTIFACT_STAR_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARTIFACT_DRAW_DRAW_TYPE_F, {
	"draw_type",
	".cs.C2S_Artifact_Draw.draw_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ARTIFACT_DRAW_ME, {
	"C2S_Artifact_Draw",
	".cs.C2S_Artifact_Draw",
	{},
	{},
	{
		var_0_10.C2S_ARTIFACT_DRAW_DRAW_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_DRAW_DRAW_TYPE_F, {
	"draw_type",
	".cs.S2C_Artifact_Draw.draw_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_DRAW_AWARDS_F, {
	"awards",
	".cs.S2C_Artifact_Draw.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_DRAW_INDEXS_F, {
	"indexs",
	".cs.S2C_Artifact_Draw.indexs",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_DRAW_AWARD_INDEXS_F, {
	"award_indexs",
	".cs.S2C_Artifact_Draw.award_indexs",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_DRAW_SCORE_F, {
	"score",
	".cs.S2C_Artifact_Draw.score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_DRAW_RET_F, {
	"ret",
	".cs.S2C_Artifact_Draw.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_DRAW_DAILY_NUM_F, {
	"daily_num",
	".cs.S2C_Artifact_Draw.daily_num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARTIFACT_DRAW_ME, {
	"S2C_Artifact_Draw",
	".cs.S2C_Artifact_Draw",
	{},
	{},
	{
		var_0_10.S2C_ARTIFACT_DRAW_DRAW_TYPE_F,
		var_0_10.S2C_ARTIFACT_DRAW_AWARDS_F,
		var_0_10.S2C_ARTIFACT_DRAW_INDEXS_F,
		var_0_10.S2C_ARTIFACT_DRAW_AWARD_INDEXS_F,
		var_0_10.S2C_ARTIFACT_DRAW_SCORE_F,
		var_0_10.S2C_ARTIFACT_DRAW_RET_F,
		var_0_10.S2C_ARTIFACT_DRAW_DAILY_NUM_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ARTIFACT_GETDRAW_ME, {
	"C2S_Artifact_GetDraw",
	".cs.C2S_Artifact_GetDraw",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_GETDRAW_RET_F, {
	"ret",
	".cs.S2C_Artifact_GetDraw.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_GETDRAW_ARTIFACT_RECRUIT_F, {
	"artifact_recruit",
	".cs.S2C_Artifact_GetDraw.artifact_recruit",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.ARTIFACTRECRUIT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_ARTIFACT_GETDRAW_ME, {
	"S2C_Artifact_GetDraw",
	".cs.S2C_Artifact_GetDraw",
	{},
	{},
	{
		var_0_10.S2C_ARTIFACT_GETDRAW_RET_F,
		var_0_10.S2C_ARTIFACT_GETDRAW_ARTIFACT_RECRUIT_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ARTIFACT_DRAWREFRESH_ME, {
	"C2S_Artifact_DrawRefresh",
	".cs.C2S_Artifact_DrawRefresh",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_DRAWREFRESH_RET_F, {
	"ret",
	".cs.S2C_Artifact_DrawRefresh.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_DRAWREFRESH_ID_F, {
	"id",
	".cs.S2C_Artifact_DrawRefresh.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARTIFACT_DRAWREFRESH_ME, {
	"S2C_Artifact_DrawRefresh",
	".cs.S2C_Artifact_DrawRefresh",
	{},
	{},
	{
		var_0_10.S2C_ARTIFACT_DRAWREFRESH_RET_F,
		var_0_10.S2C_ARTIFACT_DRAWREFRESH_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_ARTIFACT_DRAWAWARD_ME, {
	"C2S_Artifact_DrawAward",
	".cs.C2S_Artifact_DrawAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_DRAWAWARD_RET_F, {
	"ret",
	".cs.S2C_Artifact_DrawAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_DRAWAWARD_SCORE_F, {
	"score",
	".cs.S2C_Artifact_DrawAward.score",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_DRAWAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Artifact_DrawAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARTIFACT_DRAWAWARD_ME, {
	"S2C_Artifact_DrawAward",
	".cs.S2C_Artifact_DrawAward",
	{},
	{},
	{
		var_0_10.S2C_ARTIFACT_DRAWAWARD_RET_F,
		var_0_10.S2C_ARTIFACT_DRAWAWARD_SCORE_F,
		var_0_10.S2C_ARTIFACT_DRAWAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARTIFACT_INHERITFORMATION_POS_F, {
	"pos",
	".cs.C2S_Artifact_InheritFormation.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARTIFACT_INHERITFORMATION_ID_F, {
	"id",
	".cs.C2S_Artifact_InheritFormation.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ARTIFACT_INHERITFORMATION_ME, {
	"C2S_Artifact_InheritFormation",
	".cs.C2S_Artifact_InheritFormation",
	{},
	{},
	{
		var_0_10.C2S_ARTIFACT_INHERITFORMATION_POS_F,
		var_0_10.C2S_ARTIFACT_INHERITFORMATION_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_INHERITFORMATION_RET_F, {
	"ret",
	".cs.S2C_Artifact_InheritFormation.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_INHERITFORMATION_FORMATION_F, {
	"formation",
	".cs.S2C_Artifact_InheritFormation.formation",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_INHERITFORMATION_POS_F, {
	"pos",
	".cs.S2C_Artifact_InheritFormation.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_INHERITFORMATION_ID_F, {
	"id",
	".cs.S2C_Artifact_InheritFormation.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_INHERITFORMATION_AWARD_F, {
	"award",
	".cs.S2C_Artifact_InheritFormation.award",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARTIFACT_INHERITFORMATION_ME, {
	"S2C_Artifact_InheritFormation",
	".cs.S2C_Artifact_InheritFormation",
	{},
	{},
	{
		var_0_10.S2C_ARTIFACT_INHERITFORMATION_RET_F,
		var_0_10.S2C_ARTIFACT_INHERITFORMATION_FORMATION_F,
		var_0_10.S2C_ARTIFACT_INHERITFORMATION_POS_F,
		var_0_10.S2C_ARTIFACT_INHERITFORMATION_ID_F,
		var_0_10.S2C_ARTIFACT_INHERITFORMATION_AWARD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARTIFACT_HANDBOOKACTIVATE_ID_F, {
	"id",
	".cs.C2S_Artifact_HandbookActivate.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ARTIFACT_HANDBOOKACTIVATE_ME, {
	"C2S_Artifact_HandbookActivate",
	".cs.C2S_Artifact_HandbookActivate",
	{},
	{},
	{
		var_0_10.C2S_ARTIFACT_HANDBOOKACTIVATE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_HANDBOOKACTIVATE_RET_F, {
	"ret",
	".cs.S2C_Artifact_HandbookActivate.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_HANDBOOKACTIVATE_ID_F, {
	"id",
	".cs.S2C_Artifact_HandbookActivate.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARTIFACT_HANDBOOKACTIVATE_ME, {
	"S2C_Artifact_HandbookActivate",
	".cs.S2C_Artifact_HandbookActivate",
	{},
	{},
	{
		var_0_10.S2C_ARTIFACT_HANDBOOKACTIVATE_RET_F,
		var_0_10.S2C_ARTIFACT_HANDBOOKACTIVATE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARTIFACT_HANDBOOKUPGRADE_ID_F, {
	"id",
	".cs.C2S_Artifact_HandbookUpgrade.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ARTIFACT_HANDBOOKUPGRADE_ME, {
	"C2S_Artifact_HandbookUpgrade",
	".cs.C2S_Artifact_HandbookUpgrade",
	{},
	{},
	{
		var_0_10.C2S_ARTIFACT_HANDBOOKUPGRADE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_HANDBOOKUPGRADE_RET_F, {
	"ret",
	".cs.S2C_Artifact_HandbookUpgrade.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_HANDBOOKUPGRADE_ID_F, {
	"id",
	".cs.S2C_Artifact_HandbookUpgrade.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_HANDBOOKUPGRADE_LEVEL_F, {
	"level",
	".cs.S2C_Artifact_HandbookUpgrade.level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARTIFACT_HANDBOOKUPGRADE_ME, {
	"S2C_Artifact_HandbookUpgrade",
	".cs.S2C_Artifact_HandbookUpgrade",
	{},
	{},
	{
		var_0_10.S2C_ARTIFACT_HANDBOOKUPGRADE_RET_F,
		var_0_10.S2C_ARTIFACT_HANDBOOKUPGRADE_ID_F,
		var_0_10.S2C_ARTIFACT_HANDBOOKUPGRADE_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARTIFACT_SPIRITLEVELUP_ID_F, {
	"id",
	".cs.C2S_Artifact_SpiritLevelUp.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARTIFACT_SPIRITLEVELUP_TARGET_LEVEL_F, {
	"target_level",
	".cs.C2S_Artifact_SpiritLevelUp.target_level",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ARTIFACT_SPIRITLEVELUP_ME, {
	"C2S_Artifact_SpiritLevelUp",
	".cs.C2S_Artifact_SpiritLevelUp",
	{},
	{},
	{
		var_0_10.C2S_ARTIFACT_SPIRITLEVELUP_ID_F,
		var_0_10.C2S_ARTIFACT_SPIRITLEVELUP_TARGET_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_SPIRITLEVELUP_RET_F, {
	"ret",
	".cs.S2C_Artifact_SpiritLevelUp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_SPIRITLEVELUP_ID_F, {
	"id",
	".cs.S2C_Artifact_SpiritLevelUp.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_SPIRITLEVELUP_TARGET_LEVEL_F, {
	"target_level",
	".cs.S2C_Artifact_SpiritLevelUp.target_level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARTIFACT_SPIRITLEVELUP_ME, {
	"S2C_Artifact_SpiritLevelUp",
	".cs.S2C_Artifact_SpiritLevelUp",
	{},
	{},
	{
		var_0_10.S2C_ARTIFACT_SPIRITLEVELUP_RET_F,
		var_0_10.S2C_ARTIFACT_SPIRITLEVELUP_ID_F,
		var_0_10.S2C_ARTIFACT_SPIRITLEVELUP_TARGET_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARTIFACT_SPIRITSTAGEUP_ID_F, {
	"id",
	".cs.C2S_Artifact_SpiritStageUp.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ARTIFACT_SPIRITSTAGEUP_ME, {
	"C2S_Artifact_SpiritStageUp",
	".cs.C2S_Artifact_SpiritStageUp",
	{},
	{},
	{
		var_0_10.C2S_ARTIFACT_SPIRITSTAGEUP_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_SPIRITSTAGEUP_RET_F, {
	"ret",
	".cs.S2C_Artifact_SpiritStageUp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_SPIRITSTAGEUP_ID_F, {
	"id",
	".cs.S2C_Artifact_SpiritStageUp.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARTIFACT_SPIRITSTAGEUP_ME, {
	"S2C_Artifact_SpiritStageUp",
	".cs.S2C_Artifact_SpiritStageUp",
	{},
	{},
	{
		var_0_10.S2C_ARTIFACT_SPIRITSTAGEUP_RET_F,
		var_0_10.S2C_ARTIFACT_SPIRITSTAGEUP_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARTIFACT_URHANDBOOK_ACTIVE_ID_F, {
	"id",
	".cs.C2S_Artifact_URHandbook_Active.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ARTIFACT_URHANDBOOK_ACTIVE_ME, {
	"C2S_Artifact_URHandbook_Active",
	".cs.C2S_Artifact_URHandbook_Active",
	{},
	{},
	{
		var_0_10.C2S_ARTIFACT_URHANDBOOK_ACTIVE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_URHANDBOOK_ACTIVE_RET_F, {
	"ret",
	".cs.S2C_Artifact_URHandbook_Active.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_URHANDBOOK_ACTIVE_ID_F, {
	"id",
	".cs.S2C_Artifact_URHandbook_Active.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARTIFACT_URHANDBOOK_ACTIVE_ME, {
	"S2C_Artifact_URHandbook_Active",
	".cs.S2C_Artifact_URHandbook_Active",
	{},
	{},
	{
		var_0_10.S2C_ARTIFACT_URHANDBOOK_ACTIVE_RET_F,
		var_0_10.S2C_ARTIFACT_URHANDBOOK_ACTIVE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_ARTIFACT_URHANDBOOK_UPGRADE_ID_F, {
	"id",
	".cs.C2S_Artifact_URHandbook_Upgrade.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_ARTIFACT_URHANDBOOK_UPGRADE_ME, {
	"C2S_Artifact_URHandbook_Upgrade",
	".cs.C2S_Artifact_URHandbook_Upgrade",
	{},
	{},
	{
		var_0_10.C2S_ARTIFACT_URHANDBOOK_UPGRADE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_URHANDBOOK_UPGRADE_RET_F, {
	"ret",
	".cs.S2C_Artifact_URHandbook_Upgrade.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_URHANDBOOK_UPGRADE_ID_F, {
	"id",
	".cs.S2C_Artifact_URHandbook_Upgrade.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_ARTIFACT_URHANDBOOK_UPGRADE_NEW_ID_F, {
	"new_id",
	".cs.S2C_Artifact_URHandbook_Upgrade.new_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_ARTIFACT_URHANDBOOK_UPGRADE_ME, {
	"S2C_Artifact_URHandbook_Upgrade",
	".cs.S2C_Artifact_URHandbook_Upgrade",
	{},
	{},
	{
		var_0_10.S2C_ARTIFACT_URHANDBOOK_UPGRADE_RET_F,
		var_0_10.S2C_ARTIFACT_URHANDBOOK_UPGRADE_ID_F,
		var_0_10.S2C_ARTIFACT_URHANDBOOK_UPGRADE_NEW_ID_F
	},
	false,
	{}
})

return var_0_10
