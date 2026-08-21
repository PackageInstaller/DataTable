local var_0_0 = class("CowboyGameOverView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/VolumeXiuGameSettlementUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scoreCon_ = ControllerUtil.GetController(arg_4_0.transform_, "score")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.leaveBtn_, nil, function()
		JumpTools.OpenPageByJump("/cowboy", {
			activityId = arg_5_0.mainActivityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.onceMoreBtn_, nil, function()
		JumpTools.OpenPageByJump("/cowboyGame", {
			mainActivityID = arg_5_0.mainActivityID_,
			activityID = arg_5_0.activityID_
		})
		manager.notify:CallUpdateFunc(COWBOY_RESTART)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.mainActivityID_ = arg_8_0.params_.mainActivityID
	arg_8_0.activityID_ = arg_8_0.params_.activityID

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = CowboyData:GetHistoryScore(arg_9_0.activityID_)

	if var_9_0 >= arg_9_0.params_.score then
		arg_9_0.highest_.text = var_9_0

		arg_9_0.scoreCon_:SetSelectedState("normal")
	else
		CowboyData:SetScore(arg_9_0.activityID_, arg_9_0.params_.score)

		arg_9_0.highest_.text = arg_9_0.params_.score

		arg_9_0.scoreCon_:SetSelectedState("new")
	end

	arg_9_0.score_.text = arg_9_0.params_.score
end

function var_0_0.OnExit(arg_10_0)
	manager.audio:Pause("music", false)
	manager.audio:Stop("music", true)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
