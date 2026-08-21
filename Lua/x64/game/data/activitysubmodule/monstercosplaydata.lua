local var_0_0 = singletonClass("MonsterCosplayData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1.activityID = nil
	var_0_1.openStage = {}
	var_0_1.monsterData = {}
	var_0_1.viewCoreSkillTable = {}
	var_0_1.firstView = true

	for iter_1_0, iter_1_1 in ipairs(ActivityMonsterCosplayCfg.all) do
		var_0_1.monsterData[iter_1_1] = {
			finishedStage = {},
			enhancedSkill = {}
		}
		var_0_1.viewCoreSkillTable[iter_1_1] = {}
	end

	var_0_0.clickStageIDList_ = {}
end

function var_0_0.UpdateServerData(arg_2_0)
	var_0_1:UpdateServerData(arg_2_0)

	var_0_0.clickStageIDList_ = {}
end

function var_0_0.GetAffixSprite(arg_3_0)
	local var_3_0 = TalentTreeCfg[arg_3_0]
	local var_3_1 = PublicBuffCfg[var_3_0.affix_id]

	return getSpriteWithoutAtlas("TextureConfig/BuffIcon/" .. var_3_1.icon)
end

function var_0_0.UpdateMonsterSkill(arg_4_0, arg_4_1)
	var_0_1:UpdateMonsterSkill(arg_4_0, arg_4_1)
end

function var_0_0.SetFirstView()
	var_0_1.firstView = false
end

function var_0_0.GetDataByPara(arg_6_0, arg_6_1)
	return var_0_1[arg_6_1]
end

function var_0_0.UpdateMonsterCoreSkillData(arg_7_0, arg_7_1)
	var_0_1:UpdateMonsterCoreSkillData(arg_7_0, arg_7_1)
end

function var_0_0.CheckCanSkillEnhance(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(var_0_1.monsterData) do
		if iter_8_1.skillEnhanceTimes > 0 then
			return true, iter_8_0
		end
	end

	return false
end

function var_0_0.ClickStage(arg_9_0, arg_9_1)
	var_0_0.clickStageIDList_[arg_9_1] = true
end

function var_0_0.GetStageIsClick(arg_10_0, arg_10_1)
	if var_0_0.clickStageIDList_[arg_10_1] then
		return true
	else
		return false
	end
end

function var_0_0.GetStageIsFinish(arg_11_0, arg_11_1, arg_11_2)
	if var_0_1.monsterData[arg_11_1] and var_0_1.monsterData[arg_11_1].finishedStage[arg_11_2] then
		return var_0_1.monsterData[arg_11_1].finishedStage[arg_11_2]
	else
		return false
	end
end

function var_0_1.UpdateMonsterCoreSkillData(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1.kernel_affix_list) do
		arg_12_0.viewCoreSkillTable[arg_12_2.monster_id][iter_12_1.affix_id] = iter_12_1.is_activate == 1
	end
end

function var_0_1.UpdateMonsterSkill(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.monsterData[arg_13_2.monster_id]

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		var_13_0.enhancedSkill[iter_13_1.affix_id] = {}
		var_13_0.enhancedSkill[iter_13_1.affix_id].affixID = iter_13_1.affix_id
		var_13_0.enhancedSkill[iter_13_1.affix_id].stageID = iter_13_1.stage_id
	end

	var_13_0.skillEnhanceTimes = var_13_0.skillEnhanceTimes - 1
end

function var_0_1.UpdateServerData(arg_14_0, arg_14_1)
	arg_14_0.activityID = arg_14_1.activity_id

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.monster_list) do
		arg_14_0.monsterData[iter_14_1.id] = {}

		arg_14_0:DetailMonsterData(iter_14_1)
	end

	arg_14_0.mainActivity = ActivityCfg.get_id_list_by_sub_activity_list[arg_14_0.activityID][1]

	arg_14_0:UpdateOpenStage()
	arg_14_0:UpdateSkillToAffix()
end

function var_0_1.UpdateSkillToAffix(arg_15_0)
	arg_15_0.skillToAffixTable = {}

	for iter_15_0, iter_15_1 in pairs(TalentTreeCfg.get_id_list_by_activity_id[arg_15_0.mainActivity]) do
		local var_15_0 = TalentTreeCfg[iter_15_1]

		if arg_15_0.skillToAffixTable[var_15_0.stage] == nil then
			arg_15_0.skillToAffixTable[var_15_0.stage] = {}
		end

		table.insert(arg_15_0.skillToAffixTable[var_15_0.stage], var_15_0.id)
	end

	for iter_15_2, iter_15_3 in pairs(arg_15_0.skillToAffixTable) do
		table.sort(iter_15_3, function(arg_16_0, arg_16_1)
			return TalentTreeCfg[arg_16_0].type == 2
		end)
	end
end

function var_0_1.UpdateOpenStage(arg_17_0)
	arg_17_0.openStage = {}

	for iter_17_0, iter_17_1 in ipairs(ActivityMonsterCosplayCfg.all) do
		local var_17_0 = ActivityMonsterCosplayCfg[iter_17_1]

		for iter_17_2, iter_17_3 in ipairs(var_17_0.stage_list) do
			if arg_17_0.monsterData[var_17_0.id].finishedStage[iter_17_3] then
				iter_17_2 = math.min(iter_17_2 + 1, #var_17_0.stage_list)
				arg_17_0.openStage[var_17_0.id] = var_17_0.stage_list[iter_17_2]
			end
		end

		if arg_17_0.openStage[var_17_0.id] == nil then
			arg_17_0.openStage[var_17_0.id] = var_17_0.stage_list[1]
		end
	end
end

function var_0_1.DetailMonsterData(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.monsterData[arg_18_1.id]

	var_18_0.id = arg_18_1.id
	var_18_0.enhancedSkill = {}
	var_18_0.skillEnhanceTimes = arg_18_1.skill_enhance_times

	for iter_18_0, iter_18_1 in ipairs(arg_18_1.affix_list) do
		var_18_0.enhancedSkill[iter_18_1.affix_id] = {
			affixID = iter_18_1.affix_id,
			stageID = iter_18_1.stage_id
		}
	end

	var_18_0.finishedStage = {}

	for iter_18_2, iter_18_3 in ipairs(arg_18_1.finished_stage) do
		var_18_0.finishedStage[iter_18_3] = true
	end

	var_18_0.finishedPointStage = {}

	for iter_18_4, iter_18_5 in ipairs(arg_18_1.finished_point_stage) do
		var_18_0.finishedPointStage[iter_18_5.id] = {}
		var_18_0.finishedPointStage[iter_18_5.id].id = iter_18_5.id
		var_18_0.finishedPointStage[iter_18_5.id].lastScore = iter_18_5.last_score
		var_18_0.finishedPointStage[iter_18_5.id].maxScore = iter_18_5.max_score
	end
end

return var_0_0
