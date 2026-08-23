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
	C2S_COMMONPASSCARD_GETINFO_ME = protobuf.Descriptor(),
	C2S_COMMONPASSCARD_GETINFO_ID_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_GETINFO_ME = protobuf.Descriptor(),
	S2C_COMMONPASSCARD_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_GETINFO_PASSCARD_F = protobuf.FieldDescriptor(),
	C2S_COMMONPASSCARD_LEVELAWARD_ME = protobuf.Descriptor(),
	C2S_COMMONPASSCARD_LEVELAWARD_ID_F = protobuf.FieldDescriptor(),
	C2S_COMMONPASSCARD_LEVELAWARD_TYPE_F = protobuf.FieldDescriptor(),
	C2S_COMMONPASSCARD_LEVELAWARD_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_LEVELAWARD_ME = protobuf.Descriptor(),
	S2C_COMMONPASSCARD_LEVELAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_LEVELAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_LEVELAWARD_TYPE_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_LEVELAWARD_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_LEVELAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_COMMONPASSCARD_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_COMMONPASSCARD_TASKAWARD_ID_F = protobuf.FieldDescriptor(),
	C2S_COMMONPASSCARD_TASKAWARD_TASK_IDS_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_COMMONPASSCARD_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_TASKAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_TASKAWARD_TASK_IDS_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_COMMONPASSCARD_BUYLEVEL_ME = protobuf.Descriptor(),
	C2S_COMMONPASSCARD_BUYLEVEL_ID_F = protobuf.FieldDescriptor(),
	C2S_COMMONPASSCARD_BUYLEVEL_NUM_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_BUYLEVEL_ME = protobuf.Descriptor(),
	S2C_COMMONPASSCARD_BUYLEVEL_RET_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_BUYLEVEL_ID_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_BUYLEVEL_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_UPDATELEVEL_ME = protobuf.Descriptor(),
	S2C_COMMONPASSCARD_UPDATELEVEL_ID_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_UPDATELEVEL_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_UPDATELEVEL_EXP_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_UPDATETASK_ME = protobuf.Descriptor(),
	S2C_COMMONPASSCARD_UPDATETASK_ID_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_UPDATETASK_RESET_TYPE_F = protobuf.FieldDescriptor(),
	S2C_COMMONPASSCARD_UPDATETASK_ACTION_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_COMMONPASSCARD_GETINFO_ID_F, {
	"id",
	".cs.C2S_CommonPasscard_GetInfo.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_COMMONPASSCARD_GETINFO_ME, {
	"C2S_CommonPasscard_GetInfo",
	".cs.C2S_CommonPasscard_GetInfo",
	{},
	{},
	{
		var_0_10.C2S_COMMONPASSCARD_GETINFO_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_GETINFO_RET_F, {
	"ret",
	".cs.S2C_CommonPasscard_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_GETINFO_PASSCARD_F, {
	"passcard",
	".cs.S2C_CommonPasscard_GetInfo.passcard",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.COMMONPASSCARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_COMMONPASSCARD_GETINFO_ME, {
	"S2C_CommonPasscard_GetInfo",
	".cs.S2C_CommonPasscard_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_COMMONPASSCARD_GETINFO_RET_F,
		var_0_10.S2C_COMMONPASSCARD_GETINFO_PASSCARD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_COMMONPASSCARD_LEVELAWARD_ID_F, {
	"id",
	".cs.C2S_CommonPasscard_LevelAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_COMMONPASSCARD_LEVELAWARD_TYPE_F, {
	"type",
	".cs.C2S_CommonPasscard_LevelAward.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_COMMONPASSCARD_LEVELAWARD_LEVEL_F, {
	"level",
	".cs.C2S_CommonPasscard_LevelAward.level",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_COMMONPASSCARD_LEVELAWARD_ME, {
	"C2S_CommonPasscard_LevelAward",
	".cs.C2S_CommonPasscard_LevelAward",
	{},
	{},
	{
		var_0_10.C2S_COMMONPASSCARD_LEVELAWARD_ID_F,
		var_0_10.C2S_COMMONPASSCARD_LEVELAWARD_TYPE_F,
		var_0_10.C2S_COMMONPASSCARD_LEVELAWARD_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_LEVELAWARD_RET_F, {
	"ret",
	".cs.S2C_CommonPasscard_LevelAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_LEVELAWARD_ID_F, {
	"id",
	".cs.S2C_CommonPasscard_LevelAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_LEVELAWARD_TYPE_F, {
	"type",
	".cs.S2C_CommonPasscard_LevelAward.type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_LEVELAWARD_LEVEL_F, {
	"level",
	".cs.S2C_CommonPasscard_LevelAward.level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_LEVELAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_CommonPasscard_LevelAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_COMMONPASSCARD_LEVELAWARD_ME, {
	"S2C_CommonPasscard_LevelAward",
	".cs.S2C_CommonPasscard_LevelAward",
	{},
	{},
	{
		var_0_10.S2C_COMMONPASSCARD_LEVELAWARD_RET_F,
		var_0_10.S2C_COMMONPASSCARD_LEVELAWARD_ID_F,
		var_0_10.S2C_COMMONPASSCARD_LEVELAWARD_TYPE_F,
		var_0_10.S2C_COMMONPASSCARD_LEVELAWARD_LEVEL_F,
		var_0_10.S2C_COMMONPASSCARD_LEVELAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_COMMONPASSCARD_TASKAWARD_ID_F, {
	"id",
	".cs.C2S_CommonPasscard_TaskAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_COMMONPASSCARD_TASKAWARD_TASK_IDS_F, {
	"task_ids",
	".cs.C2S_CommonPasscard_TaskAward.task_ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_COMMONPASSCARD_TASKAWARD_ME, {
	"C2S_CommonPasscard_TaskAward",
	".cs.C2S_CommonPasscard_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_COMMONPASSCARD_TASKAWARD_ID_F,
		var_0_10.C2S_COMMONPASSCARD_TASKAWARD_TASK_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_CommonPasscard_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_TASKAWARD_ID_F, {
	"id",
	".cs.S2C_CommonPasscard_TaskAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_TASKAWARD_TASK_IDS_F, {
	"task_ids",
	".cs.S2C_CommonPasscard_TaskAward.task_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_CommonPasscard_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_COMMONPASSCARD_TASKAWARD_ME, {
	"S2C_CommonPasscard_TaskAward",
	".cs.S2C_CommonPasscard_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_COMMONPASSCARD_TASKAWARD_RET_F,
		var_0_10.S2C_COMMONPASSCARD_TASKAWARD_ID_F,
		var_0_10.S2C_COMMONPASSCARD_TASKAWARD_TASK_IDS_F,
		var_0_10.S2C_COMMONPASSCARD_TASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_COMMONPASSCARD_BUYLEVEL_ID_F, {
	"id",
	".cs.C2S_CommonPasscard_BuyLevel.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_COMMONPASSCARD_BUYLEVEL_NUM_F, {
	"num",
	".cs.C2S_CommonPasscard_BuyLevel.num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_COMMONPASSCARD_BUYLEVEL_ME, {
	"C2S_CommonPasscard_BuyLevel",
	".cs.C2S_CommonPasscard_BuyLevel",
	{},
	{},
	{
		var_0_10.C2S_COMMONPASSCARD_BUYLEVEL_ID_F,
		var_0_10.C2S_COMMONPASSCARD_BUYLEVEL_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_BUYLEVEL_RET_F, {
	"ret",
	".cs.S2C_CommonPasscard_BuyLevel.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_BUYLEVEL_ID_F, {
	"id",
	".cs.S2C_CommonPasscard_BuyLevel.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_BUYLEVEL_LEVEL_F, {
	"level",
	".cs.S2C_CommonPasscard_BuyLevel.level",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_COMMONPASSCARD_BUYLEVEL_ME, {
	"S2C_CommonPasscard_BuyLevel",
	".cs.S2C_CommonPasscard_BuyLevel",
	{},
	{},
	{
		var_0_10.S2C_COMMONPASSCARD_BUYLEVEL_RET_F,
		var_0_10.S2C_COMMONPASSCARD_BUYLEVEL_ID_F,
		var_0_10.S2C_COMMONPASSCARD_BUYLEVEL_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_UPDATELEVEL_ID_F, {
	"id",
	".cs.S2C_CommonPasscard_UpdateLevel.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_UPDATELEVEL_LEVEL_F, {
	"level",
	".cs.S2C_CommonPasscard_UpdateLevel.level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_UPDATELEVEL_EXP_F, {
	"exp",
	".cs.S2C_CommonPasscard_UpdateLevel.exp",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_COMMONPASSCARD_UPDATELEVEL_ME, {
	"S2C_CommonPasscard_UpdateLevel",
	".cs.S2C_CommonPasscard_UpdateLevel",
	{},
	{},
	{
		var_0_10.S2C_COMMONPASSCARD_UPDATELEVEL_ID_F,
		var_0_10.S2C_COMMONPASSCARD_UPDATELEVEL_LEVEL_F,
		var_0_10.S2C_COMMONPASSCARD_UPDATELEVEL_EXP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_UPDATETASK_ID_F, {
	"id",
	".cs.S2C_CommonPasscard_UpdateTask.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_UPDATETASK_RESET_TYPE_F, {
	"reset_type",
	".cs.S2C_CommonPasscard_UpdateTask.reset_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_COMMONPASSCARD_UPDATETASK_ACTION_F, {
	"action",
	".cs.S2C_CommonPasscard_UpdateTask.action",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.ACTION_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_COMMONPASSCARD_UPDATETASK_ME, {
	"S2C_CommonPasscard_UpdateTask",
	".cs.S2C_CommonPasscard_UpdateTask",
	{},
	{},
	{
		var_0_10.S2C_COMMONPASSCARD_UPDATETASK_ID_F,
		var_0_10.S2C_COMMONPASSCARD_UPDATETASK_RESET_TYPE_F,
		var_0_10.S2C_COMMONPASSCARD_UPDATETASK_ACTION_F
	},
	false,
	{}
})

return var_0_10
