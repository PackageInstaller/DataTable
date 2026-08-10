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

function var_0_0.CheckChapterIsOpen(arg_3_0, arg_3_1)
	local var_3_0 = ActivityTetrisGameChapterCfg[arg_3_1]

	return arg_3_0:CheckIsOpen(var_3_0.unlock_condition)
end

function var_0_0.CheckStageIsOpen(arg_4_0, arg_4_1)
	local var_4_0 = ActivityTetrisGameStageCfg[arg_4_1]

	if var_4_0.need_endless == 1 then
		return TetrisGameData:CheckSpecialStageIsUnLock(arg_4_1)
	end

	return arg_4_0:CheckIsOpen(var_4_0.unlock_condition)
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
		local var_6_0 = ActivityTetrisGameChapterCfg.get_id_list_by_tetris_stage_list[arg_6_1][1]
		local var_6_1 = ActivityTetrisGameChapterCfg[var_6_0].activityID

		if not ActivityData:GetActivityIsOpen(var_6_1) then
			local var_6_2 = ActivityData:GetActivityData(var_6_1)

			return false, string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(var_6_2.startTime, false, true))
		end

		local var_6_3, var_6_4 = var_0_0:CheckStageIsOpen(arg_6_1)

		if not var_6_3 then
			return false, GetI18NText(var_6_4)
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
	local var_8_0 = ActivityTetrisGameChapterCfg[arg_8_1]
	local var_8_1 = true
	local var_8_2 = ""

	if var_8_0 then
		for iter_8_0, iter_8_1 in ipairs(var_8_0.unlock_condition or {}) do
			if not IsConditionAchieved(iter_8_1) then
				var_8_1 = false

				local var_8_3 = ConditionCfg[iter_8_1].desc

				break
			end
		end

		if not var_8_1 then
			return "lock", GetTips("TETRIS_GAME_PRECHAPTER")
		end

		local var_8_4 = var_8_0.activityID
		local var_8_5, var_8_6 = ActivityTools.GetActivityStatusWithTips(var_8_4)

		if var_8_5 == 1 then
			return "open"
		elseif var_8_5 == 0 then
			return "lock", var_8_6
		elseif var_8_5 == 2 then
			return "finish", var_8_6
		end
	end
end

function var_0_0.CheckIsFinishChapter(arg_9_0, arg_9_1)
	if arg_9_1 == 0 then
		return true
	end

	local var_9_0 = ActivityTetrisGameChapterCfg[arg_9_1].tetris_stage_list
	local var_9_1 = true

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if TetrisGameData:GetStageInfoByStageID(iter_9_1).isClear == false then
			var_9_1 = false

			break
		end
	end

	return var_9_1
end

function var_0_0.GetEndLessStageIDByActivityID(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(ActivityTetrisGameStageCfg.all) do
		if ActivityTetrisGameStageCfg[iter_10_1].type == TetrisGameConst.stageType.endLess then
			local var_10_0 = ActivityTetrisGameChapterCfg.get_id_list_by_tetris_stage_list[iter_10_1][1]

			if ActivityTetrisGameChapterCfg[iter_10_1].activityID == arg_10_1 then
				return iter_10_1
			end
		end
	end
end

function var_0_0.GetSimpleChapterIDListByActivityID(arg_11_0, arg_11_1)
	local var_11_0 = ActivityCfg[arg_11_1].sub_activity_list
	local var_11_1 = {}
	local var_11_2 = ActivityTetrisGameChapterCfg.get_id_list_by_type[TetrisGameConst.stageType.normal]

	for iter_11_0, iter_11_1 in ipairs(var_11_2) do
		local var_11_3 = ActivityTetrisGameChapterCfg[iter_11_1].activityID

		if table.keyof(var_11_0, var_11_3) then
			table.insert(var_11_1, iter_11_1)
		end
	end

	return var_11_1
end

function var_0_0.CheckSkillIsUnlock(arg_12_0, arg_12_1)
	local var_12_0 = ActivityTetrisGameSkillCfg[arg_12_1]

	if var_12_0 then
		local var_12_1 = var_12_0.unlock_stage_id

		for iter_12_0, iter_12_1 in ipairs(var_12_1) do
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
			local var_13_2 = table.keyof(var_13_1, arg_13_1)

			table.remove(var_13_1, var_13_2)
		end

		if arg_13_2 then
			local var_13_3 = table.keyof(var_13_1, arg_13_2)

			table.remove(var_13_1, var_13_3)
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
			local var_15_1 = ActivityTetrisGameSkillCfg[iter_15_1]

			for iter_15_2, iter_15_3 in ipairs(var_15_1.exclusion) do
				if iter_15_3 == arg_15_1 then
					return true, iter_15_1
				end
			end
		end
	end

	return false
end

function var_0_0.IsUseSkillClear(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = TetrisGameData:GetStageInfoByStageID(arg_16_1)
	local var_16_1 = 0

	for iter_16_0, iter_16_1 in ipairs(var_16_0.use_skill_list) do
		if var_16_1 >= #arg_16_2 then
			break
		end

		var_16_1 = 0

		for iter_16_2, iter_16_3 in ipairs(iter_16_1.skill_id) do
			for iter_16_4, iter_16_5 in ipairs(arg_16_2) do
				if iter_16_5 == iter_16_3 then
					var_16_1 = var_16_1 + 1
				end
			end
		end
	end

	return var_16_1 >= #arg_16_2
end

function var_0_0.GetSkillIcon(arg_17_0, arg_17_1)
	if arg_17_1 then
		return getSpriteWithoutAtlas("TextureConfig/VersionUI/Alone_TetrisGameUI/TetrisGameSkill/" .. arg_17_1)
	end
end

return var_0_0
