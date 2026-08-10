local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("AutoChessEnterView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_MainUI"
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.skinDlcController_ = arg_3_0.controller_:GetController("skinDLC")
	arg_3_0.skinGotController_ = arg_3_0.controller_:GetController("skinGot")
	arg_3_0.skinGiftController_ = arg_3_0.controller_:GetController("skinGift")
end

function var_0_1.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		JumpTools.GoToSystem("/autoChessMain")
	end)
	arg_4_0:AddBtnListener(arg_4_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/autoChessLimitTaskView", {
			activityID = ActivityConst.ACTIVITY_AUTO_CHESS_TASK
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			key = "AUTO_CHESS_ENTRANCE_TIP",
			content = GetTips("AUTO_CHESS_ENTRANCE_TIP")
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.skinBtn_, nil, function()
		JumpTools.OpenPageByJump("autoChessSkinDlcView")
	end)
end

function var_0_1.OnEnter(arg_9_0)
	arg_9_0.super.OnEnter(arg_9_0)
	arg_9_0:RefreshRewardTime()
	arg_9_0:RefreshSkinTime()
	arg_9_0:BindRedPoint()

	if not arg_9_0.move then
		arg_9_0.move = Asset.Instantiate("Widget/System/Activity_OsirisHorus/Movie/Activity_OsirisHorus_Main_Movie")

		if arg_9_0.move then
			arg_9_0.move.transform.parent = arg_9_0.movieTrans_
			arg_9_0.move.transform.localScale = Vector3.one
			arg_9_0.move.transform.localPosition = Vector3.zero
		end
	end
end

function var_0_1.BindRedPoint(arg_10_0)
	manager.redPoint:bindUIandKey(arg_10_0.rewardBtn_.transform, RedPointConst.AUTO_CHESS_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_TASK)
	manager.redPoint:bindUIandKey(arg_10_0.goBtn_.transform, RedPointConst.AUTO_CHESS_GO_BTN)
end

function var_0_1.UnBindRedPoint(arg_11_0)
	manager.redPoint:unbindUIandKey(arg_11_0.rewardBtn_.transform, RedPointConst.AUTO_CHESS_LIMIT_TASK .. ActivityConst.ACTIVITY_AUTO_CHESS_TASK)
	manager.redPoint:unbindUIandKey(arg_11_0.goBtn_.transform, RedPointConst.AUTO_CHESS_GO_BTN)
end

function var_0_1.OnTop(arg_12_0)
	arg_12_0:RefreshSkinGet()
end

function var_0_1.RefreshRewardTime(arg_13_0)
	local var_13_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_TASK)

	arg_13_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_13_0.stopTime)

	SetActive(arg_13_0.rewardBtn_.gameObject, ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_TASK))

	if arg_13_0.limittimer_ == nil then
		arg_13_0.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_TASK) then
				arg_13_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_13_0.stopTime)
			else
				SetActive(arg_13_0.rewardBtn_.gameObject, false)
				arg_13_0:LimitStopTimer()
			end
		end, 1, -1)
	end

	arg_13_0.limittimer_:Start()
end

function var_0_1.LimitStopTimer(arg_15_0)
	if arg_15_0.limittimer_ then
		arg_15_0.limittimer_:Stop()

		arg_15_0.limittimer_ = nil
	end
end

function var_0_1.DisposeSkinTimer(arg_16_0)
	if arg_16_0.skinTimer_ then
		arg_16_0.skinTimer_:Stop()

		arg_16_0.skinTimer_ = nil
	end
end

function var_0_1.RefreshSkinTime(arg_17_0)
	arg_17_0:RefreshSkinGet()
	arg_17_0:UpdateSkinTime()
	arg_17_0:DisposeSkinTimer()

	arg_17_0.skinTimer_ = Timer.New(function()
		arg_17_0:UpdateSkinTime()
	end, 1, -1)

	arg_17_0.skinTimer_:Start()
end

function var_0_1.UpdateSkinTime(arg_19_0)
	local var_19_0 = ActivityConst.ACTIVITY_AUTO_CHESS_SKIN
	local var_19_1 = ActivityData:GetActivityData(var_19_0)

	if ActivityData:GetActivityIsOpen(var_19_0) then
		arg_19_0.skinTimeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(var_19_0).stopTime)
	elseif manager.time:GetServerTime() < var_19_1.startTime then
		arg_19_0.skinTimeText_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_19_1.startTime))
	elseif manager.time:GetServerTime() > var_19_1.stopTime then
		arg_19_0.skinTimeText_.text = GetTips("TIME_OVER")
	end
end

function var_0_1.RefreshSkinGet(arg_20_0)
	local var_20_0 = ActivityConst.ACTIVITY_AUTO_CHESS_SKIN
	local var_20_1 = AssignmentCfg.get_id_list_by_activity_id[var_20_0] or {}

	if not ActivityData:GetActivityIsOpen(var_20_0) then
		arg_20_0.skinDlcController_:SetSelectedState("off")

		return
	else
		arg_20_0.skinDlcController_:SetSelectedState("on")
	end

	if TaskTools:GetFinishTaskNum(var_20_1) == #var_20_1 then
		arg_20_0.skinGotController_:SetSelectedState("on")
	else
		arg_20_0.skinGotController_:SetSelectedState("off")
	end

	if TaskTools:IsHasReceiveTask(var_20_1) then
		arg_20_0.skinGiftController_:SetSelectedState("on")
	else
		arg_20_0.skinGiftController_:SetSelectedState("off")
	end
end

function var_0_1.OnExit(arg_21_0)
	arg_21_0:DisposeSkinTimer()
	arg_21_0:LimitStopTimer()

	if arg_21_0.limittimer_ then
		arg_21_0.limittimer_:Stop()

		arg_21_0.limittimer_ = nil
	end

	if arg_21_0.move then
		Object.Destroy(arg_21_0.move)

		arg_21_0.move = nil
	end

	arg_21_0:UnBindRedPoint()
	var_0_1.super.OnExit(arg_21_0)
end

function var_0_1.Dispose(arg_22_0)
	arg_22_0.super.Dispose(arg_22_0)
end

return var_0_1
