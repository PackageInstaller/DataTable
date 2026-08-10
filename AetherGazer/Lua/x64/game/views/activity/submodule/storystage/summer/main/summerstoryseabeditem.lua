local var_0_0 = class("SummerStorySeabedItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.chapterID_ = arg_1_2
	arg_1_0.activityID_ = arg_1_3

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.activityData_ = ActivityData:GetActivityData(arg_2_0.activityID_)
	arg_2_0.unLockState_ = ActivityTools.IsUnlockActivity(arg_2_0.activityID_)

	manager.redPoint:bindUIandKey(arg_2_0.transform_, ActivityTools.GetRedPointKey(arg_2_0.activityID_) .. arg_2_0.activityID_)
	arg_2_0:AddTimer()
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:StopTimer()
	manager.redPoint:unbindUIandKey(arg_3_0.transform_, ActivityTools.GetRedPointKey(arg_3_0.activityID_) .. arg_3_0.activityID_)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		local var_6_0 = arg_5_0.activityData_
		local var_6_1 = manager.time:GetServerTime()

		if var_6_1 > var_6_0.stopTime then
			ShowTips("TIME_OVER")

			return
		end

		if var_6_1 < var_6_0.startTime then
			local var_6_2 = GetTips("OPEN_TIME")

			ShowTips(string.format(var_6_2, manager.time:GetLostTimeStr(var_6_0.startTime)))

			return
		end

		if ActivityData:GetActivityIsOpen(arg_5_0.activityID_) == false then
			local var_6_3 = GetTips("OPEN_TIME")

			ShowTips(string.format(var_6_3, manager.time:GetLostTimeStr(manager.time:GetServerTime() + 1)))

			return
		end

		if not arg_5_0.unLockState_ then
			ShowTips("ACTIVITY_FINISH_ALL_SUMMER_STORY")

			return
		end

		ActivityStoryAction.UpdateRedPoint(arg_5_0.activityID_, 0)
		arg_5_0:Go("/summerStageSeabed", {
			theme = ActivityConst.THEME.SUMMER,
			chapterID = arg_5_0.chapterID_
		})
	end)
end

function var_0_0.AddTimer(arg_7_0)
	arg_7_0:StopTimer()

	local var_7_0 = arg_7_0.activityData_
	local var_7_1 = manager.time:GetServerTime()

	if var_7_1 > var_7_0.stopTime then
		arg_7_0.controller_:SetSelectedState("on")

		return
	end

	if var_7_1 < var_7_0.startTime then
		arg_7_0.controller_:SetSelectedState("off")

		arg_7_0.timeText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_7_0.startTime))
		arg_7_0.timer_ = Timer.New(function()
			var_7_1 = manager.time:GetServerTime()

			if var_7_1 >= var_7_0.startTime then
				arg_7_0.controller_:SetSelectedState("on")
				arg_7_0:StopTimer()

				return
			end

			arg_7_0.timeText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_7_0.startTime))
		end, 1, -1)

		arg_7_0.timer_:Start()

		return
	end

	arg_7_0.controller_:SetSelectedState("on")
end

function var_0_0.StopTimer(arg_9_0)
	if arg_9_0.timer_ then
		arg_9_0.timer_:Stop()

		arg_9_0.timer_ = nil
	end
end

return var_0_0
