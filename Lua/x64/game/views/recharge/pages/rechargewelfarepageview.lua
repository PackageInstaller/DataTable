local var_0_0 = import("game.views.recharge.pages.RechargePageBase")
local var_0_1 = class("RechargeWelfarePageView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.rechargeItemList_ = {}

	for iter_1_0, iter_1_1 in pairs(ActivityNewbieData:GetRechargeTemplate()) do
		arg_1_0.rechargeItemList_[iter_1_0] = ActivityNewbieRechargeItem.New(arg_1_0[string.format("button%s_", iter_1_0)], iter_1_0)
	end

	arg_1_0:Show()
end

function var_0_1.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.rechargeItemList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.rechargeItemList_ = nil

	var_0_1.super.Dispose(arg_2_0)
end

function var_0_1.Show(arg_3_0)
	SetActive(arg_3_0.gameObject_, true)

	for iter_3_0, iter_3_1 in pairs(arg_3_0.rechargeItemList_) do
		iter_3_1:RefreshUI()
	end
end

return var_0_1
