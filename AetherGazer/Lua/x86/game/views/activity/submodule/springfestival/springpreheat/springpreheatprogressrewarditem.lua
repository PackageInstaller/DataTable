local var_0_0 = class("SpringPreheatProgressRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()

	arg_1_0.normalizedLocation_ = 0.5
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = ControllerUtil.GetController(arg_2_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.onClickHandler_ then
			arg_3_0.onClickHandler_(arg_3_0)
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.getBtn_, nil, function()
		if arg_3_0.onClickHandler_ then
			arg_3_0.onClickHandler_(arg_3_0)
		end
	end)
end

function var_0_0.SetClickHandler(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.onClickHandler_ = arg_6_1
	end
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.id_ = arg_7_1
end

function var_0_0.SetNormalizeLocation(arg_8_0, arg_8_1)
	arg_8_0.normalizedLocation_ = arg_8_1
end

function var_0_0.RefreshUI(arg_9_0)
	if SpringPreheatData:IsAcquired(arg_9_0.id_) then
		arg_9_0.stateController_:SetSelectedState("received")
	elseif SpringPreheatData:CanAcquire(arg_9_0.id_) then
		arg_9_0.stateController_:SetSelectedState("complete")
	else
		arg_9_0.stateController_:SetSelectedState("uncomplete")
	end

	arg_9_0.needText_.text = ActivityPointRewardCfg[arg_9_0.id_].need
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
