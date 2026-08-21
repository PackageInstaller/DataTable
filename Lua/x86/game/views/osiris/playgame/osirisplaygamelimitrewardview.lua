local var_0_0 = import("game.views.task.limitTime.LimitTimeTaskBaseView")
local var_0_1 = class("OsirisPlayGameLimitRewardView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	arg_1_0.super.OnEnter(arg_1_0)

	for iter_1_0 = 1, #arg_1_0.subActivityIDList_ do
		local var_1_0 = arg_1_0.subActivityIDList_[iter_1_0]
		local var_1_1 = RedPointConst.OSIRIS_PLAY_GAME_TASK_TAG .. var_1_0

		manager.redPoint:bindUIandKey(arg_1_0.tabList_[iter_1_0].transform_, var_1_1)
	end
end

function var_0_1.OnExit(arg_2_0)
	arg_2_0.super.OnExit(arg_2_0)

	for iter_2_0 = 1, #arg_2_0.subActivityIDList_ do
		local var_2_0 = arg_2_0.subActivityIDList_[iter_2_0]
		local var_2_1 = RedPointConst.OSIRIS_PLAY_GAME_TASK_TAG .. var_2_0

		manager.redPoint:unbindUIandKey(arg_2_0.tabList_[iter_2_0].transform_, var_2_1)
	end
end

function var_0_1.CheckPointReward(arg_3_0)
	local var_3_0, var_3_1 = GetCurTaskScheduleInfo(arg_3_0.mainActivityID_)
	local var_3_2 = {}
	local var_3_3 = #AssignmentCfg.get_id_list_by_activity_id[arg_3_0.mainActivityID_]

	for iter_3_0 = 1, var_3_3 do
		local var_3_4 = arg_3_0.pointItemList_[iter_3_0]:GetTaskID()
		local var_3_5 = AssignmentCfg[var_3_4]
		local var_3_6 = TaskData2:GetTaskComplete(var_3_4)

		if TaskData2:GetTaskProgress(var_3_4) >= var_3_5.need and not var_3_6 then
			table.insert(var_3_2, var_3_4)
		end
	end

	if #var_3_2 > 0 then
		TaskAction:SubmitTaskList(var_3_2)
		OsirisPlayGameData:UpdateOsirisTaskRedPoint()
	end
end

function var_0_1.InitData(arg_4_0)
	arg_4_0.mainActivityID_ = arg_4_0.params_.activityID

	local var_4_0 = ActivityData:GetActivityData(arg_4_0.mainActivityID_)

	if ActivityData:GetActivityIsOpen(arg_4_0.mainActivityID_) then
		arg_4_0.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_4_0.stopTime)
	elseif manager.time:GetServerTime() < var_4_0.startTime then
		arg_4_0.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_4_0.startTime))
	elseif manager.time:GetServerTime() > var_4_0.stopTime then
		arg_4_0.timeLable_.text = GetTips("TIME_OVER")
	end

	if arg_4_0.timer_ == nil then
		arg_4_0.timer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(arg_4_0.mainActivityID_) then
				arg_4_0.timeLable_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_4_0.stopTime)
			else
				if manager.time:GetServerTime() < var_4_0.startTime then
					arg_4_0.timeLable_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_4_0.startTime))
				elseif manager.time:GetServerTime() > var_4_0.stopTime then
					arg_4_0.timeLable_.text = GetTips("TIME_OVER")
				end

				gameContext:Go("/home")
			end
		end, 1, -1)
	end

	arg_4_0.timer_:Start()
end

function GetCurTaskScheduleInfo(arg_6_0)
	local var_6_0 = AssignmentCfg.get_id_list_by_activity_id[arg_6_0]

	if var_6_0 then
		local var_6_1 = var_6_0[#var_6_0]

		return TaskData2:GetTaskProgress(var_6_1), AssignmentCfg[var_6_1].need
	end
end

return var_0_1
