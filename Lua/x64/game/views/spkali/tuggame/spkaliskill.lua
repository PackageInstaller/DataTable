local var_0_0 = class("SpKaliSkill", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.statecintroller = arg_1_0.btn_kailiskillControllerexcollection_:GetController("state")
	arg_1_0.staminacintroller = arg_1_0.btn_kailiskillControllerexcollection_:GetController("stamina")
	arg_1_0.isRedcintroller = arg_1_0.btn_kailiskillControllerexcollection_:GetController("isRed")
	arg_1_0.lockcintroller = arg_1_0.btn_kailiskillControllerexcollection_:GetController("isLock")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_kailiskillBtn_, nil, function()
		arg_2_0:OnClick()
	end)
end

function var_0_0.OnClick(arg_4_0)
	return
end

function var_0_0.UpdateFillValue(arg_5_0, arg_5_1)
	arg_5_0.lockcintroller:SetSelectedState(arg_5_1.lockTime > 0 and "locked" or "nolocked")

	arg_5_0.powerimgImg_.fillAmount = 1 - arg_5_1.value or 0
	arg_5_0.textstaminaText_.text = arg_5_1.cost or 0

	if arg_5_1.value >= 1 then
		arg_5_0.statecintroller:SetSelectedState("completely")
	else
		arg_5_0.statecintroller:SetSelectedState("powerimg")
	end

	if arg_5_1.nowAnger >= arg_5_1.cost then
		arg_5_0.isRedcintroller:SetSelectedState("state0")
	else
		arg_5_0.isRedcintroller:SetSelectedState("state1")
	end
end

function var_0_0.RefreshData(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
