local var_0_0 = {
	IsConditionAchieved = function(arg_1_0, arg_1_1)
		local var_1_0 = ConditionCfg[arg_1_0]

		if var_1_0 == nil then
			return true, 0, 0
		end

		local var_1_1 = false
		local var_1_2 = HistoryData:GetHistoryData(var_1_0.id) or 0
		local var_1_3 = var_1_0.params[1]

		if var_1_0.type == 9001 then
			var_1_2 = HistoryData:GetHistoryData(var_1_0.id) or 0

			return var_1_2 >= var_1_0.params[1], var_1_2, var_1_0.params[1]
		elseif var_1_0.type == 9002 then
			var_1_2 = HistoryData:GetHistoryData(var_1_0.id) or 0

			return var_1_2 >= var_1_0.params[1], var_1_2, var_1_0.params[1]
		elseif var_1_0.type == 9003 then
			var_1_2 = HistoryData:GetHistoryData(var_1_0.id) or 0

			return var_1_2 >= var_1_0.params[1], var_1_2, var_1_0.params[1]
		elseif var_1_0.type == 9004 then
			var_1_2 = HistoryData:GetHistoryData(var_1_0.id) or 0

			return var_1_2 >= 1, var_1_2, 1
		elseif var_1_0.type == 9005 then
			var_1_2 = HistoryData:GetHistoryData(var_1_0.id) or 0

			return var_1_2 >= 1, var_1_2, 1
		end

		return var_1_1, var_1_2, var_1_3
	end,
	GetGuildSpConditionDesc = function(arg_2_0)
		local var_2_0 = ConditionCfg[arg_2_0]
		local var_2_1 = ""

		if not var_2_0 then
			return var_2_1
		end

		if var_2_0.type == 9011 then
			local var_2_2 = GetTips(GuildActivitySPConst.NodeType[var_2_0.params[3]])

			var_2_1 = string.format(var_2_0.desc, var_2_0.params[1], var_2_0.params[2], var_2_2)
		elseif var_2_0.type == 9012 then
			var_2_1 = string.format(var_2_0.desc, var_2_0.params[2])
		elseif var_2_0.type == 9013 then
			var_2_1 = string.format(var_2_0.desc, var_2_0.params[1], var_2_0.params[2])
		elseif var_2_0.type == 9014 then
			var_2_1 = var_2_0.desc
		elseif var_2_0.type == 9015 then
			var_2_1 = string.format(var_2_0.desc, var_2_0.params[1])
		elseif var_2_0.type == 9016 then
			var_2_1 = string.format(var_2_0.desc, var_2_0.params[1])
		elseif var_2_0.type == 9017 then
			var_2_1 = string.format(var_2_0.desc, var_2_0.params[2])
		end

		return var_2_1
	end
}
local var_0_1 = {}

