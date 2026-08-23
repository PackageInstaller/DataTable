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
	S2C_OTHERRETURNPAY_GETINFO_ME = protobuf.Descriptor(),
	S2C_OTHERRETURNPAY_GETINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_OTHERRETURNPAY_GETINFO_INFO_F = protobuf.FieldDescriptor(),
	C2S_OTHERRETURNPAY_GETAWARD_ME = protobuf.Descriptor(),
	S2C_OTHERRETURNPAY_GETAWARD_ME = protobuf.Descriptor(),
	S2C_OTHERRETURNPAY_GETAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_OTHERRETURNPAY_GETAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_OTHERRETURNPAY_GETAWARD_AWARD_TIME_F = protobuf.FieldDescriptor()
}

descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OTHERRETURNPAY_GETINFO_RET_F, {
	"ret",
	".cs.S2C_OtherReturnPay_GetInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OTHERRETURNPAY_GETINFO_INFO_F, {
	"info",
	".cs.S2C_OtherReturnPay_GetInfo.info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.OTHERRETURNPAY_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_OTHERRETURNPAY_GETINFO_ME, {
	"S2C_OtherReturnPay_GetInfo",
	".cs.S2C_OtherReturnPay_GetInfo",
	{},
	{},
	{
		var_0_10.S2C_OTHERRETURNPAY_GETINFO_RET_F,
		var_0_10.S2C_OTHERRETURNPAY_GETINFO_INFO_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_OTHERRETURNPAY_GETAWARD_ME, {
	"C2S_OtherReturnPay_GetAward",
	".cs.C2S_OtherReturnPay_GetAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OTHERRETURNPAY_GETAWARD_RET_F, {
	"ret",
	".cs.S2C_OtherReturnPay_GetAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OTHERRETURNPAY_GETAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_OtherReturnPay_GetAward.awards",
	2,
	1,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_OTHERRETURNPAY_GETAWARD_AWARD_TIME_F, {
	"award_time",
	".cs.S2C_OtherReturnPay_GetAward.award_time",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_OTHERRETURNPAY_GETAWARD_ME, {
	"S2C_OtherReturnPay_GetAward",
	".cs.S2C_OtherReturnPay_GetAward",
	{},
	{},
	{
		var_0_10.S2C_OTHERRETURNPAY_GETAWARD_RET_F,
		var_0_10.S2C_OTHERRETURNPAY_GETAWARD_AWARDS_F,
		var_0_10.S2C_OTHERRETURNPAY_GETAWARD_AWARD_TIME_F
	},
	false,
	{}
})

return var_0_10
