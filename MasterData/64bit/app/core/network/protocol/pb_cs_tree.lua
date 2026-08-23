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
	C2S_TREE_GETINFO_ME = protobuf.Descriptor(),
	S2C_TREE_GETINFO_ME = protobuf.Descriptor(),
	S2C_TREE_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_TREE_GETINFO_TREE_NODES_F = protobuf.FieldDescriptor(),
	C2S_TREE_NODE_UPSTAGE_ME = protobuf.Descriptor(),
	C2S_TREE_NODE_UPSTAGE_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	S2C_TREE_NODE_UPSTAGE_ME = protobuf.Descriptor(),
	S2C_TREE_NODE_UPSTAGE_RET_F = protobuf.FieldDescriptor(),
	S2C_TREE_NODE_UPSTAGE_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	S2C_TREE_NODE_UPSTAGE_TREE_NODE_F = protobuf.FieldDescriptor(),
	C2S_TREE_NODE_LEVELUP_ME = protobuf.Descriptor(),
	C2S_TREE_NODE_LEVELUP_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	C2S_TREE_NODE_LEVELUP_TARGET_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_TREE_NODE_LEVELUP_ME = protobuf.Descriptor(),
	S2C_TREE_NODE_LEVELUP_RET_F = protobuf.FieldDescriptor(),
	S2C_TREE_NODE_LEVELUP_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	S2C_TREE_NODE_LEVELUP_TARGET_LEVEL_F = protobuf.FieldDescriptor(),
	S2C_TREE_NODE_LEVELUP_TREE_NODE_F = protobuf.FieldDescriptor(),
	S2C_TREE_UPDATE_NOTIFY_ME = protobuf.Descriptor(),
	S2C_TREE_UPDATE_NOTIFY_ADVANCE_ID_F = protobuf.FieldDescriptor(),
	S2C_TREE_UPDATE_NOTIFY_INFO_ID_F = protobuf.FieldDescriptor(),
	S2C_TREE_UPDATE_NOTIFY_CUR_TIMES_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_TREE_GETINFO_ME, {
	"C2S_Tree_GetInfo",
	".cs.C2S_Tree_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREE_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Tree_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREE_GETINFO_TREE_NODES_F, {
	"tree_nodes",
	".cs.S2C_Tree_GetInfo.tree_nodes",
	2,
	1,
	3,
	false,
	{},
	var_0_3.TREENODE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TREE_GETINFO_ME, {
	"S2C_Tree_GetInfo",
	".cs.S2C_Tree_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_TREE_GETINFO_RET_F,
		var_0_10.S2C_TREE_GETINFO_TREE_NODES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREE_NODE_UPSTAGE_ADVANCE_ID_F, {
	"advance_id",
	".cs.C2S_Tree_Node_UpStage.advance_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TREE_NODE_UPSTAGE_ME, {
	"C2S_Tree_Node_UpStage",
	".cs.C2S_Tree_Node_UpStage",
	{},
	{},
	{
		var_0_10.C2S_TREE_NODE_UPSTAGE_ADVANCE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREE_NODE_UPSTAGE_RET_F, {
	"ret",
	".cs.S2C_Tree_Node_UpStage.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREE_NODE_UPSTAGE_ADVANCE_ID_F, {
	"advance_id",
	".cs.S2C_Tree_Node_UpStage.advance_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREE_NODE_UPSTAGE_TREE_NODE_F, {
	"tree_node",
	".cs.S2C_Tree_Node_UpStage.tree_node",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.TREENODE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TREE_NODE_UPSTAGE_ME, {
	"S2C_Tree_Node_UpStage",
	".cs.S2C_Tree_Node_UpStage",
	{},
	{},
	{
		var_0_10.S2C_TREE_NODE_UPSTAGE_RET_F,
		var_0_10.S2C_TREE_NODE_UPSTAGE_ADVANCE_ID_F,
		var_0_10.S2C_TREE_NODE_UPSTAGE_TREE_NODE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREE_NODE_LEVELUP_ADVANCE_ID_F, {
	"advance_id",
	".cs.C2S_Tree_Node_LevelUp.advance_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_TREE_NODE_LEVELUP_TARGET_LEVEL_F, {
	"target_level",
	".cs.C2S_Tree_Node_LevelUp.target_level",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_TREE_NODE_LEVELUP_ME, {
	"C2S_Tree_Node_LevelUp",
	".cs.C2S_Tree_Node_LevelUp",
	{},
	{},
	{
		var_0_10.C2S_TREE_NODE_LEVELUP_ADVANCE_ID_F,
		var_0_10.C2S_TREE_NODE_LEVELUP_TARGET_LEVEL_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREE_NODE_LEVELUP_RET_F, {
	"ret",
	".cs.S2C_Tree_Node_LevelUp.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREE_NODE_LEVELUP_ADVANCE_ID_F, {
	"advance_id",
	".cs.S2C_Tree_Node_LevelUp.advance_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREE_NODE_LEVELUP_TARGET_LEVEL_F, {
	"target_level",
	".cs.S2C_Tree_Node_LevelUp.target_level",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREE_NODE_LEVELUP_TREE_NODE_F, {
	"tree_node",
	".cs.S2C_Tree_Node_LevelUp.tree_node",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.TREENODE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_TREE_NODE_LEVELUP_ME, {
	"S2C_Tree_Node_LevelUp",
	".cs.S2C_Tree_Node_LevelUp",
	{},
	{},
	{
		var_0_10.S2C_TREE_NODE_LEVELUP_RET_F,
		var_0_10.S2C_TREE_NODE_LEVELUP_ADVANCE_ID_F,
		var_0_10.S2C_TREE_NODE_LEVELUP_TARGET_LEVEL_F,
		var_0_10.S2C_TREE_NODE_LEVELUP_TREE_NODE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREE_UPDATE_NOTIFY_ADVANCE_ID_F, {
	"advance_id",
	".cs.S2C_Tree_Update_Notify.advance_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREE_UPDATE_NOTIFY_INFO_ID_F, {
	"info_id",
	".cs.S2C_Tree_Update_Notify.info_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_TREE_UPDATE_NOTIFY_CUR_TIMES_F, {
	"cur_times",
	".cs.S2C_Tree_Update_Notify.cur_times",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_TREE_UPDATE_NOTIFY_ME, {
	"S2C_Tree_Update_Notify",
	".cs.S2C_Tree_Update_Notify",
	{},
	{},
	{
		var_0_10.S2C_TREE_UPDATE_NOTIFY_ADVANCE_ID_F,
		var_0_10.S2C_TREE_UPDATE_NOTIFY_INFO_ID_F,
		var_0_10.S2C_TREE_UPDATE_NOTIFY_CUR_TIMES_F
	},
	false,
	{}
})

return var_0_10
