local var_0_0 = class("ValentineGameMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ValentineGameTools.GetMainUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		if ActivityData:GetActivityData(arg_5_0.activityID_):IsActivitying() then
			JumpTools.OpenPageByJump("valentineGameReward", {
				activityID = arg_5_0.params_.activityID
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.testBtn_, nil, function()
		if ActivityData:GetActivityData(arg_5_0.activityID_):IsActivitying() then
			JumpTools.OpenPageByJump("/valentineGameTest", {
				activityID = arg_5_0.params_.activityID
			})
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:BindUIRedPoint()
	arg_8_0:RefreshData()
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshData(arg_9_0)
	arg_9_0.activityID_ = arg_9_0.params_.activityID
	arg_9_0.activityData_ = ActivityData:GetActivityData(arg_9_0.activityID_)
	arg_9_0.startTime_ = arg_9_0.activityData_.startTime
	arg_9_0.stopTime_ = arg_9_0.activityData_.stopTime
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshTime()
end

function var_0_0.RefreshTime(arg_11_0)
	local var_11_0
	local var_11_1 = manager.time:GetServerTime()

	arg_11_0:StopTimer()

	if var_11_1 < arg_11_0.startTime_ then
		arg_11_0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		arg_11_0.timer_ = Timer.New(function()
			var_11_0 = arg_11_0.startTime_ - manager.time:GetServerTime()

			if var_11_0 <= 0 then
				arg_11_0:StopTimer()
				arg_11_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_11_0.timer_:Start()
	elseif var_11_1 < arg_11_0.stopTime_ then
		arg_11_0.timeTxt_.text = manager.time:GetLostTimeStr(arg_11_0.stopTime_)
		arg_11_0.timer_ = Timer.New(function()
			var_11_0 = arg_11_0.stopTime_ - manager.time:GetServerTime()

			if var_11_0 <= 0 then
				arg_11_0:StopTimer()
				arg_11_0:RefreshTime()

				return
			end

			arg_11_0.timeTxt_.text = manager.time:GetLostTimeStr(arg_11_0.stopTime_)
		end, 1, -1)

		arg_11_0.timer_:Start()
	else
		arg_11_0.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()

		arg_14_0.timer_ = nil
	end
end

function var_0_0.BindUIRedPoint(arg_15_0)
	manager.redPoint:bindUIandKey(arg_15_0.rewardBtn_.transform, RedPointConst.VALENTINE_GAME_REWARD .. "_" .. arg_15_0.params_.activityID)
	manager.redPoint:bindUIandKey(arg_15_0.testBtn_.transform, RedPointConst.VALENTINE_GAME_OPEN .. "_" .. arg_15_0.params_.activityID)
end

function var_0_0.UnBindUIRedPoint(arg_16_0)
	manager.redPoint:unbindUIandKey(arg_16_0.rewardBtn_.transform, RedPointConst.VALENTINE_GAME_REWARD .. "_" .. arg_16_0.params_.activityID)
	manager.redPoint:unbindUIandKey(arg_16_0.testBtn_.transform, RedPointConst.VALENTINE_GAME_OPEN .. "_" .. arg_16_0.params_.activityID)
end

function var_0_0.OnTop(arg_17_0)
	local var_17_0 = ValentineGameTools.GetGameHelpKey(arg_17_0.params_.activityID)

	if var_17_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(var_17_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0:StopTimer()
	arg_18_0:UnBindUIRedPoint()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:RemoveAllListeners()
	arg_19_0.super.Dispose(arg_19_0)
end

return var_0_0
