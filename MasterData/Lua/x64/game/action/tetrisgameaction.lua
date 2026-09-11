local var_0_0 = {}

manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function()
	var_0_0:UpdateTaskRed()
end)
manager.net:Bind(79101, function(arg_2_0)
	TetrisGameData:InitServerData(arg_2_0)
	var_0_0:InitTetrisGameRedPoint()
end)

local var_0_1

function var_0_0.AskClearStage(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	var_0_1 = arg_3_3

	local var_3_0

	if ActivityTetrisGameStageCfg[arg_3_2.stageID].type ~= TetrisGameConst.stageType.endLess then
		if arg_3_2.result == 1 then
			manager.net:SendWithLoadingNew(79102, {
				activity_id = arg_3_1,
				id = arg_3_2.stageID,
				score = arg_3_2.score,
				is_success = arg_3_2.result == 1 and true or false
			}, 79103, var_0_0.AskClearStageCallBack)
		elseif var_0_1 then
			var_0_1()
		end
	end

	var_0_1 = nil

	var_0_0:UpdataRedPoint()

	do
		var_3_0 = {}
	end

	for iter_3_0, iter_3_1 in pairs(TetrisGameRunTimeManager:GetBlackBoard().skillUseTimes or {}) do
		table.insert(var_3_0, {
			iter_3_0,
			iter_3_1
		})
	end

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = arg_3_1,
		stage_id = arg_3_2.stageID,
		result = arg_3_4 and 3 or (arg_3_2.result == 0 or nil) and 2,
		score = arg_3_2.score,
		use_seconds = arg_3_2.useTime,
		battle_times = arg_3_2.battle_times,
		skill_list = var_3_0
	})
end

function var_0_0:AskClearStageCallBack(arg_4_1)
	if isSuccess(self.result) then
		TetrisGameData:InitClearStageList(self.mission_list)

		if var_0_1 then
			var_0_1()
		end

		var_0_1 = nil

		TetrisGameData:InitSpecialUnlockIDList(self.special_unlock_id_list)
		var_0_0:UpdataRedPoint()
	else
		ShowTips(self.result)
	end
end

function var_0_0.AskEquipSkill(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		table.insert(var_5_0, iter_5_1)
	end

	manager.net:SendWithLoadingNew(79104, {
		activity_id = arg_5_1,
		skill_list = var_5_0
	}, 79105, var_0_0.AskEquipSkillCallBack)
end

function var_0_0:AskEquipSkillCallBack(arg_6_1)
	if isSuccess(self.result) then
		TetrisGameData:InitSkillList(arg_6_1.skill_list)
		manager.notify:CallUpdateFunc(TETRIS_GAME_SKILL_UPDATE)
	else
		ShowTips(self.result)
	end
end

function var_0_0.InitTetrisGameRedPoint(arg_7_0)
	var_0_0:InitRedPointTree()
	var_0_0:UpdataRedPoint()
end

function var_0_0.UpdataRedPoint(arg_8_0)
	var_0_0:UpdataStageRedPoint()
	var_0_0:UpdataNewSkill()
	var_0_0:UpdateTaskRed()
end

function var_0_0.InitRedPointTree(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(ActivityTetrisGameChapterCfg.all) do
		if ActivityTetrisGameChapterCfg[iter_9_1].type == TetrisGameConst.stageType.normal then
			table.insert(var_9_0, string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, iter_9_1))

			local var_9_1 = {}

			for iter_9_2, iter_9_3 in ipairs(ActivityTetrisGameChapterCfg[iter_9_1].tetris_stage_list) do
				table.insert(var_9_1, string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_STAGE, iter_9_3))
			end

			manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, iter_9_1), var_9_1)
		elseif ActivityTetrisGameChapterCfg[iter_9_1].type == TetrisGameConst.stageType.endLess then
			table.insert(var_9_0, string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, iter_9_1))

			local var_9_2 = {}

			for iter_9_4, iter_9_5 in pairs(ActivityTetrisGameStageCfg[iter_9_1].skill_list or {}) do
				table.insert(var_9_2, string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_NEW_SKILL, iter_9_5))
			end

			manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_CHAPTER, iter_9_1), var_9_2)
		end
	end

	table.insert(var_9_0, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, (TetrisGameData:GetCurTaskActivityID())))

	local var_9_3 = TetrisGameData:GetCurActivityID()

	manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(var_9_3), var_9_3), var_9_0)
end

function var_0_0.UpdataStageRedPoint(arg_10_0)
	for iter_10_0, iter_10_1 in pairs((TetrisGameData:GetStageInfoList())) do
		if TetrisGameTools:GetStageState(iter_10_0) == "unlock" then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_STAGE, iter_10_0), 1)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_STAGE, iter_10_0), 0)
		end
	end
end

function var_0_0.UpdataNewSkill(arg_11_0)
	local var_11_0 = RedPointData:GetJsonCacheRedPoint("TetrisGameSkill")

	if var_11_0 == 1 then
		var_11_0 = {}
	end

	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		var_11_1[iter_11_1] = true
	end

	local var_11_2 = TetrisGameTools:CheckChapterIsOpen((TetrisGameTools:GetEndLessStageIDByActivityID(TetrisGameData:GetCurActivityID())))

	for iter_11_2, iter_11_3 in pairs(ActivityTetrisGameSkillCfg.all) do
		local var_11_3, var_11_4 = TetrisGameTools:CheckSkillIsUnlock(iter_11_3)

		if var_11_2 and var_11_3 and not var_11_1[iter_11_3] then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_NEW_SKILL, iter_11_3), 1)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TETIRS_GAME_NEW_SKILL, iter_11_3), 0)
		end
	end
end

function var_0_0.UpdateTaskRed(arg_12_0)
	local var_12_0 = TetrisGameData:GetCurTaskActivityID()

	if #TaskTools:GetCanGetActivityTaskList(var_12_0) <= 0 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_12_0), 0)
	else
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_12_0), 1)
	end
end

function var_0_0.SaveNewSkill(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(ActivityTetrisGameSkillCfg.all) do
		local var_13_1, var_13_2 = TetrisGameTools:CheckSkillIsUnlock(iter_13_1)

		if var_13_1 then
			table.insert(var_13_0, iter_13_1)
		end
	end

	saveData("RedPoint", "TetrisGameSkill", var_13_0)
end

return var_0_0
