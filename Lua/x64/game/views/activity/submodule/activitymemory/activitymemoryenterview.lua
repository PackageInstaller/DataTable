local var_0_0 = class("ActivityMemoryEnterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityMemoryTools.GetEnterUIName(arg_1_0.params_.activityID)
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

	arg_4_0.taskItem_ = {}

	local var_4_0 = SpringFestivalMemoryCfg.get_id_list_by_activity_id[arg_4_0.params_.activityID]

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		arg_4_0.taskItem_[iter_4_0] = ActivityMemoryTaskItem.New(arg_4_0["taskItem_" .. iter_4_0])

		arg_4_0.taskItem_[iter_4_0]:SetData(iter_4_1, arg_4_0.params_.activityID)
	end
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.enterStoryBtn_, nil, function()
		arg_5_0:PlayStory(arg_5_0.enterStoryID_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.activityStoryBtn_, nil, function()
		arg_5_0:PlayStory(arg_5_0.activityStoryID_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.collectStoryBtn_, nil, function()
		arg_5_0:PlayStory(arg_5_0.collectStoryID_)
	end)
	arg_5_0:AddBtnListener(arg_5_0.infoBtn_, nil, function()
		local var_9_0 = ActivityMemoryTools.GetHelpKey(arg_5_0.activityID_)

		if var_9_0 ~= "" then
			JumpTools.OpenPageByJump("gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips(var_9_0),
				key = var_9_0
			})
		end
	end)
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:RefreshUI()
	manager.redPoint:setTip(RedPointConst.ACTIVITY_MEMORY_OPEN .. "_" .. arg_10_0.activityID_, 0)
	saveData(RedPointConst.ACTIVITY_MEMORY_OPEN, tostring(arg_10_0.activityID_), true)
	arg_10_0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(arg_10_0, arg_10_0.RefreshTask))
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0:RefreshData()
	arg_11_0:RefreshTime()
	arg_11_0:RefreshTask()
	arg_11_0:RefreshStory()
end

function var_0_0.RefreshData(arg_12_0)
	arg_12_0.activityID_ = arg_12_0.params_.activityID
	arg_12_0.activityData_ = ActivityData:GetActivityData(arg_12_0.activityID_)
	arg_12_0.startTime_ = arg_12_0.activityData_.startTime
	arg_12_0.stopTime_ = arg_12_0.activityData_.stopTime
	arg_12_0.enterStoryID_ = ActivityMemoryTools.GetEnterCondition(arg_12_0.activityID_)[2]
	arg_12_0.activityStoryID_ = ActivityMemoryTools.GetActivityCondition(arg_12_0.activityID_)[2]
	arg_12_0.collectStoryID_ = ActivityMemoryTools.GetCollectCondition(arg_12_0.activityID_)[2]
end

function var_0_0.RefreshTime(arg_13_0)
	arg_13_0:StopTimer()

	local var_13_0 = manager.time:GetServerTime()

	if var_13_0 < arg_13_0.startTime_ then
		arg_13_0.timeLabel_.text = GetTips("SOLO_NOT_OPEN")
		arg_13_0.timer_ = Timer.New(function()
			if manager.time:GetServerTime() >= arg_13_0.startTime_ then
				arg_13_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_13_0.timer_:Start()
	elseif var_13_0 < arg_13_0.stopTime_ then
		arg_13_0.timeLabel_.text = manager.time:GetLostTimeStr2(arg_13_0.stopTime_)
		arg_13_0.timer_ = Timer.New(function()
			if manager.time:GetServerTime() >= arg_13_0.stopTime_ then
				arg_13_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_13_0.timer_:Start()
	else
		arg_13_0.timeLabel_.text = GetTips("TIME_OVER")
	end
end

function var_0_0.StopTimer(arg_16_0)
	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end
end

function var_0_0.RefreshTask(arg_17_0)
	arg_17_0.progress_ = 0

	local var_17_0 = ActivityMemoryTools.GetTaskActivityID(arg_17_0.activityID_)
	local var_17_1 = SpringFestivalMemoryCfg.get_id_list_by_activity_id[arg_17_0.activityID_]

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		local var_17_2 = SpringFestivalMemoryCfg[iter_17_1].task_id
		local var_17_3 = AssignmentCfg[var_17_2]
		local var_17_4 = TaskData2:GetTask(var_17_2)

		if var_17_4 and var_17_4.progress >= var_17_3.need then
			arg_17_0.progress_ = arg_17_0.progress_ + 1
		end

		arg_17_0.taskItem_[iter_17_0]:RefreshUI()
	end

	arg_17_0.progressTxt_.text = string.format(GetTips("SPRING_FESTIVAL_MEMORY"), arg_17_0.progress_, #var_17_1)
end

function var_0_0.RefreshStory(arg_18_0)
	SetActive(arg_18_0.enterStoryBtn_.gameObject, arg_18_0.enterStoryID_ and manager.story:IsStoryPlayed(arg_18_0.enterStoryID_))
	SetActive(arg_18_0.activityStoryBtn_.gameObject, arg_18_0.activityStoryID_ and manager.story:IsStoryPlayed(arg_18_0.activityStoryID_))
	SetActive(arg_18_0.collectStoryBtn_.gameObject, arg_18_0.collectStoryID_ and manager.story:IsStoryPlayed(arg_18_0.collectStoryID_))
end

function var_0_0.PlayStory(arg_19_0, arg_19_1, arg_19_2)
	manager.story:StartStoryById(arg_19_1, function()
		if arg_19_2 then
			arg_19_2()
		end
	end)
end

function var_0_0.OnTop(arg_21_0)
	arg_21_0:RefreshStory()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_22_0)
	arg_22_0:StopTimer()
	arg_22_0:RemoveAllEventListener()

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.taskItem_) do
		iter_22_1:OnExit()
	end
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:RemoveAllListeners()

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.taskItem_) do
		iter_23_1:Dispose()
	end

	arg_23_0.super.Dispose(arg_23_0)
end

return var_0_0
