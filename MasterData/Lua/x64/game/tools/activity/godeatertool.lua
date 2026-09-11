return {
	GodEaterExpNum = function()
		return ItemTools.getItemNum(CurrencyIdMapCfg.ACTIVITY_GOD_EATER_HUB_EXP.item_id or 0)
	end,
	GetGodAddNum = function()
		local var_2_0 = {}
		local var_2_1 = manager.time:GetServerTime() - GodEaterData.rewardTime

		for iter_2_0, iter_2_1 in ipairs(ActivityGodEaterLevelCfg[GodEaterData.hubLv].reward_param) do
			table.insert(var_2_0, {
				id = iter_2_1[1],
				now = Mathf.Clamp(math.floor(var_2_1 / ActivityGodEaterLevelCfg[GodEaterData.hubLv].interval_second) * iter_2_1[2], 0, iter_2_1[3])
			})
		end

		return var_2_0
	end,
	HubExpToLevel = function(arg_3_0)
		if not CurrencyIdMapCfg.ACTIVITY_GOD_EATER_HUB_EXP.item_id then
			-- block empty
		end

		local var_3_1 = tonumber(arg_3_0)
		local var_3_2 = 0
		local var_3_3 = var_3_1
		local var_3_4 = 99999

		for iter_3_0, iter_3_1 in pairs(ActivityGodEaterLevelCfg.all or {}) do
			if var_3_1 >= ActivityGodEaterLevelCfg[iter_3_1].all_exp then
				var_3_2 = ActivityGodEaterLevelCfg[iter_3_1].level
				var_3_3 = var_3_1 - ActivityGodEaterLevelCfg[iter_3_1].all_exp
				var_3_4 = ActivityGodEaterLevelCfg[iter_3_1].upgrade_exp
			end
		end

		return var_3_2, var_3_3, var_3_4
	end,
	GetWelfareID = function()
		return BattleGodEaterDailyMonsterCfg.get_id_list_by_sub_type[3][1]
	end,
	GetTaskType = function(arg_5_0)
		if AssignmentCfg[arg_5_0] then
			return AssignmentCfg[arg_5_0].type == TaskConst.TASK_TYPE.ACTIVITY_GOD_EATER_3 and 2 or 1
		end

		return 1
	end,
	GotoMilestone = function(arg_6_0)
		JumpTools.OpenPageByJump("ActivityGodEaterMilestoneView", {
			activityId = arg_6_0
		})
	end,
	GotoTaskMaxNum = function(arg_7_0)
		local var_7_0 = 1
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in pairs(ActivityGodEaterLevelCfg) do
			if iter_7_1.task_num then
				var_7_0 = Mathf.Max(var_7_0, iter_7_1.task_num)
				var_7_1[iter_7_1.task_num] = var_7_1[iter_7_1.task_num] or 999
				var_7_1[iter_7_1.task_num] = Mathf.Min(var_7_1[iter_7_1.task_num], iter_7_0)
			end
		end

		return var_7_0, var_7_1
	end
}
