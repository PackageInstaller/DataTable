local var_0_0 = import("game.views.recharge.pages.RechargePageBase")
local var_0_1 = class("RechargeFirstRechargeWelfarePageView", var_0_0)

function var_0_1.InitUI(arg_1_0, arg_1_1)
	arg_1_0.index_ = arg_1_1[1]

	arg_1_0:BindCfgUI()

	arg_1_0.contentViewList_ = {}
	arg_1_0.contentClasss_ = {
		ActivityNoobFirstRechargeView_1,
		ActivityNoobFirstRechargeView_2
	}
end

function var_0_1.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.contentViewList_) do
		iter_2_1:Dispose()
	end

	var_0_1.super.Dispose(arg_2_0)
end

function var_0_1.SwitchPage(arg_3_0, arg_3_1)
	local var_3_0 = ShopConst.SIX_EIGHT[arg_3_1]

	if arg_3_0.curView_ then
		arg_3_0.curView_:SetActive(false)
	end

	if not arg_3_0.contentViewList_[var_3_0] then
		arg_3_0.contentViewList_[var_3_0] = arg_3_0.contentClasss_[var_3_0].New(arg_3_0.contentTrans_, arg_3_0.index_)
	end

	arg_3_0.curView_ = arg_3_0.contentViewList_[var_3_0]

	arg_3_0.curView_:SetData(var_3_0)
	arg_3_0.curView_:SetActive(true)
end

return var_0_1
