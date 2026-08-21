local var_0_0 = class("CanteenJobInfoItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	if not isNil(arg_1_2) then
		arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	else
		arg_1_0.gameObject_ = arg_1_1
	end

	SetActive(arg_1_0.gameObject_, true)

	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "name")
	arg_2_0.jobController = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "job")
	arg_2_0.heroItem = CanteenHeroItem.New(arg_2_0.heroitemGo_1)

	arg_2_0.heroItem:SetFunction(true)
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1)
	arg_3_0.jobText.text = CanteenTools:GetJobName(arg_3_1)

	if arg_3_1 == DormNpcTools.BackHomeNpcType.cook then
		arg_3_0.jobController:SetSelectedState("cook")
	elseif arg_3_1 == DormNpcTools.BackHomeNpcType.waiter then
		arg_3_0.jobController:SetSelectedState("waiter")
	elseif arg_3_1 == DormNpcTools.BackHomeNpcType.cashier then
		arg_3_0.jobController:SetSelectedState("cashier")
	end

	local var_3_0 = CanteenHeroTools:GetCanteenJobList()[arg_3_1]

	if var_3_0 then
		local var_3_1 = var_3_0.heroID

		if var_3_1 then
			arg_3_0.stateController:SetSelectedState("normal")
			arg_3_0.heroItem:RefreshUI(var_3_1)
		else
			arg_3_0.stateController:SetSelectedState("empty")
		end
	end
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.heroItem:Dispose()
	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)
end

return var_0_0
