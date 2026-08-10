local var_0_0 = class("FishingEnterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Fishing/FishingEnterUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.illustratedBtn_, nil, function()
		JumpTools.OpenPageByJump("fishingIllustrated", {})
	end)
	arg_6_0:AddBtnListener(arg_6_0.exchangeBtn_, nil, function()
		local var_8_0 = 702

		if JumpTools.IsSystemOperationStoped(var_8_0) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		local var_8_1 = JumpTools.IsSystemLocked(var_8_0)
		local var_8_2

		var_8_2 = var_8_1 ~= nil and var_8_1 ~= false

		if var_8_0 and var_8_1 then
			ShowTips(JumpTools.GetSystemLockedTip(var_8_0, var_8_1))

			return
		end

		JumpTools.OpenPageByJump("fishingExchange", {})
	end)
	arg_6_0:AddBtnListener(arg_6_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("fishingReward", {})
	end)
	arg_6_0:AddBtnListener(arg_6_0.goBtn_, nil, function()
		print("goBtn")
		JumpTools.OpenPageByJump("/fishingGame", {})
	end)
end

function var_0_0.AddEventListeners(arg_11_0)
	return
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.OnBehind(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "fishingNote",
		type = "jump",
		params = {}
	})
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0:AddEventListeners()
	manager.redPoint:bindUIandKey(arg_15_0.groupRedPointContainer_, RedPointConst.FISHING_GROUP_REWARD, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(arg_15_0.receiveRedPointContainer_, RedPointConst.FISHING_RECEIVE_REWARD, {
		x = 0,
		y = 0
	})
	manager.redPoint:bindUIandKey(arg_15_0.scoreRedPointContainer_, RedPointConst.FISHING_SCORE_REWARD, {
		x = 0,
		y = 0
	})
	FishingAction.GetReceiveInfo(ActivityConst.SUMMER_FISHING)
	FishingAction.ReadUnFinishRedPoint()

	if arg_15_0.timer_ == nil then
		arg_15_0.timer_ = Timer.New(function()
			arg_15_0:UpdateTimer()
		end, 1, -1)
	end

	arg_15_0.timer_:Start()
	arg_15_0:UpdateTimer()
end

function var_0_0.OnExit(arg_17_0)
	manager.redPoint:unbindUIandKey(arg_17_0.groupRedPointContainer_, RedPointConst.FISHING_GROUP_REWARD)
	manager.redPoint:unbindUIandKey(arg_17_0.receiveRedPointContainer_, RedPointConst.FISHING_RECEIVE_REWARD)
	manager.redPoint:unbindUIandKey(arg_17_0.scoreRedPointContainer_, RedPointConst.FISHING_SCORE_REWARD)
	arg_17_0:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end
end

function var_0_0.UpdateTimer(arg_18_0)
	local var_18_0 = ActivityData:GetActivityData(ActivityConst.SUMMER_FISHING)

	if manager.time:GetServerTime() >= var_18_0.stopTime then
		arg_18_0.lastTimeLabel_.text = GetTips("TIME_OVER")

		return
	end

	arg_18_0.lastTimeLabel_.text = manager.time:GetLostTimeStr(var_18_0.stopTime)
end

function var_0_0.OnMainHomeViewTop(arg_19_0)
	return
end

function var_0_0.Dispose(arg_20_0)
	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
