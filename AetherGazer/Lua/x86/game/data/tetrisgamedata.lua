local var_0_0 = singletonClass("TetrisGameData")
local var_0_1
local var_0_2
local var_0_3
local var_0_4

local function var_0_5(arg_1_0)
	return {
		isClear = false,
		topScore = 0,
		stageID = arg_1_0,
		use_skill_list = {}
	}
end

function var_0_0.Init(arg_2_0)
	var_0_1 = nil
	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = {}
end

function var_0_0.InitServerData(arg_3_0, arg_3_1)
	var_0_1 = arg_3_1.activity_id

	for iter_3_0, iter_3_1 in ipairs(ActivityTetrisGameStageCfg.all) do
		if var_0_1 == ActivityTetrisGameStageCfg[iter_3_1].activity_id then
			var_0_2[iter_3_1] = var_0_5(iter_3_1)
		end
	end

	if arg_3_1.mission_list then
		var_0_0:InitClearStageList(arg_3_1.mission_list)
	end

	var_0_0:InitSkillList(arg_3_1.used_skill_list)
	var_0_0:InitSpecialUnlockIDList(arg_3_1.special_unlock_id_list)
end

function var_0_0.InitClearStageList(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = iter_4_1.id

		if not var_0_2[var_4_0] then
			var_0_2[var_4_0] = var_0_5(var_4_0)
		end

		var_0_2[var_4_0].isClear = iter_4_1.state
		var_0_2[var_4_0].topScore = iter_4_1.max_score
		var_0_2[var_4_0].use_skill_list = iter_4_1.use_skill_list
	end
end

function var_0_0.InitEndLessScore(arg_5_0, arg_5_1)
	local var_5_0 = TetrisGameTools:GetEndLessStageIDByActivityID(var_0_1)

	var_0_2[var_5_0].topScore = arg_5_1
end

function var_0_0.InitSkillList(arg_6_0, arg_6_1)
	var_0_3 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		table.insert(var_0_3, iter_6_1)
	end
end

function var_0_0.InitSpecialUnlockIDList(arg_7_0, arg_7_1)
	var_0_4 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		var_0_4[iter_7_1] = true
	end
end

function var_0_0.CheckSpecialStageIsUnLock(arg_8_0, arg_8_1)
	local var_8_0 = ActivityTetrisGameStageCfg[arg_8_1]

	if var_8_0.need_endless == 1 then
		if var_0_4[arg_8_1] then
			return true
		else
			local var_8_1 = var_8_0.unlock_condition
			local var_8_2 = ""

			if #var_8_1 > 0 then
				var_8_2 = ConditionCfg[var_8_1[#var_8_1]].desc

				for iter_8_0, iter_8_1 in pairs(var_8_1) do
					if not IsConditionAchieved(iter_8_1) then
						var_8_2 = ConditionCfg[iter_8_1].desc

						break
					end
				end
			end

			return false, var_8_2
		end
	end
end

function var_0_0.GetStageInfoList(arg_9_0)
	if var_0_2 then
		return var_0_2
	end
end

function var_0_0.GetStageInfoByStageID(arg_10_0, arg_10_1)
	if var_0_2 then
		return var_0_2[arg_10_1]
	end
end

function var_0_0.GetCurActivityID(arg_11_0)
	return var_0_1
end

function var_0_0.GetCurRankActivityID(arg_12_0)
	return ActivityConst.ACTIVITY_TETRIS_GAME_RANK_4_8
end

function var_0_0.GetCurTaskActivityID(arg_13_0)
	return ActivityConst.ACTIVITY_TETRIS_GAME_TASK_4_8
end

function var_0_0.GetSkillList(arg_14_0)
	return var_0_3
end

function var_0_0.GetEndlessSkillList(arg_15_0)
	local var_15_0 = {}

	table.insert(var_15_0, TetrisGameConst.ultimateID)

	for iter_15_0, iter_15_1 in pairs(arg_15_0:GetSkillList()) do
		table.insert(var_15_0, iter_15_1)
	end

	return var_15_0
end

function var_0_0.GetSpecialStageInfo(arg_16_0)
	local var_16_0 = TetrisGameTools:GetEndLessStageIDByActivityID(var_0_1)

	return var_0_2[var_16_0]
end

function var_0_0.GetChapterIsClear(arg_17_0, arg_17_1)
	if arg_17_1 and ActivityTetrisGameChapterCfg[arg_17_1] then
		local var_17_0 = ActivityTetrisGameChapterCfg[arg_17_1].tetris_stage_list

		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			if not var_0_2[iter_17_1].isClear then
				return false
			end
		end

		return true
	end
end

return var_0_0
