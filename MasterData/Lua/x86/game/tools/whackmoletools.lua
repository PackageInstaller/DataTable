local var_0_0 = {}

function var_0_0.InitConst(arg_1_0)
	var_0_0.taskIDDic = var_0_0.taskIDDIc or {}

	for iter_1_0, iter_1_1 in ipairs(ActivityCfg[arg_1_0].sub_activity_list) do
		if ActivityCfg[iter_1_1].activity_template == ActivityTemplateConst.TASK then
			var_0_0.taskIDDic[arg_1_0] = iter_1_1
		end
	end

	var_0_0.sessionCfg = var_0_0.sesstionCfg or {}
	var_0_0.sessionCfg[arg_1_0] = var_0_0.sessionCfg[arg_1_0] or {}

	local var_1_0 = {}
	local var_1_1 = 0

	for iter_1_2, iter_1_3 in ipairs(ActivityWhackMoleCfg.get_id_list_by_activity_id[arg_1_0]) do
		if not var_1_0[ActivityWhackMoleCfg[iter_1_3].session] and ActivityWhackMoleCfg[iter_1_3].type ~= WhackMoleConst.STAGE_TYPE.CHESS then
			var_1_1 = var_1_1 + 1

			local var_1_2 = {
				conditionID = ActivityWhackMoleCfg[iter_1_3].session,
				whackMoleIDList = {},
				sessionIndex = var_1_1
			}

			var_1_0[ActivityWhackMoleCfg[iter_1_3].session] = var_1_2
			var_0_0.sessionCfg[arg_1_0][var_1_1] = var_1_2
		end

		if ActivityWhackMoleCfg[iter_1_3].type ~= WhackMoleConst.STAGE_TYPE.CHESS then
			table.insert(var_1_0[ActivityWhackMoleCfg[iter_1_3].session].whackMoleIDList, iter_1_3)
		end
	end
end

function var_0_0.GetSessionList(arg_2_0)
	local var_2_0 = {}

	if not var_0_0.sessionCfg[arg_2_0] then
		return var_2_0
	end

	for iter_2_0, iter_2_1 in ipairs(var_0_0.sessionCfg[arg_2_0]) do
		var_2_0[iter_2_0] = iter_2_1.conditionID
	end

	return var_2_0
end

function var_0_0.GetSessionIsLock(arg_3_0, arg_3_1)
	if not var_0_0.sessionCfg[arg_3_0] or not var_0_0.sessionCfg[arg_3_0][arg_3_1] then
		return true
	end

	return var_0_0.GetSessionIsLockByID((var_0_0.GetSessionID(arg_3_0, arg_3_1)))
end

function var_0_0.GetSessionID(arg_4_0, arg_4_1)
	if not var_0_0.sessionCfg[arg_4_0] or not var_0_0.sessionCfg[arg_4_0][arg_4_1] then
		return 0
	end

	return var_0_0.sessionCfg[arg_4_0][arg_4_1].conditionID
end

function var_0_0.GetSessionIsLockByID(arg_5_0)
	return not IsConditionAchieved(ActivitySummerChessConditionCfg[arg_5_0].condition)
end

function var_0_0.GetSessionIsFirstEnter(arg_6_0, arg_6_1)
	return not WhackMoleTools.GetSessionIsLock(arg_6_0, arg_6_1) and not WhackMoleData:GetHadEntered(arg_6_0, arg_6_1)
end

function var_0_0.GetStageIsLock(arg_7_0)
	if ActivityWhackMoleCfg[arg_7_0].pre_level and ActivityWhackMoleCfg[arg_7_0].pre_level ~= 0 and not WhackMoleData:IsCompletedStage(ActivityWhackMoleCfg[arg_7_0].pre_level) then
		return true
	else
		return false
	end
end

function var_0_0.GetSessionStageList(arg_8_0, arg_8_1)
	if not var_0_0.sessionCfg[arg_8_0] or not var_0_0.sessionCfg[arg_8_0][arg_8_1] then
		return {}
	end

	return var_0_0.sessionCfg[arg_8_0][arg_8_1].whackMoleIDList
end

function var_0_0.GetTaskID(arg_9_0)
	return var_0_0.taskIDDic[arg_9_0] or 0
end

function var_0_0.SetLastSessionIndex(arg_10_0)
	var_0_0.lastSessionIndex = arg_10_0
end

function var_0_0.GetLastSessionIndex()
	return var_0_0.lastSessionIndex
end

return var_0_0
