ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("SummerPubMainView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_MainUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.skinDlcController_ = arg_3_0.exController_:GetController("skinDLC")
	arg_3_0.skinGiftController_ = arg_3_0.exController_:GetController("skinGift")
	arg_3_0.skinGotController_ = arg_3_0.exController_:GetController("skinGot")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.infoBtn_, nil, function()
		local var_5_0 = "NYA_SUMMER_ENTRANCE_TIP"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_5_0),
			key = var_5_0
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.limitRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/summerPubLimitTaskView", {
			activityID = ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		SummerPubTool:MainToEnterView()
	end)
	arg_4_0:AddBtnListener(arg_4_0.skinBtn_, nil, function()
		JumpTools.OpenPageByJump("summerPubSkinPopView")
	end)
end

function var_0_0.OnEnter(arg_9_0)
	var_0_0.super.OnEnter(arg_9_0)

	arg_9_0.titleTxt_.text = GetI18NText(GetTips("NYA_SUMMER_ENTRANCE_TITLE"))
	arg_9_0.bg_.sprite = pureGetSpriteWithoutAtlas("TextureBg/Activity_SummerPub/MainPub/SP92601")

	arg_9_0:UpdatePreview()
	arg_9_0:RefreshLimitTime()
	arg_9_0:RefreshSkinDlc()
	manager.redPoint:bindUIandKey(arg_9_0.goBtn_.transform, RedPointConst.SUMMER_PUB_GO_BTN)
	manager.redPoint:bindUIandKey(arg_9_0.limitRewardBtn_.transform, RedPointConst.SUMMER_PUB_LIMIT_TASK .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK)
	manager.redPoint:bindUIandKey(arg_9_0.skinBtn_.transform, RedPointConst.SUMMER_PUB_SKIN_DLC_GIFT)
end

function var_0_0.RefreshLimitTime(arg_10_0)
	local var_10_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK) then
		arg_10_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_10_0.stopTime)
	elseif manager.time:GetServerTime() < var_10_0.startTime then
		arg_10_0.limitTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_10_0.startTime))
	elseif manager.time:GetServerTime() > var_10_0.stopTime then
		arg_10_0.limitTimeTxt_.text = GetTips("TIME_OVER")
	end

	if arg_10_0.limittimer_ == nil then
		arg_10_0.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK) then
				if arg_10_0.limittimer_ == nil then
					arg_10_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_10_0.stopTime)
				end
			elseif manager.time:GetServerTime() < var_10_0.startTime then
				arg_10_0.limitTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_10_0.startTime))
			elseif manager.time:GetServerTime() > var_10_0.stopTime then
				arg_10_0.limitTimeTxt_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	arg_10_0.limittimer_:Start()
end

function var_0_0.RefreshSkinDlc(arg_12_0)
	local var_12_0 = ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC

	if ActivityData:GetActivityIsOpen(var_12_0) then
		arg_12_0.skinDlcController_:SetSelectedState("on")

		local var_12_1 = AssignmentCfg.get_id_list_by_activity_id[var_12_0] or {}

		if TaskTools:IsHasReceiveTask(var_12_1) then
			arg_12_0.skinGiftController_:SetSelectedState("on")
		else
			arg_12_0.skinGiftController_:SetSelectedState("off")

			if TaskTools:GetFinishTaskNum(var_12_1) == #var_12_1 then
				arg_12_0.skinGotController_:SetSelectedState("on")
			else
				arg_12_0.skinGotController_:SetSelectedState("off")
			end
		end

		arg_12_0:RefreshSkinTimeText()
	else
		arg_12_0.skinDlcController_:SetSelectedState("off")
	end
end

function var_0_0.RefreshSkinTimeText(arg_13_0)
	local var_13_0 = ActivityConst.ACTIVITY_NYA_SUMMER_PUB_SKIN_DLC
	local var_13_1 = ActivityData:GetActivityData(var_13_0)

	if ActivityData:GetActivityIsOpen(var_13_0) then
		arg_13_0.skinTimeTxt_.text = manager.time:GetLostTimeStr2(var_13_1.stopTime)
	elseif manager.time:GetServerTime() < var_13_1.startTime then
		arg_13_0.skinTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_13_1.startTime))
	elseif manager.time:GetServerTime() > var_13_1.stopTime then
		arg_13_0.skinTimeTxt_.text = GetTips("TIME_OVER")
	end

	if arg_13_0.skinTimer_ == nil then
		arg_13_0.skinTimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(var_13_0) then
				if arg_13_0.skinTimer_ == nil then
					arg_13_0.skinTimeTxt_.text = manager.time:GetLostTimeStr2(var_13_1.stopTime)
				end
			elseif manager.time:GetServerTime() < var_13_1.startTime then
				arg_13_0.skinTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_13_1.startTime))
			elseif manager.time:GetServerTime() > var_13_1.stopTime then
				arg_13_0.skinTimeTxt_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	arg_13_0.skinTimer_:Start()
end

function var_0_0.UpdateBar(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnTop(arg_16_0)
	arg_16_0:UpdateBar()
	arg_16_0:RefreshSkinDlc()
end

function var_0_0.LimitStopTimer(arg_17_0)
	if arg_17_0.limittimer_ then
		arg_17_0.limittimer_:Stop()

		arg_17_0.limittimer_ = nil
	end
end

function var_0_0.SkinStopTimer(arg_18_0)
	if arg_18_0.skinTimer_ then
		arg_18_0.skinTimer_:Stop()

		arg_18_0.skinTimer_ = nil
	end
end

function var_0_0.OnExit(arg_19_0)
	manager.redPoint:unbindUIandKey(arg_19_0.goBtn_.transform, RedPointConst.SUMMER_PUB_GO_BTN)
	manager.redPoint:unbindUIandKey(arg_19_0.limitRewardBtn_.transform, RedPointConst.SUMMER_PUB_LIMIT_TASK .. ActivityConst.ACTIVITY_NYA_SUMMER_PUB_ACCUMULATE_TASK)
	manager.redPoint:unbindUIandKey(arg_19_0.skinBtn_.transform, RedPointConst.SUMMER_PUB_SKIN_DLC_GIFT)
	arg_19_0:LimitStopTimer()
	arg_19_0:SkinStopTimer()
	var_0_0.super.OnExit(arg_19_0)
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
