local SpringFestivalQuestionView = class("SpringFestivalQuestionView", ReduxView)

function SpringFestivalQuestionView:UIName()
	return "UI/EmptyDream/Riddle/RiddleQuestionUI"
end

function SpringFestivalQuestionView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringFestivalQuestionView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.answerItemList_ = {}

	for iter_3_0 = 1, 4 do
		self.answerItemList_[iter_3_0] = SpringFestivalRiddleAnswerItem.New(self[string.format("answerGo%s_", iter_3_0)], iter_3_0)
	end

	self.riddleUpdateHandler_ = handler(self, self.RefreshRiddleItem)
	self.riddleAnswerTipsHandler_ = handler(self, self.ShowAnswerTips)
	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function SpringFestivalQuestionView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.questionID_ = self.params_.questionID

	for iter_4_0, iter_4_1 in ipairs(self.answerItemList_) do
		iter_4_1:OnEnter(self.activityID_, self.questionID_)
	end

	self.questionText_.text = GetI18NText(ActivitySpringFestivalRiddleCfg[self.questionID_].question)

	SetActive(self.tipsGo_, false)
	self:AddTimer()
	manager.notify:RegistListener(SPRING_FESTIVAL_RIDDLE_UPDATE, self.riddleUpdateHandler_)
	manager.notify:RegistListener(SPRING_FESTIVAL_RIDDLE_ANSWER_ERROR, self.riddleAnswerTipsHandler_)
end

function SpringFestivalQuestionView:OnExit()
	manager.notify:RemoveListener(SPRING_FESTIVAL_RIDDLE_UPDATE, self.riddleUpdateHandler_)
	manager.notify:RemoveListener(SPRING_FESTIVAL_RIDDLE_ANSWER_ERROR, self.riddleAnswerTipsHandler_)
	self:StopTimer()
	self:StopTipsTimer()

	for iter_5_0, iter_5_1 in ipairs(self.answerItemList_) do
		iter_5_1:OnExit()
	end
end

function SpringFestivalQuestionView:Dispose()
	SpringFestivalQuestionView.super.Dispose(self)

	self.riddleUpdateHandler_ = nil
	self.riddleAnswerTipsHandler_ = nil

	for iter_6_0, iter_6_1 in ipairs(self.answerItemList_) do
		iter_6_1:Dispose()
	end

	self.answerItemList_ = nil
end

function SpringFestivalQuestionView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function SpringFestivalQuestionView:RefreshRiddleItem()
	self:AddTimer()
end

function SpringFestivalQuestionView:RefreshItemEnabled(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self.answerItemList_) do
		iter_10_1:RefreshItemEnabled(arg_10_1)
	end
end

function SpringFestivalQuestionView:ShowAnswerTips()
	self.tipsText_.text = GetI18NText((string.format(GetTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_ERROR_CD"), GameSetting.activity_spring_festival_riddle_punish_time.value[1])))

	SetActive(self.tipsGo_, true)
	self:AddTipsTimer()
end

function SpringFestivalQuestionView:AddTimer()
	self:StopTimer()

	local var_12_0 = SpringFestivalRiddleData:GetLastAnswerTime(self.activityID_)
	local var_12_1 = var_12_0 + GameSetting.activity_spring_festival_riddle_punish_time.value[1] * 60
	local var_12_2 = GameSetting.refresh_time1.value[1][1]
	local var_12_3 = manager.time:GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0)

	if var_12_3 < var_12_0 + GameSetting.activity_spring_festival_riddle_punish_time.value[1] * 60 then
		var_12_1 = var_12_3
	end

	if var_12_1 <= manager.time:GetServerTime() or var_12_3 - var_12_0 > 86400 then
		self:RefreshItemEnabled(true)
		self.controller_:SetSelectedState("false")

		return
	end

	self:RefreshItemEnabled(false)

	if SpringFestivalRiddleData:CanAnswer(self.activityID_) then
		self.controller_:SetSelectedState("true")
	else
		self.controller_:SetSelectedState("false")
	end

	self.timeText_.text = string.format(GetTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_CD"), manager.time:GetLostTimeStr(var_12_1, true))
	self.timer_ = Timer.New(function()
		var_12_3 = manager.time:GetNextTime(var_12_2, 0, 0)

		if var_12_1 <= manager.time:GetServerTime() or var_12_3 - var_12_0 > 86400 then
			self:RefreshItemEnabled(true)
			self.controller_:SetSelectedState("false")
			self:StopTimer()

			return
		end

		self.timeText_.text = string.format(GetTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_CD"), manager.time:GetLostTimeStr(var_12_1, true))
	end, 1, -1)

	self.timer_:Start()
end

function SpringFestivalQuestionView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SpringFestivalQuestionView:AddTipsTimer()
	self:StopTipsTimer()

	self.tipsTimer_ = Timer.New(function()
		self:StopTipsTimer()
		SetActive(self.tipsGo_, false)
	end, 1, 1)

	self.tipsTimer_:Start()
end

function SpringFestivalQuestionView:StopTipsTimer()
	if self.tipsTimer_ then
		self.tipsTimer_:Stop()

		self.tipsTimer_ = nil
	end
end

return SpringFestivalQuestionView
