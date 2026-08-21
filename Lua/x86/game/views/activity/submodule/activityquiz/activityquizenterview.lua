local var_0_0 = class("ActivityQuizEnterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return ActivityQuizTools.GetEnterUIName(arg_1_0.params_.activityID)
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

	arg_4_0.stateCon_ = ControllerUtil.GetController(arg_4_0.transform_, "state")
	arg_4_0.clearCon_ = ControllerUtil.GetController(arg_4_0.transform_, "clear")
	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, ActivityQuizTaskItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:Refresh(arg_5_0.list_[arg_5_1], arg_5_0.activityID_)

	local var_5_0 = manager.time:GetServerTime()

	arg_5_2:RefreshTime(var_5_0)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.startBtn_, nil, function()
		if arg_6_0:IsActivitying() and arg_6_0:IsOpenTime() then
			ActivityQuizAction.StartMarch()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.allReceiveBtn_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_6_0.list_) do
			local var_8_1 = iter_8_1.id
			local var_8_2 = AssignmentCfg[var_8_1]

			if iter_8_1.complete_flag < 1 and iter_8_1.progress >= var_8_2.need then
				table.insert(var_8_0, var_8_1)
			end
		end

		TaskAction:SubmitTaskList(var_8_0)
	end)
	arg_6_0:AddBtnListener(arg_6_0.tipBtn_, nil, function()
		local var_9_0 = ActivityQuizTools.GetHelpKey(arg_6_0.activityID_)

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

function var_0_0.MuteEnterRedPoint(arg_10_0)
	if arg_10_0:IsOpenTime() then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_QUIZ_OPEN .. "_" .. arg_10_0.activityID_, 0)
		ActivityQuizTools.RecordAlreadyEnterThisLogin(arg_10_0.activityID_)
		ActivityQuizTools.RecordAlreadyEnterTodayLocal(arg_10_0.activityID_)
	end
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:RegisterEvents()

	arg_11_0.activityID_ = arg_11_0.params_.activityID

	arg_11_0:RefreshUI()
	arg_11_0:MuteEnterRedPoint()
end

function var_0_0.RegisterEvents(arg_12_0)
	arg_12_0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(arg_12_0, arg_12_0.RefreshTask))
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0:RefreshActivityData()
	arg_13_0:RefreshTime()
	arg_13_0:RefreshTask()
end

function var_0_0.RefreshActivityData(arg_14_0)
	arg_14_0.activityData_ = ActivityData:GetActivityData(arg_14_0.activityID_)
	arg_14_0.startTime_ = arg_14_0.activityData_.startTime
	arg_14_0.stopTime_ = arg_14_0.activityData_.stopTime

	local var_14_0 = GameSetting.activity_quiz_open_time.value

	arg_14_0.openTbl_, arg_14_0.closeTbl_ = var_14_0[1], var_14_0[2]
	arg_14_0.dayOpen_.text = string.format("%02d:%02d-%02d:%02d", arg_14_0.openTbl_[1], arg_14_0.openTbl_[2], arg_14_0.closeTbl_[1], arg_14_0.closeTbl_[2])
end

function var_0_0.RefreshTime(arg_15_0)
	local var_15_0 = manager.time:GetServerTime()

	arg_15_0:StopTimer()

	if var_15_0 < arg_15_0.startTime_ then
		arg_15_0.stateCon_:SetSelectedState("close")

		arg_15_0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		arg_15_0.timer_ = Timer.New(function()
			if arg_15_0.startTime_ <= manager.time:GetServerTime() then
				arg_15_0:StopTimer()
				arg_15_0:RefreshTime()

				return
			end
		end, 1, -1)

		arg_15_0.timer_:Start()
	elseif var_15_0 < arg_15_0.stopTime_ then
		arg_15_0.stateCon_:SetSelectedState(arg_15_0:IsOpenTime() and "unlock" or "close")

		arg_15_0.timeLable_.text = manager.time:GetLostTimeStr2(arg_15_0.stopTime_)
		arg_15_0.timer_ = Timer.New(function()
			var_15_0 = manager.time:GetServerTime()

			if arg_15_0.stopTime_ <= var_15_0 then
				arg_15_0:StopTimer()
				arg_15_0:RefreshTime()

				return
			else
				arg_15_0.stateCon_:SetSelectedState(arg_15_0:IsOpenTime() and "unlock" or "close")

				arg_15_0.timeLable_.text = manager.time:GetLostTimeStr2(arg_15_0.stopTime_)
			end
		end, 1, -1)

		arg_15_0.timer_:Start()
	else
		arg_15_0.timeLable_.text = GetTips("TIME_OVER")

		arg_15_0.stateCon_:SetSelectedState("close")
	end
end

function var_0_0.StopTimer(arg_18_0)
	if arg_18_0.timer_ then
		arg_18_0.timer_:Stop()

		arg_18_0.timer_ = nil
	end
end

