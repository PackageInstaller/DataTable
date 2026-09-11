local var_0_0 = {}

function var_0_0.EnterStage(arg_1_0, arg_1_1)
	local var_1_0, var_1_1 = var_0_0:CheckStageIsUnlock(arg_1_1)

	if var_1_0 then
		local var_1_2 = {
			stageID = arg_1_1
		}
		local var_1_3 = gameContext:GetOpenPageHandler("tetrisGameStageView")

		if var_1_3 then
			TetrisGameRunTimeManager:Init(var_1_2, var_1_3.stageGo)
		else
			JumpTools.OpenPageByJump("/tetrisGameStageView", {
				stageID = arg_1_1,
				callBack = function(arg_2_0)
					TetrisGameRunTimeManager:Init(var_1_2, arg_2_0)
				end
			})
		end
	else
		ShowTips(var_1_1)
	end
end

function var_0_0:CheckChapterIsOpen(arg_3_1)
	return self:CheckIsOpen(ActivityTetrisGameChapterCfg[arg_3_1].unlock_condition)
end

function var_0_0:CheckStageIsOpen(arg_4_1)
	if ActivityTetrisGameStageCfg[arg_4_1].need_endless == 1 then
		return TetrisGameData:CheckSpecialStageIsUnLock(arg_4_1)
	end

	return self:CheckIsOpen(ActivityTetrisGameStageCfg[arg_4_1].unlock_condition)
end

function var_0_0.CheckIsOpen(arg_5_0, arg_5_1)
	local var_5_0 = true
	local var_5_1 = ""

	for iter_5_0, iter_5_1 in ipairs(arg_5_1 or {}) do
		if not IsConditionAchieved(iter_5_1) then
			var_5_0 = false
			var_5_1 = ConditionCfg[iter_5_1].desc

			break
		end
	end

	return var_5_0, var_5_1
end

function var_0_0.CheckStageIsUnlock(arg_6_0, arg_6_1)
	if ActivityTetrisGameStageCfg[arg_6_1] then
		if not ActivityData:GetActivityIsOpen(ActivityTetrisGameChapterCfg[ActivityTetrisGameChapterCfg.get_id_list_by_tetris_stage_list[arg_6_1][1]].activityID) then
			return false, string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ActivityTetrisGameChapterCfg[ActivityTetrisGameChapterCfg.get_id_list_by_tetris_stage_list[arg_6_1][1]].activityID).startTime, false, true))
		end

		local var_6_0, var_6_1 = var_0_0:CheckStageIsOpen(arg_6_1)

		if not var_6_0 then
			return false, GetI18NText(var_6_1)
		end

		return true
	end
end

function var_0_0.GetStageState(arg_7_0, arg_7_1)
	if ActivityTetrisGameStageCfg[arg_7_1] then
		local var_7_0, var_7_1 = var_0_0:CheckStageIsOpen(arg_7_1)

		if not var_7_0 then
			return "lock", var_7_1
		end

		local var_7_2 = TetrisGameData:GetStageInfoByStageID(arg_7_1)

		if var_7_2 and var_7_2.isClear then
			return "finish"
		else
			return "unlock"
		end
	end
end

function var_0_0.GetChapterState(arg_8_0, arg_8_1)
	if ActivityTetrisGameChapterCfg[arg_8_1] then
		for iter_8_0, iter_8_1 in ipairs(ActivityTetrisGameChapterCfg[arg_8_1].unlock_condition or {}) do
			if not IsConditionAchieved(iter_8_1) then
				break
			end
		end

		if not true then
			return "lock", GetTips("TETRIS_GAME_PRECHAPTER")
		end

		local var_8_4, var_8_5 = ActivityTools.GetActivityStatusWithTips(ActivityTetrisGameChapterCfg[arg_8_1].activityID)

		if var_8_4 == 1 then
			return "open"
		elseif var_8_4 == 0 then
			return "lock", var_8_5
		elseif var_8_4 == 2 then
			return "finish", var_8_5
		end
	end
end

