local var_0_0 = {
	GetEnterUI = function(arg_1_0)
		local var_1_0 = ActivityTools.GetActivityTheme(arg_1_0)

		if var_1_0 == ActivityConst.THEME.ACTIVITY_3_0 then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_HeroEnhanceUI/NorseUI_3_0_HeroEnhanceMainUI"
		elseif var_1_0 == ActivityConst.THEME.ACTIVITY_3_5 then
			return "Widget/Version/SummerUI_3_5/SummerUI_3_5_HeroEnhanceUI/SummerUI_3_5_HeroEnhanceMainUI"
		elseif var_1_0 == ActivityConst.THEME.ACTIVITY_4_5 then
			return "Widget/Version/Alone_HeroEnhanceUI/Alone_HeroEnhanceMainUI"
		end

		Debug.LogError("HeroEnhance: activity " .. arg_1_0 .. " has no EnterUI")

		return "Widget/Version/NorseUI_3_0/NorseUI_3_0_HeroEnhanceUI/NorseUI_3_0_HeroEnhanceMainUI"
	end,
	GetHeroUIName = function(arg_2_0)
		local var_2_0 = ActivityTools.GetActivityTheme(arg_2_0)

		if var_2_0 == ActivityConst.THEME.ACTIVITY_3_0 then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_HeroEnhanceUI/NorseUI_3_0_HeroEnhanceHeroUI"
		elseif var_2_0 == ActivityConst.THEME.ACTIVITY_3_5 then
			return "Widget/Version/SummerUI_3_5/SummerUI_3_5_HeroEnhanceUI/SummerUI_3_5_HeroEnhanceHeroUI"
		elseif var_2_0 == ActivityConst.THEME.ACTIVITY_4_5 then
			return "Widget/Version/Alone_HeroEnhanceUI/Alone_HeroEnhanceHeroUI"
		end

		Debug.LogError("HeroEnhance: activity " .. arg_2_0 .. " has no HeroUI")

		return "Widget/Version/NorseUI_3_0/NorseUI_3_0_HeroEnhanceUI/NorseUI_3_0_HeroEnhanceHeroUI"
	end,
	GetStageUIName = function(arg_3_0)
		local var_3_0 = ActivityTools.GetActivityTheme(arg_3_0)

		if var_3_0 == ActivityConst.THEME.ACTIVITY_3_0 then
			-- block empty
		elseif var_3_0 == ActivityConst.THEME.ACTIVITY_4_5 then
			return "Widget/Version/Alone_HeroEnhanceUI/Alone_OperationStageUI"
		end

		return "Widget/System/Operation/OperationStageUI"
	end,
	GetStageInfoUIName = function(arg_4_0)
		if ActivityTools.GetActivityTheme(arg_4_0) == ActivityConst.THEME.ACTIVITY_3_0 then
			-- block empty
		end

		return "Widget/System/Operation/ChapterSectionInfoUI"
	end,
	GetStageAttachUIName = function(arg_5_0)
		local var_5_0 = ActivityTools.GetActivityTheme(arg_5_0)

		if var_5_0 == ActivityConst.THEME.ACTIVITY_3_0 then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_HeroEnhanceUI/NorseUI_3_0_HeroEnhanceStageAttachUI"
		elseif var_5_0 == ActivityConst.THEME.ACTIVITY_3_5 then
			return "Widget/Version/SummerUI_3_5/SummerUI_3_5_HeroEnhanceUI/SummerUI_3_5_HeroEnhanceStageAttachUI"
		elseif var_5_0 == ActivityConst.THEME.ACTIVITY_4_5 then
			return "Widget/Version/Alone_HeroEnhanceUI/Alone_HeroEnhanceStageAttachUI"
		end

		Debug.LogError("HeroEnhance: activity " .. arg_5_0 .. " has no StageAttachUI")

		return "Widget/Version/NorseUI_3_0/NorseUI_3_0_HeroEnhanceUI/NorseUI_3_0_HeroEnhanceStageAttachUI"
	end,
	GetBattleResultContentUIName = function(arg_6_0)
		local var_6_0 = ActivityTools.GetActivityTheme(arg_6_0)

		if var_6_0 == ActivityConst.THEME.ACTIVITY_3_0 then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_HeroEnhanceUI/NorseUI_3_0_HeroEnhanceBattleResultContent"
		elseif var_6_0 == ActivityConst.THEME.ACTIVITY_3_5 then
			return "Widget/Version/SummerUI_3_5/SummerUI_3_5_HeroEnhanceUI/SummerUI_3_5_HeroEnhanceBattleResultContent"
		elseif var_6_0 == ActivityConst.THEME.ACTIVITY_4_5 then
			return "Widget/Version/Alone_HeroEnhanceUI/Alone_HeroEnhanceBattleResultContent"
		end

		Debug.LogError("HeroEnhance: activity " .. arg_6_0 .. " has no StageAttachUI")

		return "Widget/Version/NorseUI_3_0/NorseUI_3_0_HeroEnhanceUI/NorseUI_3_0_HeroEnhanceBattleResultContent"
	end,
	GetTalentPopUIName = function(arg_7_0)
		if ActivityTools.GetActivityTheme(arg_7_0) == ActivityConst.THEME.ACTIVITY_4_5 then
			return "Widget/Version/Alone_HeroEnhanceUI/Alone_HeroEnhance_TalentPopUI"
		end

		return "Widget/Version/Alone_HeroEnhanceUI/Alone_HeroEnhance_TalentPopUI"
	end
}

