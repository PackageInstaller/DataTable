local var_0_0 = class("AccumulateDiscountModule", ReduxView)
local var_0_1 = {
	[0] = "CUMULATIVE_LOGIN_SALE_0",
	"CUMULATIVE_LOGIN_SALE_1",
	"CUMULATIVE_LOGIN_SALE_2",
	"CUMULATIVE_LOGIN_SALE_3",
	"CUMULATIVE_LOGIN_SALE_3",
	"CUMULATIVE_LOGIN_SALE_3"
}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.isUse_ = true
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.mainBtn_, nil, function()
		JumpTools.OpenPageByJump("accumulateSignView")
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.type_ = arg_5_1
	arg_5_0.num_ = 0
	arg_5_0.lv_ = 0
	arg_5_0.isUse_ = arg_5_2

	if arg_5_0.type_ == 1 then
		arg_5_0.num_, arg_5_0.lv_ = AccumulateSignData:GetMonthCardNumAndLv()
	else
		arg_5_0.num_, arg_5_0.lv_ = AccumulateSignData:GetPassportNumAndLv()
	end

	arg_5_0:RefreshText()
end

function var_0_0.RefreshOpen(arg_6_0)
	return
end

function var_0_0.RefreshText(arg_7_0)
	arg_7_0.text_num.text = GetTips(var_0_1[arg_7_0.lv_])
	arg_7_0.text_title.text = GetTips("ACTIVITY_ACCUMULATIVE_CUR_DISCOUNT")
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
