local var_0_0 = singletonClass("DestroyBoxGameData")

var_0_0.CHALLENGE_MAX_HARD_LEVEL = 2
var_0_0.SPECTIAL_HARD_LEVEL = 9

function var_0_0.Init(arg_1_0)
	arg_1_0.boxStageData_ = {}
	arg_1_0.receiveRewardList_ = {}
	arg_1_0.boxDifficultList_ = {}

	arg_1_0:ParseCfg()

	arg_1_0.curSelectID_ = {}
	arg_1_0.curSelectDifficult_ = {}
	arg_1_0.lastSelectNormalID_ = {}
end

function var_0_0.ParseCfg(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(DestroyBoxGameCfg.get_id_list_by_main_activity_id) do
		arg_2_0.boxDifficultList_[iter_2_0] = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
			local var_2_0 = DestroyBoxGameCfg[iter_2_3].difficult

			if arg_2_0.boxDifficultList_[iter_2_0][var_2_0] == nil then
				arg_2_0.boxDifficultList_[iter_2_0][var_2_0] = {}
			end

			table.insert(arg_2_0.boxDifficultList_[iter_2_0][var_2_0], iter_2_3)
		end
	end
end

function var_0_0.InitData(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.main_activity_id

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.stage_info_list) do
		local var_3_1 = iter_3_1.id

		arg_3_0.boxStageData_[var_3_1] = {
			isSuccess = iter_3_1.is_success,
			maxScore = iter_3_1.history_max_score
		}
	end

	arg_3_0.receiveRewardList_[var_3_0] = {}

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.got_reward_id_list) do
		table.insert(arg_3_0.receiveRewardList_[var_3_0], iter_3_3)
	end

	DestroyBoxGameAction.UpdateAllRedPoint(var_3_0)
	arg_3_0:UpdateRewardRedPoint(var_3_0)
end

function var_0_0.GetDifficultList(arg_4_0, arg_4_1)
	return arg_4_0.boxDifficultList_[arg_4_1]
end

function var_0_0.GetStageData(arg_5_0, arg_5_1)
	return arg_5_0.boxStageData_[arg_5_1]
end

function var_0_0.GetReceiveRewardList(arg_6_0, arg_6_1)
	return arg_6_0.receiveRewardList_[arg_6_1]
end

function var_0_0.UpdateReceiveRewardList(arg_7_0, arg_7_1, arg_7_2)
	table.insertto(arg_7_0.receiveRewardList_[arg_7_1], arg_7_2)
	arg_7_0:UpdateRewardRedPoint(arg_7_1)
end

function var_0_0.UpdateRewardRedPoint(arg_8_0, arg_8_1)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(DestroyBoxGameRewardCfg.get_id_list_by_main_activity_id[arg_8_1]) do
		local var_8_1 = DestroyBoxGameRewardCfg[iter_8_1]
		local var_8_2 = 0

		if DestroyBoxGameTools.IsUnlockReward(iter_8_1) and not table.keyof(arg_8_0.receiveRewardList_[arg_8_1], iter_8_1) then
			if var_8_1.need_show == 1 then
				var_8_0 = 1
			else
				var_8_2 = 1
			end
		end

		if var_8_1.need_show ~= 1 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_CHALLENGE_REWARD, var_8_1.activity_id), var_8_2)
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_REWARD, arg_8_1), var_8_0)
end

function var_0_0.IsClearStage(arg_9_0, arg_9_1)
	return arg_9_0.boxStageData_[arg_9_1] and arg_9_0.boxStageData_[arg_9_1].isSuccess or false
end

function var_0_0.IsFinishPreStage(arg_10_0, arg_10_1)
	local var_10_0 = DestroyBoxGameCfg[arg_10_1]
	local var_10_1 = var_10_0.main_activity_id

	if var_10_0.unlock_condition ~= "" then
		local var_10_2 = var_10_0.unlock_condition[1]
		local var_10_3 = var_10_0.unlock_condition[2]

		if arg_10_0.boxStageData_[var_10_2] and arg_10_0.boxStageData_[var_10_2].isSuccess and var_10_3 <= arg_10_0.boxStageData_[var_10_2].maxScore then
			return true
		end

		return false
	end

	return true
end

