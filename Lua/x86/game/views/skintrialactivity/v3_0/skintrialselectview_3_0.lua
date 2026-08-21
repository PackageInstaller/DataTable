local var_0_0 = class("SkinTrialSelectView_3_0", SkinTrialSelectView_2_0)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)
end

function var_0_0.AddListeners(arg_2_0)
	var_0_0.super.AddListeners(arg_2_0)

	if arg_2_0.getBtn_ then
		arg_2_0:AddBtnListener(arg_2_0.getBtn_, nil, function()
			SkinTrialAction.RequestSkinTrialReward(arg_2_0.skinTrialID_)
		end)
	end

	arg_2_0:RegistEventListener(SKIN_TRIAL_UPDATE, handler(arg_2_0, arg_2_0.OnSkinTrialUpdate))
end

function var_0_0.RefreshUI(arg_4_0)
	var_0_0.super.RefreshUI(arg_4_0)
	arg_4_0:RefreshReceive()
end

function var_0_0.RefreshReceive(arg_5_0)
	if not arg_5_0.receiveController_ then
		return
	end

	if not arg_5_0.receiveController then
		arg_5_0.receiveController = arg_5_0.receiveController_:GetController("default0")
	end

	local var_5_0 = SkinTrialData:GetSkinTrialStatus(arg_5_0.skinTrialID_)

	if var_5_0 == 0 then
		arg_5_0.receiveController:SetSelectedState("state0")
	elseif var_5_0 == 1 then
		arg_5_0.receiveController:SetSelectedState("state2")
	elseif var_5_0 == 2 then
		arg_5_0.receiveController:SetSelectedState("state1")
	end
end

function var_0_0.GetRewardItem(arg_6_0)
	return CommonItemView
end

function var_0_0.OnSkinTrialUpdate(arg_7_0, arg_7_1)
	arg_7_0:RefreshReceive()
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.rewardCfg_[arg_8_1]
	local var_8_1 = clone(ItemTemplateData)

	var_8_1.index = arg_8_1
	var_8_1.id = var_8_0[1]
	var_8_1.number = var_8_0[2]
	var_8_1.completedFlag = false

	function var_8_1.clickFun(arg_9_0)
		if arg_8_0.clickCallback_ then
			if arg_8_0.clickCallback_() then
				ShowPopItem(arg_8_0.popType_, arg_9_0)
			end
		else
			ShowPopItem(arg_8_0.popType_, arg_9_0)
		end
	end

	arg_8_2:SetData(var_8_1)
end

function var_0_0.SaveRoute(arg_10_0)
	local var_10_0 = {
		name = "skinTrialSelectView_3_0",
		activityID = arg_10_0.activityID_,
		skinTrialID = arg_10_0.skinTrialID_
	}

	SkinTrialData:SaveRoute(var_10_0)
end

return var_0_0
