local var_0_0 = singletonClass("SpringFestivalRiddleData")

function var_0_0.Init(arg_1_0)
	arg_1_0.activityRiddleList_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.admitted_award) do
		table.insert(var_2_1, iter_2_1)
	end

	local var_2_2 = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.answer_history) do
		local var_2_3 = {}

		for iter_2_4, iter_2_5 in ipairs(iter_2_3.answer) do
			table.insert(var_2_3, iter_2_5)
		end

		var_2_2[iter_2_3.quiz_id] = {
			answerList = var_2_3,
			correct = iter_2_3.correct == 1
		}
	end

	for iter_2_6, iter_2_7 in ipairs(ActivitySpringFestivalRiddleCfg.get_id_list_by_activity_id[var_2_0]) do
		if var_2_2[iter_2_7] == nil then
			var_2_2[iter_2_7] = {
				correct = false,
				answerList = {}
			}
		end
	end

	arg_2_0.activityRiddleList_[var_2_0] = {
		canAnswer = arg_2_1.is_today_answer == 0,
		riddleList = var_2_2,
		rewardList = var_2_1,
		lastQuestionID = arg_2_1.last_answer_quiz,
		lastAnswerTime = arg_2_1.last_answer_time
	}
end

function var_0_0.CanAnswer(arg_3_0, arg_3_1)
	return arg_3_0.activityRiddleList_[arg_3_1].canAnswer
end

function var_0_0.GetQuestionAnswerList(arg_4_0, arg_4_1, arg_4_2)
	return arg_4_0.activityRiddleList_[arg_4_1].riddleList[arg_4_2].answerList or {}
end

function var_0_0.IsCorrectAnswer(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_0.activityRiddleList_[arg_5_1].riddleList[arg_5_2].correct or false
end

function var_0_0.GetLastAnswerTime(arg_6_0, arg_6_1)
	return arg_6_0.activityRiddleList_[arg_6_1].lastAnswerTime or 0
end

function var_0_0.ReceiveReward(arg_7_0, arg_7_1, arg_7_2)
	table.insert(arg_7_0.activityRiddleList_[arg_7_1].rewardList, arg_7_2)
end

function var_0_0.GetReceiveList(arg_8_0, arg_8_1)
	return arg_8_0.activityRiddleList_[arg_8_1].rewardList
end

function var_0_0.SubmitRiddle(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	table.insert(arg_9_0.activityRiddleList_[arg_9_1].riddleList[arg_9_2].answerList, arg_9_3)

	arg_9_0.activityRiddleList_[arg_9_1].lastQuestionID = arg_9_2
	arg_9_0.activityRiddleList_[arg_9_1].lastAnswerTime = manager.time:GetServerTime()

	if arg_9_4 then
		arg_9_0.activityRiddleList_[arg_9_1].canAnswer = false
		arg_9_0.activityRiddleList_[arg_9_1].riddleList[arg_9_2].correct = true

		local var_9_0 = arg_9_0.activityRiddleList_[arg_9_1].rewardList
		local var_9_1 = arg_9_0:GetCorrectCnt(arg_9_1)

		if table.keyof(var_9_0, var_9_1) == nil then
			table.insert(var_9_0, var_9_1)
		end
	end
end

function var_0_0.GetCorrectCnt(arg_10_0, arg_10_1)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in pairs(arg_10_0.activityRiddleList_[arg_10_1].riddleList) do
		if iter_10_1.correct == true then
			var_10_0 = var_10_0 + 1
		end
	end

	return var_10_0
end

return var_0_0