function var_0_0.RefreshScore(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.id
	local var_11_1 = arg_11_1.settle_score

	if arg_11_0.boxStageData_[var_11_0] then
		arg_11_0.boxStageData_[var_11_0].historyMaxScore = arg_11_0.boxStageData_[var_11_0].maxScore

		if var_11_1 > arg_11_0.boxStageData_[var_11_0].maxScore then
			arg_11_0.boxStageData_[var_11_0].maxScore = var_11_1
		end

		arg_11_0.boxStageData_[var_11_0].score = arg_11_1.settle_score
		arg_11_0.boxStageData_[var_11_0].isSuccess = true
	else
		arg_11_0.boxStageData_[arg_11_1.id] = {
			isSuccess = true,
			historyMaxScore = 0,
			maxScore = var_11_1,
			score = arg_11_1.settle_score
		}
	end

	local var_11_2 = DestroyBoxGameCfg[arg_11_1.id].main_activity_id

	DestroyBoxGameAction.UpdateAllRedPoint(var_11_2)
	arg_11_0:UpdateRewardRedPoint(var_11_2)
end

function var_0_0.SwitchDifficult(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = DestroyBoxGameCfg[arg_12_1]

	if var_12_0.difficult <= var_0_0.CHALLENGE_MAX_HARD_LEVEL then
		local var_12_1 = var_12_0.activity_id

		arg_12_1 = DestroyBoxGameCfg.get_id_list_by_activity_id[var_12_1][arg_12_2]
	else
		local var_12_2 = var_12_0.main_activity_id
		local var_12_3 = arg_12_0:GetLastSelectNormalID(var_12_2)
		local var_12_4 = DestroyBoxGameCfg[var_12_3]
		local var_12_5 = DestroyBoxGameCfg.get_id_list_by_activity_id[var_12_4.activity_id][arg_12_2]

		arg_12_0.lastSelectNormalID_[var_12_2] = var_12_5

		saveData("destroyBoxGame", string.format("lastSelectNormalID_%s", var_12_2), var_12_5)
	end

	return arg_12_1
end

function var_0_0.SetSelectIDAndDifficult(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0.curSelectID_[arg_13_1] = arg_13_2

	saveData("destroyBoxGame", string.format("id_%s", arg_13_1), arg_13_2)

	arg_13_0.curSelectDifficult_[arg_13_1] = arg_13_3 or arg_13_0.curSelectDifficult_[arg_13_1] or 1

	if DestroyBoxGameCfg[arg_13_2].difficult <= var_0_0.CHALLENGE_MAX_HARD_LEVEL then
		arg_13_0.lastSelectNormalID_[arg_13_1] = arg_13_2

		saveData("destroyBoxGame", string.format("lastSelectNormalID_%s", arg_13_1), arg_13_2)
	end
end

function var_0_0.GetSelectID(arg_14_0, arg_14_1)
	arg_14_0.curSelectID_[arg_14_1] = arg_14_0.curSelectID_[arg_14_1] or getData("destroyBoxGame", string.format("id_%s", arg_14_1)) or arg_14_0:GetCurMaxStageID(arg_14_1)

	return arg_14_0.curSelectID_[arg_14_1]
end

function var_0_0.GetSelectDifficult(arg_15_0, arg_15_1)
	if arg_15_0.curSelectDifficult_[arg_15_1] then
		return arg_15_0.curSelectDifficult_[arg_15_1]
	end

	local var_15_0 = arg_15_0:GetLastSelectNormalID(arg_15_1)
	local var_15_1 = DestroyBoxGameCfg[var_15_0]
	local var_15_2 = table.keyof(DestroyBoxGameCfg.get_id_list_by_activity_id[var_15_1.activity_id], var_15_0) or 1

	arg_15_0.curSelectDifficult_[arg_15_1] = var_15_2

	return var_15_2
end

function var_0_0.GetLastSelectNormalID(arg_16_0, arg_16_1)
	arg_16_0.lastSelectNormalID_[arg_16_1] = arg_16_0.lastSelectNormalID_[arg_16_1] or getData("destroyBoxGame", string.format("lastSelectNormalID_%s", arg_16_1)) or arg_16_0:GetCurMaxNormalStageID(arg_16_1)

	return arg_16_0.lastSelectNormalID_[arg_16_1]
end

function var_0_0.GetCurMaxStageID(arg_17_0, arg_17_1)
	local var_17_0

	for iter_17_0, iter_17_1 in ipairs(DestroyBoxGameCfg.get_id_list_by_main_activity_id[arg_17_1]) do
		if iter_17_0 == 1 and not arg_17_0:IsFinishFirstStage(DestroyBoxGameCfg[iter_17_1].activity_id) then
			return iter_17_1
		end

		if not arg_17_0:IsFinishPreStage(iter_17_1) then
			return var_17_0
		end

		var_17_0 = iter_17_1
	end

	return var_17_0
end

function var_0_0.GetCurMaxNormalStageID(arg_18_0, arg_18_1)
	local var_18_0

	for iter_18_0, iter_18_1 in ipairs(DestroyBoxGameCfg.get_id_list_by_main_activity_id[arg_18_1]) do
		if iter_18_0 == 1 and not arg_18_0:IsFinishFirstStage(DestroyBoxGameCfg[iter_18_1].activity_id) then
			return iter_18_1
		end

		if DestroyBoxGameCfg[iter_18_1].difficult <= var_0_0.CHALLENGE_MAX_HARD_LEVEL then
			if not arg_18_0:IsFinishPreStage(iter_18_1) then
				return iter_18_1
			end

			var_18_0 = iter_18_1
		end
	end

	return var_18_0
end

function var_0_0.IsFinishFirstStage(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(DestroyBoxGameCfg.get_id_list_by_activity_id[arg_19_1]) do
		if arg_19_0.boxStageData_[iter_19_1] and arg_19_0.boxStageData_[iter_19_1].isSuccess then
			return true
		end
	end

	return false
end

return var_0_0