function var_0_0.RefreshTask(arg_19_0)
	local var_19_0 = ActivityQuizTools.GetTaskActivityID(arg_19_0.activityID_)
	local var_19_1 = ActivityData:GetActivityData(var_19_0).subActivityIdList

	arg_19_0.list_ = {}

	local var_19_2 = {}
	local var_19_3 = {}
	local var_19_4 = TaskTools:GetActivityTaskList(var_19_0) or {}

	for iter_19_0, iter_19_1 in pairs(var_19_4) do
		table.insert(var_19_2, iter_19_1)
	end

	for iter_19_2, iter_19_3 in ipairs(var_19_1) do
		if ActivityData:GetActivityData(iter_19_3):IsActivitying() then
			local var_19_5 = TaskTools:GetActivityTaskList(iter_19_3) or {}

			for iter_19_4, iter_19_5 in pairs(var_19_5) do
				table.insert(var_19_2, iter_19_5)
			end
		else
			local var_19_6 = AssignmentCfg.get_id_list_by_activity_id[iter_19_3]

			for iter_19_6, iter_19_7 in ipairs(var_19_6) do
				local var_19_7 = TaskData2:ParserData({
					complete_flag = 0,
					progress = 0,
					id = iter_19_7
				})

				table.insert(var_19_3, var_19_7)
			end
		end
	end

	local var_19_8 = {}
	local var_19_9 = {}
	local var_19_10 = {}

	for iter_19_8, iter_19_9 in pairs(var_19_2) do
		local var_19_11 = iter_19_9.id
		local var_19_12 = AssignmentCfg[var_19_11]

		if iter_19_9.complete_flag >= 1 then
			table.insert(var_19_10, iter_19_9)
		elseif iter_19_9.progress >= var_19_12.need then
			table.insert(var_19_8, iter_19_9)
		else
			table.insert(var_19_9, iter_19_9)
		end
	end

	local function var_19_13(arg_20_0, arg_20_1)
		local var_20_0 = AssignmentCfg[arg_20_0.id]
		local var_20_1 = AssignmentCfg[arg_20_1.id]

		if var_20_0.type ~= var_20_1.type then
			return var_20_0.type < var_20_1.type
		end

		return arg_20_0.id < arg_20_1.id
	end

	table.sort(var_19_8, var_19_13)
	table.sort(var_19_9, var_19_13)
	table.sort(var_19_10, var_19_13)
	table.sort(var_19_3, var_19_13)
	table.insertto(arg_19_0.list_, var_19_8)
	table.insertto(arg_19_0.list_, var_19_9)
	table.insertto(arg_19_0.list_, var_19_10)
	table.insertto(arg_19_0.list_, var_19_3)
	arg_19_0.scrollHelper_:StartScroll(#arg_19_0.list_)

	if #var_19_8 > 0 then
		arg_19_0.clearCon_:SetSelectedState("true")
	else
		arg_19_0.clearCon_:SetSelectedState("false")
	end

	arg_19_0:StartTaskTimer()
end

function var_0_0.StartTaskTimer(arg_21_0)
	arg_21_0:StopTaskTimer()

	arg_21_0.taskTimer_ = Timer.New(function()
		local var_22_0 = manager.time:GetServerTime()

		for iter_22_0, iter_22_1 in ipairs(arg_21_0.scrollHelper_:GetItemList()) do
			iter_22_1:RefreshTime(var_22_0)
		end
	end, 1, -1)

	arg_21_0.taskTimer_:Start()
end

function var_0_0.StopTaskTimer(arg_23_0)
	if arg_23_0.taskTimer_ then
		arg_23_0.taskTimer_:Stop()

		arg_23_0.taskTimer_ = nil
	end
end

function var_0_0.IsActivitying(arg_24_0)
	local var_24_0 = manager.time:GetServerTime()

	if var_24_0 < arg_24_0.startTime_ then
		local var_24_1 = GetTips("OPEN_TIME")

		ShowTips(string.format(var_24_1, manager.time:GetLostTimeStr2(arg_24_0.startTime_, nil, true)))

		return false
	end

	if var_24_0 >= arg_24_0.stopTime_ then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

function var_0_0.IsOpenTime(arg_25_0)
	return ActivityQuizTools.IsInOpenTimeSpan()
end

function var_0_0.OnActivityQuizStartMarch(arg_26_0)
	ActivityQuizTools.SetCurActivityID(arg_26_0.activityID_, "qworld")
	JumpTools.OpenPageByJump("activityQuizMatchPop", {
		activityId = arg_26_0.activityID_
	})
end

function var_0_0.OnTop(arg_27_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnBehind(arg_28_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_29_0)
	arg_29_0:RemoveAllListeners()
	arg_29_0:StopTimer()
	arg_29_0:StopTaskTimer()

	for iter_29_0, iter_29_1 in pairs(arg_29_0.scrollHelper_:GetItemList()) do
		iter_29_1:OnExit()
	end
end

function var_0_0.Dispose(arg_30_0)
	arg_30_0:RemoveAllListeners()

	for iter_30_0, iter_30_1 in pairs(arg_30_0.scrollHelper_:GetItemList()) do
		iter_30_1:Dispose()
	end

	arg_30_0.scrollHelper_:Dispose()
	arg_30_0.super.Dispose(arg_30_0)
end

return var_0_0
