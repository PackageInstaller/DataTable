require("game.data.Hodur.HodurDataTemplate")

local var_0_0 = singletonClass("HodurSystemData")
local var_0_1 = false
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}
local var_0_6

function var_0_0.Init(arg_1_0)
	var_0_1 = false
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	if not var_0_1 then
		-- block empty
	end

	arg_2_0.isInit_ = true
	var_0_2 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.normal_stage_info) do
		local var_2_0 = HodurChapterTemplate.New(iter_2_1)

		table.insert(var_0_2, var_2_0)
	end

	var_0_3 = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.challenge_stage_info) do
		local var_2_1 = HodurChallengeTemplate.New(iter_2_3)

		table.insert(var_0_3, var_2_1)
	end

	HodurGameTempHeroData:Init()
	HodurGameTempHeroData:ModifyAllHeroInfo()
end

function var_0_0.OnSelectEvent(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:GetMainlineChapterData(arg_3_1)

	if var_3_0 == nil then
		var_3_0 = HodurChapterTemplate.New({
			normal_stage_id = arg_3_1,
			normal_option_info = {},
			normal_hero_stage_info = {},
			normal_boss_id_list = {}
		})

		table.insert(var_0_2, var_3_0)
	end

	table.insert(var_3_0.option_list, arg_3_2)
end

function var_0_0.SetChallengeTeam(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.challengeTeamData = {
		heroIDList = arg_4_1,
		trialIDList = arg_4_2
	}
end

function var_0_0.IsChallengeTeamSwitch(arg_5_0)
	local var_5_0 = arg_5_0:GetChallengeData()

	if var_5_0 == nil then
		return false
	end

	local var_5_1 = var_5_0:GetHeroList()

	if var_5_1 == nil or #var_5_1 == 0 then
		return false
	end

	return arg_5_0.challengeTeamData ~= nil
end

function var_0_0.GetChallengeTeam(arg_6_0)
	if arg_6_0.challengeTeamData == nil then
		return {}, {}
	end

	return arg_6_0.challengeTeamData.heroIDList, arg_6_0.challengeTeamData.trialIDList
end

function var_0_0.ClearChallengeTeamCache(arg_7_0)
	arg_7_0.challengeTeamData = nil
end

function var_0_0.CacheStageData(arg_8_0, arg_8_1)
	arg_8_0.cachedStageData_ = arg_8_1
end

function var_0_0.GetCachedStageData(arg_9_0)
	if arg_9_0.cachedStageData_ ~= nil then
		arg_9_0.cachedStageData_.isRestart = true

		return arg_9_0.cachedStageData_
	end

	return arg_9_0.cachedStageData_
end

function var_0_0.ClearStageDataCache(arg_10_0)
	arg_10_0.cachedStageData_ = nil
end

function var_0_0.OnResetChapter(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:GetMainlineChapterData(arg_11_1)

	if var_11_0 == nil then
		var_11_0 = HodurChapterTemplate.New({
			normal_stage_id = arg_11_1,
			normal_option_info = {},
			normal_hero_stage_info = {},
			normal_boss_id_list = {}
		})

		table.insert(var_0_2, var_11_0)

		return
	end

	var_11_0:ResetData()
end

function var_0_0.OnSettleChallenge(arg_12_0)
	local var_12_0 = var_0_3[1]

	if var_12_0 then
		arg_12_0:CacheFinalHero(var_12_0:GetHeroList())
		var_12_0:ResetData()
	end
end

function var_0_0.GetMainlineChapterData(arg_13_0, arg_13_1)
	if var_0_2 == nil then
		return nil
	end

	for iter_13_0, iter_13_1 in ipairs(var_0_2) do
		if iter_13_1:GetChapterID() == arg_13_1 then
			return iter_13_1
		end
	end

	return nil
end

function var_0_0.GetChallengeData(arg_14_0)
	if arg_14_0.cacheChallengeData_ then
		return arg_14_0.cacheChallengeData_
	else
		return var_0_3[1]
	end
end

function var_0_0.CacheAffixList(arg_15_0, arg_15_1)
	var_0_4 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		table.insert(var_0_4, iter_15_1)
	end
end

function var_0_0.ClearAffixCache(arg_16_0)
	var_0_4 = {}
end

function var_0_0.GetAffixCache(arg_17_0)
	return var_0_4
end

function var_0_0.CacheChallengeData(arg_18_0)
	local var_18_0 = arg_18_0:GetChallengeData()

	arg_18_0.cacheChallengeData_ = deepClone(var_18_0)
end

function var_0_0.GetCacheChallengeData(arg_19_0)
	return arg_19_0.cacheChallengeData_
end

function var_0_0.ClearCacheChallengeData(arg_20_0)
	arg_20_0.cacheChallengeData_ = nil
end

function var_0_0.CachePos(arg_21_0, arg_21_1, arg_21_2)
	var_0_5[arg_21_1] = arg_21_2
end

function var_0_0.GetCachePos(arg_22_0, arg_22_1)
	return var_0_5[arg_22_1] or 0
end

function var_0_0.CacheFinalHero(arg_23_0, arg_23_1)
	arg_23_0.cacheFinalHero = arg_23_1
end

function var_0_0.CheckFinalHero(arg_24_0)
	return arg_24_0.cacheFinalHero ~= nil
end

function var_0_0.GetFinalHero(arg_25_0)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.cacheFinalHero or {}) do
		table.insert(var_25_0, iter_25_1)
	end

	return var_25_0
end

function var_0_0.ClearFinalHero(arg_26_0)
	arg_26_0.cacheFinalHero = nil
end

function var_0_0.InitRedPointGroup(arg_27_0)
	local var_27_0 = RedPointConst.HODUR_ACTIVITY_MAIN .. ActivityConst.ACTIVITY_HODUR_MAIN
	local var_27_1 = RedPointConst.HODUR_ACTIVITY_RESIDENT_TASK .. ActivityConst.ACTIVITY_HODUR_MAIN
	local var_27_2 = RedPointConst.HODUR_ACTIVITY_LIMIT_TASK .. ActivityConst.ACTIVITY_HODUR_LIMITED_TASK
	local var_27_3 = ActivityCfg[ActivityConst.ACTIVITY_HODUR_LIMITED_TASK]
	local var_27_4 = {}

	for iter_27_0, iter_27_1 in pairs(var_27_3.sub_activity_list) do
		local var_27_5 = RedPointConst.HODUR_ACTIVITY_LIMIT_TASK_TAG .. iter_27_1

		table.insert(var_27_4, var_27_5)
	end

	manager.redPoint:addGroup(var_27_2, var_27_4)

	local var_27_6 = {}

	for iter_27_2, iter_27_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_HODUR_LIMITED_TASK]) do
		local var_27_7 = RedPointConst.HODUR_ACTIVITY_LIMIT_TASK_POINT .. iter_27_3

		table.insert(var_27_6, var_27_7)
	end

	manager.redPoint:addGroup(var_27_2, var_27_6)
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
		arg_27_0:UpdateLimitedTaskRedPoint()
	end)
	manager.redPoint:addGroup(var_27_0, {
		var_27_1,
		var_27_2
	})
