local var_0_0 = class("SpringFestivalQuestionView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/Riddle/RiddleQuestionUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.answerItemList_ = {}

	for iter_3_0 = 1, 4 do
		arg_3_0.answerItemList_[iter_3_0] = SpringFestivalRiddleAnswerItem.New(arg_3_0[string.format("answerGo%s_", iter_3_0)], iter_3_0)
	end

	arg_3_0.riddleUpdateHandler_ = handler(arg_3_0, arg_3_0.RefreshRiddleItem)
	arg_3_0.riddleAnswerTipsHandler_ = handler(arg_3_0, arg_3_0.ShowAnswerTips)
	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.transform_, "name")
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.activityID_ = arg_4_0.params_.activityID
	arg_4_0.questionID_ = arg_4_0.params_.questionID

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.answerItemList_) do
		iter_4_1:OnEnter(arg_4_0.activityID_, arg_4_0.questionID_)
	end

	arg_4_0.questionText_.text = GetI18NText(ActivitySpringFestivalRiddleCfg[arg_4_0.questionID_].question)

	SetActive(arg_4_0.tipsGo_, false)
	arg_4_0:AddTimer()
	manager.notify:RegistListener(SPRING_FESTIVAL_RIDDLE_UPDATE, arg_4_0.riddleUpdateHandler_)
	manager.notify:RegistListener(SPRING_FESTIVAL_RIDDLE_ANSWER_ERROR, arg_4_0.riddleAnswerTipsHandler_)
end

function var_0_0.OnExit(arg_5_0)
	manager.notify:RemoveListener(SPRING_FESTIVAL_RIDDLE_UPDATE, arg_5_0.riddleUpdateHandler_)
	manager.notify:RemoveListener(SPRING_FESTIVAL_RIDDLE_ANSWER_ERROR, arg_5_0.riddleAnswerTipsHandler_)
	arg_5_0:StopTimer()
	arg_5_0:StopTipsTimer()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.answerItemList_) do
		iter_5_1:OnExit()
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.riddleUpdateHandler_ = nil
	arg_6_0.riddleAnswerTipsHandler_ = nil

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.answerItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.answerItemList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.RefreshRiddleItem(arg_9_0)
	arg_9_0:AddTimer()
end

function var_0_0.RefreshItemEnabled(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.answerItemList_) do
		iter_10_1:RefreshItemEnabled(arg_10_1)
	end
end

function var_0_0.ShowAnswerTips(arg_11_0)
	local var_11_0 = string.format(GetTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_ERROR_CD"), GameSetting.activity_spring_festival_riddle_punish_time.value[1])

	arg_11_0.tipsText_.text = GetI18NText(var_11_0)

	SetActive(arg_11_0.tipsGo_, true)
	arg_11_0:AddTipsTimer()
end

function var_0_0.AddTimer(arg_12_0)
	arg_12_0:StopTimer()

	local var_12_0 = SpringFestivalRiddleData:GetLastAnswerTime(arg_12_0.activityID_)
	local var_12_1 = var_12_0 + GameSetting.activity_spring_festival_riddle_punish_time.value[1] * 60
	local var_12_2 = GameSetting.refresh_time1.value[1][1]
	local var_12_3 = manager.time:GetNextTime(var_12_2, 0, 0)

	if var_12_3 < var_12_1 then
		var_12_1 = var_12_3
	end

	if var_12_1 <= manager.time:GetServerTime() or var_12_3 - var_12_0 > 86400 then
		arg_12_0:RefreshItemEnabled(true)
		arg_12_0.controller_:SetSelectedState("false")

		return
	end

	arg_12_0:RefreshItemEnabled(false)

	if SpringFestivalRiddleData:CanAnswer(arg_12_0.activityID_) then
		arg_12_0.controller_:SetSelectedState("true")
	else
		arg_12_0.controller_:SetSelectedState("false")
	end

	arg_12_0.timeText_.text = string.format(GetTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_CD"), manager.time:GetLostTimeStr(var_12_1, true))
	arg_12_0.timer_ = Timer.New(function()
		var_12_3 = manager.time:GetNextTime(var_12_2, 0, 0)

		if var_12_1 <= manager.time:GetServerTime() or var_12_3 - var_12_0 > 86400 then
			arg_12_0:RefreshItemEnabled(true)
			arg_12_0.controller_:SetSelectedState("false")
			arg_12_0:StopTimer()

			return
		end

		arg_12_0.timeText_.text = string.format(GetTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_CD"), manager.time:GetLostTimeStr(var_12_1, true))
	end, 1, -1)

	arg_12_0.timer_:Start()
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()

		arg_14_0.timer_ = nil
	end
end

function var_0_0.AddTipsTimer(arg_15_0)
	arg_15_0:StopTipsTimer()

	arg_15_0.tipsTimer_ = Timer.New(function()
		arg_15_0:StopTipsTimer()
		SetActive(arg_15_0.tipsGo_, false)
	end, 1, 1)

	arg_15_0.tipsTimer_:Start()
end

function var_0_0.StopTipsTimer(arg_17_0)
	if arg_17_0.tipsTimer_ then
		arg_17_0.tipsTimer_:Stop()

		arg_17_0.tipsTimer_ = nil
	end
end

return var_0_0
