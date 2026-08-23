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
	C2S_MONTHGACHA_ACTIVITYINFO_ME = protobuf.Descriptor(),
	S2C_MONTHGACHA_ACTIVITYINFO_ME = protobuf.Descriptor(),
	S2C_MONTHGACHA_ACTIVITYINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_ACTIVITYINFO_ACTIVITY_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_ACTIVITYINFO_SSR_GUARANT_NUM_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_ACTIVITYINFO_SR_GUARANT_NUM_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_ACTIVITYINFO_REWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_ACTIVITYINFO_ROUND_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_ACTIVITYINFO_LUCKY_VALUE_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_ACTIVITYINFO_REWARD_ID_INDEX_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_ACTIVITYINFO_DRAW_TOTAL_TIMES_F = protobuf.FieldDescriptor(),
	C2S_MONTHGACHA_TASKINFO_ME = protobuf.Descriptor(),
	S2C_MONTHGACHA_TASKINFO_ME = protobuf.Descriptor(),
	S2C_MONTHGACHA_TASKINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_TASKINFO_TASK_INFOS_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_TASKINFO_TASK_AWARDED_IDS_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_TASKNOTIFY_ME = protobuf.Descriptor(),
	S2C_MONTHGACHA_TASKNOTIFY_DAILY_VALUE_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_TASKNOTIFY_PHASE_VALUE_F = protobuf.FieldDescriptor(),
	C2S_MONTHGACHA_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_MONTHGACHA_TASKAWARD_TASK_IDS_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_MONTHGACHA_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_TASKAWARD_TASK_IDS_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_MONTHGACHA_DRAW_ME = protobuf.Descriptor(),
	C2S_MONTHGACHA_DRAW_RECRUIT_TYPE_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_DRAW_ME = protobuf.Descriptor(),
	S2C_MONTHGACHA_DRAW_RET_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_DRAW_RECRUIT_TYPE_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_DRAW_SSR_GUARANT_NUM_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_DRAW_SR_GUARANT_NUM_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_DRAW_REWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_DRAW_LUCKY_VALUE_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_DRAW_DRAW_TOTAL_TIMES_F = protobuf.FieldDescriptor(),
	C2S_MONTHGACHA_RESET_ME = protobuf.Descriptor(),
	S2C_MONTHGACHA_RESET_ME = protobuf.Descriptor(),
	S2C_MONTHGACHA_RESET_RET_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_RESET_SSR_GUARANT_NUM_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_RESET_SR_GUARANT_NUM_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_RESET_REWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_RESET_ROUND_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_RESET_LUCKY_VALUE_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_RESET_REWARD_ID_INDEX_F = protobuf.FieldDescriptor(),
	C2S_MONTHGACHA_CHOSEAWARD_ME = protobuf.Descriptor(),
	C2S_MONTHGACHA_CHOSEAWARD_AWARD_ID_F = protobuf.FieldDescriptor(),
	C2S_MONTHGACHA_CHOSEAWARD_INDEX_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_CHOSEAWARD_ME = protobuf.Descriptor(),
	S2C_MONTHGACHA_CHOSEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_CHOSEAWARD_AWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_MONTHGACHA_CHOSEAWARD_INDEX_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_MONTHGACHA_ACTIVITYINFO_ME, {
	"C2S_MonthGacha_ActivityInfo",
	".cs.C2S_MonthGacha_ActivityInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_RET_F, {
	"ret",
	".cs.S2C_MonthGacha_ActivityInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_ACTIVITY_F, {
	"activity",
	".cs.S2C_MonthGacha_ActivityInfo.activity",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.MONTHGACHAACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_SSR_GUARANT_NUM_F, {
	"ssr_guarant_num",
	".cs.S2C_MonthGacha_ActivityInfo.ssr_guarant_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_SR_GUARANT_NUM_F, {
	"sr_guarant_num",
	".cs.S2C_MonthGacha_ActivityInfo.sr_guarant_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_REWARD_IDS_F, {
	"reward_ids",
	".cs.S2C_MonthGacha_ActivityInfo.reward_ids",
	5,
	4,
	3,
	false,
	{},
	var_0_3.UINT32KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_ROUND_F, {
	"round",
	".cs.S2C_MonthGacha_ActivityInfo.round",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_LUCKY_VALUE_F, {
	"lucky_value",
	".cs.S2C_MonthGacha_ActivityInfo.lucky_value",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_REWARD_ID_INDEX_F, {
	"reward_id_index",
	".cs.S2C_MonthGacha_ActivityInfo.reward_id_index",
	8,
	7,
	3,
	false,
	{},
	var_0_3.UINT32KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_DRAW_TOTAL_TIMES_F, {
	"draw_total_times",
	".cs.S2C_MonthGacha_ActivityInfo.draw_total_times",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_ME, {
	"S2C_MonthGacha_ActivityInfo",
	".cs.S2C_MonthGacha_ActivityInfo",
	{},
	{},
	{
		var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_RET_F,
		var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_ACTIVITY_F,
		var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_SSR_GUARANT_NUM_F,
		var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_SR_GUARANT_NUM_F,
		var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_REWARD_IDS_F,
		var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_ROUND_F,
		var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_LUCKY_VALUE_F,
		var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_REWARD_ID_INDEX_F,
		var_0_10.S2C_MONTHGACHA_ACTIVITYINFO_DRAW_TOTAL_TIMES_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MONTHGACHA_TASKINFO_ME, {
	"C2S_MonthGacha_TaskInfo",
	".cs.C2S_MonthGacha_TaskInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_TASKINFO_RET_F, {
	"ret",
	".cs.S2C_MonthGacha_TaskInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_TASKINFO_TASK_INFOS_F, {
	"task_infos",
	".cs.S2C_MonthGacha_TaskInfo.task_infos",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.MONTHGACHATASK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_TASKINFO_TASK_AWARDED_IDS_F, {
	"task_awarded_ids",
	".cs.S2C_MonthGacha_TaskInfo.task_awarded_ids",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MONTHGACHA_TASKINFO_ME, {
	"S2C_MonthGacha_TaskInfo",
	".cs.S2C_MonthGacha_TaskInfo",
	{},
	{},
	{
		var_0_10.S2C_MONTHGACHA_TASKINFO_RET_F,
		var_0_10.S2C_MONTHGACHA_TASKINFO_TASK_INFOS_F,
		var_0_10.S2C_MONTHGACHA_TASKINFO_TASK_AWARDED_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_TASKNOTIFY_DAILY_VALUE_F, {
	"daily_value",
	".cs.S2C_MonthGacha_TaskNotify.daily_value",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.TASKINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_TASKNOTIFY_PHASE_VALUE_F, {
	"phase_value",
	".cs.S2C_MonthGacha_TaskNotify.phase_value",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.TASKINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MONTHGACHA_TASKNOTIFY_ME, {
	"S2C_MonthGacha_TaskNotify",
	".cs.S2C_MonthGacha_TaskNotify",
	{},
	{},
	{
		var_0_10.S2C_MONTHGACHA_TASKNOTIFY_DAILY_VALUE_F,
		var_0_10.S2C_MONTHGACHA_TASKNOTIFY_PHASE_VALUE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MONTHGACHA_TASKAWARD_TASK_IDS_F, {
	"task_ids",
	".cs.C2S_MonthGacha_TaskAward.task_ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MONTHGACHA_TASKAWARD_ME, {
	"C2S_MonthGacha_TaskAward",
	".cs.C2S_MonthGacha_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_MONTHGACHA_TASKAWARD_TASK_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_MonthGacha_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_TASKAWARD_TASK_IDS_F, {
	"task_ids",
	".cs.S2C_MonthGacha_TaskAward.task_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_MonthGacha_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MONTHGACHA_TASKAWARD_ME, {
	"S2C_MonthGacha_TaskAward",
	".cs.S2C_MonthGacha_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_MONTHGACHA_TASKAWARD_RET_F,
		var_0_10.S2C_MONTHGACHA_TASKAWARD_TASK_IDS_F,
		var_0_10.S2C_MONTHGACHA_TASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MONTHGACHA_DRAW_RECRUIT_TYPE_F, {
	"recruit_type",
	".cs.C2S_MonthGacha_Draw.recruit_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MONTHGACHA_DRAW_ME, {
	"C2S_MonthGacha_Draw",
	".cs.C2S_MonthGacha_Draw",
	{},
	{},
	{
		var_0_10.C2S_MONTHGACHA_DRAW_RECRUIT_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_DRAW_RET_F, {
	"ret",
	".cs.S2C_MonthGacha_Draw.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_DRAW_RECRUIT_TYPE_F, {
	"recruit_type",
	".cs.S2C_MonthGacha_Draw.recruit_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_DRAW_SSR_GUARANT_NUM_F, {
	"ssr_guarant_num",
	".cs.S2C_MonthGacha_Draw.ssr_guarant_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_DRAW_SR_GUARANT_NUM_F, {
	"sr_guarant_num",
	".cs.S2C_MonthGacha_Draw.sr_guarant_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_DRAW_REWARD_IDS_F, {
	"reward_ids",
	".cs.S2C_MonthGacha_Draw.reward_ids",
	5,
	4,
	3,
	false,
	{},
	var_0_3.UINT32KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_DRAW_LUCKY_VALUE_F, {
	"lucky_value",
	".cs.S2C_MonthGacha_Draw.lucky_value",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_DRAW_DRAW_TOTAL_TIMES_F, {
	"draw_total_times",
	".cs.S2C_MonthGacha_Draw.draw_total_times",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MONTHGACHA_DRAW_ME, {
	"S2C_MonthGacha_Draw",
	".cs.S2C_MonthGacha_Draw",
	{},
	{},
	{
		var_0_10.S2C_MONTHGACHA_DRAW_RET_F,
		var_0_10.S2C_MONTHGACHA_DRAW_RECRUIT_TYPE_F,
		var_0_10.S2C_MONTHGACHA_DRAW_SSR_GUARANT_NUM_F,
		var_0_10.S2C_MONTHGACHA_DRAW_SR_GUARANT_NUM_F,
		var_0_10.S2C_MONTHGACHA_DRAW_REWARD_IDS_F,
		var_0_10.S2C_MONTHGACHA_DRAW_LUCKY_VALUE_F,
		var_0_10.S2C_MONTHGACHA_DRAW_DRAW_TOTAL_TIMES_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_MONTHGACHA_RESET_ME, {
	"C2S_MonthGacha_Reset",
	".cs.C2S_MonthGacha_Reset",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_RESET_RET_F, {
	"ret",
	".cs.S2C_MonthGacha_Reset.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_RESET_SSR_GUARANT_NUM_F, {
	"ssr_guarant_num",
	".cs.S2C_MonthGacha_Reset.ssr_guarant_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_RESET_SR_GUARANT_NUM_F, {
	"sr_guarant_num",
	".cs.S2C_MonthGacha_Reset.sr_guarant_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_RESET_REWARD_IDS_F, {
	"reward_ids",
	".cs.S2C_MonthGacha_Reset.reward_ids",
	5,
	3,
	3,
	false,
	{},
	var_0_3.UINT32KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_RESET_ROUND_F, {
	"round",
	".cs.S2C_MonthGacha_Reset.round",
	6,
	4,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_RESET_LUCKY_VALUE_F, {
	"lucky_value",
	".cs.S2C_MonthGacha_Reset.lucky_value",
	7,
	5,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_RESET_REWARD_ID_INDEX_F, {
	"reward_id_index",
	".cs.S2C_MonthGacha_Reset.reward_id_index",
	8,
	6,
	3,
	false,
	{},
	var_0_3.UINT32KV_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MONTHGACHA_RESET_ME, {
	"S2C_MonthGacha_Reset",
	".cs.S2C_MonthGacha_Reset",
	{},
	{},
	{
		var_0_10.S2C_MONTHGACHA_RESET_RET_F,
		var_0_10.S2C_MONTHGACHA_RESET_SSR_GUARANT_NUM_F,
		var_0_10.S2C_MONTHGACHA_RESET_SR_GUARANT_NUM_F,
		var_0_10.S2C_MONTHGACHA_RESET_REWARD_IDS_F,
		var_0_10.S2C_MONTHGACHA_RESET_ROUND_F,
		var_0_10.S2C_MONTHGACHA_RESET_LUCKY_VALUE_F,
		var_0_10.S2C_MONTHGACHA_RESET_REWARD_ID_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MONTHGACHA_CHOSEAWARD_AWARD_ID_F, {
	"award_id",
	".cs.C2S_MonthGacha_ChoseAward.award_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MONTHGACHA_CHOSEAWARD_INDEX_F, {
	"index",
	".cs.C2S_MonthGacha_ChoseAward.index",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MONTHGACHA_CHOSEAWARD_ME, {
	"C2S_MonthGacha_ChoseAward",
	".cs.C2S_MonthGacha_ChoseAward",
	{},
	{},
	{
		var_0_10.C2S_MONTHGACHA_CHOSEAWARD_AWARD_ID_F,
		var_0_10.C2S_MONTHGACHA_CHOSEAWARD_INDEX_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_CHOSEAWARD_RET_F, {
	"ret",
	".cs.S2C_MonthGacha_ChoseAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_CHOSEAWARD_AWARD_ID_F, {
	"award_id",
	".cs.S2C_MonthGacha_ChoseAward.award_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONTHGACHA_CHOSEAWARD_INDEX_F, {
	"index",
	".cs.S2C_MonthGacha_ChoseAward.index",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MONTHGACHA_CHOSEAWARD_ME, {
	"S2C_MonthGacha_ChoseAward",
	".cs.S2C_MonthGacha_ChoseAward",
	{},
	{},
	{
		var_0_10.S2C_MONTHGACHA_CHOSEAWARD_RET_F,
		var_0_10.S2C_MONTHGACHA_CHOSEAWARD_AWARD_ID_F,
		var_0_10.S2C_MONTHGACHA_CHOSEAWARD_INDEX_F
	},
	false,
	{}
})

return var_0_10