end

function var_0_0.UpdateLimitedTaskRedPoint(arg_29_0)
	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_HODUR_LIMITED_TASK) then
		local var_29_0 = ActivityCfg[ActivityConst.ACTIVITY_HODUR_LIMITED_TASK].sub_activity_list

		for iter_29_0, iter_29_1 in pairs(var_29_0) do
			local var_29_1 = ActivityData:GetActivityIsOpen(iter_29_1)

			for iter_29_2, iter_29_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_29_1]) do
				local var_29_2 = RedPointConst.HODUR_ACTIVITY_LIMIT_TASK_TAG .. iter_29_1

				if var_29_1 then
					local var_29_3 = TaskData2:GetTaskProgress(iter_29_3)
					local var_29_4 = AssignmentCfg[iter_29_3]

					if TaskData2:GetTaskComplete(iter_29_3) then
						manager.redPoint:setTip(var_29_2, 0)
					elseif var_29_3 >= var_29_4.need then
						manager.redPoint:setTip(var_29_2, 1)

						break
					else
						manager.redPoint:setTip(var_29_2, 0)
					end
				else
					manager.redPoint:setTip(var_29_2, 0)
				end
			end
		end

		for iter_29_4, iter_29_5 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_HODUR_LIMITED_TASK]) do
			local var_29_5 = 0
			local var_29_6 = TaskData2:GetTaskProgress(iter_29_5)
			local var_29_7 = AssignmentCfg[iter_29_5]

			if not TaskData2:GetTaskComplete(iter_29_5) and var_29_6 >= var_29_7.need then
				var_29_5 = 1
			end

			manager.redPoint:setTip(RedPointConst.HODUR_ACTIVITY_LIMIT_TASK_POINT .. iter_29_5, var_29_5)
		end
	end
end

function var_0_0.UpdateTaskRedPoint(arg_30_0)
	arg_30_0:UpdatePointRed()
end

function var_0_0.UpdatePointRed(arg_31_0)
	local var_31_0 = false
	local var_31_1 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_HODUR_MAIN] or {}

	for iter_31_0, iter_31_1 in pairs(var_31_1) do
		local var_31_2 = TaskData2:GetTaskProgress(iter_31_1)
		local var_31_3 = AssignmentCfg[iter_31_1]

		if not TaskData2:GetTaskComplete(iter_31_1) and var_31_2 >= var_31_3.need then
			var_31_0 = true

			break
		end
	end

	local var_31_4 = RedPointConst.HODUR_ACTIVITY_RESIDENT_TASK .. ActivityConst.ACTIVITY_HODUR_MAIN

	if var_31_0 then
		manager.redPoint:setTip(var_31_4, 1)
	else
		manager.redPoint:setTip(var_31_4, 0)
	end

	arg_31_0:UpdateLimitedTaskRedPoint()
end

return var_0_0