local function var_0_1()
	return ActivityHeroEnhanceCfg[ActivityHeroEnhanceCfg.all[1]]
end

local var_0_2 = {}

local function var_0_3(arg_9_0, arg_9_1, arg_9_2)
	if var_0_2[arg_9_0] == nil then
		return nil
	end

	local var_9_0 = var_0_2[arg_9_0][arg_9_1]

	if var_0_2[arg_9_0][arg_9_1] == nil then
		return nil
	end

	return var_9_0[arg_9_2]
end

local function var_0_4(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = var_0_2[arg_10_0]

	if var_0_2[arg_10_0] == nil then
		var_10_0 = {}
		var_0_2[arg_10_0] = var_10_0
	end

	local var_10_1 = var_10_0[arg_10_1]

	if var_10_0[arg_10_1] == nil then
		var_10_1 = {}
		var_10_0[arg_10_1] = var_10_1
	end

	var_10_1[arg_10_2] = arg_10_3
end

function var_0_0.GetAllRewardList(arg_11_0)
	if ActivityHeroEnhanceCfg.get_id_list_by_activity_id[arg_11_0] == nil then
		Debug.LogError("hero enhance config empty for activity: " .. arg_11_0)

		return {}
	end

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(ActivityHeroEnhanceCfg.get_id_list_by_activity_id[arg_11_0]) do
		for iter_11_2, iter_11_3 in ipairs(ActivityHeroEnhanceCfg[iter_11_1].stage_list) do
			var_11_0 = mergeRewardList(var_11_0, (var_0_0.GetStageRewardList(arg_11_0, iter_11_3, true)))
		end
	end

	return var_11_0
end

function var_0_0.GetStageRewardList(arg_12_0, arg_12_1, arg_12_2)
	if BattleHeroEnhanceCfg[arg_12_1] == nil then
		Debug.LogError("battle hero enhance config empty for activity(" .. arg_12_0 .. "), stageId(" .. arg_12_1 .. ")")

		return {}
	end

	if arg_12_2 == nil then
		arg_12_2 = not ActivityHeroEnhanceData:IsStageClear(arg_12_0, arg_12_1)
	end

	return (getRewardFromDropCfg(BattleHeroEnhanceCfg[arg_12_1].drop_lib_id, arg_12_2))
end

function var_0_0.GetCfgIdList(arg_13_0)
	if ActivityHeroEnhanceCfg.get_id_list_by_activity_id[arg_13_0] == nil then
		return {
			var_0_1().id
		}
	end

	return ActivityHeroEnhanceCfg.get_id_list_by_activity_id[arg_13_0]
end

local var_0_5 = {}

function var_0_0:GetCfgTalentDict()
	if var_0_5[self.id] then
		return var_0_5[self.id]
	end

	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(self.talent_list) do
		var_14_0[TalentTreeCfg[iter_14_1].stage] = var_14_0[TalentTreeCfg[iter_14_1].stage] or {}

		table.insert(var_14_0[TalentTreeCfg[iter_14_1].stage], iter_14_1)
	end

	var_0_5[self.id] = var_14_0

	return var_14_0
end

function var_0_0.GetCfgTalentListByStage(arg_15_0, arg_15_1)
	return var_0_0.GetCfgTalentDict(arg_15_0)[arg_15_1]
end

function var_0_0:GetCfgActivatedTalentList()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(self.talent_list) do
		if ActivityHeroEnhanceData:IsTalentActivated(self.activity_id, iter_16_1) then
			table.insert(var_16_0, iter_16_1)
		end
	end

	return var_16_0
end

function var_0_0:GetCfgActivatedTalentDict()
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(self.talent_list) do
		if ActivityHeroEnhanceData:IsTalentActivated(self.activity_id, iter_17_1) then
			var_17_0[TalentTreeCfg[iter_17_1].stage] = iter_17_1
		end
	end

	return var_17_0
end

function var_0_0.GetUnlockTalentList(arg_18_0, arg_18_1)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1.talent_list) do
		if not var_0_0.IsTalentLock(arg_18_0, iter_18_1) then
			var_18_0[TalentTreeCfg[iter_18_1].stage] = iter_18_1
		end
	end

	return var_18_0
