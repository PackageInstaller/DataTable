return {
	GodEaterExpNum = function()
		local var_1_0 = CurrencyIdMapCfg.ACTIVITY_GOD_EATER_HUB_EXP.item_id or 0

		return ItemTools.getItemNum(var_1_0)
	end,
	GetGodAddNum = function()
		local var_2_0 = {}
		local var_2_1 = manager.time:GetServerTime() - GodEaterData.rewardTime
		local var_2_2 = GodEaterData.hubLv
		local var_2_3 = ActivityGodEaterLevelCfg[var_2_2]

		for iter_2_0, iter_2_1 in ipairs(var_2_3.reward_param) do
			local var_2_4 = {
				id = iter_2_1[1],
				now = Mathf.Clamp(math.floor(var_2_1 / var_2_3.interval_second) * iter_2_1[2], 0, iter_2_1[3])
			}

			table.insert(var_2_0, var_2_4)
		end

		return var_2_0
	end,
	HubExpToLevel = function(arg_3_0)
		if not CurrencyIdMapCfg.ACTIVITY_GOD_EATER_HUB_EXP.item_id then
			local var_3_0 = 0
		end

		local var_3_1 = tonumber(arg_3_0)
		local var_3_2 = ActivityGodEaterLevelCfg.all
		local var_3_3 = 0
		local var_3_4 = var_3_1
		local var_3_5 = 99999

		for iter_3_0, iter_3_1 in pairs(var_3_2 or {}) do
			local var_3_6 = ActivityGodEaterLevelCfg[iter_3_1]

			if var_3_1 >= var_3_6.all_exp then
				var_3_3 = var_3_6.level
				var_3_4 = var_3_1 - var_3_6.all_exp
				var_3_5 = var_3_6.upgrade_exp
			end
		end

		return var_3_3, var_3_4, var_3_5
	end,
	GetWelfareID = function()
		return BattleGodEaterDailyMonsterCfg.get_id_list_by_sub_type[3][1]
	end,
	GetTaskType = function(arg_5_0)
		local var_5_0 = AssignmentCfg[arg_5_0]

		if var_5_0 then
			return var_5_0.type == TaskConst.TASK_TYPE.ACTIVITY_GOD_EATER_3 and 2 or 1
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

				if not var_7_1[iter_7_1.task_num] then
					var_7_1[iter_7_1.task_num] = 999
				end

				var_7_1[iter_7_1.task_num] = Mathf.Min(var_7_1[iter_7_1.task_num], iter_7_0)
			end
		end

		return var_7_0, var_7_1
	end
}
