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
	C2S_LOTTERY_GETINFO_ME = protobuf.Descriptor(),
	S2C_LOTTERY_GETINFO_ME = protobuf.Descriptor(),
	S2C_LOTTERY_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_LOTTERY_GETINFO_ACTIVITY_INFO_F = protobuf.FieldDescriptor(),
	S2C_LOTTERY_GETINFO_LOTTERY_F = protobuf.FieldDescriptor(),
	S2C_LOTTERY_GETINFO_TASK_AWARDED_F = protobuf.FieldDescriptor(),
	S2C_LOTTERY_GETINFO_TASKS_F = protobuf.FieldDescriptor(),
	C2S_LOTTERY_DRAW_ME = protobuf.Descriptor(),
	C2S_LOTTERY_DRAW_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_LOTTERY_DRAW_ME = protobuf.Descriptor(),
	S2C_LOTTERY_DRAW_RET_F = protobuf.FieldDescriptor(),
	S2C_LOTTERY_DRAW_GRID_ID_F = protobuf.FieldDescriptor(),
	S2C_LOTTERY_DRAW_IS_RARE_F = protobuf.FieldDescriptor(),
	S2C_LOTTERY_DRAW_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_LOTTERY_NEXT_POOL_ME = protobuf.Descriptor(),
	S2C_LOTTERY_NEXT_POOL_ME = protobuf.Descriptor(),
	S2C_LOTTERY_NEXT_POOL_RET_F = protobuf.FieldDescriptor(),
	S2C_LOTTERY_NEXT_POOL_POOL_ID_F = protobuf.FieldDescriptor(),
	S2C_LOTTERY_NEXT_POOL_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_LOTTERY_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_LOTTERY_TASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	C2S_LOTTERY_TASKAWARD_NUM_F = protobuf.FieldDescriptor(),
	S2C_LOTTERY_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_LOTTERY_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_LOTTERY_TASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_LOTTERY_TASKAWARD_NUM_F = protobuf.FieldDescriptor(),
	S2C_LOTTERY_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_LOTTERY_GETINFO_ME, {
	"C2S_Lottery_GetInfo",
	".cs.C2S_Lottery_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_LOTTERY_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Lottery_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_LOTTERY_GETINFO_ACTIVITY_INFO_F, {
	"activity_info",
	".cs.S2C_Lottery_GetInfo.activity_info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.LOTTERYACTIVITYINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_LOTTERY_GETINFO_LOTTERY_F, {
	"lottery",
	".cs.S2C_Lottery_GetInfo.lottery",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.USERLOTTERY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_LOTTERY_GETINFO_TASK_AWARDED_F, {
	"task_awarded",
	".cs.S2C_Lottery_GetInfo.task_awarded",
	4,
	3,
	3,
	false,
	{},
	var_0_3.UINT32KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_LOTTERY_GETINFO_TASKS_F, {
	"tasks",
	".cs.S2C_Lottery_GetInfo.tasks",
	5,
	4,
	3,
	false,
	{},
	var_0_3.STATUS_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_LOTTERY_GETINFO_ME, {
	"S2C_Lottery_GetInfo",
	".cs.S2C_Lottery_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_LOTTERY_GETINFO_RET_F,
		var_0_10.S2C_LOTTERY_GETINFO_ACTIVITY_INFO_F,
		var_0_10.S2C_LOTTERY_GETINFO_LOTTERY_F,
		var_0_10.S2C_LOTTERY_GETINFO_TASK_AWARDED_F,
		var_0_10.S2C_LOTTERY_GETINFO_TASKS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_LOTTERY_DRAW_GRID_ID_F, {
	"grid_id",
	".cs.C2S_Lottery_Draw.grid_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_LOTTERY_DRAW_ME, {
	"C2S_Lottery_Draw",
	".cs.C2S_Lottery_Draw",
	{},
	{},
	{
		var_0_10.C2S_LOTTERY_DRAW_GRID_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_LOTTERY_DRAW_RET_F, {
	"ret",
	".cs.S2C_Lottery_Draw.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_LOTTERY_DRAW_GRID_ID_F, {
	"grid_id",
	".cs.S2C_Lottery_Draw.grid_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_LOTTERY_DRAW_IS_RARE_F, {
	"is_rare",
	".cs.S2C_Lottery_Draw.is_rare",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_LOTTERY_DRAW_AWARDS_F, {
	"awards",
	".cs.S2C_Lottery_Draw.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_LOTTERY_DRAW_ME, {
	"S2C_Lottery_Draw",
	".cs.S2C_Lottery_Draw",
	{},
	{},
	{
		var_0_10.S2C_LOTTERY_DRAW_RET_F,
		var_0_10.S2C_LOTTERY_DRAW_GRID_ID_F,
		var_0_10.S2C_LOTTERY_DRAW_IS_RARE_F,
		var_0_10.S2C_LOTTERY_DRAW_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_LOTTERY_NEXT_POOL_ME, {
	"C2S_Lottery_Next_Pool",
	".cs.C2S_Lottery_Next_Pool",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_LOTTERY_NEXT_POOL_RET_F, {
	"ret",
	".cs.S2C_Lottery_Next_Pool.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_LOTTERY_NEXT_POOL_POOL_ID_F, {
	"pool_id",
	".cs.S2C_Lottery_Next_Pool.pool_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_LOTTERY_NEXT_POOL_AWARDS_F, {
	"awards",
	".cs.S2C_Lottery_Next_Pool.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_LOTTERY_NEXT_POOL_ME, {
	"S2C_Lottery_Next_Pool",
	".cs.S2C_Lottery_Next_Pool",
	{},
	{},
	{
		var_0_10.S2C_LOTTERY_NEXT_POOL_RET_F,
		var_0_10.S2C_LOTTERY_NEXT_POOL_POOL_ID_F,
		var_0_10.S2C_LOTTERY_NEXT_POOL_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_LOTTERY_TASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.C2S_Lottery_TaskAward.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_LOTTERY_TASKAWARD_NUM_F, {
	"num",
	".cs.C2S_Lottery_TaskAward.num",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_LOTTERY_TASKAWARD_ME, {
	"C2S_Lottery_TaskAward",
	".cs.C2S_Lottery_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_LOTTERY_TASKAWARD_TASK_ID_F,
		var_0_10.C2S_LOTTERY_TASKAWARD_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_LOTTERY_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_Lottery_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_LOTTERY_TASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.S2C_Lottery_TaskAward.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_LOTTERY_TASKAWARD_NUM_F, {
	"num",
	".cs.S2C_Lottery_TaskAward.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_LOTTERY_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Lottery_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_LOTTERY_TASKAWARD_ME, {
	"S2C_Lottery_TaskAward",
	".cs.S2C_Lottery_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_LOTTERY_TASKAWARD_RET_F,
		var_0_10.S2C_LOTTERY_TASKAWARD_TASK_ID_F,
		var_0_10.S2C_LOTTERY_TASKAWARD_NUM_F,
		var_0_10.S2C_LOTTERY_TASKAWARD_AWARDS_F
	},
	false,
	{}
})

return var_0_10
