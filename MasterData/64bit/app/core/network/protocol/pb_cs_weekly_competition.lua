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
	C2S_WEEKLYCOMPETITION_INFO_ME = protobuf.Descriptor(),
	S2C_WEEKLYCOMPETITION_INFO_ME = protobuf.Descriptor(),
	S2C_WEEKLYCOMPETITION_INFO_RET_F = protobuf.FieldDescriptor(),
	S2C_WEEKLYCOMPETITION_INFO_ACTIVITY_F = protobuf.FieldDescriptor(),
	S2C_WEEKLYCOMPETITION_INFO_USER_ACT_F = protobuf.FieldDescriptor(),
	C2S_WEEKLYCOMPETITION_ENTER_ME = protobuf.Descriptor(),
	C2S_WEEKLYCOMPETITION_ENTER_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_WEEKLYCOMPETITION_ENTER_ME = protobuf.Descriptor(),
	S2C_WEEKLYCOMPETITION_ENTER_RET_F = protobuf.FieldDescriptor(),
	S2C_WEEKLYCOMPETITION_ENTER_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_WEEKLYCOMPETITION_ENTER_LAST_SCORE_F = protobuf.FieldDescriptor(),
	C2S_WEEKLYCOMPETITION_SCOREAWARD_ME = protobuf.Descriptor(),
	C2S_WEEKLYCOMPETITION_SCOREAWARD_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	C2S_WEEKLYCOMPETITION_SCOREAWARD_REWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_WEEKLYCOMPETITION_SCOREAWARD_ME = protobuf.Descriptor(),
	S2C_WEEKLYCOMPETITION_SCOREAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_WEEKLYCOMPETITION_SCOREAWARD_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_WEEKLYCOMPETITION_SCOREAWARD_REWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_WEEKLYCOMPETITION_SCOREAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_WEEKLYCOMPETITION_GETRANKLIST_ME = protobuf.Descriptor(),
	C2S_WEEKLYCOMPETITION_GETRANKLIST_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	C2S_WEEKLYCOMPETITION_GETRANKLIST_PAGE_F = protobuf.FieldDescriptor(),
	S2C_WEEKLYCOMPETITION_GETRANKLIST_ME = protobuf.Descriptor(),
	S2C_WEEKLYCOMPETITION_GETRANKLIST_RET_F = protobuf.FieldDescriptor(),
	S2C_WEEKLYCOMPETITION_GETRANKLIST_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_WEEKLYCOMPETITION_GETRANKLIST_PAGE_F = protobuf.FieldDescriptor(),
	S2C_WEEKLYCOMPETITION_GETRANKLIST_TOTAL_PAGE_F = protobuf.FieldDescriptor(),
	S2C_WEEKLYCOMPETITION_GETRANKLIST_SELF_RANK_F = protobuf.FieldDescriptor(),
	S2C_WEEKLYCOMPETITION_GETRANKLIST_RANK_UNITS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_WEEKLYCOMPETITION_INFO_ME, {
	"C2S_WeeklyCompetition_Info",
	".cs.C2S_WeeklyCompetition_Info",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_INFO_RET_F, {
	"ret",
	".cs.S2C_WeeklyCompetition_Info.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_INFO_ACTIVITY_F, {
	"activity",
	".cs.S2C_WeeklyCompetition_Info.activity",
	2,
	1,
	3,
	false,
	{},
	var_0_3.WEEKLYCOMPETITIONACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_INFO_USER_ACT_F, {
	"user_act",
	".cs.S2C_WeeklyCompetition_Info.user_act",
	3,
	2,
	3,
	false,
	{},
	var_0_3.USERWEEKLYCOMPETITIONACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_INFO_ME, {
	"S2C_WeeklyCompetition_Info",
	".cs.S2C_WeeklyCompetition_Info",
	{},
	{},
	{
		var_0_10.S2C_WEEKLYCOMPETITION_INFO_RET_F,
		var_0_10.S2C_WEEKLYCOMPETITION_INFO_ACTIVITY_F,
		var_0_10.S2C_WEEKLYCOMPETITION_INFO_USER_ACT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_WEEKLYCOMPETITION_ENTER_ACTIVITY_ID_F, {
	"activity_id",
	".cs.C2S_WeeklyCompetition_Enter.activity_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_WEEKLYCOMPETITION_ENTER_ME, {
	"C2S_WeeklyCompetition_Enter",
	".cs.C2S_WeeklyCompetition_Enter",
	{},
	{},
	{
		var_0_10.C2S_WEEKLYCOMPETITION_ENTER_ACTIVITY_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_ENTER_RET_F, {
	"ret",
	".cs.S2C_WeeklyCompetition_Enter.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_ENTER_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_WeeklyCompetition_Enter.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_ENTER_LAST_SCORE_F, {
	"last_score",
	".cs.S2C_WeeklyCompetition_Enter.last_score",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_ENTER_ME, {
	"S2C_WeeklyCompetition_Enter",
	".cs.S2C_WeeklyCompetition_Enter",
	{},
	{},
	{
		var_0_10.S2C_WEEKLYCOMPETITION_ENTER_RET_F,
		var_0_10.S2C_WEEKLYCOMPETITION_ENTER_ACTIVITY_ID_F,
		var_0_10.S2C_WEEKLYCOMPETITION_ENTER_LAST_SCORE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_WEEKLYCOMPETITION_SCOREAWARD_ACTIVITY_ID_F, {
	"activity_id",
	".cs.C2S_WeeklyCompetition_ScoreAward.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_WEEKLYCOMPETITION_SCOREAWARD_REWARD_ID_F, {
	"reward_id",
	".cs.C2S_WeeklyCompetition_ScoreAward.reward_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_WEEKLYCOMPETITION_SCOREAWARD_ME, {
	"C2S_WeeklyCompetition_ScoreAward",
	".cs.C2S_WeeklyCompetition_ScoreAward",
	{},
	{},
	{
		var_0_10.C2S_WEEKLYCOMPETITION_SCOREAWARD_ACTIVITY_ID_F,
		var_0_10.C2S_WEEKLYCOMPETITION_SCOREAWARD_REWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_SCOREAWARD_RET_F, {
	"ret",
	".cs.S2C_WeeklyCompetition_ScoreAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_SCOREAWARD_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_WeeklyCompetition_ScoreAward.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_SCOREAWARD_REWARD_ID_F, {
	"reward_id",
	".cs.S2C_WeeklyCompetition_ScoreAward.reward_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_SCOREAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_WeeklyCompetition_ScoreAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_SCOREAWARD_ME, {
	"S2C_WeeklyCompetition_ScoreAward",
	".cs.S2C_WeeklyCompetition_ScoreAward",
	{},
	{},
	{
		var_0_10.S2C_WEEKLYCOMPETITION_SCOREAWARD_RET_F,
		var_0_10.S2C_WEEKLYCOMPETITION_SCOREAWARD_ACTIVITY_ID_F,
		var_0_10.S2C_WEEKLYCOMPETITION_SCOREAWARD_REWARD_ID_F,
		var_0_10.S2C_WEEKLYCOMPETITION_SCOREAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_WEEKLYCOMPETITION_GETRANKLIST_ACTIVITY_ID_F, {
	"activity_id",
	".cs.C2S_WeeklyCompetition_GetRankList.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_WEEKLYCOMPETITION_GETRANKLIST_PAGE_F, {
	"page",
	".cs.C2S_WeeklyCompetition_GetRankList.page",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_WEEKLYCOMPETITION_GETRANKLIST_ME, {
	"C2S_WeeklyCompetition_GetRankList",
	".cs.C2S_WeeklyCompetition_GetRankList",
	{},
	{},
	{
		var_0_10.C2S_WEEKLYCOMPETITION_GETRANKLIST_ACTIVITY_ID_F,
		var_0_10.C2S_WEEKLYCOMPETITION_GETRANKLIST_PAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_GETRANKLIST_RET_F, {
	"ret",
	".cs.S2C_WeeklyCompetition_GetRankList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_GETRANKLIST_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_WeeklyCompetition_GetRankList.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_GETRANKLIST_PAGE_F, {
	"page",
	".cs.S2C_WeeklyCompetition_GetRankList.page",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_GETRANKLIST_TOTAL_PAGE_F, {
	"total_page",
	".cs.S2C_WeeklyCompetition_GetRankList.total_page",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_GETRANKLIST_SELF_RANK_F, {
	"self_rank",
	".cs.S2C_WeeklyCompetition_GetRankList.self_rank",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_GETRANKLIST_RANK_UNITS_F, {
	"rank_units",
	".cs.S2C_WeeklyCompetition_GetRankList.rank_units",
	6,
	5,
	3,
	false,
	{},
	var_0_3.RANKUNIT_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_WEEKLYCOMPETITION_GETRANKLIST_ME, {
	"S2C_WeeklyCompetition_GetRankList",
	".cs.S2C_WeeklyCompetition_GetRankList",
	{},
	{},
	{
		var_0_10.S2C_WEEKLYCOMPETITION_GETRANKLIST_RET_F,
		var_0_10.S2C_WEEKLYCOMPETITION_GETRANKLIST_ACTIVITY_ID_F,
		var_0_10.S2C_WEEKLYCOMPETITION_GETRANKLIST_PAGE_F,
		var_0_10.S2C_WEEKLYCOMPETITION_GETRANKLIST_TOTAL_PAGE_F,
		var_0_10.S2C_WEEKLYCOMPETITION_GETRANKLIST_SELF_RANK_F,
		var_0_10.S2C_WEEKLYCOMPETITION_GETRANKLIST_RANK_UNITS_F
	},
	false,
	{}
})

return var_0_10
