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
	C2S_MONOPOLY_GETINFO_ME = protobuf.Descriptor(),
	S2C_MONOPOLY_GETINFO_ME = protobuf.Descriptor(),
	S2C_MONOPOLY_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_MONOPOLY_GETINFO_MAP_DATA_F = protobuf.FieldDescriptor(),
	C2S_MONOPOLY_ROLLDICE_ME = protobuf.Descriptor(),
	C2S_MONOPOLY_ROLLDICE_ACTIVITYID_F = protobuf.FieldDescriptor(),
	C2S_MONOPOLY_ROLLDICE_ROLL_COUNT_F = protobuf.FieldDescriptor(),
	S2C_MONOPOLY_ROLLDICE_ME = protobuf.Descriptor(),
	S2C_MONOPOLY_ROLLDICE_RET_F = protobuf.FieldDescriptor(),
	S2C_MONOPOLY_ROLLDICE_ACTIVITYID_F = protobuf.FieldDescriptor(),
	S2C_MONOPOLY_ROLLDICE_ROLL_COUNT_F = protobuf.FieldDescriptor(),
	S2C_MONOPOLY_ROLLDICE_MAP_DATA_F = protobuf.FieldDescriptor(),
	S2C_MONOPOLY_ROLLDICE_RESULTS_F = protobuf.FieldDescriptor(),
	S2C_MONOPOLY_ROLLDICE_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_MONOPOLY_NODEAWARD_ME = protobuf.Descriptor(),
	C2S_MONOPOLY_NODEAWARD_ACTIVITYID_F = protobuf.FieldDescriptor(),
	C2S_MONOPOLY_NODEAWARD_NODE_IDS_F = protobuf.FieldDescriptor(),
	S2C_MONOPOLY_NODEAWARD_ME = protobuf.Descriptor(),
	S2C_MONOPOLY_NODEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_MONOPOLY_NODEAWARD_ACTIVITYID_F = protobuf.FieldDescriptor(),
	S2C_MONOPOLY_NODEAWARD_NODE_IDS_F = protobuf.FieldDescriptor(),
	S2C_MONOPOLY_NODEAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_MONOPOLY_USEFIXEDDICE_ME = protobuf.Descriptor(),
	C2S_MONOPOLY_USEFIXEDDICE_ACTIVITYID_F = protobuf.FieldDescriptor(),
	C2S_MONOPOLY_USEFIXEDDICE_DICE_F = protobuf.FieldDescriptor(),
	S2C_MONOPOLY_USEFIXEDDICE_ME = protobuf.Descriptor(),
	S2C_MONOPOLY_USEFIXEDDICE_RET_F = protobuf.FieldDescriptor(),
	S2C_MONOPOLY_USEFIXEDDICE_ACTIVITYID_F = protobuf.FieldDescriptor(),
	S2C_MONOPOLY_USEFIXEDDICE_DICE_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_MONOPOLY_GETINFO_ME, {
	"C2S_Monopoly_GetInfo",
	".cs.C2S_Monopoly_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONOPOLY_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Monopoly_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONOPOLY_GETINFO_MAP_DATA_F, {
	"map_data",
	".cs.S2C_Monopoly_GetInfo.map_data",
	2,
	1,
	3,
	false,
	{},
	var_0_3.MONOPOLYMAP_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MONOPOLY_GETINFO_ME, {
	"S2C_Monopoly_GetInfo",
	".cs.S2C_Monopoly_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_MONOPOLY_GETINFO_RET_F,
		var_0_10.S2C_MONOPOLY_GETINFO_MAP_DATA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MONOPOLY_ROLLDICE_ACTIVITYID_F, {
	"activityId",
	".cs.C2S_Monopoly_RollDice.activityId",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MONOPOLY_ROLLDICE_ROLL_COUNT_F, {
	"roll_count",
	".cs.C2S_Monopoly_RollDice.roll_count",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MONOPOLY_ROLLDICE_ME, {
	"C2S_Monopoly_RollDice",
	".cs.C2S_Monopoly_RollDice",
	{},
	{},
	{
		var_0_10.C2S_MONOPOLY_ROLLDICE_ACTIVITYID_F,
		var_0_10.C2S_MONOPOLY_ROLLDICE_ROLL_COUNT_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONOPOLY_ROLLDICE_RET_F, {
	"ret",
	".cs.S2C_Monopoly_RollDice.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONOPOLY_ROLLDICE_ACTIVITYID_F, {
	"activityId",
	".cs.S2C_Monopoly_RollDice.activityId",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONOPOLY_ROLLDICE_ROLL_COUNT_F, {
	"roll_count",
	".cs.S2C_Monopoly_RollDice.roll_count",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONOPOLY_ROLLDICE_MAP_DATA_F, {
	"map_data",
	".cs.S2C_Monopoly_RollDice.map_data",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.MONOPOLYMAP_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONOPOLY_ROLLDICE_RESULTS_F, {
	"results",
	".cs.S2C_Monopoly_RollDice.results",
	5,
	4,
	3,
	false,
	{},
	var_0_3.MONOPOLYROLLRESULT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONOPOLY_ROLLDICE_AWARDS_F, {
	"awards",
	".cs.S2C_Monopoly_RollDice.awards",
	6,
	5,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_MONOPOLY_ROLLDICE_ME, {
	"S2C_Monopoly_RollDice",
	".cs.S2C_Monopoly_RollDice",
	{},
	{},
	{
		var_0_10.S2C_MONOPOLY_ROLLDICE_RET_F,
		var_0_10.S2C_MONOPOLY_ROLLDICE_ACTIVITYID_F,
		var_0_10.S2C_MONOPOLY_ROLLDICE_ROLL_COUNT_F,
		var_0_10.S2C_MONOPOLY_ROLLDICE_MAP_DATA_F,
		var_0_10.S2C_MONOPOLY_ROLLDICE_RESULTS_F,
		var_0_10.S2C_MONOPOLY_ROLLDICE_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MONOPOLY_NODEAWARD_ACTIVITYID_F, {
	"activityId",
	".cs.C2S_Monopoly_NodeAward.activityId",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MONOPOLY_NODEAWARD_NODE_IDS_F, {
	"node_ids",
	".cs.C2S_Monopoly_NodeAward.node_ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MONOPOLY_NODEAWARD_ME, {
	"C2S_Monopoly_NodeAward",
	".cs.C2S_Monopoly_NodeAward",
	{},
	{},
	{
		var_0_10.C2S_MONOPOLY_NODEAWARD_ACTIVITYID_F,
		var_0_10.C2S_MONOPOLY_NODEAWARD_NODE_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONOPOLY_NODEAWARD_RET_F, {
	"ret",
	".cs.S2C_Monopoly_NodeAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONOPOLY_NODEAWARD_ACTIVITYID_F, {
	"activityId",
	".cs.S2C_Monopoly_NodeAward.activityId",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONOPOLY_NODEAWARD_NODE_IDS_F, {
	"node_ids",
	".cs.S2C_Monopoly_NodeAward.node_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONOPOLY_NODEAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Monopoly_NodeAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MONOPOLY_NODEAWARD_ME, {
	"S2C_Monopoly_NodeAward",
	".cs.S2C_Monopoly_NodeAward",
	{},
	{},
	{
		var_0_10.S2C_MONOPOLY_NODEAWARD_RET_F,
		var_0_10.S2C_MONOPOLY_NODEAWARD_ACTIVITYID_F,
		var_0_10.S2C_MONOPOLY_NODEAWARD_NODE_IDS_F,
		var_0_10.S2C_MONOPOLY_NODEAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MONOPOLY_USEFIXEDDICE_ACTIVITYID_F, {
	"activityId",
	".cs.C2S_Monopoly_UseFixedDice.activityId",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_MONOPOLY_USEFIXEDDICE_DICE_F, {
	"dice",
	".cs.C2S_Monopoly_UseFixedDice.dice",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_MONOPOLY_USEFIXEDDICE_ME, {
	"C2S_Monopoly_UseFixedDice",
	".cs.C2S_Monopoly_UseFixedDice",
	{},
	{},
	{
		var_0_10.C2S_MONOPOLY_USEFIXEDDICE_ACTIVITYID_F,
		var_0_10.C2S_MONOPOLY_USEFIXEDDICE_DICE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONOPOLY_USEFIXEDDICE_RET_F, {
	"ret",
	".cs.S2C_Monopoly_UseFixedDice.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONOPOLY_USEFIXEDDICE_ACTIVITYID_F, {
	"activityId",
	".cs.S2C_Monopoly_UseFixedDice.activityId",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_MONOPOLY_USEFIXEDDICE_DICE_F, {
	"dice",
	".cs.S2C_Monopoly_UseFixedDice.dice",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_MONOPOLY_USEFIXEDDICE_ME, {
	"S2C_Monopoly_UseFixedDice",
	".cs.S2C_Monopoly_UseFixedDice",
	{},
	{},
	{
		var_0_10.S2C_MONOPOLY_USEFIXEDDICE_RET_F,
		var_0_10.S2C_MONOPOLY_USEFIXEDDICE_ACTIVITYID_F,
		var_0_10.S2C_MONOPOLY_USEFIXEDDICE_DICE_F
	},
	false,
	{}
})

return var_0_10
