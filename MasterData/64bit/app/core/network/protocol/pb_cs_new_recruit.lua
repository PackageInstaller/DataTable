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
	C2S_NEWRECRUIT_INFO_ME = protobuf.Descriptor(),
	S2C_NEWRECRUIT_INFO_ME = protobuf.Descriptor(),
	S2C_NEWRECRUIT_INFO_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_INFO_RECRUIT_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_INFO_MINIMUM_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_INFO_NOVICE_TEN_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_INFO_RECRUIT_TOKEN_NUM_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_INFO_DAILY_TEN_DRAW_NUM_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_INFO_USER_DATA_F = protobuf.FieldDescriptor(),
	C2S_NEWRECRUIT_RECRUIT_ME = protobuf.Descriptor(),
	C2S_NEWRECRUIT_RECRUIT_RECRUIT_TYPE_F = protobuf.FieldDescriptor(),
	C2S_NEWRECRUIT_RECRUIT_CONSUME_TYPE_F = protobuf.FieldDescriptor(),
	C2S_NEWRECRUIT_RECRUIT_NUM_F = protobuf.FieldDescriptor(),
	C2S_NEWRECRUIT_RECRUIT_CLIENT_PARAMS_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_RECRUIT_ME = protobuf.Descriptor(),
	S2C_NEWRECRUIT_RECRUIT_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_RECRUIT_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_RECRUIT_RECRUIT_TYPE_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_RECRUIT_CONSUME_TYPE_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_RECRUIT_NUM_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_RECRUIT_RECRUIT_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_RECRUIT_MINIMUM_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_RECRUIT_RECRUIT_INFO_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_RECRUIT_DAILY_LV_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_RECRUIT_DAILY_TEN_DRAW_NUM_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_RECRUIT_CLIENT_PARAMS_F = protobuf.FieldDescriptor(),
	C2S_NEWRECRUIT_LUCK_ME = protobuf.Descriptor(),
	C2S_NEWRECRUIT_LUCK_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWRECRUIT_LUCK_WISH_F = protobuf.FieldDescriptor(),
	C2S_NEWRECRUIT_LUCK_CLIENT_PARAMS_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_LUCK_ME = protobuf.Descriptor(),
	S2C_NEWRECRUIT_LUCK_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_LUCK_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_LUCK_WISH_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_LUCK_WISH_IDS_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_LUCK_CLIENT_PARAMS_F = protobuf.FieldDescriptor(),
	C2S_NEWRECRUIT_NOVICETENRECRUIT_ME = protobuf.Descriptor(),
	C2S_NEWRECRUIT_NOVICETENRECRUIT_POS_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_NOVICETENRECRUIT_ME = protobuf.Descriptor(),
	S2C_NEWRECRUIT_NOVICETENRECRUIT_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_NOVICETENRECRUIT_POS_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_NOVICETENRECRUIT_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_NEWRECRUIT_NOVICETENAWARD_ME = protobuf.Descriptor(),
	C2S_NEWRECRUIT_NOVICETENAWARD_POS_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_NOVICETENAWARD_ME = protobuf.Descriptor(),
	S2C_NEWRECRUIT_NOVICETENAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_NOVICETENAWARD_POS_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_NOVICETENAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_NEWRECRUIT_PROGRESSAWARD_ME = protobuf.Descriptor(),
	C2S_NEWRECRUIT_PROGRESSAWARD_RECRUIT_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWRECRUIT_PROGRESSAWARD_AWARD_ID_F = protobuf.FieldDescriptor(),
	C2S_NEWRECRUIT_PROGRESSAWARD_CLIENT_PARAMS_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_PROGRESSAWARD_ME = protobuf.Descriptor(),
	S2C_NEWRECRUIT_PROGRESSAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_PROGRESSAWARD_RECRUIT_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_PROGRESSAWARD_AWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_PROGRESSAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_NEWRECRUIT_PROGRESSAWARD_CLIENT_PARAMS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_NEWRECRUIT_INFO_ME, {
	"C2S_NewRecruit_Info",
	".cs.C2S_NewRecruit_Info",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_INFO_RET_F, {
	"ret",
	".cs.S2C_NewRecruit_Info.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_INFO_RECRUIT_F, {
	"recruit",
	".cs.S2C_NewRecruit_Info.recruit",
	2,
	1,
	3,
	false,
	{},
	var_0_3.RECRUITINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_INFO_MINIMUM_F, {
	"minimum",
	".cs.S2C_NewRecruit_Info.minimum",
	3,
	2,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_INFO_NOVICE_TEN_F, {
	"novice_ten",
	".cs.S2C_NewRecruit_Info.novice_ten",
	4,
	3,
	1,
	false,
	nil,
	var_0_3.NOVICETEN_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_INFO_RECRUIT_TOKEN_NUM_F, {
	"recruit_token_num",
	".cs.S2C_NewRecruit_Info.recruit_token_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_INFO_DAILY_TEN_DRAW_NUM_F, {
	"daily_ten_draw_num",
	".cs.S2C_NewRecruit_Info.daily_ten_draw_num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_INFO_USER_DATA_F, {
	"user_data",
	".cs.S2C_NewRecruit_Info.user_data",
	7,
	6,
	1,
	false,
	nil,
	var_0_3.USERRECRUITDATA_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWRECRUIT_INFO_ME, {
	"S2C_NewRecruit_Info",
	".cs.S2C_NewRecruit_Info",
	{},
	{},
	{
		var_0_10.S2C_NEWRECRUIT_INFO_RET_F,
		var_0_10.S2C_NEWRECRUIT_INFO_RECRUIT_F,
		var_0_10.S2C_NEWRECRUIT_INFO_MINIMUM_F,
		var_0_10.S2C_NEWRECRUIT_INFO_NOVICE_TEN_F,
		var_0_10.S2C_NEWRECRUIT_INFO_RECRUIT_TOKEN_NUM_F,
		var_0_10.S2C_NEWRECRUIT_INFO_DAILY_TEN_DRAW_NUM_F,
		var_0_10.S2C_NEWRECRUIT_INFO_USER_DATA_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWRECRUIT_RECRUIT_RECRUIT_TYPE_F, {
	"recruit_type",
	".cs.C2S_NewRecruit_Recruit.recruit_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWRECRUIT_RECRUIT_CONSUME_TYPE_F, {
	"consume_type",
	".cs.C2S_NewRecruit_Recruit.consume_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWRECRUIT_RECRUIT_NUM_F, {
	"num",
	".cs.C2S_NewRecruit_Recruit.num",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWRECRUIT_RECRUIT_CLIENT_PARAMS_F, {
	"client_params",
	".cs.C2S_NewRecruit_Recruit.client_params",
	4,
	3,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWRECRUIT_RECRUIT_ME, {
	"C2S_NewRecruit_Recruit",
	".cs.C2S_NewRecruit_Recruit",
	{},
	{},
	{
		var_0_10.C2S_NEWRECRUIT_RECRUIT_RECRUIT_TYPE_F,
		var_0_10.C2S_NEWRECRUIT_RECRUIT_CONSUME_TYPE_F,
		var_0_10.C2S_NEWRECRUIT_RECRUIT_NUM_F,
		var_0_10.C2S_NEWRECRUIT_RECRUIT_CLIENT_PARAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_RECRUIT_RET_F, {
	"ret",
	".cs.S2C_NewRecruit_Recruit.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_RECRUIT_AWARDS_F, {
	"awards",
	".cs.S2C_NewRecruit_Recruit.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_RECRUIT_RECRUIT_TYPE_F, {
	"recruit_type",
	".cs.S2C_NewRecruit_Recruit.recruit_type",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_RECRUIT_CONSUME_TYPE_F, {
	"consume_type",
	".cs.S2C_NewRecruit_Recruit.consume_type",
	4,
	3,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_RECRUIT_NUM_F, {
	"num",
	".cs.S2C_NewRecruit_Recruit.num",
	5,
	4,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_RECRUIT_RECRUIT_F, {
	"recruit",
	".cs.S2C_NewRecruit_Recruit.recruit",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.RECRUITINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_RECRUIT_MINIMUM_F, {
	"minimum",
	".cs.S2C_NewRecruit_Recruit.minimum",
	7,
	6,
	3,
	false,
	{},
	var_0_3.KV_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_RECRUIT_RECRUIT_INFO_F, {
	"recruit_info",
	".cs.S2C_NewRecruit_Recruit.recruit_info",
	8,
	7,
	3,
	false,
	{},
	var_0_3.NEWRECRUITINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_RECRUIT_DAILY_LV_AWARDS_F, {
	"daily_lv_awards",
	".cs.S2C_NewRecruit_Recruit.daily_lv_awards",
	9,
	8,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_RECRUIT_DAILY_TEN_DRAW_NUM_F, {
	"daily_ten_draw_num",
	".cs.S2C_NewRecruit_Recruit.daily_ten_draw_num",
	10,
	9,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_RECRUIT_CLIENT_PARAMS_F, {
	"client_params",
	".cs.S2C_NewRecruit_Recruit.client_params",
	11,
	10,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWRECRUIT_RECRUIT_ME, {
	"S2C_NewRecruit_Recruit",
	".cs.S2C_NewRecruit_Recruit",
	{},
	{},
	{
		var_0_10.S2C_NEWRECRUIT_RECRUIT_RET_F,
		var_0_10.S2C_NEWRECRUIT_RECRUIT_AWARDS_F,
		var_0_10.S2C_NEWRECRUIT_RECRUIT_RECRUIT_TYPE_F,
		var_0_10.S2C_NEWRECRUIT_RECRUIT_CONSUME_TYPE_F,
		var_0_10.S2C_NEWRECRUIT_RECRUIT_NUM_F,
		var_0_10.S2C_NEWRECRUIT_RECRUIT_RECRUIT_F,
		var_0_10.S2C_NEWRECRUIT_RECRUIT_MINIMUM_F,
		var_0_10.S2C_NEWRECRUIT_RECRUIT_RECRUIT_INFO_F,
		var_0_10.S2C_NEWRECRUIT_RECRUIT_DAILY_LV_AWARDS_F,
		var_0_10.S2C_NEWRECRUIT_RECRUIT_DAILY_TEN_DRAW_NUM_F,
		var_0_10.S2C_NEWRECRUIT_RECRUIT_CLIENT_PARAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWRECRUIT_LUCK_ID_F, {
	"id",
	".cs.C2S_NewRecruit_Luck.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWRECRUIT_LUCK_WISH_F, {
	"wish",
	".cs.C2S_NewRecruit_Luck.wish",
	2,
	1,
	3,
	false,
	{},
	var_0_3.RECRUITWISH_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWRECRUIT_LUCK_CLIENT_PARAMS_F, {
	"client_params",
	".cs.C2S_NewRecruit_Luck.client_params",
	3,
	2,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWRECRUIT_LUCK_ME, {
	"C2S_NewRecruit_Luck",
	".cs.C2S_NewRecruit_Luck",
	{},
	{},
	{
		var_0_10.C2S_NEWRECRUIT_LUCK_ID_F,
		var_0_10.C2S_NEWRECRUIT_LUCK_WISH_F,
		var_0_10.C2S_NEWRECRUIT_LUCK_CLIENT_PARAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_LUCK_RET_F, {
	"ret",
	".cs.S2C_NewRecruit_Luck.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_LUCK_ID_F, {
	"id",
	".cs.S2C_NewRecruit_Luck.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_LUCK_WISH_F, {
	"wish",
	".cs.S2C_NewRecruit_Luck.wish",
	3,
	2,
	3,
	false,
	{},
	var_0_3.RECRUITWISH_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_LUCK_WISH_IDS_F, {
	"wish_ids",
	".cs.S2C_NewRecruit_Luck.wish_ids",
	4,
	3,
	3,
	false,
	{},
	var_0_3.RECRUITLUCK_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_LUCK_CLIENT_PARAMS_F, {
	"client_params",
	".cs.S2C_NewRecruit_Luck.client_params",
	5,
	4,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWRECRUIT_LUCK_ME, {
	"S2C_NewRecruit_Luck",
	".cs.S2C_NewRecruit_Luck",
	{},
	{},
	{
		var_0_10.S2C_NEWRECRUIT_LUCK_RET_F,
		var_0_10.S2C_NEWRECRUIT_LUCK_ID_F,
		var_0_10.S2C_NEWRECRUIT_LUCK_WISH_F,
		var_0_10.S2C_NEWRECRUIT_LUCK_WISH_IDS_F,
		var_0_10.S2C_NEWRECRUIT_LUCK_CLIENT_PARAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWRECRUIT_NOVICETENRECRUIT_POS_F, {
	"pos",
	".cs.C2S_NewRecruit_NoviceTenRecruit.pos",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWRECRUIT_NOVICETENRECRUIT_ME, {
	"C2S_NewRecruit_NoviceTenRecruit",
	".cs.C2S_NewRecruit_NoviceTenRecruit",
	{},
	{},
	{
		var_0_10.C2S_NEWRECRUIT_NOVICETENRECRUIT_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_NOVICETENRECRUIT_RET_F, {
	"ret",
	".cs.S2C_NewRecruit_NoviceTenRecruit.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_NOVICETENRECRUIT_POS_F, {
	"pos",
	".cs.S2C_NewRecruit_NoviceTenRecruit.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_NOVICETENRECRUIT_AWARDS_F, {
	"awards",
	".cs.S2C_NewRecruit_NoviceTenRecruit.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWRECRUIT_NOVICETENRECRUIT_ME, {
	"S2C_NewRecruit_NoviceTenRecruit",
	".cs.S2C_NewRecruit_NoviceTenRecruit",
	{},
	{},
	{
		var_0_10.S2C_NEWRECRUIT_NOVICETENRECRUIT_RET_F,
		var_0_10.S2C_NEWRECRUIT_NOVICETENRECRUIT_POS_F,
		var_0_10.S2C_NEWRECRUIT_NOVICETENRECRUIT_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWRECRUIT_NOVICETENAWARD_POS_F, {
	"pos",
	".cs.C2S_NewRecruit_NoviceTenAward.pos",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWRECRUIT_NOVICETENAWARD_ME, {
	"C2S_NewRecruit_NoviceTenAward",
	".cs.C2S_NewRecruit_NoviceTenAward",
	{},
	{},
	{
		var_0_10.C2S_NEWRECRUIT_NOVICETENAWARD_POS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_NOVICETENAWARD_RET_F, {
	"ret",
	".cs.S2C_NewRecruit_NoviceTenAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_NOVICETENAWARD_POS_F, {
	"pos",
	".cs.S2C_NewRecruit_NoviceTenAward.pos",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_NOVICETENAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_NewRecruit_NoviceTenAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWRECRUIT_NOVICETENAWARD_ME, {
	"S2C_NewRecruit_NoviceTenAward",
	".cs.S2C_NewRecruit_NoviceTenAward",
	{},
	{},
	{
		var_0_10.S2C_NEWRECRUIT_NOVICETENAWARD_RET_F,
		var_0_10.S2C_NEWRECRUIT_NOVICETENAWARD_POS_F,
		var_0_10.S2C_NEWRECRUIT_NOVICETENAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWRECRUIT_PROGRESSAWARD_RECRUIT_ID_F, {
	"recruit_id",
	".cs.C2S_NewRecruit_ProgressAward.recruit_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWRECRUIT_PROGRESSAWARD_AWARD_ID_F, {
	"award_id",
	".cs.C2S_NewRecruit_ProgressAward.award_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_NEWRECRUIT_PROGRESSAWARD_CLIENT_PARAMS_F, {
	"client_params",
	".cs.C2S_NewRecruit_ProgressAward.client_params",
	3,
	2,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.C2S_NEWRECRUIT_PROGRESSAWARD_ME, {
	"C2S_NewRecruit_ProgressAward",
	".cs.C2S_NewRecruit_ProgressAward",
	{},
	{},
	{
		var_0_10.C2S_NEWRECRUIT_PROGRESSAWARD_RECRUIT_ID_F,
		var_0_10.C2S_NEWRECRUIT_PROGRESSAWARD_AWARD_ID_F,
		var_0_10.C2S_NEWRECRUIT_PROGRESSAWARD_CLIENT_PARAMS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_PROGRESSAWARD_RET_F, {
	"ret",
	".cs.S2C_NewRecruit_ProgressAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_PROGRESSAWARD_RECRUIT_ID_F, {
	"recruit_id",
	".cs.S2C_NewRecruit_ProgressAward.recruit_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_PROGRESSAWARD_AWARD_ID_F, {
	"award_id",
	".cs.S2C_NewRecruit_ProgressAward.award_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_PROGRESSAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_NewRecruit_ProgressAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_NEWRECRUIT_PROGRESSAWARD_CLIENT_PARAMS_F, {
	"client_params",
	".cs.S2C_NewRecruit_ProgressAward.client_params",
	5,
	4,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_10.S2C_NEWRECRUIT_PROGRESSAWARD_ME, {
	"S2C_NewRecruit_ProgressAward",
	".cs.S2C_NewRecruit_ProgressAward",
	{},
	{},
	{
		var_0_10.S2C_NEWRECRUIT_PROGRESSAWARD_RET_F,
		var_0_10.S2C_NEWRECRUIT_PROGRESSAWARD_RECRUIT_ID_F,
		var_0_10.S2C_NEWRECRUIT_PROGRESSAWARD_AWARD_ID_F,
		var_0_10.S2C_NEWRECRUIT_PROGRESSAWARD_AWARDS_F,
		var_0_10.S2C_NEWRECRUIT_PROGRESSAWARD_CLIENT_PARAMS_F
	},
	false,
	{}
})

return var_0_10
