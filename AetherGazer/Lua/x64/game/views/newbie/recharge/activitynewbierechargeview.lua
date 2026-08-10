local var_0_0 = class("ActivityNewbieRechargeView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/Activitynewbie/NewbieRechargeUI")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.rechargeItemList_ = {}

	for iter_1_0, iter_1_1 in pairs(ActivityNewbieData:GetRechargeTemplate()) do
		arg_1_0.rechargeItemList_[iter_1_0] = ActivityNewbieRechargeItem.New(arg_1_0[string.format("button%s_", iter_1_0)], iter_1_0)
	end
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)

	for iter_2_0, iter_2_1 in pairs(arg_2_0.rechargeItemList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.rechargeItemList_ = nil

	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.Show(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, arg_3_1)

	if arg_3_1 then
		for iter_3_0, iter_3_1 in pairs(arg_3_0.rechargeItemList_) do
			iter_3_1:RefreshUI()
		end
	end
end

return var_0_0
