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
	C2S_RECHARGE_GETRECHARGE_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETRECHARGE_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETRECHARGE_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGE_RECHARGE_IDS_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGE_SHOW_IDS_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGE_MC_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGE_SUBS_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGE_FIRST_RECHARGE_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGE_FUND_RECHARGE_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGE_TOTAL_RECHARGE_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGE_RECHARGES_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGE_GIFT_RECHARGES_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGE_DAILY_SALE_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGE_MONTH_CARD_TURN_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGE_GM_TOTAL_RECHARGE_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGE_GM_FIRST_RECHARGE_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGE_DAILY_BOX_TURN_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGE_RECHARGE_REBATES_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGE_LIMIT_SALE_RECHARGES_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_USEMONTHCARD_ME = protobuf.Descriptor(),
	C2S_RECHARGE_USEMONTHCARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_USEMONTHCARD_ME = protobuf.Descriptor(),
	S2C_RECHARGE_USEMONTHCARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_USEMONTHCARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_USEMONTHCARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_USESUBRECHARGE_ME = protobuf.Descriptor(),
	C2S_RECHARGE_USESUBRECHARGE_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_USESUBRECHARGE_ME = protobuf.Descriptor(),
	S2C_RECHARGE_USESUBRECHARGE_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_USESUBRECHARGE_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_USESUBRECHARGE_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_SUBRECHARGENOTIFY_ME = protobuf.Descriptor(),
	S2C_RECHARGE_SUBRECHARGENOTIFY_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_NOTIFYSUCCESS_ME = protobuf.Descriptor(),
	S2C_RECHARGE_NOTIFYSUCCESS_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_NOTIFYSUCCESS_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_NOTIFYSUCCESS_ORDER_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_AWARD_ME = protobuf.Descriptor(),
	S2C_RECHARGE_AWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_AWARD_ORDER_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_AWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETFIRSTRECHARGEAWARD_ME = protobuf.Descriptor(),
	C2S_RECHARGE_GETFIRSTRECHARGEAWARD_DAY_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETFIRSTRECHARGEAWARD_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETFIRSTRECHARGEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETFIRSTRECHARGEAWARD_DAY_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETFIRSTRECHARGEAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETFUNDRECHARGEAWARD_ME = protobuf.Descriptor(),
	C2S_RECHARGE_GETFUNDRECHARGEAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETFUNDRECHARGEAWARD_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETFUNDRECHARGEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETFUNDRECHARGEAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETFUNDRECHARGEAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_ME = protobuf.Descriptor(),
	C2S_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_TP_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_PERIOD_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_TP_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_PERIOD_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_FUNDBUYNOTIFY_ME = protobuf.Descriptor(),
	S2C_RECHARGE_FUNDBUYNOTIFY_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_FUNDBUYNOTIFY_NUM_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_ME = protobuf.Descriptor(),
	S2C_RECHARGE_OPRECHARGE_MONTH_CARD_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_FIRST_RECHARGE_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_FUND_RECHARGE_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_SUB_RECHARGE_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_TOTAL_RECHARGE_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_GIFT_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_DAILY_SALE_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_PASSCARD_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_PUSH_GIFT_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_GM_TOTAL_RECHARGE_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_GM_FIRST_RECHARGE_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_RECHARGE_REBATE_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_LIMIT_SALE_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_CULTIVATE_ACTIVITY_PASSCARD_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_PASSCARD_ACTIVITY_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_FUND_ACTIVITY_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_THEME_PASSCARD_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_COMMON_PASSCARD_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_OPRECHARGE_SERVER_PASS_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETFUNDRECHARGE_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETFUNDRECHARGE_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETFUNDRECHARGE_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETFUNDRECHARGE_FUND_RECHARGE_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETFUNDRECHARGE_DEAD_BATTLE_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETTOTALRECHARGEAWARD_ME = protobuf.Descriptor(),
	C2S_RECHARGE_GETTOTALRECHARGEAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETTOTALRECHARGEAWARD_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETTOTALRECHARGEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETTOTALRECHARGEAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETTOTALRECHARGEAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETFREEGIFTAWARD_ME = protobuf.Descriptor(),
	C2S_RECHARGE_GETFREEGIFTAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETFREEGIFTAWARD_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETFREEGIFTAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETFREEGIFTAWARD_ID_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETFREEDAILYSALEAWARD_ME = protobuf.Descriptor(),
	C2S_RECHARGE_GETFREEDAILYSALEAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETFREEDAILYSALEAWARD_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETFREEDAILYSALEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETFREEDAILYSALEAWARD_ID_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETALLDAILYSALEAWARD_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETALLDAILYSALEAWARD_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETALLDAILYSALEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETALLDAILYSALEAWARD_AWARD_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_FIRST_RECHARGE_GETRECHARGEAWARD_ME = protobuf.Descriptor(),
	S2C_RECHARGE_FIRST_RECHARGE_GETRECHARGEAWARD_ME = protobuf.Descriptor(),
	S2C_RECHARGE_FIRST_RECHARGE_GETRECHARGEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_FIRST_RECHARGE_GETRECHARGEAWARD_AWARD_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_MONTHCARDTURNAWARD_ME = protobuf.Descriptor(),
	C2S_RECHARGE_MONTHCARDTURNAWARD_ID_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_MONTHCARDTURNAWARD_REWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_MONTHCARDTURNAWARD_ME = protobuf.Descriptor(),
	S2C_RECHARGE_MONTHCARDTURNAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_MONTHCARDTURNAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_MONTHCARDTURNAWARD_REWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_MONTHCARDTURNAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_MONTHCARDTURNAWARD_MONTH_CARD_TURN_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_DAILYBOXTURNAWARD_ME = protobuf.Descriptor(),
	C2S_RECHARGE_DAILYBOXTURNAWARD_ID_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_DAILYBOXTURNAWARD_REWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_DAILYBOXTURNAWARD_ME = protobuf.Descriptor(),
	S2C_RECHARGE_DAILYBOXTURNAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_DAILYBOXTURNAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_DAILYBOXTURNAWARD_REWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_DAILYBOXTURNAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_DAILYBOXTURNAWARD_DAILY_BOX_TURN_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETGMTOTALRECHARGEINFO_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGEINFO_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGEINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGEINFO_INFOS_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETGMTOTALRECHARGEAWARD_ME = protobuf.Descriptor(),
	C2S_RECHARGE_GETGMTOTALRECHARGEAWARD_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETGMTOTALRECHARGEAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGEAWARD_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGEAWARD_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGEAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGEAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETGMTOTALRECHARGETASKDATA_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGETASKDATA_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGETASKDATA_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGETASKDATA_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGETASKDATA_INFOS_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETGMTOTALRECHARGETASKAWARD_ME = protobuf.Descriptor(),
	C2S_RECHARGE_GETGMTOTALRECHARGETASKAWARD_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETGMTOTALRECHARGETASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD_ACTIVITY_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD_TASK_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETGMFIRSTRECHARGEINFO_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETGMFIRSTRECHARGEINFO_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETGMFIRSTRECHARGEINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETGMFIRSTRECHARGEINFO_INFO_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_UPDATEGMFIRSTRECHARGEINFO_ME = protobuf.Descriptor(),
	S2C_RECHARGE_UPDATEGMFIRSTRECHARGEINFO_INFO_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_UPDATEGMFIRSTRECHARGEINFO_DELETE_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETRECHARGEREBATEINFO_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETRECHARGEREBATEINFO_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETRECHARGEREBATEINFO_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGEREBATEINFO_INFO_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGEREBATEINFO_REFRESH_TIME_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_UPDATERECHARGEREBATEGMINFO_ME = protobuf.Descriptor(),
	S2C_RECHARGE_UPDATERECHARGEREBATEGMINFO_INFO_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_UPDATERECHARGEREBATEGMINFO_REFRESH_TIME_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_GETRECHARGEREBATEAWARD_ME = protobuf.Descriptor(),
	C2S_RECHARGE_GETRECHARGEREBATEAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGEREBATEAWARD_ME = protobuf.Descriptor(),
	S2C_RECHARGE_GETRECHARGEREBATEAWARD_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGEREBATEAWARD_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_GETRECHARGEREBATEAWARD_AWARDS_F = protobuf.FieldDescriptor(),
	C2S_RECHARGE_BUYRECHARGEREBATEGIFT_ME = protobuf.Descriptor(),
	C2S_RECHARGE_BUYRECHARGEREBATEGIFT_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_BUYRECHARGEREBATEGIFT_ME = protobuf.Descriptor(),
	S2C_RECHARGE_BUYRECHARGEREBATEGIFT_RET_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_BUYRECHARGEREBATEGIFT_ID_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_BUYRECHARGEREBATEGIFT_AWARDS_F = protobuf.FieldDescriptor(),
	S2C_RECHARGE_RECHARGEREBATEAWARDS_ME = protobuf.Descriptor(),
	S2C_RECHARGE_RECHARGEREBATEAWARDS_AWARDS_F = protobuf.FieldDescriptor()
}

descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_GETRECHARGE_ME, {
	"C2S_Recharge_GetRecharge",
	".cs.C2S_Recharge_GetRecharge",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_RET_F, {
	"ret",
	".cs.S2C_Recharge_GetRecharge.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_RECHARGE_IDS_F, {
	"recharge_ids",
	".cs.S2C_Recharge_GetRecharge.recharge_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_SHOW_IDS_F, {
	"show_ids",
	".cs.S2C_Recharge_GetRecharge.show_ids",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_MC_F, {
	"mc",
	".cs.S2C_Recharge_GetRecharge.mc",
	4,
	3,
	3,
	false,
	{},
	var_0_3.MONTHCARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_SUBS_F, {
	"subs",
	".cs.S2C_Recharge_GetRecharge.subs",
	5,
	4,
	3,
	false,
	{},
	var_0_3.MONTHCARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_FIRST_RECHARGE_F, {
	"first_recharge",
	".cs.S2C_Recharge_GetRecharge.first_recharge",
	6,
	5,
	1,
	false,
	nil,
	var_0_3.FIRSTRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_FUND_RECHARGE_F, {
	"fund_recharge",
	".cs.S2C_Recharge_GetRecharge.fund_recharge",
	7,
	6,
	3,
	false,
	{},
	var_0_3.FUNDRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_TOTAL_RECHARGE_F, {
	"total_recharge",
	".cs.S2C_Recharge_GetRecharge.total_recharge",
	9,
	7,
	1,
	false,
	nil,
	var_0_3.TOTALRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_RECHARGES_F, {
	"recharges",
	".cs.S2C_Recharge_GetRecharge.recharges",
	10,
	8,
	3,
	false,
	{},
	var_0_3.RECHARGENOTIFY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_GIFT_RECHARGES_F, {
	"gift_recharges",
	".cs.S2C_Recharge_GetRecharge.gift_recharges",
	16,
	9,
	3,
	false,
	{},
	var_0_3.GIFTRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_DAILY_SALE_F, {
	"daily_sale",
	".cs.S2C_Recharge_GetRecharge.daily_sale",
	17,
	10,
	1,
	false,
	nil,
	var_0_3.DAILYSALE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_MONTH_CARD_TURN_F, {
	"month_card_turn",
	".cs.S2C_Recharge_GetRecharge.month_card_turn",
	18,
	11,
	1,
	false,
	nil,
	var_0_3.MONTHCARDTURN_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_GM_TOTAL_RECHARGE_F, {
	"gm_total_recharge",
	".cs.S2C_Recharge_GetRecharge.gm_total_recharge",
	19,
	12,
	1,
	false,
	nil,
	var_0_3.GMTOTALRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_GM_FIRST_RECHARGE_F, {
	"gm_first_recharge",
	".cs.S2C_Recharge_GetRecharge.gm_first_recharge",
	20,
	13,
	1,
	false,
	nil,
	var_0_3.GMFIRSTRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_DAILY_BOX_TURN_F, {
	"daily_box_turn",
	".cs.S2C_Recharge_GetRecharge.daily_box_turn",
	21,
	14,
	1,
	false,
	nil,
	var_0_3.DAILYBOXTURN_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_RECHARGE_REBATES_F, {
	"recharge_rebates",
	".cs.S2C_Recharge_GetRecharge.recharge_rebates",
	22,
	15,
	3,
	false,
	{},
	var_0_3.RECHARGEREBATE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_LIMIT_SALE_RECHARGES_F, {
	"limit_sale_recharges",
	".cs.S2C_Recharge_GetRecharge.limit_sale_recharges",
	23,
	16,
	3,
	false,
	{},
	var_0_3.RECHARGELIMITSALE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGE_ME, {
	"S2C_Recharge_GetRecharge",
	".cs.S2C_Recharge_GetRecharge",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_GETRECHARGE_RET_F,
		var_0_10.S2C_RECHARGE_GETRECHARGE_RECHARGE_IDS_F,
		var_0_10.S2C_RECHARGE_GETRECHARGE_SHOW_IDS_F,
		var_0_10.S2C_RECHARGE_GETRECHARGE_MC_F,
		var_0_10.S2C_RECHARGE_GETRECHARGE_SUBS_F,
		var_0_10.S2C_RECHARGE_GETRECHARGE_FIRST_RECHARGE_F,
		var_0_10.S2C_RECHARGE_GETRECHARGE_FUND_RECHARGE_F,
		var_0_10.S2C_RECHARGE_GETRECHARGE_TOTAL_RECHARGE_F,
		var_0_10.S2C_RECHARGE_GETRECHARGE_RECHARGES_F,
		var_0_10.S2C_RECHARGE_GETRECHARGE_GIFT_RECHARGES_F,
		var_0_10.S2C_RECHARGE_GETRECHARGE_DAILY_SALE_F,
		var_0_10.S2C_RECHARGE_GETRECHARGE_MONTH_CARD_TURN_F,
		var_0_10.S2C_RECHARGE_GETRECHARGE_GM_TOTAL_RECHARGE_F,
		var_0_10.S2C_RECHARGE_GETRECHARGE_GM_FIRST_RECHARGE_F,
		var_0_10.S2C_RECHARGE_GETRECHARGE_DAILY_BOX_TURN_F,
		var_0_10.S2C_RECHARGE_GETRECHARGE_RECHARGE_REBATES_F,
		var_0_10.S2C_RECHARGE_GETRECHARGE_LIMIT_SALE_RECHARGES_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_USEMONTHCARD_ID_F, {
	"id",
	".cs.C2S_Recharge_UseMonthCard.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_USEMONTHCARD_ME, {
	"C2S_Recharge_UseMonthCard",
	".cs.C2S_Recharge_UseMonthCard",
	{},
	{},
	{
		var_0_10.C2S_RECHARGE_USEMONTHCARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_USEMONTHCARD_RET_F, {
	"ret",
	".cs.S2C_Recharge_UseMonthCard.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_USEMONTHCARD_ID_F, {
	"id",
	".cs.S2C_Recharge_UseMonthCard.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_USEMONTHCARD_AWARDS_F, {
	"awards",
	".cs.S2C_Recharge_UseMonthCard.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_USEMONTHCARD_ME, {
	"S2C_Recharge_UseMonthCard",
	".cs.S2C_Recharge_UseMonthCard",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_USEMONTHCARD_RET_F,
		var_0_10.S2C_RECHARGE_USEMONTHCARD_ID_F,
		var_0_10.S2C_RECHARGE_USEMONTHCARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_USESUBRECHARGE_ID_F, {
	"id",
	".cs.C2S_Recharge_UseSubRecharge.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_USESUBRECHARGE_ME, {
	"C2S_Recharge_UseSubRecharge",
	".cs.C2S_Recharge_UseSubRecharge",
	{},
	{},
	{
		var_0_10.C2S_RECHARGE_USESUBRECHARGE_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_USESUBRECHARGE_RET_F, {
	"ret",
	".cs.S2C_Recharge_UseSubRecharge.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_USESUBRECHARGE_ID_F, {
	"id",
	".cs.S2C_Recharge_UseSubRecharge.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_USESUBRECHARGE_AWARDS_F, {
	"awards",
	".cs.S2C_Recharge_UseSubRecharge.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_USESUBRECHARGE_ME, {
	"S2C_Recharge_UseSubRecharge",
	".cs.S2C_Recharge_UseSubRecharge",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_USESUBRECHARGE_RET_F,
		var_0_10.S2C_RECHARGE_USESUBRECHARGE_ID_F,
		var_0_10.S2C_RECHARGE_USESUBRECHARGE_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_SUBRECHARGENOTIFY_AWARDS_F, {
	"awards",
	".cs.S2C_Recharge_SubRechargeNotify.awards",
	1,
	0,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_SUBRECHARGENOTIFY_ME, {
	"S2C_Recharge_SubRechargeNotify",
	".cs.S2C_Recharge_SubRechargeNotify",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_SUBRECHARGENOTIFY_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_NOTIFYSUCCESS_RET_F, {
	"ret",
	".cs.S2C_Recharge_NotifySuccess.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_NOTIFYSUCCESS_ID_F, {
	"id",
	".cs.S2C_Recharge_NotifySuccess.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_NOTIFYSUCCESS_ORDER_ID_F, {
	"order_id",
	".cs.S2C_Recharge_NotifySuccess.order_id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_NOTIFYSUCCESS_ME, {
	"S2C_Recharge_NotifySuccess",
	".cs.S2C_Recharge_NotifySuccess",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_NOTIFYSUCCESS_RET_F,
		var_0_10.S2C_RECHARGE_NOTIFYSUCCESS_ID_F,
		var_0_10.S2C_RECHARGE_NOTIFYSUCCESS_ORDER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_AWARD_RET_F, {
	"ret",
	".cs.S2C_Recharge_Award.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_AWARD_ORDER_ID_F, {
	"order_id",
	".cs.S2C_Recharge_Award.order_id",
	2,
	1,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_AWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Recharge_Award.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_AWARD_ME, {
	"S2C_Recharge_Award",
	".cs.S2C_Recharge_Award",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_AWARD_RET_F,
		var_0_10.S2C_RECHARGE_AWARD_ORDER_ID_F,
		var_0_10.S2C_RECHARGE_AWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_GETFIRSTRECHARGEAWARD_DAY_F, {
	"day",
	".cs.C2S_Recharge_GetFirstRechargeAward.day",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_GETFIRSTRECHARGEAWARD_ME, {
	"C2S_Recharge_GetFirstRechargeAward",
	".cs.C2S_Recharge_GetFirstRechargeAward",
	{},
	{},
	{
		var_0_10.C2S_RECHARGE_GETFIRSTRECHARGEAWARD_DAY_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFIRSTRECHARGEAWARD_RET_F, {
	"ret",
	".cs.S2C_Recharge_GetFirstRechargeAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFIRSTRECHARGEAWARD_DAY_F, {
	"day",
	".cs.S2C_Recharge_GetFirstRechargeAward.day",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFIRSTRECHARGEAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Recharge_GetFirstRechargeAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_GETFIRSTRECHARGEAWARD_ME, {
	"S2C_Recharge_GetFirstRechargeAward",
	".cs.S2C_Recharge_GetFirstRechargeAward",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_GETFIRSTRECHARGEAWARD_RET_F,
		var_0_10.S2C_RECHARGE_GETFIRSTRECHARGEAWARD_DAY_F,
		var_0_10.S2C_RECHARGE_GETFIRSTRECHARGEAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_GETFUNDRECHARGEAWARD_ID_F, {
	"id",
	".cs.C2S_Recharge_GetFundRechargeAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_GETFUNDRECHARGEAWARD_ME, {
	"C2S_Recharge_GetFundRechargeAward",
	".cs.C2S_Recharge_GetFundRechargeAward",
	{},
	{},
	{
		var_0_10.C2S_RECHARGE_GETFUNDRECHARGEAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFUNDRECHARGEAWARD_RET_F, {
	"ret",
	".cs.S2C_Recharge_GetFundRechargeAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFUNDRECHARGEAWARD_ID_F, {
	"id",
	".cs.S2C_Recharge_GetFundRechargeAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFUNDRECHARGEAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Recharge_GetFundRechargeAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_GETFUNDRECHARGEAWARD_ME, {
	"S2C_Recharge_GetFundRechargeAward",
	".cs.S2C_Recharge_GetFundRechargeAward",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_GETFUNDRECHARGEAWARD_RET_F,
		var_0_10.S2C_RECHARGE_GETFUNDRECHARGEAWARD_ID_F,
		var_0_10.S2C_RECHARGE_GETFUNDRECHARGEAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_TP_F, {
	"tp",
	".cs.C2S_Recharge_GetFundRechargeAwardOneKey.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_PERIOD_F, {
	"period",
	".cs.C2S_Recharge_GetFundRechargeAwardOneKey.period",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_ME, {
	"C2S_Recharge_GetFundRechargeAwardOneKey",
	".cs.C2S_Recharge_GetFundRechargeAwardOneKey",
	{},
	{},
	{
		var_0_10.C2S_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_TP_F,
		var_0_10.C2S_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_PERIOD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_RET_F, {
	"ret",
	".cs.S2C_Recharge_GetFundRechargeAwardOneKey.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_TP_F, {
	"tp",
	".cs.S2C_Recharge_GetFundRechargeAwardOneKey.tp",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_PERIOD_F, {
	"period",
	".cs.S2C_Recharge_GetFundRechargeAwardOneKey.period",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_AWARDS_F, {
	"awards",
	".cs.S2C_Recharge_GetFundRechargeAwardOneKey.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_ME, {
	"S2C_Recharge_GetFundRechargeAwardOneKey",
	".cs.S2C_Recharge_GetFundRechargeAwardOneKey",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_RET_F,
		var_0_10.S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_TP_F,
		var_0_10.S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_PERIOD_F,
		var_0_10.S2C_RECHARGE_GETFUNDRECHARGEAWARDONEKEY_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_FUNDBUYNOTIFY_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_Recharge_FundBuyNotify.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_FUNDBUYNOTIFY_NUM_F, {
	"num",
	".cs.S2C_Recharge_FundBuyNotify.num",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_FUNDBUYNOTIFY_ME, {
	"S2C_Recharge_FundBuyNotify",
	".cs.S2C_Recharge_FundBuyNotify",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_FUNDBUYNOTIFY_ACTIVITY_ID_F,
		var_0_10.S2C_RECHARGE_FUNDBUYNOTIFY_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_MONTH_CARD_F, {
	"month_card",
	".cs.S2C_Recharge_OpRecharge.month_card",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.OPMONTHCARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_FIRST_RECHARGE_F, {
	"first_recharge",
	".cs.S2C_Recharge_OpRecharge.first_recharge",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.OPFIRSTRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_FUND_RECHARGE_F, {
	"fund_recharge",
	".cs.S2C_Recharge_OpRecharge.fund_recharge",
	3,
	2,
	1,
	false,
	nil,
	var_0_3.OPFUNDRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_SUB_RECHARGE_F, {
	"sub_recharge",
	".cs.S2C_Recharge_OpRecharge.sub_recharge",
	5,
	3,
	1,
	false,
	nil,
	var_0_3.OPSUBRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_TOTAL_RECHARGE_F, {
	"total_recharge",
	".cs.S2C_Recharge_OpRecharge.total_recharge",
	6,
	4,
	1,
	false,
	nil,
	var_0_3.OPTOTALRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_GIFT_F, {
	"gift",
	".cs.S2C_Recharge_OpRecharge.gift",
	13,
	5,
	1,
	false,
	nil,
	var_0_3.OPGIFTRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_DAILY_SALE_F, {
	"daily_sale",
	".cs.S2C_Recharge_OpRecharge.daily_sale",
	14,
	6,
	1,
	false,
	nil,
	var_0_3.OPDAILYSALERECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_PASSCARD_F, {
	"passcard",
	".cs.S2C_Recharge_OpRecharge.passcard",
	15,
	7,
	1,
	false,
	nil,
	var_0_3.OPPASSCARDRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_PUSH_GIFT_F, {
	"push_gift",
	".cs.S2C_Recharge_OpRecharge.push_gift",
	16,
	8,
	1,
	false,
	nil,
	var_0_3.OPPUSHGIFTRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_GM_TOTAL_RECHARGE_F, {
	"gm_total_recharge",
	".cs.S2C_Recharge_OpRecharge.gm_total_recharge",
	17,
	9,
	1,
	false,
	nil,
	var_0_3.OPGMTOTALRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_GM_FIRST_RECHARGE_F, {
	"gm_first_recharge",
	".cs.S2C_Recharge_OpRecharge.gm_first_recharge",
	18,
	10,
	1,
	false,
	nil,
	var_0_3.OPGMFIRSTRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_RECHARGE_REBATE_F, {
	"recharge_rebate",
	".cs.S2C_Recharge_OpRecharge.recharge_rebate",
	19,
	11,
	1,
	false,
	nil,
	var_0_3.OPRECHARGEREBATE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_LIMIT_SALE_F, {
	"limit_sale",
	".cs.S2C_Recharge_OpRecharge.limit_sale",
	20,
	12,
	1,
	false,
	nil,
	var_0_3.OPRECHARGELIMITSALE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_CULTIVATE_ACTIVITY_PASSCARD_F, {
	"cultivate_activity_passcard",
	".cs.S2C_Recharge_OpRecharge.cultivate_activity_passcard",
	21,
	13,
	1,
	false,
	nil,
	var_0_3.OPRECHARGECULTIVATEACTIVITYPASSCARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_PASSCARD_ACTIVITY_F, {
	"passcard_activity",
	".cs.S2C_Recharge_OpRecharge.passcard_activity",
	22,
	14,
	1,
	false,
	nil,
	var_0_3.OPRECHARGEPASSCARDACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_FUND_ACTIVITY_F, {
	"fund_activity",
	".cs.S2C_Recharge_OpRecharge.fund_activity",
	23,
	15,
	1,
	false,
	nil,
	var_0_3.OPRECHARGEFUNDACTIVITY_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_THEME_PASSCARD_F, {
	"theme_passcard",
	".cs.S2C_Recharge_OpRecharge.theme_passcard",
	24,
	16,
	1,
	false,
	nil,
	var_0_3.OPRECHARGETHEMEPASSCARD_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_COMMON_PASSCARD_F, {
	"common_passcard",
	".cs.S2C_Recharge_OpRecharge.common_passcard",
	25,
	17,
	1,
	false,
	nil,
	var_0_3.OPCOMMONPASSCARDRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_SERVER_PASS_F, {
	"server_pass",
	".cs.S2C_Recharge_OpRecharge.server_pass",
	26,
	18,
	1,
	false,
	nil,
	var_0_3.OPSERVERPASSRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_OPRECHARGE_ME, {
	"S2C_Recharge_OpRecharge",
	".cs.S2C_Recharge_OpRecharge",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_OPRECHARGE_MONTH_CARD_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_FIRST_RECHARGE_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_FUND_RECHARGE_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_SUB_RECHARGE_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_TOTAL_RECHARGE_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_GIFT_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_DAILY_SALE_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_PASSCARD_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_PUSH_GIFT_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_GM_TOTAL_RECHARGE_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_GM_FIRST_RECHARGE_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_RECHARGE_REBATE_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_LIMIT_SALE_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_CULTIVATE_ACTIVITY_PASSCARD_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_PASSCARD_ACTIVITY_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_FUND_ACTIVITY_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_THEME_PASSCARD_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_COMMON_PASSCARD_F,
		var_0_10.S2C_RECHARGE_OPRECHARGE_SERVER_PASS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_GETFUNDRECHARGE_ME, {
	"C2S_Recharge_GetFundRecharge",
	".cs.C2S_Recharge_GetFundRecharge",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFUNDRECHARGE_RET_F, {
	"ret",
	".cs.S2C_Recharge_GetFundRecharge.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFUNDRECHARGE_FUND_RECHARGE_F, {
	"fund_recharge",
	".cs.S2C_Recharge_GetFundRecharge.fund_recharge",
	2,
	1,
	3,
	false,
	{},
	var_0_3.FUNDRECHARGE_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFUNDRECHARGE_DEAD_BATTLE_F, {
	"dead_battle",
	".cs.S2C_Recharge_GetFundRecharge.dead_battle",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_GETFUNDRECHARGE_ME, {
	"S2C_Recharge_GetFundRecharge",
	".cs.S2C_Recharge_GetFundRecharge",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_GETFUNDRECHARGE_RET_F,
		var_0_10.S2C_RECHARGE_GETFUNDRECHARGE_FUND_RECHARGE_F,
		var_0_10.S2C_RECHARGE_GETFUNDRECHARGE_DEAD_BATTLE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_GETTOTALRECHARGEAWARD_ID_F, {
	"id",
	".cs.C2S_Recharge_GetTotalRechargeAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_GETTOTALRECHARGEAWARD_ME, {
	"C2S_Recharge_GetTotalRechargeAward",
	".cs.C2S_Recharge_GetTotalRechargeAward",
	{},
	{},
	{
		var_0_10.C2S_RECHARGE_GETTOTALRECHARGEAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETTOTALRECHARGEAWARD_RET_F, {
	"ret",
	".cs.S2C_Recharge_GetTotalRechargeAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETTOTALRECHARGEAWARD_ID_F, {
	"id",
	".cs.S2C_Recharge_GetTotalRechargeAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETTOTALRECHARGEAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Recharge_GetTotalRechargeAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_GETTOTALRECHARGEAWARD_ME, {
	"S2C_Recharge_GetTotalRechargeAward",
	".cs.S2C_Recharge_GetTotalRechargeAward",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_GETTOTALRECHARGEAWARD_RET_F,
		var_0_10.S2C_RECHARGE_GETTOTALRECHARGEAWARD_ID_F,
		var_0_10.S2C_RECHARGE_GETTOTALRECHARGEAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_GETFREEGIFTAWARD_ID_F, {
	"id",
	".cs.C2S_Recharge_GetFreeGiftAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_GETFREEGIFTAWARD_ME, {
	"C2S_Recharge_GetFreeGiftAward",
	".cs.C2S_Recharge_GetFreeGiftAward",
	{},
	{},
	{
		var_0_10.C2S_RECHARGE_GETFREEGIFTAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFREEGIFTAWARD_RET_F, {
	"ret",
	".cs.S2C_Recharge_GetFreeGiftAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFREEGIFTAWARD_ID_F, {
	"id",
	".cs.S2C_Recharge_GetFreeGiftAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_GETFREEGIFTAWARD_ME, {
	"S2C_Recharge_GetFreeGiftAward",
	".cs.S2C_Recharge_GetFreeGiftAward",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_GETFREEGIFTAWARD_RET_F,
		var_0_10.S2C_RECHARGE_GETFREEGIFTAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_GETFREEDAILYSALEAWARD_ID_F, {
	"id",
	".cs.C2S_Recharge_GetFreeDailySaleAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_GETFREEDAILYSALEAWARD_ME, {
	"C2S_Recharge_GetFreeDailySaleAward",
	".cs.C2S_Recharge_GetFreeDailySaleAward",
	{},
	{},
	{
		var_0_10.C2S_RECHARGE_GETFREEDAILYSALEAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFREEDAILYSALEAWARD_RET_F, {
	"ret",
	".cs.S2C_Recharge_GetFreeDailySaleAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETFREEDAILYSALEAWARD_ID_F, {
	"id",
	".cs.S2C_Recharge_GetFreeDailySaleAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_GETFREEDAILYSALEAWARD_ME, {
	"S2C_Recharge_GetFreeDailySaleAward",
	".cs.S2C_Recharge_GetFreeDailySaleAward",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_GETFREEDAILYSALEAWARD_RET_F,
		var_0_10.S2C_RECHARGE_GETFREEDAILYSALEAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_GETALLDAILYSALEAWARD_ME, {
	"C2S_Recharge_GetAllDailySaleAward",
	".cs.C2S_Recharge_GetAllDailySaleAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETALLDAILYSALEAWARD_RET_F, {
	"ret",
	".cs.S2C_Recharge_GetAllDailySaleAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETALLDAILYSALEAWARD_AWARD_F, {
	"award",
	".cs.S2C_Recharge_GetAllDailySaleAward.award",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_GETALLDAILYSALEAWARD_ME, {
	"S2C_Recharge_GetAllDailySaleAward",
	".cs.S2C_Recharge_GetAllDailySaleAward",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_GETALLDAILYSALEAWARD_RET_F,
		var_0_10.S2C_RECHARGE_GETALLDAILYSALEAWARD_AWARD_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_FIRST_RECHARGE_GETRECHARGEAWARD_ME, {
	"C2S_Recharge_First_Recharge_GetRechargeAward",
	".cs.C2S_Recharge_First_Recharge_GetRechargeAward",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_FIRST_RECHARGE_GETRECHARGEAWARD_RET_F, {
	"ret",
	".cs.S2C_Recharge_First_Recharge_GetRechargeAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_FIRST_RECHARGE_GETRECHARGEAWARD_AWARD_F, {
	"award",
	".cs.S2C_Recharge_First_Recharge_GetRechargeAward.award",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_FIRST_RECHARGE_GETRECHARGEAWARD_ME, {
	"S2C_Recharge_First_Recharge_GetRechargeAward",
	".cs.S2C_Recharge_First_Recharge_GetRechargeAward",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_FIRST_RECHARGE_GETRECHARGEAWARD_RET_F,
		var_0_10.S2C_RECHARGE_FIRST_RECHARGE_GETRECHARGEAWARD_AWARD_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_MONTHCARDTURNAWARD_ID_F, {
	"id",
	".cs.C2S_Recharge_MonthCardTurnAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_MONTHCARDTURNAWARD_REWARD_ID_F, {
	"reward_id",
	".cs.C2S_Recharge_MonthCardTurnAward.reward_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_MONTHCARDTURNAWARD_ME, {
	"C2S_Recharge_MonthCardTurnAward",
	".cs.C2S_Recharge_MonthCardTurnAward",
	{},
	{},
	{
		var_0_10.C2S_RECHARGE_MONTHCARDTURNAWARD_ID_F,
		var_0_10.C2S_RECHARGE_MONTHCARDTURNAWARD_REWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_MONTHCARDTURNAWARD_RET_F, {
	"ret",
	".cs.S2C_Recharge_MonthCardTurnAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_MONTHCARDTURNAWARD_ID_F, {
	"id",
	".cs.S2C_Recharge_MonthCardTurnAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_MONTHCARDTURNAWARD_REWARD_ID_F, {
	"reward_id",
	".cs.S2C_Recharge_MonthCardTurnAward.reward_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_MONTHCARDTURNAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Recharge_MonthCardTurnAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_MONTHCARDTURNAWARD_MONTH_CARD_TURN_F, {
	"month_card_turn",
	".cs.S2C_Recharge_MonthCardTurnAward.month_card_turn",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.MONTHCARDTURN_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_MONTHCARDTURNAWARD_ME, {
	"S2C_Recharge_MonthCardTurnAward",
	".cs.S2C_Recharge_MonthCardTurnAward",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_MONTHCARDTURNAWARD_RET_F,
		var_0_10.S2C_RECHARGE_MONTHCARDTURNAWARD_ID_F,
		var_0_10.S2C_RECHARGE_MONTHCARDTURNAWARD_REWARD_ID_F,
		var_0_10.S2C_RECHARGE_MONTHCARDTURNAWARD_AWARDS_F,
		var_0_10.S2C_RECHARGE_MONTHCARDTURNAWARD_MONTH_CARD_TURN_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_DAILYBOXTURNAWARD_ID_F, {
	"id",
	".cs.C2S_Recharge_DailyBoxTurnAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_DAILYBOXTURNAWARD_REWARD_ID_F, {
	"reward_id",
	".cs.C2S_Recharge_DailyBoxTurnAward.reward_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_DAILYBOXTURNAWARD_ME, {
	"C2S_Recharge_DailyBoxTurnAward",
	".cs.C2S_Recharge_DailyBoxTurnAward",
	{},
	{},
	{
		var_0_10.C2S_RECHARGE_DAILYBOXTURNAWARD_ID_F,
		var_0_10.C2S_RECHARGE_DAILYBOXTURNAWARD_REWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_DAILYBOXTURNAWARD_RET_F, {
	"ret",
	".cs.S2C_Recharge_DailyBoxTurnAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_DAILYBOXTURNAWARD_ID_F, {
	"id",
	".cs.S2C_Recharge_DailyBoxTurnAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_DAILYBOXTURNAWARD_REWARD_ID_F, {
	"reward_id",
	".cs.S2C_Recharge_DailyBoxTurnAward.reward_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_DAILYBOXTURNAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Recharge_DailyBoxTurnAward.awards",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_DAILYBOXTURNAWARD_DAILY_BOX_TURN_F, {
	"daily_box_turn",
	".cs.S2C_Recharge_DailyBoxTurnAward.daily_box_turn",
	5,
	4,
	1,
	false,
	nil,
	var_0_3.DAILYBOXTURN_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_DAILYBOXTURNAWARD_ME, {
	"S2C_Recharge_DailyBoxTurnAward",
	".cs.S2C_Recharge_DailyBoxTurnAward",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_DAILYBOXTURNAWARD_RET_F,
		var_0_10.S2C_RECHARGE_DAILYBOXTURNAWARD_ID_F,
		var_0_10.S2C_RECHARGE_DAILYBOXTURNAWARD_REWARD_ID_F,
		var_0_10.S2C_RECHARGE_DAILYBOXTURNAWARD_AWARDS_F,
		var_0_10.S2C_RECHARGE_DAILYBOXTURNAWARD_DAILY_BOX_TURN_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_GETGMTOTALRECHARGEINFO_ME, {
	"C2S_Recharge_GetGMTotalRechargeInfo",
	".cs.C2S_Recharge_GetGMTotalRechargeInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGEINFO_RET_F, {
	"ret",
	".cs.S2C_Recharge_GetGMTotalRechargeInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGEINFO_INFOS_F, {
	"infos",
	".cs.S2C_Recharge_GetGMTotalRechargeInfo.infos",
	2,
	1,
	3,
	false,
	{},
	var_0_3.GMTOTALRECHARGEINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGEINFO_ME, {
	"S2C_Recharge_GetGMTotalRechargeInfo",
	".cs.S2C_Recharge_GetGMTotalRechargeInfo",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGEINFO_RET_F,
		var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGEINFO_INFOS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_GETGMTOTALRECHARGEAWARD_ACTIVITY_ID_F, {
	"activity_id",
	".cs.C2S_Recharge_GetGMTotalRechargeAward.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_GETGMTOTALRECHARGEAWARD_ID_F, {
	"id",
	".cs.C2S_Recharge_GetGMTotalRechargeAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_GETGMTOTALRECHARGEAWARD_ME, {
	"C2S_Recharge_GetGMTotalRechargeAward",
	".cs.C2S_Recharge_GetGMTotalRechargeAward",
	{},
	{},
	{
		var_0_10.C2S_RECHARGE_GETGMTOTALRECHARGEAWARD_ACTIVITY_ID_F,
		var_0_10.C2S_RECHARGE_GETGMTOTALRECHARGEAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGEAWARD_RET_F, {
	"ret",
	".cs.S2C_Recharge_GetGMTotalRechargeAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGEAWARD_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_Recharge_GetGMTotalRechargeAward.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGEAWARD_ID_F, {
	"id",
	".cs.S2C_Recharge_GetGMTotalRechargeAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGEAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Recharge_GetGMTotalRechargeAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGEAWARD_ME, {
	"S2C_Recharge_GetGMTotalRechargeAward",
	".cs.S2C_Recharge_GetGMTotalRechargeAward",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGEAWARD_RET_F,
		var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGEAWARD_ACTIVITY_ID_F,
		var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGEAWARD_ID_F,
		var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGEAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_GETGMTOTALRECHARGETASKDATA_ME, {
	"C2S_Recharge_GetGMTotalRechargeTaskData",
	".cs.C2S_Recharge_GetGMTotalRechargeTaskData",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGETASKDATA_RET_F, {
	"ret",
	".cs.S2C_Recharge_GetGMTotalRechargeTaskData.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGETASKDATA_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_Recharge_GetGMTotalRechargeTaskData.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGETASKDATA_INFOS_F, {
	"infos",
	".cs.S2C_Recharge_GetGMTotalRechargeTaskData.infos",
	3,
	2,
	3,
	false,
	{},
	var_0_3.GMTOTALRECHARGETASK_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGETASKDATA_ME, {
	"S2C_Recharge_GetGMTotalRechargeTaskData",
	".cs.S2C_Recharge_GetGMTotalRechargeTaskData",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGETASKDATA_RET_F,
		var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGETASKDATA_ACTIVITY_ID_F,
		var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGETASKDATA_INFOS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_GETGMTOTALRECHARGETASKAWARD_ACTIVITY_ID_F, {
	"activity_id",
	".cs.C2S_Recharge_GetGMTotalRechargeTaskAward.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_GETGMTOTALRECHARGETASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.C2S_Recharge_GetGMTotalRechargeTaskAward.task_id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_GETGMTOTALRECHARGETASKAWARD_ME, {
	"C2S_Recharge_GetGMTotalRechargeTaskAward",
	".cs.C2S_Recharge_GetGMTotalRechargeTaskAward",
	{},
	{},
	{
		var_0_10.C2S_RECHARGE_GETGMTOTALRECHARGETASKAWARD_ACTIVITY_ID_F,
		var_0_10.C2S_RECHARGE_GETGMTOTALRECHARGETASKAWARD_TASK_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD_RET_F, {
	"ret",
	".cs.S2C_Recharge_GetGMTotalRechargeTaskAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD_ACTIVITY_ID_F, {
	"activity_id",
	".cs.S2C_Recharge_GetGMTotalRechargeTaskAward.activity_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD_TASK_ID_F, {
	"task_id",
	".cs.S2C_Recharge_GetGMTotalRechargeTaskAward.task_id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Recharge_GetGMTotalRechargeTaskAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD_ME, {
	"S2C_Recharge_GetGMTotalRechargeTaskAward",
	".cs.S2C_Recharge_GetGMTotalRechargeTaskAward",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD_RET_F,
		var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD_ACTIVITY_ID_F,
		var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD_TASK_ID_F,
		var_0_10.S2C_RECHARGE_GETGMTOTALRECHARGETASKAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_GETGMFIRSTRECHARGEINFO_ME, {
	"C2S_Recharge_GetGMFirstRechargeInfo",
	".cs.C2S_Recharge_GetGMFirstRechargeInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETGMFIRSTRECHARGEINFO_RET_F, {
	"ret",
	".cs.S2C_Recharge_GetGMFirstRechargeInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETGMFIRSTRECHARGEINFO_INFO_F, {
	"info",
	".cs.S2C_Recharge_GetGMFirstRechargeInfo.info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.GMFIRSTRECHARGEINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_GETGMFIRSTRECHARGEINFO_ME, {
	"S2C_Recharge_GetGMFirstRechargeInfo",
	".cs.S2C_Recharge_GetGMFirstRechargeInfo",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_GETGMFIRSTRECHARGEINFO_RET_F,
		var_0_10.S2C_RECHARGE_GETGMFIRSTRECHARGEINFO_INFO_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_UPDATEGMFIRSTRECHARGEINFO_INFO_F, {
	"info",
	".cs.S2C_Recharge_UpdateGMFirstRechargeInfo.info",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.GMFIRSTRECHARGEINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_UPDATEGMFIRSTRECHARGEINFO_DELETE_F, {
	"delete",
	".cs.S2C_Recharge_UpdateGMFirstRechargeInfo.delete",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_UPDATEGMFIRSTRECHARGEINFO_ME, {
	"S2C_Recharge_UpdateGMFirstRechargeInfo",
	".cs.S2C_Recharge_UpdateGMFirstRechargeInfo",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_UPDATEGMFIRSTRECHARGEINFO_INFO_F,
		var_0_10.S2C_RECHARGE_UPDATEGMFIRSTRECHARGEINFO_DELETE_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_GETRECHARGEREBATEINFO_ME, {
	"C2S_Recharge_GetRechargeRebateInfo",
	".cs.C2S_Recharge_GetRechargeRebateInfo",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGEREBATEINFO_RET_F, {
	"ret",
	".cs.S2C_Recharge_GetRechargeRebateInfo.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGEREBATEINFO_INFO_F, {
	"info",
	".cs.S2C_Recharge_GetRechargeRebateInfo.info",
	2,
	1,
	1,
	false,
	nil,
	var_0_3.RECHARGEREBATEGMINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGEREBATEINFO_REFRESH_TIME_F, {
	"refresh_time",
	".cs.S2C_Recharge_GetRechargeRebateInfo.refresh_time",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGEREBATEINFO_ME, {
	"S2C_Recharge_GetRechargeRebateInfo",
	".cs.S2C_Recharge_GetRechargeRebateInfo",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_GETRECHARGEREBATEINFO_RET_F,
		var_0_10.S2C_RECHARGE_GETRECHARGEREBATEINFO_INFO_F,
		var_0_10.S2C_RECHARGE_GETRECHARGEREBATEINFO_REFRESH_TIME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_UPDATERECHARGEREBATEGMINFO_INFO_F, {
	"info",
	".cs.S2C_Recharge_UpdateRechargeRebateGMInfo.info",
	1,
	0,
	1,
	false,
	nil,
	var_0_3.RECHARGEREBATEGMINFO_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_UPDATERECHARGEREBATEGMINFO_REFRESH_TIME_F, {
	"refresh_time",
	".cs.S2C_Recharge_UpdateRechargeRebateGMInfo.refresh_time",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_UPDATERECHARGEREBATEGMINFO_ME, {
	"S2C_Recharge_UpdateRechargeRebateGMInfo",
	".cs.S2C_Recharge_UpdateRechargeRebateGMInfo",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_UPDATERECHARGEREBATEGMINFO_INFO_F,
		var_0_10.S2C_RECHARGE_UPDATERECHARGEREBATEGMINFO_REFRESH_TIME_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_GETRECHARGEREBATEAWARD_ID_F, {
	"id",
	".cs.C2S_Recharge_GetRechargeRebateAward.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_GETRECHARGEREBATEAWARD_ME, {
	"C2S_Recharge_GetRechargeRebateAward",
	".cs.C2S_Recharge_GetRechargeRebateAward",
	{},
	{},
	{
		var_0_10.C2S_RECHARGE_GETRECHARGEREBATEAWARD_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGEREBATEAWARD_RET_F, {
	"ret",
	".cs.S2C_Recharge_GetRechargeRebateAward.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGEREBATEAWARD_ID_F, {
	"id",
	".cs.S2C_Recharge_GetRechargeRebateAward.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGEREBATEAWARD_AWARDS_F, {
	"awards",
	".cs.S2C_Recharge_GetRechargeRebateAward.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_GETRECHARGEREBATEAWARD_ME, {
	"S2C_Recharge_GetRechargeRebateAward",
	".cs.S2C_Recharge_GetRechargeRebateAward",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_GETRECHARGEREBATEAWARD_RET_F,
		var_0_10.S2C_RECHARGE_GETRECHARGEREBATEAWARD_ID_F,
		var_0_10.S2C_RECHARGE_GETRECHARGEREBATEAWARD_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.C2S_RECHARGE_BUYRECHARGEREBATEGIFT_ID_F, {
	"id",
	".cs.C2S_Recharge_BuyRechargeRebateGift.id",
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
descriptor_helper.descriptorFunc(var_0_10.C2S_RECHARGE_BUYRECHARGEREBATEGIFT_ME, {
	"C2S_Recharge_BuyRechargeRebateGift",
	".cs.C2S_Recharge_BuyRechargeRebateGift",
	{},
	{},
	{
		var_0_10.C2S_RECHARGE_BUYRECHARGEREBATEGIFT_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_BUYRECHARGEREBATEGIFT_RET_F, {
	"ret",
	".cs.S2C_Recharge_BuyRechargeRebateGift.ret",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_BUYRECHARGEREBATEGIFT_ID_F, {
	"id",
	".cs.S2C_Recharge_BuyRechargeRebateGift.id",
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
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_BUYRECHARGEREBATEGIFT_AWARDS_F, {
	"awards",
	".cs.S2C_Recharge_BuyRechargeRebateGift.awards",
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
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_BUYRECHARGEREBATEGIFT_ME, {
	"S2C_Recharge_BuyRechargeRebateGift",
	".cs.S2C_Recharge_BuyRechargeRebateGift",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_BUYRECHARGEREBATEGIFT_RET_F,
		var_0_10.S2C_RECHARGE_BUYRECHARGEREBATEGIFT_ID_F,
		var_0_10.S2C_RECHARGE_BUYRECHARGEREBATEGIFT_AWARDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_10.S2C_RECHARGE_RECHARGEREBATEAWARDS_AWARDS_F, {
	"awards",
	".cs.S2C_Recharge_RechargeRebateAwards.awards",
	1,
	0,
	3,
	false,
	{},
	var_0_3.AWARD_ME,
	nil,
	11,
	10
})
descriptor_helper.descriptorFunc(var_0_10.S2C_RECHARGE_RECHARGEREBATEAWARDS_ME, {
	"S2C_Recharge_RechargeRebateAwards",
	".cs.S2C_Recharge_RechargeRebateAwards",
	{},
	{},
	{
		var_0_10.S2C_RECHARGE_RECHARGEREBATEAWARDS_AWARDS_F
	},
	false,
	{}
})

return var_0_10
