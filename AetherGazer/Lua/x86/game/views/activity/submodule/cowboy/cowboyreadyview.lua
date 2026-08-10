local var_0_0 = class("CowboyReadyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/VolumeSignXiuGmaeUI"
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
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.startBtn_, nil, function()
		CowboyData:SetLastLevel(arg_5_0.mainActivityID_, arg_5_0.activityID_)
		JumpTools.OpenPageByJump("/cowboyGame", {
			mainActivityID = arg_5_0.mainActivityID_,
			activityID = arg_5_0.activityID_
		})
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID
	arg_8_0.mainActivityID_ = arg_8_0.params_.mainActivityID

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.title_.text = string.format(GetTips("ACTIVITY_COWBOY_ROUND"), arg_9_0.params_.index)
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
