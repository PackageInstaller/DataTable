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
	C2S_SUCCUBA_GETINFO_ME = protobuf.Descriptor(),
	S2C_SUCCUBA_GETINFO_ME = protobuf.Descriptor(),
	S2C_SUCCUBA_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_GETINFO_SUCCUBAS_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_GETINFO_INTER_ACTIONS_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_GETINFO_ACTION_TIMES_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_GETINFO_MAIN_SUCCUBA_ID_F = protobuf.FieldDescriptor(),
	C2S_SUCCUBA_LEVELUP_ME = protobuf.Descriptor(),
	C2S_SUCCUBA_LEVELUP_ID_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_LEVELUP_ME = protobuf.Descriptor(),
	S2C_SUCCUBA_LEVELUP_RET_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_LEVELUP_ID_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_LEVELUP_LEVEL_F = protobuf.FieldDescriptor(),
	C2S_SUCCUBA_STARUP_ME = protobuf.Descriptor(),
	C2S_SUCCUBA_STARUP_ID_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_STARUP_ME = protobuf.Descriptor(),
	S2C_SUCCUBA_STARUP_RET_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_STARUP_ID_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_STARUP_STAR_F = protobuf.FieldDescriptor(),
	C2S_SUCCUBA_INTERACTIVEGET_ME = protobuf.Descriptor(),
	C2S_SUCCUBA_INTERACTIVEGET_ID_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_INTERACTIVEGET_ME = protobuf.Descriptor(),
	S2C_SUCCUBA_INTERACTIVEGET_RET_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_INTERACTIVEGET_ID_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_INTERACTIVEGET_EVENT_ID_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_INTERACTIVEGET_PROGRESS_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_INTERACTIVEGET_INTERACTION_F = protobuf.FieldDescriptor(),
	C2S_SUCCUBA_INTERACTIVESAVE_ME = protobuf.Descriptor(),
	C2S_SUCCUBA_INTERACTIVESAVE_ID_F = protobuf.FieldDescriptor(),
	C2S_SUCCUBA_INTERACTIVESAVE_EVENT_ID_F = protobuf.FieldDescriptor(),
	C2S_SUCCUBA_INTERACTIVESAVE_PROGRESS_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_INTERACTIVESAVE_ME = protobuf.Descriptor(),
	S2C_SUCCUBA_INTERACTIVESAVE_RET_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_INTERACTIVESAVE_ID_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_INTERACTIVESAVE_EVENT_ID_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_INTERACTIVESAVE_PROGRESS_F = protobuf.FieldDescriptor(),
	C2S_SUCCUBA_INTERACTIVEFINISH_ME = protobuf.Descriptor(),
	C2S_SUCCUBA_INTERACTIVEFINISH_ID_F = protobuf.FieldDescriptor(),
	C2S_SUCCUBA_INTERACTIVEFINISH_EVENT_ID_F = protobuf.FieldDescriptor(),
	C2S_SUCCUBA_INTERACTIVEFINISH_TP_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_INTERACTIVEFINISH_ME = protobuf.Descriptor(),
	S2C_SUCCUBA_INTERACTIVEFINISH_RET_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_INTERACTIVEFINISH_ID_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_INTERACTIVEFINISH_EVENT_ID_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_INTERACTIVEFINISH_TP_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_INTERACTIVEFINISH_DATA_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_FLUSH_ME = protobuf.Descriptor(),
	S2C_SUCCUBA_FLUSH_SUCCUBAS_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_FLUSH_INTER_ACTIONS_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_FLUSH_ACTION_TIMES_F = protobuf.FieldDescriptor(),
	C2S_SUCCUBA_SETMAINSUCCUBA_ME = protobuf.Descriptor(),
	C2S_SUCCUBA_SETMAINSUCCUBA_ID_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_SETMAINSUCCUBA_ME = protobuf.Descriptor(),
	S2C_SUCCUBA_SETMAINSUCCUBA_RET_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_SETMAINSUCCUBA_ID_F = protobuf.FieldDescriptor(),
	C2S_SUCCUBA_STAGEUP_ME = protobuf.Descriptor(),
	C2S_SUCCUBA_STAGEUP_ID_F = protobuf.FieldDescriptor(),
	C2S_SUCCUBA_STAGEUP_NEXT_STAGE_F = protobuf.FieldDescriptor(),
	C2S_SUCCUBA_STAGEUP_NEXT_NODE_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_STAGEUP_ME = protobuf.Descriptor(),
	S2C_SUCCUBA_STAGEUP_RET_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_STAGEUP_ID_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_STAGEUP_NEXT_STAGE_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_STAGEUP_NEXT_NODE_F = protobuf.FieldDescriptor(),
	C2S_SUCCUBA_ACTIVITY_GETINFO_ME = protobuf.Descriptor(),
	S2C_SUCCUBA_ACTIVITY_GETINFO_ME = protobuf.Descriptor(),
	S2C_SUCCUBA_ACTIVITY_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_ACTIVITY_GETINFO_ACTIVITY_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_ACTIVITY_GETINFO_TASK_F = protobuf.FieldDescriptor(),
	C2S_SUCCUBA_ACTIVITY_FINISHTASK_ME = protobuf.Descriptor(),
	C2S_SUCCUBA_ACTIVITY_FINISHTASK_TASK_IDS_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_ACTIVITY_FINISHTASK_ME = protobuf.Descriptor(),
	S2C_SUCCUBA_ACTIVITY_FINISHTASK_RET_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_ACTIVITY_FINISHTASK_TASK_IDS_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_ACTIVITY_FINISHTASK_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_ACTIVITY_NOTIFY_ME = protobuf.Descriptor(),
	S2C_SUCCUBA_ACTIVITY_NOTIFY_DATA_F = protobuf.FieldDescriptor(),
	S2C_SUCCUBA_ACTIVITY_TASKNOTIFY_ME = protobuf.Descriptor(),
	S2C_SUCCUBA_ACTIVITY_TASKNOTIFY_TASKS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_SUCCUBA_GETINFO_ME, {
	"C2S_Succuba_GetInfo",
	".cs.C2S_Succuba_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Succuba_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_GETINFO_SUCCUBAS_F, {
	"succubas",
	".cs.S2C_Succuba_GetInfo.succubas",
	2,
	1,
	3,
	false,
	{},
	var_0_3.SUCCUBA_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_GETINFO_INTER_ACTIONS_F, {
	"inter_actions",
	".cs.S2C_Succuba_GetInfo.inter_actions",
	3,
	2,
	3,
	false,
	{},
	var_0_3.SUCCUBAINTERACTION_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_GETINFO_ACTION_TIMES_F, {
	"action_times",
	".cs.S2C_Succuba_GetInfo.action_times",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_GETINFO_MAIN_SUCCUBA_ID_F, {
	"main_succuba_id",
	".cs.S2C_Succuba_GetInfo.main_succuba_id",
	5,
	4,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_10.S2C_SUCCUBA_GETINFO_ME, {
	"S2C_Succuba_GetInfo",
	".cs.S2C_Succuba_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_SUCCUBA_GETINFO_RET_F,
		var_0_10.S2C_SUCCUBA_GETINFO_SUCCUBAS_F,
		var_0_10.S2C_SUCCUBA_GETINFO_INTER_ACTIONS_F,
		var_0_10.S2C_SUCCUBA_GETINFO_ACTION_TIMES_F,
		var_0_10.S2C_SUCCUBA_GETINFO_MAIN_SUCCUBA_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SUCCUBA_LEVELUP_ID_F, {
	"id",
	".cs.C2S_Succuba_LevelUp.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_SUCCUBA_LEVELUP_ME, {
	"C2S_Succuba_LevelUp",
	".cs.C2S_Succuba_LevelUp",
	{},
	{},
	{
		var_0_10.C2S_SUCCUBA_LEVELUP_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_LEVELUP_RET_F, {
	"ret",
	".cs.S2C_Succuba_LevelUp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_LEVELUP_ID_F, {
	"id",
	".cs.S2C_Succuba_LevelUp.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_LEVELUP_LEVEL_F, {
	"level",
	".cs.S2C_Succuba_LevelUp.level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SUCCUBA_LEVELUP_ME, {
	"S2C_Succuba_LevelUp",
	".cs.S2C_Succuba_LevelUp",
	{},
	{},
	{
		var_0_10.S2C_SUCCUBA_LEVELUP_RET_F,
		var_0_10.S2C_SUCCUBA_LEVELUP_ID_F,
		var_0_10.S2C_SUCCUBA_LEVELUP_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SUCCUBA_STARUP_ID_F, {
	"id",
	".cs.C2S_Succuba_StarUp.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_SUCCUBA_STARUP_ME, {
	"C2S_Succuba_StarUp",
	".cs.C2S_Succuba_StarUp",
	{},
	{},
	{
		var_0_10.C2S_SUCCUBA_STARUP_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_STARUP_RET_F, {
	"ret",
	".cs.S2C_Succuba_StarUp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_STARUP_ID_F, {
	"id",
	".cs.S2C_Succuba_StarUp.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_STARUP_STAR_F, {
	"star",
	".cs.S2C_Succuba_StarUp.star",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SUCCUBA_STARUP_ME, {
	"S2C_Succuba_StarUp",
	".cs.S2C_Succuba_StarUp",
	{},
	{},
	{
		var_0_10.S2C_SUCCUBA_STARUP_RET_F,
		var_0_10.S2C_SUCCUBA_STARUP_ID_F,
		var_0_10.S2C_SUCCUBA_STARUP_STAR_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SUCCUBA_INTERACTIVEGET_ID_F, {
	"id",
	".cs.C2S_Succuba_InterActiveGet.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_SUCCUBA_INTERACTIVEGET_ME, {
	"C2S_Succuba_InterActiveGet",
	".cs.C2S_Succuba_InterActiveGet",
	{},
	{},
	{
		var_0_10.C2S_SUCCUBA_INTERACTIVEGET_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVEGET_RET_F, {
	"ret",
	".cs.S2C_Succuba_InterActiveGet.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVEGET_ID_F, {
	"id",
	".cs.S2C_Succuba_InterActiveGet.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVEGET_EVENT_ID_F, {
	"event_id",
	".cs.S2C_Succuba_InterActiveGet.event_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVEGET_PROGRESS_F, {
	"progress",
	".cs.S2C_Succuba_InterActiveGet.progress",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVEGET_INTERACTION_F, {
	"interaction",
	".cs.S2C_Succuba_InterActiveGet.interaction",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.SUCCUBAINTERACTION_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVEGET_ME, {
	"S2C_Succuba_InterActiveGet",
	".cs.S2C_Succuba_InterActiveGet",
	{},
	{},
	{
		var_0_10.S2C_SUCCUBA_INTERACTIVEGET_RET_F,
		var_0_10.S2C_SUCCUBA_INTERACTIVEGET_ID_F,
		var_0_10.S2C_SUCCUBA_INTERACTIVEGET_EVENT_ID_F,
		var_0_10.S2C_SUCCUBA_INTERACTIVEGET_PROGRESS_F,
		var_0_10.S2C_SUCCUBA_INTERACTIVEGET_INTERACTION_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SUCCUBA_INTERACTIVESAVE_ID_F, {
	"id",
	".cs.C2S_Succuba_InterActiveSave.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SUCCUBA_INTERACTIVESAVE_EVENT_ID_F, {
	"event_id",
	".cs.C2S_Succuba_InterActiveSave.event_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SUCCUBA_INTERACTIVESAVE_PROGRESS_F, {
	"progress",
	".cs.C2S_Succuba_InterActiveSave.progress",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_SUCCUBA_INTERACTIVESAVE_ME, {
	"C2S_Succuba_InterActiveSave",
	".cs.C2S_Succuba_InterActiveSave",
	{},
	{},
	{
		var_0_10.C2S_SUCCUBA_INTERACTIVESAVE_ID_F,
		var_0_10.C2S_SUCCUBA_INTERACTIVESAVE_EVENT_ID_F,
		var_0_10.C2S_SUCCUBA_INTERACTIVESAVE_PROGRESS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVESAVE_RET_F, {
	"ret",
	".cs.S2C_Succuba_InterActiveSave.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVESAVE_ID_F, {
	"id",
	".cs.S2C_Succuba_InterActiveSave.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVESAVE_EVENT_ID_F, {
	"event_id",
	".cs.S2C_Succuba_InterActiveSave.event_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVESAVE_PROGRESS_F, {
	"progress",
	".cs.S2C_Succuba_InterActiveSave.progress",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVESAVE_ME, {
	"S2C_Succuba_InterActiveSave",
	".cs.S2C_Succuba_InterActiveSave",
	{},
	{},
	{
		var_0_10.S2C_SUCCUBA_INTERACTIVESAVE_RET_F,
		var_0_10.S2C_SUCCUBA_INTERACTIVESAVE_ID_F,
		var_0_10.S2C_SUCCUBA_INTERACTIVESAVE_EVENT_ID_F,
		var_0_10.S2C_SUCCUBA_INTERACTIVESAVE_PROGRESS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SUCCUBA_INTERACTIVEFINISH_ID_F, {
	"id",
	".cs.C2S_Succuba_InterActiveFinish.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SUCCUBA_INTERACTIVEFINISH_EVENT_ID_F, {
	"event_id",
	".cs.C2S_Succuba_InterActiveFinish.event_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SUCCUBA_INTERACTIVEFINISH_TP_F, {
	"tp",
	".cs.C2S_Succuba_InterActiveFinish.tp",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_SUCCUBA_INTERACTIVEFINISH_ME, {
	"C2S_Succuba_InterActiveFinish",
	".cs.C2S_Succuba_InterActiveFinish",
	{},
	{},
	{
		var_0_10.C2S_SUCCUBA_INTERACTIVEFINISH_ID_F,
		var_0_10.C2S_SUCCUBA_INTERACTIVEFINISH_EVENT_ID_F,
		var_0_10.C2S_SUCCUBA_INTERACTIVEFINISH_TP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVEFINISH_RET_F, {
	"ret",
	".cs.S2C_Succuba_InterActiveFinish.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVEFINISH_ID_F, {
	"id",
	".cs.S2C_Succuba_InterActiveFinish.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVEFINISH_EVENT_ID_F, {
	"event_id",
	".cs.S2C_Succuba_InterActiveFinish.event_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVEFINISH_TP_F, {
	"tp",
	".cs.S2C_Succuba_InterActiveFinish.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVEFINISH_DATA_F, {
	"data",
	".cs.S2C_Succuba_InterActiveFinish.data",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.SUCCUBAINTERACTION_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_SUCCUBA_INTERACTIVEFINISH_ME, {
	"S2C_Succuba_InterActiveFinish",
	".cs.S2C_Succuba_InterActiveFinish",
	{},
	{},
	{
		var_0_10.S2C_SUCCUBA_INTERACTIVEFINISH_RET_F,
		var_0_10.S2C_SUCCUBA_INTERACTIVEFINISH_ID_F,
		var_0_10.S2C_SUCCUBA_INTERACTIVEFINISH_EVENT_ID_F,
		var_0_10.S2C_SUCCUBA_INTERACTIVEFINISH_TP_F,
		var_0_10.S2C_SUCCUBA_INTERACTIVEFINISH_DATA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_FLUSH_SUCCUBAS_F, {
	"succubas",
	".cs.S2C_Succuba_Flush.succubas",
	1,
	0,
	3,
	false,
	{},
	var_0_3.SUCCUBA_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_FLUSH_INTER_ACTIONS_F, {
	"inter_actions",
	".cs.S2C_Succuba_Flush.inter_actions",
	2,
	1,
	3,
	false,
	{},
	var_0_3.SUCCUBAINTERACTION_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_FLUSH_ACTION_TIMES_F, {
	"action_times",
	".cs.S2C_Succuba_Flush.action_times",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SUCCUBA_FLUSH_ME, {
	"S2C_Succuba_Flush",
	".cs.S2C_Succuba_Flush",
	{},
	{},
	{
		var_0_10.S2C_SUCCUBA_FLUSH_SUCCUBAS_F,
		var_0_10.S2C_SUCCUBA_FLUSH_INTER_ACTIONS_F,
		var_0_10.S2C_SUCCUBA_FLUSH_ACTION_TIMES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SUCCUBA_SETMAINSUCCUBA_ID_F, {
	"id",
	".cs.C2S_Succuba_SetMainSuccuba.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_SUCCUBA_SETMAINSUCCUBA_ME, {
	"C2S_Succuba_SetMainSuccuba",
	".cs.C2S_Succuba_SetMainSuccuba",
	{},
	{},
	{
		var_0_10.C2S_SUCCUBA_SETMAINSUCCUBA_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_SETMAINSUCCUBA_RET_F, {
	"ret",
	".cs.S2C_Succuba_SetMainSuccuba.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_SETMAINSUCCUBA_ID_F, {
	"id",
	".cs.S2C_Succuba_SetMainSuccuba.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SUCCUBA_SETMAINSUCCUBA_ME, {
	"S2C_Succuba_SetMainSuccuba",
	".cs.S2C_Succuba_SetMainSuccuba",
	{},
	{},
	{
		var_0_10.S2C_SUCCUBA_SETMAINSUCCUBA_RET_F,
		var_0_10.S2C_SUCCUBA_SETMAINSUCCUBA_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SUCCUBA_STAGEUP_ID_F, {
	"id",
	".cs.C2S_Succuba_StageUp.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SUCCUBA_STAGEUP_NEXT_STAGE_F, {
	"next_stage",
	".cs.C2S_Succuba_StageUp.next_stage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SUCCUBA_STAGEUP_NEXT_NODE_F, {
	"next_node",
	".cs.C2S_Succuba_StageUp.next_node",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_SUCCUBA_STAGEUP_ME, {
	"C2S_Succuba_StageUp",
	".cs.C2S_Succuba_StageUp",
	{},
	{},
	{
		var_0_10.C2S_SUCCUBA_STAGEUP_ID_F,
		var_0_10.C2S_SUCCUBA_STAGEUP_NEXT_STAGE_F,
		var_0_10.C2S_SUCCUBA_STAGEUP_NEXT_NODE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_STAGEUP_RET_F, {
	"ret",
	".cs.S2C_Succuba_StageUp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_STAGEUP_ID_F, {
	"id",
	".cs.S2C_Succuba_StageUp.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_STAGEUP_NEXT_STAGE_F, {
	"next_stage",
	".cs.S2C_Succuba_StageUp.next_stage",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_STAGEUP_NEXT_NODE_F, {
	"next_node",
	".cs.S2C_Succuba_StageUp.next_node",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SUCCUBA_STAGEUP_ME, {
	"S2C_Succuba_StageUp",
	".cs.S2C_Succuba_StageUp",
	{},
	{},
	{
		var_0_10.S2C_SUCCUBA_STAGEUP_RET_F,
		var_0_10.S2C_SUCCUBA_STAGEUP_ID_F,
		var_0_10.S2C_SUCCUBA_STAGEUP_NEXT_STAGE_F,
		var_0_10.S2C_SUCCUBA_STAGEUP_NEXT_NODE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_SUCCUBA_ACTIVITY_GETINFO_ME, {
	"C2S_Succuba_Activity_GetInfo",
	".cs.C2S_Succuba_Activity_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_ACTIVITY_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Succuba_Activity_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_ACTIVITY_GETINFO_ACTIVITY_F, {
	"activity",
	".cs.S2C_Succuba_Activity_GetInfo.activity",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.SUCCUBAACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_ACTIVITY_GETINFO_TASK_F, {
	"task",
	".cs.S2C_Succuba_Activity_GetInfo.task",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.SUCCUBAACTIVTYTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_SUCCUBA_ACTIVITY_GETINFO_ME, {
	"S2C_Succuba_Activity_GetInfo",
	".cs.S2C_Succuba_Activity_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_SUCCUBA_ACTIVITY_GETINFO_RET_F,
		var_0_10.S2C_SUCCUBA_ACTIVITY_GETINFO_ACTIVITY_F,
		var_0_10.S2C_SUCCUBA_ACTIVITY_GETINFO_TASK_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_SUCCUBA_ACTIVITY_FINISHTASK_TASK_IDS_F, {
	"task_ids",
	".cs.C2S_Succuba_Activity_FinishTask.task_ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_SUCCUBA_ACTIVITY_FINISHTASK_ME, {
	"C2S_Succuba_Activity_FinishTask",
	".cs.C2S_Succuba_Activity_FinishTask",
	{},
	{},
	{
		var_0_10.C2S_SUCCUBA_ACTIVITY_FINISHTASK_TASK_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_ACTIVITY_FINISHTASK_RET_F, {
	"ret",
	".cs.S2C_Succuba_Activity_FinishTask.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_ACTIVITY_FINISHTASK_TASK_IDS_F, {
	"task_ids",
	".cs.S2C_Succuba_Activity_FinishTask.task_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_ACTIVITY_FINISHTASK_AWARDS_F, {
	"awards",
	".cs.S2C_Succuba_Activity_FinishTask.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_SUCCUBA_ACTIVITY_FINISHTASK_ME, {
	"S2C_Succuba_Activity_FinishTask",
	".cs.S2C_Succuba_Activity_FinishTask",
	{},
	{},
	{
		var_0_10.S2C_SUCCUBA_ACTIVITY_FINISHTASK_RET_F,
		var_0_10.S2C_SUCCUBA_ACTIVITY_FINISHTASK_TASK_IDS_F,
		var_0_10.S2C_SUCCUBA_ACTIVITY_FINISHTASK_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_ACTIVITY_NOTIFY_DATA_F, {
	"data",
	".cs.S2C_Succuba_Activity_Notify.data",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.SUCCUBAACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_SUCCUBA_ACTIVITY_NOTIFY_ME, {
	"S2C_Succuba_Activity_Notify",
	".cs.S2C_Succuba_Activity_Notify",
	{},
	{},
	{
		var_0_10.S2C_SUCCUBA_ACTIVITY_NOTIFY_DATA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_SUCCUBA_ACTIVITY_TASKNOTIFY_TASKS_F, {
	"tasks",
	".cs.S2C_Succuba_Activity_TaskNotify.tasks",
	1,
	0,
	3,
	false,
	{},
	var_0_3.KV2_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_SUCCUBA_ACTIVITY_TASKNOTIFY_ME, {
	"S2C_Succuba_Activity_TaskNotify",
	".cs.S2C_Succuba_Activity_TaskNotify",
	{},
	{},
	{
		var_0_10.S2C_SUCCUBA_ACTIVITY_TASKNOTIFY_TASKS_F
	},
	false,
	{}
})

return var_0_10
