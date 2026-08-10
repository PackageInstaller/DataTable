local var_0_0 = {}

manager.net:Bind(83401, function(arg_1_0)
	MonsterCosplayData.UpdateServerData(arg_1_0)
	manager.notify:CallUpdateFunc(MONSTER_COSPLAY_ALL_UPDATE_SKILL)

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.monster_list) do
		var_0_0.UpdateSkillRedPoint(iter_1_1.affix_list, iter_1_1.id)
	end

	var_0_0.AddRedPointGroup(ActivityConst.SUMMER_CHESS_BOARD_NONSTER_COSPLAY)
	var_0_0.UpdateMonsterStageRedPoint()
end)

function var_0_0.UpdateMonsterSkill(arg_2_0, arg_2_1)
	local var_2_0 = MonsterCosplayData:GetDataByPara("activityID")
	local var_2_1 = {
		activity_id = var_2_0,
		monster_id = arg_2_0,
		affix_id = arg_2_1
	}

	manager.net:SendWithLoadingNew(83402, var_2_1, 83403, var_0_0.UpdateMonsterSkillCallBack)
end

function var_0_0.UpdateMonsterSkillCallBack(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		MonsterCosplayData.UpdateMonsterSkill(arg_3_0.affix_list, arg_3_1)
		manager.notify:CallUpdateFunc(MONSTER_COSPLAY_UPDATE_SKILL)
		var_0_0.UpdateSkillRedPoint(arg_3_0.affix_list, arg_3_1.monster_id)
	else
		ShowTips(GetTips(arg_3_0.result))
	end
end

function var_0_0.ViewMonsterSkill(arg_4_0, arg_4_1)
	local var_4_0 = MonsterCosplayData:GetDataByPara("activityID")
	local var_4_1 = {
		activity_id = var_4_0,
		monster_id = arg_4_0,
		affix_id = arg_4_1
	}

	manager.net:SendWithLoadingNew(83404, var_4_1, 83405, var_0_0.ViewMonsterSkillCallBack)
end

function var_0_0.ViewMonsterSkillCallBack(arg_5_0, arg_5_1)
	if isSuccess(arg_5_0.result) then
		MonsterCosplayData.UpdateMonsterCoreSkillData(arg_5_0, arg_5_1)
		manager.notify:CallUpdateFunc(MONSTER_COSPLAY_UPDATE_CORE_SKILL, arg_5_1.affix_id)
		var_0_0.UpdateSkillRedPoint(arg_5_0.kernel_affix_list, arg_5_1.monster_id)
	else
		ShowTips(GetTips(arg_5_0.result))
	end
end

function var_0_0.UpdateSkillRedPoint(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
		local var_6_0 = getData("monsterCosplay", tostring(iter_6_1.affix_id)) or 0
		local var_6_1 = TalentTreeCfg[iter_6_1.affix_id].stage

		if var_6_0 ~= "true" then
			if TalentTreeCfg[iter_6_1.affix_id].type == 1 then
				local var_6_2 = MonsterCosplayData:GetDataByPara("viewCoreSkillTable")[arg_6_1]

				manager.redPoint:setTip("MonsterCosPlay" .. var_6_1, var_6_2[iter_6_1.affix_id] and 1 or 0)
			else
				manager.redPoint:setTip("MonsterCosPlay" .. var_6_1, 1)
			end
		end
	end
end

function var_0_0.AddRedPointGroup(arg_7_0)
	local var_7_0 = ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MONSTER_COSPLAY_NORMAL_TASK]
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0.sub_activity_list) do
		table.insert(var_7_1, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_7_1))
	end

	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SUMMER_CHESS_BOARD_MONSTER_COSPLAY_NORMAL_TASK), var_7_1)

	local var_7_2 = {}
	local var_7_3 = ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MONSTER_COSPLAY_LIMIT_TASK]

	for iter_7_2, iter_7_3 in ipairs(var_7_3.sub_activity_list) do
		table.insert(var_7_2, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_7_3))
	end

	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SUMMER_CHESS_BOARD_MONSTER_COSPLAY_LIMIT_TASK), var_7_2)
	manager.redPoint:addGroup(RedPointConst.MONSTER_COSPLAY_TASK, {
		string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SUMMER_CHESS_BOARD_MONSTER_COSPLAY_NORMAL_TASK),
		string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.SUMMER_CHESS_BOARD_MONSTER_COSPLAY_LIMIT_TASK)
	})

	local var_7_4 = {}

	for iter_7_4, iter_7_5 in pairs(ActivityMonsterCosplayCfg.all) do
		for iter_7_6, iter_7_7 in pairs(ActivityMonsterCosplayCfg[iter_7_5].stage_list) do
			local var_7_5 = RedPointConst.MONSTER_COSPLAY_STAGE .. iter_7_7

			table.insert(var_7_4, var_7_5)
		end
	end

	manager.redPoint:addGroup(RedPointConst.MONSTER_COSPLAY_STAGE, var_7_4)
	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(arg_7_0) .. arg_7_0, {
		RedPointConst.MONSTER_COSPLAY_STAGE,
		RedPointConst.MONSTER_COSPLAY_TASK
	})
end

manager.notify:RegistListener(HISTORY_UPDATE, function()
	var_0_0.UpdateMonsterStageRedPoint()
end)

function var_0_0.UpdateMonsterStageRedPoint()
	local var_9_0 = MonsterCosplayData:GetDataByPara("openStage")
	local var_9_1 = (ActivitySummerChessConditionCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_CHESS_BOARD_NONSTER_COSPLAY] or {})[1]

	for iter_9_0, iter_9_1 in pairs(var_9_0 or {}) do
		local var_9_2 = BattleActivityMonsterCosplayCfg[iter_9_1]
		local var_9_3 = tonumber(var_9_2.unlock_condition[1])
		local var_9_4 = RedPointConst.MONSTER_COSPLAY_STAGE .. iter_9_1

		if IsConditionAchieved(var_9_3) and not MonsterCosplayData:GetStageIsFinish(iter_9_0, iter_9_1) and not MonsterCosplayData:GetStageIsClick(iter_9_1) and IsConditionAchieved(var_9_1) then
			manager.redPoint:setTip(var_9_4, 1)
		else
			manager.redPoint:setTip(var_9_4, 0)
		end
	end
end

return var_0_0
