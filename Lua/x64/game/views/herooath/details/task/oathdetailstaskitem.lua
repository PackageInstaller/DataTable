local var_0_0 = class("OathDetailsTaskItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.stateController_ = arg_2_0.controller_:GetController("state")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		arg_3_0.isNeedPlayFinishAni = true

		OathAssignmentAction.SubmitOathTask({
			arg_3_0.taskID
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.goBtn_, nil, function()
		local var_5_0 = WeddingAssignmentCfg[arg_3_0.taskID]

		JumpTools.JumpToPage2(var_5_0.jump)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.taskID = arg_6_1
	arg_6_0.taskCount = arg_6_2

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = OathAssignmentData:GetOathAssignmentByID(arg_7_0.taskID)
	local var_7_1 = WeddingAssignmentCfg[arg_7_0.taskID]

	arg_7_0.titleText_.text = var_7_1.desc
	arg_7_0.storyText_.text = var_7_1.story
	arg_7_0.rewardValueText_.text = 1 / arg_7_0.taskCount * 100 .. "%"
	arg_7_0.progressBar_.value = var_7_0.progress / var_7_1.need
	arg_7_0.progressText_.text = string.format("%s/%s", math.min(var_7_0.progress, var_7_1.need), var_7_1.need)

	if var_7_0.status == 0 then
		if var_7_0.progress < var_7_1.need then
			arg_7_0.stateController_:SetSelectedState("unComplete")
		else
			arg_7_0.stateController_:SetSelectedState("received")
		end
	else
		arg_7_0.stateController_:SetSelectedState("finish")
		arg_7_0:OpenPlayAni()
	end
end

function var_0_0.DelAniTimer(arg_8_0)
	if arg_8_0.aniTimer_ then
		arg_8_0.aniTimer_:Stop()

		arg_8_0.aniTimer_ = nil
	end
end

function var_0_0.OpenPlayAni(arg_9_0)
	arg_9_0:DelAniTimer()

	arg_9_0.aniTimer_ = Timer.New(function()
		arg_9_0:PlayFinishAni()
	end, 0.1)

	arg_9_0.aniTimer_:Start()
end

function var_0_0.PlayFinishAni(arg_11_0)
	if arg_11_0.isNeedPlayFinishAni then
		arg_11_0.completeAni_:Play("UI_complete_cx", 0, 0)
		arg_11_0.completeAni_:Update(0)

		arg_11_0.isNeedPlayFinishAni = false
	else
		arg_11_0.completeAni_:Play("UI_complete_cx", 0, 1)
		arg_11_0.completeAni_:Update(1)
	end
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:DelAniTimer()
	arg_12_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
