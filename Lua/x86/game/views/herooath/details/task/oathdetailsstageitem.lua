local var_0_0 = class("OathDetailsStageItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.level = arg_1_2

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.selectStateController_ = arg_2_0.controller_:GetController("select")
	arg_2_0.processStateController_ = arg_2_0.controller_:GetController("process")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0:GetProcessState() == "lock" then
			ShowTips("WEDDING_RIGHT_LOCK_TIP")

			return
		end

		if arg_3_0.clickCallback_ then
			arg_3_0.clickCallback_()
		end
	end)
end

function var_0_0.SetClickCallback(arg_5_0, arg_5_1)
	arg_5_0.clickCallback_ = arg_5_1
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.heroID = arg_6_1

	arg_6_0:RefreshUI()
	arg_6_0:UpdateProcessState()
end

function var_0_0.CheckIsOpen(arg_7_0)
	return OathCollectionContentData:GetOathLevel(arg_7_0.heroID) >= arg_7_0.level
end

function var_0_0.SetSelectState(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0.selectStateController_:SetSelectedState("select")
	elseif arg_8_0:CheckIsOpen() then
		arg_8_0.selectStateController_:SetSelectedState("normal")
	else
		arg_8_0.selectStateController_:SetSelectedState("gray")
	end
end

function var_0_0.UpdateProcessState(arg_9_0)
	if arg_9_0:CheckIsOpen() then
		local var_9_0, var_9_1 = OathAssignmentData:GetOathAssignmentHeroLevelProgress(arg_9_0.heroID, arg_9_0.level)

		if var_9_1 <= var_9_0 then
			arg_9_0.processStateController_:SetSelectedState("finish")
		else
			arg_9_0.processStateController_:SetSelectedState("normal")
		end
	else
		arg_9_0.processStateController_:SetSelectedState("lock")
	end
end

function var_0_0.GetProcessState(arg_10_0)
	return arg_10_0.processStateController_:GetSelectedState()
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.titleText_.text = OathTools.GetOathLvShowTips(arg_11_0.level)

	local var_11_0, var_11_1 = OathAssignmentData:GetOathAssignmentHeroLevelProgress(arg_11_0.heroID, arg_11_0.level)

	arg_11_0.processText_.text = string.format("%d/%d", var_11_0, var_11_1)
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
