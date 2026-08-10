local var_0_0 = {}
local var_0_1

manager.net:Bind(75017, function(arg_1_0)
	var_0_1 = arg_1_0.open_edition

	MultHeartDemonData:InitMultHeartDemonData(arg_1_0)
	var_0_0.InitRedPointKey(arg_1_0.open_edition)
	var_0_0.UpdateRewardRedPoint()
	var_0_0.UpdateRefreshRedPoint(arg_1_0)
	manager.notify:CallUpdateFunc(MULT_HEART_DEMON_UPDATE)
end)
manager.net:Bind(75025, function(arg_2_0)
	MultHeartDemonData:UpdateBattleFinishScore(arg_2_0.score)
	manager.notify:CallUpdateFunc(MULT_HEART_DEMON_SCORE_UPDATE)
end)

function var_0_0.SaveTeam(arg_3_0)
	return manager.net:SendWithLoading(75020, arg_3_0, 75021):next(function(arg_4_0)
		var_0_0.OnSaveTeamCallback(arg_4_0, arg_3_0)

		return arg_4_0
	end)
end

function var_0_0.OnSaveTeamCallback(arg_5_0, arg_5_1)
	if isSuccess(arg_5_0.result) then
		MultHeartDemonData:InitHeroList(nil, arg_5_1.hero_id_list, arg_5_1.difficulty)
	else
		ShowTips(arg_5_0.result)
	end
end

function var_0_0.SaveBattle(arg_6_0)
	manager.net:SendWithLoadingNew(75022, arg_6_0, 75023, var_0_0.OnSaveBattleCallback)
end

function var_0_0.OnSaveBattleCallback(arg_7_0, arg_7_1)
	if isSuccess(arg_7_0.result) then
		-- block empty
	else
		ShowTips(arg_7_0.result)
	end
end

function var_0_0.Reset(arg_8_0)
	manager.net:SendWithLoadingNew(75026, arg_8_0, 75027, var_0_0.OnResetCallback)
end

function var_0_0.ResetPromise(arg_9_0)
	return manager.net:SendWithLoading(75026, arg_9_0, 75027):next(function(arg_10_0)
		var_0_0.OnResetCallback(arg_10_0, arg_9_0)

		return isSuccess(arg_10_0.result)
	end)
end

function var_0_0.OnResetCallback(arg_11_0, arg_11_1)
	if isSuccess(arg_11_0.result) then
		MultHeartDemonData:GiveUp(arg_11_1.difficulty)
		manager.notify:CallUpdateFunc(MULT_HEART_DEMON_UPDATE)
	else
		ShowTips(arg_11_0.result)
	end
end

function var_0_0.SendDataToServer(arg_12_0)
	manager.net:SendWithLoadingNew(75028, arg_12_0, 75029, var_0_0.OnSendDataToServerCallback)
end

function var_0_0.OnSendDataToServerCallback(arg_13_0, arg_13_1)
	if isSuccess(arg_13_0.result) then
		-- block empty
	else
		ShowTips(arg_13_0.result)
	end
end

function var_0_0.InitRedPointKey(arg_14_0)
	var_0_1 = arg_14_0

	manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(var_0_1), var_0_1), {
		RedPointConst.MULT_HEART_DEMON_REWARD,
		RedPointConst.MULT_HEART_DEMON_FIRST_VIEW
	})

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MULT_HEART_DEMON) then
		return
	end

	if getData("MULT_HEART_DEMON", "ENTER_VIEW" .. var_0_1) ~= "1" then
		manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(var_0_1), var_0_1), 1)
	end
end

function var_0_0.UpdateRefreshRedPoint(arg_15_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MULT_HEART_DEMON) then
		return
	end

	if var_0_1 == nil then
		return
	end

	local var_15_0 = getData("MULT_HEART_DEMON", "STAGE")
	local var_15_1 = getData("MULT_HEART_DEMON", "STAGE_VIEW")
	local var_15_2 = arg_15_0.challenge_stage

	saveData("MULT_HEART_DEMON", "STAGE", tostring(var_15_2))

	if var_15_1 ~= "1" and var_15_2 == 0 then
		manager.redPoint:setTip(RedPointConst.MULT_HEART_DEMON_FIRST_VIEW, 1)

		return
	end

	if var_15_2 == 0 and var_15_0 ~= "0" then
		manager.redPoint:setTip(RedPointConst.MULT_HEART_DEMON_FIRST_VIEW, 1)
		manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(var_0_1), var_0_1), 1)
		saveData("MULT_HEART_DEMON", "STAGE_VIEW", "0")
		saveData("MULT_HEART_DEMON", "ENTER_VIEW" .. var_0_1, "0")
	end
end

function var_0_0.UpdateViewRedPoint()
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MULT_HEART_DEMON) then
		return
	end

	saveData("MULT_HEART_DEMON", "STAGE_VIEW", "1")
	manager.redPoint:setTip(RedPointConst.MULT_HEART_DEMON_FIRST_VIEW, 0)
end

function var_0_0.UpdateEnterRedPoint(arg_17_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MULT_HEART_DEMON) then
		return
	end

	if var_0_1 == nil then
		return
	end

	saveData("MULT_HEART_DEMON", "ENTER_VIEW" .. var_0_1, "1")
	manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(var_0_1), var_0_1), 0)
end

function var_0_0.UpdateRewardRedPoint()
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MULT_HEART_DEMON) then
		return
	end

	manager.redPoint:setTip(RedPointConst.MULT_HEART_DEMON_REWARD, 0)

	local var_18_0 = TaskData2:GetTypedTaskSortListCommonFilter(TaskConst.TASK_TYPE.MULT_HEART_NORMAL_TASK)
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		var_18_1[iter_18_1.id] = iter_18_1
	end

	for iter_18_2, iter_18_3 in pairs(var_18_1) do
		local var_18_2 = TaskData2:GetTaskComplete(iter_18_2)

		if TaskData2:GetTaskProgress(iter_18_2) >= AssignmentCfg[iter_18_2].need and not var_18_2 then
			manager.redPoint:setTip(RedPointConst.MULT_HEART_DEMON_REWARD, 1)
		end
	end
end

manager.notify:RegistListener(PLAYER_LEVEL_UP, function()
	var_0_0.UpdateRefreshRedPoint({
		challenge_stage = MultHeartDemonData:GetDataByPara("challengeStage")
	})

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MULT_HEART_DEMON) then
		return
	end

	if var_0_1 == nil then
		return
	end

	if getData("MULT_HEART_DEMON", "ENTER_VIEW" .. var_0_1) ~= "1" then
		manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(var_0_1), var_0_1), 1)
	end
end)
manager.notify:RegistListener(ACTIVITY_TIMER_UPDATE, function(arg_20_0)
	if var_0_1 == arg_20_0 then
		manager.notify:CallUpdateFunc(MULT_HEART_DEMON_UPDATE)
	end
end)

return var_0_0