function var_0_0.CheckIsFinishChapter(arg_9_0, arg_9_1)
	local var_9_0

	if arg_9_1 == 0 then
		do return true end

		var_9_0 = true
	end

	for iter_9_0, iter_9_1 in pairs(ActivityTetrisGameChapterCfg[arg_9_1].tetris_stage_list) do
		if TetrisGameData:GetStageInfoByStageID(iter_9_1).isClear == false then
			var_9_0 = false

			break
		end
	end

	return var_9_0
end

function var_0_0.GetEndLessStageIDByActivityID(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(ActivityTetrisGameStageCfg.all) do
		if ActivityTetrisGameStageCfg[iter_10_1].type == TetrisGameConst.stageType.endLess then
			if ActivityTetrisGameChapterCfg[iter_10_1].activityID == arg_10_1 then
				return iter_10_1
			end
		end
	end
end

function var_0_0.GetSimpleChapterIDListByActivityID(arg_11_0, arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(ActivityTetrisGameChapterCfg.get_id_list_by_type[TetrisGameConst.stageType.normal]) do
		if table.keyof(ActivityCfg[arg_11_1].sub_activity_list, ActivityTetrisGameChapterCfg[iter_11_1].activityID) then
			table.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function var_0_0.CheckSkillIsUnlock(arg_12_0, arg_12_1)
	if ActivityTetrisGameSkillCfg[arg_12_1] then
		for iter_12_0, iter_12_1 in ipairs(ActivityTetrisGameSkillCfg[arg_12_1].unlock_stage_id) do
			if var_0_0:GetStageState(iter_12_1) ~= "finish" then
				return false, "STAGE_LOCK"
			end
		end

		return true
	end
end

function var_0_0.AddOrReduceSkill(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = TetrisGameData:GetCurActivityID()

	if var_13_0 then
		local var_13_1 = deepClone(TetrisGameData:GetSkillList())

		if not var_0_0:CheckSkillInList(arg_13_1) then
			table.insert(var_13_1, arg_13_1)
		else
			table.remove(var_13_1, (table.keyof(var_13_1, arg_13_1)))
		end

		if arg_13_2 then
			table.remove(var_13_1, (table.keyof(var_13_1, arg_13_2)))
		end

		if #var_13_1 > GameSetting.tetris_game_skill_max.value[1] then
			ShowTips("PROFILE_LABEL_MAX_NUM")

			return
		end

		TetrisGameAction:AskEquipSkill(var_13_0, var_13_1)
	end
end

function var_0_0.CheckSkillInList(arg_14_0, arg_14_1)
	local var_14_0 = TetrisGameData:GetSkillList()

	if var_14_0 then
		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			if iter_14_1 == arg_14_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.CheckSkillIsConflict(arg_15_0, arg_15_1)
	local var_15_0 = TetrisGameData:GetSkillList()

	if var_15_0 then
		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			for iter_15_2, iter_15_3 in ipairs(ActivityTetrisGameSkillCfg[iter_15_1].exclusion) do
				if iter_15_3 == arg_15_1 then
					return true, iter_15_1
				end
			end
		end
	end

	return false
end

function var_0_0.IsUseSkillClear(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in ipairs(TetrisGameData:GetStageInfoByStageID(arg_16_1).use_skill_list) do
		if var_16_0 >= #arg_16_2 then
			break
		end

		var_16_0 = 0

		for iter_16_2, iter_16_3 in ipairs(iter_16_1.skill_id) do
			for iter_16_4, iter_16_5 in ipairs(arg_16_2) do
				if iter_16_5 == iter_16_3 then
					var_16_0 = var_16_0 + 1
				end
			end
		end
	end

	return var_16_0 >= #arg_16_2
end

function var_0_0.GetSkillIcon(arg_17_0, arg_17_1)
	if arg_17_1 then
		return getSpriteWithoutAtlas("TextureConfig/VersionUI/Alone_TetrisGameUI/TetrisGameSkill/" .. arg_17_1)
	end
end

return var_0_0
