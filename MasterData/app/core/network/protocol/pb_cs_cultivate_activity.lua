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
	C2S_CULTIVATEACTIVITY_GETINFO_ME = protobuf.Descriptor(),
	C2S_CULTIVATEACTIVITY_GETINFO_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_GETINFO_ME = protobuf.Descriptor(),
	S2C_CULTIVATEACTIVITY_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_GETINFO_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_GETINFO_TASKS_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_GETINFO_PASSCARDS_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_UPDATETASK_ME = protobuf.Descriptor(),
	S2C_CULTIVATEACTIVITY_UPDATETASK_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_UPDATETASK_TASKS_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_UPDATEPASSCARD_ME = protobuf.Descriptor(),
	S2C_CULTIVATEACTIVITY_UPDATEPASSCARD_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_UPDATEPASSCARD_PASSCARDS_F = protobuf.FieldDescriptor(),
	C2S_CULTIVATEACTIVITY_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_CULTIVATEACTIVITY_TASKAWARD_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	C2S_CULTIVATEACTIVITY_TASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_CULTIVATEACTIVITY_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_TASKAWARD_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_TASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_CULTIVATEACTIVITY_PASSCARDGIFT_ME = protobuf.Descriptor(),
	C2S_CULTIVATEACTIVITY_PASSCARDGIFT_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	C2S_CULTIVATEACTIVITY_PASSCARDGIFT_PASSCARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_PASSCARDGIFT_ME = protobuf.Descriptor(),
	S2C_CULTIVATEACTIVITY_PASSCARDGIFT_RET_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_PASSCARDGIFT_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_PASSCARDGIFT_PASSCARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_PASSCARDGIFT_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_CULTIVATEACTIVITY_NOTICE_ME = protobuf.Descriptor(),
	S2C_CULTIVATEACTIVITY_NOTICE_LIST_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CULTIVATEACTIVITY_GETINFO_ACTIVITY_ID_F, {
	"activity_id",
	".cs.C2S_CultivateActivity_GetInfo.activity_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_CULTIVATEACTIVITY_GETINFO_ME, {
	"C2S_CultivateActivity_GetInfo",
	".cs.C2S_CultivateActivity_GetInfo",
	{},
	{},
	{
		var_0_10.C2S_CULTIVATEACTIVITY_GETINFO_ACTIVITY_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_GETINFO_RET_F, {
	"ret",
	".cs.S2C_CultivateActivity_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_GETINFO_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_CultivateActivity_GetInfo.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_GETINFO_TASKS_F, {
	"tasks",
	".cs.S2C_CultivateActivity_GetInfo.tasks",
	3,
	2,
	3,
	false,
	{},
	var_0_3.CULTIVATEACTIVITYTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_GETINFO_PASSCARDS_F, {
	"passcards",
	".cs.S2C_CultivateActivity_GetInfo.passcards",
	4,
	3,
	3,
	false,
	{},
	var_0_3.CULTIVATEACTIVITYPASSCARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_GETINFO_ME, {
	"S2C_CultivateActivity_GetInfo",
	".cs.S2C_CultivateActivity_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_CULTIVATEACTIVITY_GETINFO_RET_F,
		var_0_10.S2C_CULTIVATEACTIVITY_GETINFO_ACTIVITY_ID_F,
		var_0_10.S2C_CULTIVATEACTIVITY_GETINFO_TASKS_F,
		var_0_10.S2C_CULTIVATEACTIVITY_GETINFO_PASSCARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_UPDATETASK_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_CultivateActivity_UpdateTask.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_UPDATETASK_TASKS_F, {
	"tasks",
	".cs.S2C_CultivateActivity_UpdateTask.tasks",
	2,
	1,
	3,
	false,
	{},
	var_0_3.CULTIVATEACTIVITYTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_UPDATETASK_ME, {
	"S2C_CultivateActivity_UpdateTask",
	".cs.S2C_CultivateActivity_UpdateTask",
	{},
	{},
	{
		var_0_10.S2C_CULTIVATEACTIVITY_UPDATETASK_ACTIVITY_ID_F,
		var_0_10.S2C_CULTIVATEACTIVITY_UPDATETASK_TASKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_UPDATEPASSCARD_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_CultivateActivity_UpdatePasscard.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_UPDATEPASSCARD_PASSCARDS_F, {
	"passcards",
	".cs.S2C_CultivateActivity_UpdatePasscard.passcards",
	2,
	1,
	3,
	false,
	{},
	var_0_3.CULTIVATEACTIVITYPASSCARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_UPDATEPASSCARD_ME, {
	"S2C_CultivateActivity_UpdatePasscard",
	".cs.S2C_CultivateActivity_UpdatePasscard",
	{},
	{},
	{
		var_0_10.S2C_CULTIVATEACTIVITY_UPDATEPASSCARD_ACTIVITY_ID_F,
		var_0_10.S2C_CULTIVATEACTIVITY_UPDATEPASSCARD_PASSCARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CULTIVATEACTIVITY_TASKAWARD_ACTIVITY_ID_F, {
	"activity_id",
	".cs.C2S_CultivateActivity_TaskAward.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CULTIVATEACTIVITY_TASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.C2S_CultivateActivity_TaskAward.task_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_CULTIVATEACTIVITY_TASKAWARD_ME, {
	"C2S_CultivateActivity_TaskAward",
	".cs.C2S_CultivateActivity_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_CULTIVATEACTIVITY_TASKAWARD_ACTIVITY_ID_F,
		var_0_10.C2S_CULTIVATEACTIVITY_TASKAWARD_TASK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_CultivateActivity_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_TASKAWARD_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_CultivateActivity_TaskAward.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_TASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.S2C_CultivateActivity_TaskAward.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_CultivateActivity_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_TASKAWARD_ME, {
	"S2C_CultivateActivity_TaskAward",
	".cs.S2C_CultivateActivity_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_CULTIVATEACTIVITY_TASKAWARD_RET_F,
		var_0_10.S2C_CULTIVATEACTIVITY_TASKAWARD_ACTIVITY_ID_F,
		var_0_10.S2C_CULTIVATEACTIVITY_TASKAWARD_TASK_ID_F,
		var_0_10.S2C_CULTIVATEACTIVITY_TASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CULTIVATEACTIVITY_PASSCARDGIFT_ACTIVITY_ID_F, {
	"activity_id",
	".cs.C2S_CultivateActivity_PasscardGift.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_CULTIVATEACTIVITY_PASSCARDGIFT_PASSCARD_IDS_F, {
	"passcard_ids",
	".cs.C2S_CultivateActivity_PasscardGift.passcard_ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_CULTIVATEACTIVITY_PASSCARDGIFT_ME, {
	"C2S_CultivateActivity_PasscardGift",
	".cs.C2S_CultivateActivity_PasscardGift",
	{},
	{},
	{
		var_0_10.C2S_CULTIVATEACTIVITY_PASSCARDGIFT_ACTIVITY_ID_F,
		var_0_10.C2S_CULTIVATEACTIVITY_PASSCARDGIFT_PASSCARD_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_PASSCARDGIFT_RET_F, {
	"ret",
	".cs.S2C_CultivateActivity_PasscardGift.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_PASSCARDGIFT_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_CultivateActivity_PasscardGift.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_PASSCARDGIFT_PASSCARD_IDS_F, {
	"passcard_ids",
	".cs.S2C_CultivateActivity_PasscardGift.passcard_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_PASSCARDGIFT_AWARDS_F, {
	"awards",
	".cs.S2C_CultivateActivity_PasscardGift.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_PASSCARDGIFT_ME, {
	"S2C_CultivateActivity_PasscardGift",
	".cs.S2C_CultivateActivity_PasscardGift",
	{},
	{},
	{
		var_0_10.S2C_CULTIVATEACTIVITY_PASSCARDGIFT_RET_F,
		var_0_10.S2C_CULTIVATEACTIVITY_PASSCARDGIFT_ACTIVITY_ID_F,
		var_0_10.S2C_CULTIVATEACTIVITY_PASSCARDGIFT_PASSCARD_IDS_F,
		var_0_10.S2C_CULTIVATEACTIVITY_PASSCARDGIFT_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_NOTICE_LIST_F, {
	"list",
	".cs.S2C_CultivateActivity_Notice.list",
	1,
	0,
	3,
	false,
	{},
	var_0_3.CULTIVATEACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_CULTIVATEACTIVITY_NOTICE_ME, {
	"S2C_CultivateActivity_Notice",
	".cs.S2C_CultivateActivity_Notice",
	{},
	{},
	{
		var_0_10.S2C_CULTIVATEACTIVITY_NOTICE_LIST_F
	},
	false,
	{}
})

return var_0_10
