local SpringFestivalRiddleAnswerItem = class("SpringFestivalRiddleAnswerItem", ReduxView)

SpringFestivalRiddleAnswerItem.STATE = {
	CAN_CHOICE = 1,
	FINISH = 4,
	LOCK = 2,
	PENALTY = 3
}

function SpringFestivalRiddleAnswerItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "Abtn")
end

function SpringFestivalRiddleAnswerItem:OnEnter(arg_2_1, arg_2_2)
	self.activityID_ = arg_2_1
	self.questionID_ = arg_2_2
	self.answerText_.text = GetI18NText(ActivitySpringFestivalRiddleCfg[arg_2_2].answer_list[self.index_])
end

function SpringFestivalRiddleAnswerItem:OnExit()
	return
end

function SpringFestivalRiddleAnswerItem:Dispose()
	SpringFestivalRiddleAnswerItem.super.Dispose(self)
end

function SpringFestivalRiddleAnswerItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.state_ == SpringFestivalRiddleAnswerItem.STATE.FINISH then
			return
		end

		if not SpringFestivalRiddleData:CanAnswer(self.activityID_) then
			ShowTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_FINISH")

			return
		end

		if self.state_ == SpringFestivalRiddleAnswerItem.STATE.PENALTY then
			local var_6_0 = SpringFestivalRiddleData:GetLastAnswerTime(self.activityID_) + GameSetting.activity_spring_festival_riddle_punish_time.value[1] * 60
			local var_6_1 = manager.time:GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0)

			if var_6_1 < var_6_0 then
				var_6_0 = var_6_1
			end

			if var_6_0 > manager.time:GetServerTime() then
				ShowTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_BAN")

				return
			end
		end

		SpringFestivalRiddleAction.ChoiceAnswer(self.activityID_, self.questionID_, self.index_, function(arg_7_0)
			if isSuccess(arg_7_0.result) then
				local var_7_0 = ActivitySpringFestivalRiddleCfg[self.questionID_].correct_answer == self.index_

				SpringFestivalRiddleData:SubmitRiddle(self.activityID_, self.questionID_, self.index_, ActivitySpringFestivalRiddleCfg[self.questionID_].correct_answer == self.index_)

				if var_7_0 then
					SpringFestivalRiddleData:ReceiveReward(self.activityID_, ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID_][#SpringFestivalRiddleData:GetReceiveList(self.activityID_)])
					getReward2(arg_7_0.reward_list)
				else
					manager.audio:PlayUIAudio(7)
					manager.notify:Invoke(SPRING_FESTIVAL_RIDDLE_ANSWER_ERROR)
				end

				SpringFestivalRiddleAction.RefreshRedPoint(self.activityID_)
				manager.notify:Invoke(SPRING_FESTIVAL_RIDDLE_UPDATE)
			else
				ShowTips(arg_7_0.result)
			end
		end)
	end)
end

function SpringFestivalRiddleAnswerItem:RefreshItemEnabled(arg_8_1)
	local var_8_0 = SpringFestivalRiddleData:GetQuestionAnswerList(self.activityID_, self.questionID_)

	if SpringFestivalRiddleData:IsCorrectAnswer(self.activityID_, self.questionID_) then
		if ActivitySpringFestivalRiddleCfg[self.questionID_].correct_answer == self.index_ then
			self.controller_:SetSelectedState("correct")
		else
			self.controller_:SetSelectedState("normal")
		end

		self:FinishState()

		return
	end

	if table.keyof(var_8_0, self.index_) then
		if ActivitySpringFestivalRiddleCfg[self.questionID_].correct_answer == self.index_ then
			self.controller_:SetSelectedState("correct")
		else
			self.controller_:SetSelectedState("error")
		end
	else
		self.controller_:SetSelectedState("normal")
	end

	if table.keyof(var_8_0, self.index_) then
		self:FinishState()

		return
	end

	if not SpringFestivalRiddleData:CanAnswer(self.activityID_) then
		self:LockState()

		return
	end

	if arg_8_1 == false then
		self:PenaltyState()
	else
		self:CanChoiceState()
	end
end

function SpringFestivalRiddleAnswerItem:FinishState()
	self.btn_.interactable = false
	self.state_ = SpringFestivalRiddleAnswerItem.STATE.FINISH
end

function SpringFestivalRiddleAnswerItem:LockState()
	self.btn_.interactable = true
	self.state_ = SpringFestivalRiddleAnswerItem.STATE.LOCK
end

function SpringFestivalRiddleAnswerItem:PenaltyState()
	self.btn_.interactable = true
	self.state_ = SpringFestivalRiddleAnswerItem.STATE.PENALTY
end

function SpringFestivalRiddleAnswerItem:CanChoiceState()
	self.btn_.interactable = true
	self.state_ = SpringFestivalRiddleAnswerItem.STATE.CAN_CHOICE
end

return SpringFestivalRiddleAnswerItem