end

function var_0_0:GetCfgTalentList()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(self.talent_list) do
		var_19_0[TalentTreeCfg[iter_19_1].stage] = iter_19_1
	end

	return var_19_0
end

function var_0_0.GetTutorialCfg(arg_20_0)
	if ActivityHeroEnhanceCfg.get_id_list_by_activity_id[arg_20_0] == nil then
		return var_0_1()
	end

	return ActivityHeroEnhanceCfg[ActivityHeroEnhanceCfg.get_id_list_by_activity_id[arg_20_0][1]]
end

function var_0_0.GetTutorialHeroId(arg_21_0)
	return var_0_0.GetTutorialCfg(arg_21_0).hero_id
end

function var_0_0.GetCfgByTalentId(arg_22_0, arg_22_1)
	local var_22_0 = var_0_3(arg_22_0, "GetCfgByTalentId", arg_22_1)

	if var_22_0 then
		return var_22_0
	end

	local var_22_1 = ActivityHeroEnhanceCfg.get_id_list_by_activity_id[arg_22_0]

	if ActivityHeroEnhanceCfg.get_id_list_by_activity_id[arg_22_0] == nil then
		return var_0_1()
	end

	for iter_22_0, iter_22_1 in ipairs(var_22_1) do
		if table.indexof(ActivityHeroEnhanceCfg[iter_22_1].talent_list, arg_22_1) then
			var_0_4(arg_22_0, "GetCfgByTalentId", arg_22_1, ActivityHeroEnhanceCfg[iter_22_1])

			return ActivityHeroEnhanceCfg[iter_22_1]
		end
	end

	return var_0_1()
end

function var_0_0:IsCfgHeroPass()
	for iter_23_0, iter_23_1 in ipairs(self.stage_list) do
		if not ActivityHeroEnhanceData:IsStageClear(self.activity_id, iter_23_1) then
			return false
		end
	end

	return true
end

