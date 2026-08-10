local var_0_0 = class("SpringFestivalRiddleAnswerItem", ReduxView)

var_0_0.STATE = {
	CAN_CHOICE = 1,
	FINISH = 4,
	LOCK = 2,
	PENALTY = 3
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "Abtn")
end

function var_0_0.OnEnter(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.activityID_ = arg_2_1
	arg_2_0.questionID_ = arg_2_2

	local var_2_0 = ActivitySpringFestivalRiddleCfg[arg_2_2].answer_list[arg_2_0.index_]

	arg_2_0.answerText_.text = GetI18NText(var_2_0)
end

function var_0_0.OnExit(arg_3_0)
	return
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		if arg_5_0.state_ == var_0_0.STATE.FINISH then
			return
		end

		if not SpringFestivalRiddleData:CanAnswer(arg_5_0.activityID_) then
			ShowTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_FINISH")

			return
		end

		if arg_5_0.state_ == var_0_0.STATE.PENALTY then
			local var_6_0 = GameSetting.activity_spring_festival_riddle_punish_time.value[1]
			local var_6_1 = SpringFestivalRiddleData:GetLastAnswerTime(arg_5_0.activityID_) + var_6_0 * 60
			local var_6_2 = GameSetting.refresh_time1.value[1][1]
			local var_6_3 = manager.time:GetNextTime(var_6_2, 0, 0)

			if var_6_3 < var_6_1 then
				var_6_1 = var_6_3
			end

			if var_6_1 > manager.time:GetServerTime() then
				ShowTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_BAN")

				return
			end
		end

		SpringFestivalRiddleAction.ChoiceAnswer(arg_5_0.activityID_, arg_5_0.questionID_, arg_5_0.index_, function(arg_7_0)
			if isSuccess(arg_7_0.result) then
				local var_7_0 = ActivitySpringFestivalRiddleCfg[arg_5_0.questionID_].correct_answer == arg_5_0.index_

				SpringFestivalRiddleData:SubmitRiddle(arg_5_0.activityID_, arg_5_0.questionID_, arg_5_0.index_, var_7_0)

				if var_7_0 then
					local var_7_1 = #SpringFestivalRiddleData:GetReceiveList(arg_5_0.activityID_)
					local var_7_2 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_5_0.activityID_][var_7_1]
					local var_7_3 = arg_7_0.reward_list

					SpringFestivalRiddleData:ReceiveReward(arg_5_0.activityID_, var_7_2)
					getReward2(var_7_3)
				else
					manager.audio:PlayUIAudio(7)
					manager.notify:Invoke(SPRING_FESTIVAL_RIDDLE_ANSWER_ERROR)
				end

				SpringFestivalRiddleAction.RefreshRedPoint(arg_5_0.activityID_)
				manager.notify:Invoke(SPRING_FESTIVAL_RIDDLE_UPDATE)
			else
				ShowTips(arg_7_0.result)
			end
		end)
	end)
end

function var_0_0.RefreshItemEnabled(arg_8_0, arg_8_1)
	local var_8_0 = SpringFestivalRiddleData:GetQuestionAnswerList(arg_8_0.activityID_, arg_8_0.questionID_)

	if SpringFestivalRiddleData:IsCorrectAnswer(arg_8_0.activityID_, arg_8_0.questionID_) then
		if ActivitySpringFestivalRiddleCfg[arg_8_0.questionID_].correct_answer == arg_8_0.index_ then
			arg_8_0.controller_:SetSelectedState("correct")
		else
			arg_8_0.controller_:SetSelectedState("normal")
		end

		arg_8_0:FinishState()

		return
	end

	if table.keyof(var_8_0, arg_8_0.index_) then
		if ActivitySpringFestivalRiddleCfg[arg_8_0.questionID_].correct_answer == arg_8_0.index_ then
			arg_8_0.controller_:SetSelectedState("correct")
		else
			arg_8_0.controller_:SetSelectedState("error")
		end
	else
		arg_8_0.controller_:SetSelectedState("normal")
	end

	if table.keyof(var_8_0, arg_8_0.index_) then
		arg_8_0:FinishState()

		return
	end

	if not SpringFestivalRiddleData:CanAnswer(arg_8_0.activityID_) then
		arg_8_0:LockState()

		return
	end

	if arg_8_1 == false then
		arg_8_0:PenaltyState()
	else
		arg_8_0:CanChoiceState()
	end
end

function var_0_0.FinishState(arg_9_0)
	arg_9_0.btn_.interactable = false
	arg_9_0.state_ = var_0_0.STATE.FINISH
end

function var_0_0.LockState(arg_10_0)
	arg_10_0.btn_.interactable = true
	arg_10_0.state_ = var_0_0.STATE.LOCK
end

function var_0_0.PenaltyState(arg_11_0)
	arg_11_0.btn_.interactable = true
	arg_11_0.state_ = var_0_0.STATE.PENALTY
end

function var_0_0.CanChoiceState(arg_12_0)
	arg_12_0.btn_.interactable = true
	arg_12_0.state_ = var_0_0.STATE.CAN_CHOICE
end

return var_0_0
