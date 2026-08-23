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
	C2S_PALACE_GETINFO_ME = protobuf.Descriptor(),
	S2C_PALACE_GETINFO_ME = protobuf.Descriptor(),
	S2C_PALACE_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_PALACE_GETINFO_ID_F = protobuf.FieldDescriptor(),
	S2C_PALACE_GETINFO_BUILD_F = protobuf.FieldDescriptor(),
	S2C_PALACE_GETINFO_COMPOSE_F = protobuf.FieldDescriptor(),
	S2C_PALACE_GETINFO_ACTIVEDALTAR_F = protobuf.FieldDescriptor(),
	C2S_PALACE_GETHANGUPAWARD_ME = protobuf.Descriptor(),
	C2S_PALACE_GETHANGUPAWARD_BUILD_TYPE_F = protobuf.FieldDescriptor(),
	S2C_PALACE_GETHANGUPAWARD_ME = protobuf.Descriptor(),
	S2C_PALACE_GETHANGUPAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_PALACE_GETHANGUPAWARD_BUILD_TYPE_F = protobuf.FieldDescriptor(),
	S2C_PALACE_GETHANGUPAWARD_START_TIME_F = protobuf.FieldDescriptor(),
	S2C_PALACE_GETHANGUPAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_PALACE_ACTIVECOMPOSE_ME = protobuf.Descriptor(),
	C2S_PALACE_ACTIVECOMPOSE_ID_F = protobuf.FieldDescriptor(),
	S2C_PALACE_ACTIVECOMPOSE_ME = protobuf.Descriptor(),
	S2C_PALACE_ACTIVECOMPOSE_RET_F = protobuf.FieldDescriptor(),
	S2C_PALACE_ACTIVECOMPOSE_ID_F = protobuf.FieldDescriptor(),
	S2C_PALACE_ACTIVECOMPOSE_DAILY_ACTIVE_CNT_F = protobuf.FieldDescriptor(),
	S2C_PALACE_ACTIVECOMPOSE_AWARD_F = protobuf.FieldDescriptor(),
	S2C_PALACE_ACTIVECOMPOSE_BUILD_GRADE_F = protobuf.FieldDescriptor(),
	S2C_PALACE_ACTIVECOMPOSE_BUILD_EXP_F = protobuf.FieldDescriptor(),
	S2C_PALACE_ACTIVECOMPOSE_HANG_UP_F = protobuf.FieldDescriptor(),
	C2S_PALACE_UPGRADECOMPOSE_ME = protobuf.Descriptor(),
	C2S_PALACE_UPGRADECOMPOSE_ID_F = protobuf.FieldDescriptor(),
	S2C_PALACE_UPGRADECOMPOSE_ME = protobuf.Descriptor(),
	S2C_PALACE_UPGRADECOMPOSE_RET_F = protobuf.FieldDescriptor(),
	S2C_PALACE_UPGRADECOMPOSE_ID_F = protobuf.FieldDescriptor(),
	S2C_PALACE_UPGRADECOMPOSE_AWARD_F = protobuf.FieldDescriptor(),
	S2C_PALACE_UPGRADECOMPOSE_BUILD_GRADE_F = protobuf.FieldDescriptor(),
	S2C_PALACE_UPGRADECOMPOSE_BUILD_EXP_F = protobuf.FieldDescriptor(),
	S2C_PALACE_UPGRADECOMPOSE_HANG_UP_F = protobuf.FieldDescriptor(),
	C2S_PALACE_ONEKEYUPGRADECOMPOSE_ME = protobuf.Descriptor(),
	C2S_PALACE_ONEKEYUPGRADECOMPOSE_IDS_F = protobuf.FieldDescriptor(),
	S2C_PALACE_ONEKEYUPGRADECOMPOSE_ME = protobuf.Descriptor(),
	S2C_PALACE_ONEKEYUPGRADECOMPOSE_RET_F = protobuf.FieldDescriptor(),
	S2C_PALACE_ONEKEYUPGRADECOMPOSE_IDS_F = protobuf.FieldDescriptor(),
	S2C_PALACE_ONEKEYUPGRADECOMPOSE_AWARD_F = protobuf.FieldDescriptor(),
	S2C_PALACE_ONEKEYUPGRADECOMPOSE_BUILD_GRADE_F = protobuf.FieldDescriptor(),
	S2C_PALACE_ONEKEYUPGRADECOMPOSE_BUILD_EXP_F = protobuf.FieldDescriptor(),
	S2C_PALACE_ONEKEYUPGRADECOMPOSE_HANG_UP_F = protobuf.FieldDescriptor(),
	C2S_PALACE_USECOMPOSE_ME = protobuf.Descriptor(),
	C2S_PALACE_USECOMPOSE_ID_F = protobuf.FieldDescriptor(),
	C2S_PALACE_USECOMPOSE_POS_F = protobuf.FieldDescriptor(),
	S2C_PALACE_USECOMPOSE_ME = protobuf.Descriptor(),
	S2C_PALACE_USECOMPOSE_RET_F = protobuf.FieldDescriptor(),
	S2C_PALACE_USECOMPOSE_ID_F = protobuf.FieldDescriptor(),
	S2C_PALACE_USECOMPOSE_POS_F = protobuf.FieldDescriptor(),
	C2S_PALACE_UNUSECOMPOSE_ME = protobuf.Descriptor(),
	C2S_PALACE_UNUSECOMPOSE_ID_F = protobuf.FieldDescriptor(),
	S2C_PALACE_UNUSECOMPOSE_ME = protobuf.Descriptor(),
	S2C_PALACE_UNUSECOMPOSE_RET_F = protobuf.FieldDescriptor(),
	S2C_PALACE_UNUSECOMPOSE_ID_F = protobuf.FieldDescriptor(),
	C2S_PALACE_ACTIVEALTARNODE_ME = protobuf.Descriptor(),
	C2S_PALACE_ACTIVEALTARNODE_ID_F = protobuf.FieldDescriptor(),
	S2C_PALACE_ACTIVEALTARNODE_ME = protobuf.Descriptor(),
	S2C_PALACE_ACTIVEALTARNODE_RET_F = protobuf.FieldDescriptor(),
	S2C_PALACE_ACTIVEALTARNODE_ID_F = protobuf.FieldDescriptor(),
	S2C_PALACE_ACTIVEALTARNODE_PALACE_ID_F = protobuf.FieldDescriptor(),
	C2S_PALACE_FIRSTENTERBUILD_ME = protobuf.Descriptor(),
	C2S_PALACE_FIRSTENTERBUILD_BUILD_TYPE_F = protobuf.FieldDescriptor(),
	S2C_PALACE_FIRSTENTERBUILD_ME = protobuf.Descriptor(),
	S2C_PALACE_FIRSTENTERBUILD_RET_F = protobuf.FieldDescriptor(),
	S2C_PALACE_FIRSTENTERBUILD_BUILD_TYPE_F = protobuf.FieldDescriptor(),
	S2C_PALACE_FIRSTENTERBUILD_START_TIME_F = protobuf.FieldDescriptor(),
	S2C_PALACE_FIRSTENTERBUILD_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_PALACE_GETINFO_ME, {
	"C2S_Palace_GetInfo",
	".cs.C2S_Palace_GetInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_GETINFO_RET_F, {
	"ret",
	".cs.S2C_Palace_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_GETINFO_ID_F, {
	"id",
	".cs.S2C_Palace_GetInfo.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_GETINFO_BUILD_F, {
	"build",
	".cs.S2C_Palace_GetInfo.build",
	3,
	2,
	3,
	false,
	{},
	var_0_3.PALACEBUILDINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_GETINFO_COMPOSE_F, {
	"compose",
	".cs.S2C_Palace_GetInfo.compose",
	4,
	3,
	3,
	false,
	{},
	var_0_3.PALACECOMPOSE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_GETINFO_ACTIVEDALTAR_F, {
	"activedAltar",
	".cs.S2C_Palace_GetInfo.activedAltar",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PALACE_GETINFO_ME, {
	"S2C_Palace_GetInfo",
	".cs.S2C_Palace_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_PALACE_GETINFO_RET_F,
		var_0_10.S2C_PALACE_GETINFO_ID_F,
		var_0_10.S2C_PALACE_GETINFO_BUILD_F,
		var_0_10.S2C_PALACE_GETINFO_COMPOSE_F,
		var_0_10.S2C_PALACE_GETINFO_ACTIVEDALTAR_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PALACE_GETHANGUPAWARD_BUILD_TYPE_F, {
	"build_type",
	".cs.C2S_Palace_GetHangupAward.build_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PALACE_GETHANGUPAWARD_ME, {
	"C2S_Palace_GetHangupAward",
	".cs.C2S_Palace_GetHangupAward",
	{},
	{},
	{
		var_0_10.C2S_PALACE_GETHANGUPAWARD_BUILD_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_GETHANGUPAWARD_RET_F, {
	"ret",
	".cs.S2C_Palace_GetHangupAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_GETHANGUPAWARD_BUILD_TYPE_F, {
	"build_type",
	".cs.S2C_Palace_GetHangupAward.build_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_GETHANGUPAWARD_START_TIME_F, {
	"start_time",
	".cs.S2C_Palace_GetHangupAward.start_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_GETHANGUPAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Palace_GetHangupAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PALACE_GETHANGUPAWARD_ME, {
	"S2C_Palace_GetHangupAward",
	".cs.S2C_Palace_GetHangupAward",
	{},
	{},
	{
		var_0_10.S2C_PALACE_GETHANGUPAWARD_RET_F,
		var_0_10.S2C_PALACE_GETHANGUPAWARD_BUILD_TYPE_F,
		var_0_10.S2C_PALACE_GETHANGUPAWARD_START_TIME_F,
		var_0_10.S2C_PALACE_GETHANGUPAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PALACE_ACTIVECOMPOSE_ID_F, {
	"id",
	".cs.C2S_Palace_ActiveCompose.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PALACE_ACTIVECOMPOSE_ME, {
	"C2S_Palace_ActiveCompose",
	".cs.C2S_Palace_ActiveCompose",
	{},
	{},
	{
		var_0_10.C2S_PALACE_ACTIVECOMPOSE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_ACTIVECOMPOSE_RET_F, {
	"ret",
	".cs.S2C_Palace_ActiveCompose.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_ACTIVECOMPOSE_ID_F, {
	"id",
	".cs.S2C_Palace_ActiveCompose.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_ACTIVECOMPOSE_DAILY_ACTIVE_CNT_F, {
	"daily_active_cnt",
	".cs.S2C_Palace_ActiveCompose.daily_active_cnt",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_ACTIVECOMPOSE_AWARD_F, {
	"award",
	".cs.S2C_Palace_ActiveCompose.award",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_ACTIVECOMPOSE_BUILD_GRADE_F, {
	"build_grade",
	".cs.S2C_Palace_ActiveCompose.build_grade",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_ACTIVECOMPOSE_BUILD_EXP_F, {
	"build_exp",
	".cs.S2C_Palace_ActiveCompose.build_exp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_ACTIVECOMPOSE_HANG_UP_F, {
	"hang_up",
	".cs.S2C_Palace_ActiveCompose.hang_up",
	7,
	6,
	1,
	false,
	nil,
	var_0_3.PALACEBUILDHANGUP_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PALACE_ACTIVECOMPOSE_ME, {
	"S2C_Palace_ActiveCompose",
	".cs.S2C_Palace_ActiveCompose",
	{},
	{},
	{
		var_0_10.S2C_PALACE_ACTIVECOMPOSE_RET_F,
		var_0_10.S2C_PALACE_ACTIVECOMPOSE_ID_F,
		var_0_10.S2C_PALACE_ACTIVECOMPOSE_DAILY_ACTIVE_CNT_F,
		var_0_10.S2C_PALACE_ACTIVECOMPOSE_AWARD_F,
		var_0_10.S2C_PALACE_ACTIVECOMPOSE_BUILD_GRADE_F,
		var_0_10.S2C_PALACE_ACTIVECOMPOSE_BUILD_EXP_F,
		var_0_10.S2C_PALACE_ACTIVECOMPOSE_HANG_UP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PALACE_UPGRADECOMPOSE_ID_F, {
	"id",
	".cs.C2S_Palace_UpgradeCompose.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PALACE_UPGRADECOMPOSE_ME, {
	"C2S_Palace_UpgradeCompose",
	".cs.C2S_Palace_UpgradeCompose",
	{},
	{},
	{
		var_0_10.C2S_PALACE_UPGRADECOMPOSE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_UPGRADECOMPOSE_RET_F, {
	"ret",
	".cs.S2C_Palace_UpgradeCompose.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_UPGRADECOMPOSE_ID_F, {
	"id",
	".cs.S2C_Palace_UpgradeCompose.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_UPGRADECOMPOSE_AWARD_F, {
	"award",
	".cs.S2C_Palace_UpgradeCompose.award",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_UPGRADECOMPOSE_BUILD_GRADE_F, {
	"build_grade",
	".cs.S2C_Palace_UpgradeCompose.build_grade",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_UPGRADECOMPOSE_BUILD_EXP_F, {
	"build_exp",
	".cs.S2C_Palace_UpgradeCompose.build_exp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_UPGRADECOMPOSE_HANG_UP_F, {
	"hang_up",
	".cs.S2C_Palace_UpgradeCompose.hang_up",
	7,
	5,
	1,
	false,
	nil,
	var_0_3.PALACEBUILDHANGUP_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PALACE_UPGRADECOMPOSE_ME, {
	"S2C_Palace_UpgradeCompose",
	".cs.S2C_Palace_UpgradeCompose",
	{},
	{},
	{
		var_0_10.S2C_PALACE_UPGRADECOMPOSE_RET_F,
		var_0_10.S2C_PALACE_UPGRADECOMPOSE_ID_F,
		var_0_10.S2C_PALACE_UPGRADECOMPOSE_AWARD_F,
		var_0_10.S2C_PALACE_UPGRADECOMPOSE_BUILD_GRADE_F,
		var_0_10.S2C_PALACE_UPGRADECOMPOSE_BUILD_EXP_F,
		var_0_10.S2C_PALACE_UPGRADECOMPOSE_HANG_UP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PALACE_ONEKEYUPGRADECOMPOSE_IDS_F, {
	"ids",
	".cs.C2S_Palace_OneKeyUpgradeCompose.ids",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PALACE_ONEKEYUPGRADECOMPOSE_ME, {
	"C2S_Palace_OneKeyUpgradeCompose",
	".cs.C2S_Palace_OneKeyUpgradeCompose",
	{},
	{},
	{
		var_0_10.C2S_PALACE_ONEKEYUPGRADECOMPOSE_IDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_ONEKEYUPGRADECOMPOSE_RET_F, {
	"ret",
	".cs.S2C_Palace_OneKeyUpgradeCompose.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_ONEKEYUPGRADECOMPOSE_IDS_F, {
	"ids",
	".cs.S2C_Palace_OneKeyUpgradeCompose.ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_ONEKEYUPGRADECOMPOSE_AWARD_F, {
	"award",
	".cs.S2C_Palace_OneKeyUpgradeCompose.award",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_ONEKEYUPGRADECOMPOSE_BUILD_GRADE_F, {
	"build_grade",
	".cs.S2C_Palace_OneKeyUpgradeCompose.build_grade",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_ONEKEYUPGRADECOMPOSE_BUILD_EXP_F, {
	"build_exp",
	".cs.S2C_Palace_OneKeyUpgradeCompose.build_exp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_ONEKEYUPGRADECOMPOSE_HANG_UP_F, {
	"hang_up",
	".cs.S2C_Palace_OneKeyUpgradeCompose.hang_up",
	7,
	5,
	1,
	false,
	nil,
	var_0_3.PALACEBUILDHANGUP_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_PALACE_ONEKEYUPGRADECOMPOSE_ME, {
	"S2C_Palace_OneKeyUpgradeCompose",
	".cs.S2C_Palace_OneKeyUpgradeCompose",
	{},
	{},
	{
		var_0_10.S2C_PALACE_ONEKEYUPGRADECOMPOSE_RET_F,
		var_0_10.S2C_PALACE_ONEKEYUPGRADECOMPOSE_IDS_F,
		var_0_10.S2C_PALACE_ONEKEYUPGRADECOMPOSE_AWARD_F,
		var_0_10.S2C_PALACE_ONEKEYUPGRADECOMPOSE_BUILD_GRADE_F,
		var_0_10.S2C_PALACE_ONEKEYUPGRADECOMPOSE_BUILD_EXP_F,
		var_0_10.S2C_PALACE_ONEKEYUPGRADECOMPOSE_HANG_UP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PALACE_USECOMPOSE_ID_F, {
	"id",
	".cs.C2S_Palace_UseCompose.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PALACE_USECOMPOSE_POS_F, {
	"pos",
	".cs.C2S_Palace_UseCompose.pos",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PALACE_USECOMPOSE_ME, {
	"C2S_Palace_UseCompose",
	".cs.C2S_Palace_UseCompose",
	{},
	{},
	{
		var_0_10.C2S_PALACE_USECOMPOSE_ID_F,
		var_0_10.C2S_PALACE_USECOMPOSE_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_USECOMPOSE_RET_F, {
	"ret",
	".cs.S2C_Palace_UseCompose.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_USECOMPOSE_ID_F, {
	"id",
	".cs.S2C_Palace_UseCompose.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_USECOMPOSE_POS_F, {
	"pos",
	".cs.S2C_Palace_UseCompose.pos",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PALACE_USECOMPOSE_ME, {
	"S2C_Palace_UseCompose",
	".cs.S2C_Palace_UseCompose",
	{},
	{},
	{
		var_0_10.S2C_PALACE_USECOMPOSE_RET_F,
		var_0_10.S2C_PALACE_USECOMPOSE_ID_F,
		var_0_10.S2C_PALACE_USECOMPOSE_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PALACE_UNUSECOMPOSE_ID_F, {
	"id",
	".cs.C2S_Palace_UnuseCompose.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PALACE_UNUSECOMPOSE_ME, {
	"C2S_Palace_UnuseCompose",
	".cs.C2S_Palace_UnuseCompose",
	{},
	{},
	{
		var_0_10.C2S_PALACE_UNUSECOMPOSE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_UNUSECOMPOSE_RET_F, {
	"ret",
	".cs.S2C_Palace_UnuseCompose.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_UNUSECOMPOSE_ID_F, {
	"id",
	".cs.S2C_Palace_UnuseCompose.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PALACE_UNUSECOMPOSE_ME, {
	"S2C_Palace_UnuseCompose",
	".cs.S2C_Palace_UnuseCompose",
	{},
	{},
	{
		var_0_10.S2C_PALACE_UNUSECOMPOSE_RET_F,
		var_0_10.S2C_PALACE_UNUSECOMPOSE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PALACE_ACTIVEALTARNODE_ID_F, {
	"id",
	".cs.C2S_Palace_ActiveAltarNode.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PALACE_ACTIVEALTARNODE_ME, {
	"C2S_Palace_ActiveAltarNode",
	".cs.C2S_Palace_ActiveAltarNode",
	{},
	{},
	{
		var_0_10.C2S_PALACE_ACTIVEALTARNODE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_ACTIVEALTARNODE_RET_F, {
	"ret",
	".cs.S2C_Palace_ActiveAltarNode.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_ACTIVEALTARNODE_ID_F, {
	"id",
	".cs.S2C_Palace_ActiveAltarNode.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_ACTIVEALTARNODE_PALACE_ID_F, {
	"palace_id",
	".cs.S2C_Palace_ActiveAltarNode.palace_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PALACE_ACTIVEALTARNODE_ME, {
	"S2C_Palace_ActiveAltarNode",
	".cs.S2C_Palace_ActiveAltarNode",
	{},
	{},
	{
		var_0_10.S2C_PALACE_ACTIVEALTARNODE_RET_F,
		var_0_10.S2C_PALACE_ACTIVEALTARNODE_ID_F,
		var_0_10.S2C_PALACE_ACTIVEALTARNODE_PALACE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_PALACE_FIRSTENTERBUILD_BUILD_TYPE_F, {
	"build_type",
	".cs.C2S_Palace_FirstEnterBuild.build_type",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_PALACE_FIRSTENTERBUILD_ME, {
	"C2S_Palace_FirstEnterBuild",
	".cs.C2S_Palace_FirstEnterBuild",
	{},
	{},
	{
		var_0_10.C2S_PALACE_FIRSTENTERBUILD_BUILD_TYPE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_FIRSTENTERBUILD_RET_F, {
	"ret",
	".cs.S2C_Palace_FirstEnterBuild.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_FIRSTENTERBUILD_BUILD_TYPE_F, {
	"build_type",
	".cs.S2C_Palace_FirstEnterBuild.build_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_FIRSTENTERBUILD_START_TIME_F, {
	"start_time",
	".cs.S2C_Palace_FirstEnterBuild.start_time",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_PALACE_FIRSTENTERBUILD_AWARDS_F, {
	"awards",
	".cs.S2C_Palace_FirstEnterBuild.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_PALACE_FIRSTENTERBUILD_ME, {
	"S2C_Palace_FirstEnterBuild",
	".cs.S2C_Palace_FirstEnterBuild",
	{},
	{},
	{
		var_0_10.S2C_PALACE_FIRSTENTERBUILD_RET_F,
		var_0_10.S2C_PALACE_FIRSTENTERBUILD_BUILD_TYPE_F,
		var_0_10.S2C_PALACE_FIRSTENTERBUILD_START_TIME_F,
		var_0_10.S2C_PALACE_FIRSTENTERBUILD_AWARDS_F
	},
	false,
	{}
})

return var_0_10
