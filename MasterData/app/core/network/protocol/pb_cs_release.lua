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
	C2S_RELEASE_GETINFO_ME = protobuf.Descriptor(),
	S2C_RELEASE_GETINFO_ME = protobuf.Descriptor(),
	S2C_RELEASE_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_RELEASE_GETINFO_RELEASE_F = protobuf.FieldDescriptor(),
	S2C_RELEASE_GETINFO_SPINNER_F = protobuf.FieldDescriptor(),
	S2C_RELEASE_GETINFO_TASKS_F = protobuf.FieldDescriptor(),
	C2S_RELEASE_PRIZELIST_ME = protobuf.Descriptor(),
	S2C_RELEASE_PRIZELIST_ME = protobuf.Descriptor(),
	S2C_RELEASE_PRIZELIST_RET_F = protobuf.FieldDescriptor(),
	S2C_RELEASE_PRIZELIST_PRIZES_F = protobuf.FieldDescriptor(),
	C2S_RELEASE_DRAW_ME = protobuf.Descriptor(),
	C2S_RELEASE_DRAW_TIMES_F = protobuf.FieldDescriptor(),
	S2C_RELEASE_DRAW_ME = protobuf.Descriptor(),
	S2C_RELEASE_DRAW_RET_F = protobuf.FieldDescriptor(),
	S2C_RELEASE_DRAW_TIMES_F = protobuf.FieldDescriptor(),
	S2C_RELEASE_DRAW_PRIZE_IDS_F = protobuf.FieldDescriptor(),
	S2C_RELEASE_DRAW_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_RELEASE_GETREWARD_ME = protobuf.Descriptor(),
	C2S_RELEASE_GETREWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RELEASE_GETREWARD_ME = protobuf.Descriptor(),
	S2C_RELEASE_GETREWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RELEASE_GETREWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RELEASE_GETREWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_RELEASE_TASKAWARD_ME = protobuf.Descriptor(),
	C2S_RELEASE_TASKAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_RELEASE_TASKAWARD_ME = protobuf.Descriptor(),
	S2C_RELEASE_TASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RELEASE_TASKAWARD_IDS_F = protobuf.FieldDescriptor(),
	S2C_RELEASE_TASKAWARD_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_RELEASE_GETINFO_ME, {
	"C2S_Release_GetInfo",
	".cs.C2S_Release_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RELEASE_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Release_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RELEASE_GETINFO_RELEASE_F, {
	"release",
	".cs.S2C_Release_GetInfo.release",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.RELEASE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RELEASE_GETINFO_SPINNER_F, {
	"spinner",
	".cs.S2C_Release_GetInfo.spinner",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.RELEASESPINNER_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RELEASE_GETINFO_TASKS_F, {
	"tasks",
	".cs.S2C_Release_GetInfo.tasks",
	4,
	3,
	3,
	false,
	{},
	var_0_3.PERIODTASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_RELEASE_GETINFO_ME, {
	"S2C_Release_GetInfo",
	".cs.S2C_Release_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_RELEASE_GETINFO_RET_F,
		var_0_10.S2C_RELEASE_GETINFO_RELEASE_F,
		var_0_10.S2C_RELEASE_GETINFO_SPINNER_F,
		var_0_10.S2C_RELEASE_GETINFO_TASKS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_RELEASE_PRIZELIST_ME, {
	"C2S_Release_PrizeList",
	".cs.C2S_Release_PrizeList",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RELEASE_PRIZELIST_RET_F, {
	"ret",
	".cs.S2C_Release_PrizeList.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RELEASE_PRIZELIST_PRIZES_F, {
	"prizes",
	".cs.S2C_Release_PrizeList.prizes",
	2,
	1,
	3,
	false,
	{},
	var_0_3.RELEASESPINNERPRIZE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_RELEASE_PRIZELIST_ME, {
	"S2C_Release_PrizeList",
	".cs.S2C_Release_PrizeList",
	{},
	{},
	{
		var_0_10.S2C_RELEASE_PRIZELIST_RET_F,
		var_0_10.S2C_RELEASE_PRIZELIST_PRIZES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RELEASE_DRAW_TIMES_F, {
	"times",
	".cs.C2S_Release_Draw.times",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RELEASE_DRAW_ME, {
	"C2S_Release_Draw",
	".cs.C2S_Release_Draw",
	{},
	{},
	{
		var_0_10.C2S_RELEASE_DRAW_TIMES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RELEASE_DRAW_RET_F, {
	"ret",
	".cs.S2C_Release_Draw.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RELEASE_DRAW_TIMES_F, {
	"times",
	".cs.S2C_Release_Draw.times",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RELEASE_DRAW_PRIZE_IDS_F, {
	"prize_ids",
	".cs.S2C_Release_Draw.prize_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RELEASE_DRAW_AWARDS_F, {
	"awards",
	".cs.S2C_Release_Draw.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RELEASE_DRAW_ME, {
	"S2C_Release_Draw",
	".cs.S2C_Release_Draw",
	{},
	{},
	{
		var_0_10.S2C_RELEASE_DRAW_RET_F,
		var_0_10.S2C_RELEASE_DRAW_TIMES_F,
		var_0_10.S2C_RELEASE_DRAW_PRIZE_IDS_F,
		var_0_10.S2C_RELEASE_DRAW_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RELEASE_GETREWARD_ID_F, {
	"id",
	".cs.C2S_Release_GetReward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RELEASE_GETREWARD_ME, {
	"C2S_Release_GetReward",
	".cs.C2S_Release_GetReward",
	{},
	{},
	{
		var_0_10.C2S_RELEASE_GETREWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RELEASE_GETREWARD_RET_F, {
	"ret",
	".cs.S2C_Release_GetReward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RELEASE_GETREWARD_ID_F, {
	"id",
	".cs.S2C_Release_GetReward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RELEASE_GETREWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Release_GetReward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RELEASE_GETREWARD_ME, {
	"S2C_Release_GetReward",
	".cs.S2C_Release_GetReward",
	{},
	{},
	{
		var_0_10.S2C_RELEASE_GETREWARD_RET_F,
		var_0_10.S2C_RELEASE_GETREWARD_ID_F,
		var_0_10.S2C_RELEASE_GETREWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RELEASE_TASKAWARD_IDS_F, {
	"ids",
	".cs.C2S_Release_TaskAward.ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RELEASE_TASKAWARD_ME, {
	"C2S_Release_TaskAward",
	".cs.C2S_Release_TaskAward",
	{},
	{},
	{
		var_0_10.C2S_RELEASE_TASKAWARD_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RELEASE_TASKAWARD_RET_F, {
	"ret",
	".cs.S2C_Release_TaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RELEASE_TASKAWARD_IDS_F, {
	"ids",
	".cs.S2C_Release_TaskAward.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RELEASE_TASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Release_TaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RELEASE_TASKAWARD_ME, {
	"S2C_Release_TaskAward",
	".cs.S2C_Release_TaskAward",
	{},
	{},
	{
		var_0_10.S2C_RELEASE_TASKAWARD_RET_F,
		var_0_10.S2C_RELEASE_TASKAWARD_IDS_F,
		var_0_10.S2C_RELEASE_TASKAWARD_AWARDS_F
	},
	false,
	{}
})

return var_0_10
