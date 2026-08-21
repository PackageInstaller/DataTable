local var_0_0 = class("PreviewTaskMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Task/AdvanceTaskUIPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.scrollView_, PreviewTaskItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backMask_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.activityID_ = PreviewTaskData:GetCurActivityID()
	arg_7_0.stopTime_ = ActivityData:GetActivityData(arg_7_0.activityID_).stopTime

	if arg_7_0.lastPosition_ then
		arg_7_0:RefreshScroll(true)

		arg_7_0.lastPosition_ = nil
	else
		arg_7_0:RefreshScroll()
	end

	arg_7_0:RefreshTimeText()
end

function var_0_0.RefreshScroll(arg_8_0, arg_8_1)
	arg_8_0:UpdateData()

	if arg_8_1 then
		if arg_8_0.lastPosition_ then
			local var_8_0 = clone(arg_8_0.lastPosition_)
			local var_8_1

			var_8_1 = FrameTimer.New(function()
				arg_8_0.scrollHelper_:StartScrollWithoutAnimator(#arg_8_0._taskIDList, var_8_0)
				var_8_1:Stop()

				var_8_1 = nil
			end, 1, 1)

			var_8_1:Start()
		else
			arg_8_0.scrollHelper_:StartScrollWithoutAnimator(#arg_8_0._taskIDList)
		end
	else
		arg_8_0.scrollHelper_:StartScroll(#arg_8_0._taskIDList)
	end
end

function var_0_0.indexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0._taskIDList[arg_10_1]

	arg_10_2:SetData(var_10_0, arg_10_0.activityID_)
end

function var_0_0.OnExit(arg_11_0)
	if arg_11_0.dailyTimer_ then
		arg_11_0.dailyTimer_:Stop()

		arg_11_0.dailyTimer_ = nil
	end

	arg_11_0.lastPosition_ = arg_11_0.scrollHelper_:GetScrolledPosition()

	arg_11_0:StopTimer()
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.scrollHelper_:Dispose()
	arg_12_0:StopTimer()
	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.UpdateData(arg_13_0)
	arg_13_0._taskIDList = PreviewTaskData:GetSortTaskIDList(arg_13_0.activityID_)
end

function var_0_0.OnPreviewTaskListChange(arg_14_0)
	arg_14_0:RefreshScroll(true)
end

function var_0_0.RefreshTimeText(arg_15_0)
	if not ActivityData:GetActivityIsOpen(arg_15_0.activityID_) then
		arg_15_0.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	arg_15_0.remainTimeText_.text = manager.time:GetLostTimeStr(arg_15_0.stopTime_)

	arg_15_0:StopTimer()

	arg_15_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_15_0.stopTime_ then
			arg_15_0:StopTimer()

			arg_15_0.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		arg_15_0.remainTimeText_.text = manager.time:GetLostTimeStr(arg_15_0.stopTime_)
	end, 1, -1)

	arg_15_0.timer_:Start()
end

function var_0_0.StopTimer(arg_17_0)
	if arg_17_0.timer_ then
		arg_17_0.timer_:Stop()
	end

	arg_17_0.timer_ = nil
end

return var_0_0