function var_0_0.PlayGuildActivitySpStoryList(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	for iter_3_0, iter_3_1 in ipairs(GuildActivitySPConst.StoryPriorty) do
		if GuildActivityTools:PlayGuildActivityStory(iter_3_1, arg_3_1, arg_3_3) then
			return true
		end
	end

	if arg_3_1 then
		arg_3_1(arg_3_2)
	end

	var_0_1 = {}
end

function var_0_0.CheckCanPlayStory(arg_4_0, arg_4_1)
	if GuildActivitySPData:GetCurMainActivityID() == ActivityConst.GUILD_ACTIVITY_SP_2_4 then
		for iter_4_0, iter_4_1 in ipairs(GuildActivitySPConst.StoryPriorty) do
			local var_4_0 = var_0_0:GetCanPlatStory(iter_4_1, arg_4_1)

			if var_4_0 and not manager.story:IsStoryPlayed(var_4_0) and not var_0_1[var_4_0] then
				return true
			end
		end
	end
end

function var_0_0.GetCanPlatStory(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0

	if arg_5_2 == 1 then
		if arg_5_1 == GuildActivitySPConst.StoryType.FirstEnter then
			var_5_0 = GameSetting.activity_club_sp_start_plot.value[1]
		elseif arg_5_1 == GuildActivitySPConst.StoryType.Condition then
			local var_5_1 = GameSetting.activity_club_sp_middle_plot.value[1]

			for iter_5_0, iter_5_1 in ipairs(var_5_1) do
				local var_5_2 = iter_5_1[1]

				if IsConditionAchieved(var_5_2) and not manager.story:IsStoryPlayed(iter_5_1[2]) and not var_0_1[iter_5_1[2]] then
					var_5_0 = iter_5_1[2]

					break
				end
			end
		end
	elseif arg_5_2 == 2 then
		if arg_5_1 == GuildActivitySPConst.StoryType.Condition then
			local var_5_3 = GameSetting.activity_club_sp_middle_plot.value[2]

			for iter_5_2, iter_5_3 in ipairs(var_5_3) do
				local var_5_4 = iter_5_3[1]

				if IsConditionAchieved(var_5_4) and not manager.story:IsStoryPlayed(iter_5_3[2]) and not var_0_1[iter_5_3[2]] then
					var_5_0 = iter_5_3[2]

					break
				end
			end
		elseif arg_5_1 == GuildActivitySPConst.StoryType.Level1BossPass then
			if var_0_0:GetSpActivityStage() == GuildActivitySPConst.StageType.First and var_0_0:CheckBigBossDead(2) then
				var_5_0 = GameSetting.activity_club_sp_success_complete_plot.value[1]
			end
		elseif arg_5_1 == GuildActivitySPConst.StoryType.Level1BossNoPass then
			if var_0_0:GetSpActivityStage() == GuildActivitySPConst.StageType.Second and not var_0_0:CheckBigBossDead(2) then
				var_5_0 = GameSetting.activity_club_sp_fail_plot.value[1]
			end
		elseif arg_5_1 == GuildActivitySPConst.StoryType.Level2BossPass and var_0_0:GetSpActivityStage() == GuildActivitySPConst.StageType.Second and var_0_0:CheckBigBossDead(2) then
			var_5_0 = GameSetting.activity_club_sp_success_plot.value[1]
		end
	end

	return var_5_0
end

function var_0_0.PlayGuildActivityStory(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = var_0_0:GetCanPlatStory(arg_6_1, arg_6_3)

	if var_6_0 and not manager.story:IsStoryPlayed(var_6_0) and not var_0_1[var_6_0] then
		var_0_1[var_6_0] = true

		LeanTween.cancel(manager.ui.mainCamera.transform.gameObject)
		manager.story:StartStoryById(var_6_0, function(arg_7_0)
			var_0_0:PlayGuildActivitySpStoryList(arg_6_2, true, arg_6_3)
		end)

		return true
	end
end

function var_0_0.GetSpActivityStage(arg_8_0)
	local var_8_0 = manager.time:GetServerTime()
	local var_8_1 = GuildActivitySPData:GetCurRunActivityID()
	local var_8_2 = ActivityData:GetActivityData(var_8_1)
	local var_8_3 = var_8_2.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600
	local var_8_4 = var_8_2.stopTime

	if var_8_3 < var_8_0 then
		return GuildActivitySPConst.StageType.Second
	else
		return GuildActivitySPConst.StageType.First
	end
end

function var_0_0.CheckBigBossDead(arg_9_0, arg_9_1)
	local var_9_0 = GuildActivitySPData:GetMaxNodeId()

	if var_9_0 and GuildActivitySPData:GetNodeData(var_9_0).health <= 0 then
		return true
	end
end

function var_0_0.IsLastBossDefeated(arg_10_0, arg_10_1)
	local var_10_0 = GuildActivityData:GetNodeData(arg_10_1)

	if arg_10_1 == ActivityClubCfg.all[#ActivityClubCfg.all] and var_10_0.health <= 0 then
		return true
	end

	return false
end

return var_0_0
