local var_0_0 = class("LeviathanLittleGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/SummerUI/SummerzoawdUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()

	arg_3_0.scrollMoveView_ = ScrollMoveView.New(arg_3_0, arg_3_0.scrollViewGo_, true)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.buttonBtn_, nil, function()
		if arg_4_0:IsOpenSectionInfo() then
			JumpTools.Back()
		else
			JumpTools.OpenPageByJump("leviathanGameReward")
		end
	end)
end

function var_0_0.IsOpenSectionInfo(arg_6_0)
	return arg_6_0:IsOpenRoute("leviathanSectionInfo")
end

function var_0_0.InitBtns(arg_7_0)
	if not arg_7_0.itemView_ then
		arg_7_0.itemView_ = {}

		for iter_7_0, iter_7_1 in ipairs(ActivityCfg[arg_7_0.activityID_].sub_activity_list) do
			arg_7_0.itemView_[iter_7_1] = LeviathanLittleGameItem.New(arg_7_0[string.format("itemGo_%d", iter_7_0)], iter_7_1, arg_7_0.activityID_, iter_7_0)

			arg_7_0.itemView_[iter_7_1]:AddClickFunc(function(arg_8_0)
				arg_7_0.selIndex_ = arg_8_0

				local var_8_0 = arg_7_0:GetScrollPos()
				local var_8_1 = arg_7_0:GetScrollWidth()

				arg_7_0.scrollMoveView_:RefreshUI(var_8_0, var_8_1)
			end)
		end
	end
end

function var_0_0.OnUpdate(arg_9_0)
	local var_9_0 = arg_9_0:GetScrollPos()
	local var_9_1 = arg_9_0:GetScrollWidth()

	arg_9_0.scrollMoveView_:RefreshUI(var_9_0, var_9_1)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.activityID_ = ActivityConst.LEVIATHAN_GAME

	local var_10_0 = ActivityTools.GetGameHelpKey(arg_10_0.activityID_)

	if var_10_0 ~= "" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey(var_10_0)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	arg_10_0:InitBtns()

	for iter_10_0, iter_10_1 in pairs(arg_10_0.itemView_) do
		iter_10_1:OnEnter()
	end

	arg_10_0.descText_.text = GetTips("ACTIVITY__BUBBLES_CONTENT")
	arg_10_0.stopTime_ = ActivityData:GetActivityData(arg_10_0.activityID_).stopTime

	arg_10_0:AddTimer()
	manager.redPoint:setTip(RedPointConst.LEVIATHAN_LITTLE_GAME_LEVEL, 0)
	manager.redPoint:bindUIandKey(arg_10_0.buttonBtn_.transform, RedPointConst.LEVIATHAN_LITTLE_GAME_REWARD)

	local var_10_1 = arg_10_0:GetScrollPos()
	local var_10_2 = arg_10_0:GetScrollWidth()

	arg_10_0.scrollMoveView_:RefreshUI(var_10_1, var_10_2)
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:StopTimer()
	manager.windowBar:HideBar()
	arg_11_0.scrollMoveView_:OnExit()

	for iter_11_0, iter_11_1 in pairs(arg_11_0.itemView_) do
		iter_11_1:OnExit()
	end

	manager.redPoint:unbindUIandKey(arg_11_0.buttonBtn_.transform, RedPointConst.LEVIATHAN_LITTLE_GAME_REWARD)
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.itemView_) do
		iter_12_1:Dispose()
	end

	arg_12_0.itemView_ = nil

	arg_12_0.scrollMoveView_:Dispose()

	arg_12_0.scrollMoveView_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.GetScrollWidth(arg_13_0)
	return 2777
end

function var_0_0.GetScrollPos(arg_14_0)
	return arg_14_0.selIndex_ and arg_14_0[string.format("itemGo_%d", arg_14_0.selIndex_)].transform.localPosition.x or 0
end

function var_0_0.AddTimer(arg_15_0)
	if manager.time:GetServerTime() >= arg_15_0.stopTime_ then
		arg_15_0.remainText_.text = GetTips("TIME_OVER")

		return
	end

	arg_15_0.remainText_.text = manager.time:GetLostTimeStr(arg_15_0.stopTime_)
	arg_15_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_15_0.stopTime_ then
			arg_15_0:StopTimer()

			arg_15_0.remainText_.text = GetTips("TIME_OVER")

			return
		end

		arg_15_0.remainText_.text = manager.time:GetLostTimeStr(arg_15_0.stopTime_)
	end, 0.33, -1)

	arg_15_0.timer_:Start()
end

function var_0_0.StopTimer(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()

		arg_17_0.timer_ = nil
	end
end

return var_0_0