function var_0_0:IsCfgHeroLock()
	local var_24_0 = ActivityHeroEnhanceData:GetDay(self.activity_id)

	if var_24_0 < self.start_day then
		return true, {
			isBeforeStartDay = true,
			curDay = var_24_0,
			startDay = self.start_day
		}
	end

	local var_24_1 = var_0_0.GetTutorialCfg(self.activity_id)

	if var_24_1.id == self.id then
		return false
	end

	if not var_0_0.IsCfgHeroPass(var_24_1) then
		return true, {
			isTutorialNotPass = true
		}
	end

	return false
end

function var_0_0.GetTalentLockConditionId(arg_26_0, arg_26_1, arg_26_2)
	for iter_26_0, iter_26_1 in ipairs(TalentTreeCfg[arg_26_1].unlock_condition) do
		if ConditionCfg[iter_26_1].type == 11401 and not ActivityHeroEnhanceData:IsStageClear(arg_26_0, ConditionCfg[iter_26_1].params[1]) then
			return iter_26_1
		end
	end

	return nil
end

function var_0_0.IsTalentLock(arg_27_0, arg_27_1, arg_27_2)
	if var_0_0.GetTalentLockConditionId(arg_27_0, arg_27_1, arg_27_2) ~= nil then
		return true
	end

	return false
end

function var_0_0:IsCfgTalentStageLock(arg_28_1, arg_28_2)
	for iter_28_0, iter_28_1 in ipairs((var_0_0.GetCfgTalentListByStage(self, arg_28_1))) do
		if not var_0_0.IsTalentLock(self.activity_id, iter_28_1, arg_28_2) then
			return false
		end
	end

	return true
end

function var_0_0.IsCfgTalentStageFirstCanAdd(arg_29_0, arg_29_1)
	local var_29_0 = ActivityHeroEnhanceTools.GetCfgActivatedTalentDict(arg_29_0)

	if var_29_0[arg_29_1] then
		return false
	end

	local var_29_1 = var_0_0.IsCfgTalentStageLock(arg_29_0, arg_29_1, true)

	if arg_29_1 == 1 then
		return not var_29_1
	end

	return not var_29_1 and var_29_0[arg_29_1 - 1] ~= nil
end

function var_0_0.GetTalentListActivatedIdx(arg_30_0, arg_30_1)
	if arg_30_1 == nil then
		return -1
	end

	for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
		if ActivityHeroEnhanceData:IsTalentActivated(arg_30_0, iter_30_1) then
			return iter_30_0
		end
	end

	return -1
end

function var_0_0:IsCfgStageUnlock(arg_31_1)
	local var_31_0

	for iter_31_0, iter_31_1 in ipairs(self.stage_list) do
		if table.indexof(BattleHeroEnhanceCfg[iter_31_1].next_unlock_id_list, arg_31_1) then
			if ActivityHeroEnhanceData:IsStageClear(self.activity_id, iter_31_1) then
				return true
			end

			var_31_0 = iter_31_1
		end
	end

	if var_31_0 == nil then
		return true
	end

	return false
end

function var_0_0.GetIsNewTalent(arg_32_0)
	local var_32_0 = ActivityHeroEnhanceData:GetCacheStageTalent()

	if ActivityHeroEnhanceCfg.get_id_list_by_activity_id[arg_32_0] == nil then
		return var_0_1()
	end

	for iter_32_0, iter_32_1 in ipairs(ActivityHeroEnhanceCfg.get_id_list_by_activity_id[arg_32_0]) do
		for iter_32_2, iter_32_3 in ipairs(ActivityHeroEnhanceCfg[iter_32_1].talent_list) do
			if TalentTreeCfg[iter_32_3].unlock_condition[1] and table.indexof(var_32_0, ConditionCfg[TalentTreeCfg[iter_32_3].unlock_condition[1]].params[1]) then
				return iter_32_3
			end
		end
	end

	return -1
end

function var_0_0.GetCfgTalentMaxStage(arg_33_0)
	return 4
end

return var_0_0
