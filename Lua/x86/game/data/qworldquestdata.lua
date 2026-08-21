local var_0_0 = singletonClass("QWorldQuestData")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.questData_ = {}
	arg_1_0.mainQuestData_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.questData_ = {}
	arg_2_0.mainQuestData_ = {}

	arg_2_0:UpdateQuest(arg_2_1)
end

function var_0_0.UpdateQuest(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1.quest_list) do
		local var_3_0 = arg_3_0.mainQuestData_[iter_3_1.id]

		if not var_3_0 then
			var_3_0 = {
				id = iter_3_1.id,
				taskIdList = {}
			}
			arg_3_0.mainQuestData_[var_3_0.id] = var_3_0
		end

		var_3_0.status = iter_3_1.status
		var_3_0.expired_timestamp = iter_3_1.expired_timestamp

		for iter_3_2, iter_3_3 in ipairs(iter_3_1.task_list) do
			local var_3_1 = arg_3_0.questData_[iter_3_3.id]

			if not var_3_1 then
				var_3_1 = {
					id = iter_3_3.id
				}
				arg_3_0.questData_[var_3_1.id] = var_3_1

				table.insert(var_3_0.taskIdList, var_3_1.id)
			end

			var_3_1.status = iter_3_3.status
			var_3_1.progress = iter_3_3.progress
		end
	end
end

function var_0_0.FinishMainQuest(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0:GetMainQuestData(iter_4_1).status = QWorldQuestConst.MAIN_QUEST_STATUS.FINISH
	end
end

function var_0_0.FinishQuest(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		arg_5_0:GetQuestData(iter_5_1).status = QWorldQuestConst.QUEST_STATUS.FINISH
	end
end

function var_0_0.CancelMainQuest(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1.quest_id_list) do
		arg_6_0.mainQuestData_[iter_6_1] = nil
	end
end

function var_0_0.TakeMainQuest(arg_7_0, arg_7_1)
	arg_7_0:GetMainQuestData(arg_7_1).status = QWorldQuestConst.MAIN_QUEST_STATUS.IN_PROGRESS
end

function var_0_0.GetQuestData(arg_8_0, arg_8_1)
	return arg_8_0.questData_[arg_8_1]
end

function var_0_0.GetMainQuestData(arg_9_0, arg_9_1)
	return arg_9_0.mainQuestData_[arg_9_1]
end

function var_0_0.GetMainQuestTrackingIdRaw(arg_10_0)
	return getData("qworld", "tracking_quest_id") or -1
end

function var_0_0.SetMainQuestTrackingId(arg_11_0, arg_11_1)
	saveData("qworld", "tracking_quest_id", arg_11_1)
end

return var_0_0
