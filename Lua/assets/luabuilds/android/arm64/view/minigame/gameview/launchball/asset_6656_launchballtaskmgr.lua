local LaunchBallTaskMgr = class("LaunchBallTaskMgr")

LaunchBallTaskMgr.type_split = 1
LaunchBallTaskMgr.type_series_split = 2
LaunchBallTaskMgr.type_close_split = 3
LaunchBallTaskMgr.type_over_split = 4
LaunchBallTaskMgr.type_many_split = 5
LaunchBallTaskMgr.type_pass_skill = 200
LaunchBallTaskMgr.type_pass_skill_split = 201
LaunchBallTaskMgr.type_trigger_skill = 300
LaunchBallTaskMgr.type_trigger_skill_split = 301
LaunchBallTaskMgr.type_trigger_skill_split_all = 302
LaunchBallTaskMgr.type_trigger_skill_time = 303
LaunchBallTaskMgr.type_player_target_round = 400
LaunchBallTaskMgr.type_player_round = 401

function LaunchBallTaskMgr:CheckTaskUpdate()
	local var_1_0 = LaunchBallActivityMgr.GetPlayerZhuanshuIndex(self.player)

	if var_1_0 and not LaunchBallActivityMgr.CheckZhuanShuAble(ActivityConst.MINIGAME_ZUMA, var_1_0) then
		return
	end

	local var_1_2 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_ZUMA_TASK):getConfig("config_client")
	local var_1_3 = {}

	for iter_1_0 = 1, #var_1_2 do
		if var_1_2[iter_1_0].player == self.player then
			var_1_3 = var_1_2[iter_1_0].task
		end
	end

	local var_1_4 = {}

	for iter_1_1 = 1, #var_1_3 do
		local var_1_5 = var_1_3[iter_1_1][2]
		local var_1_6 = getProxy(TaskProxy):getTaskById(var_1_3[iter_1_1][2])

		if var_1_6 and var_1_6:getTaskStatus() == 0 then
			local var_1_7 = 0
			local var_1_8 = var_1_6:getTargetNumber()
			local var_1_9 = var_1_6:getProgress()

			if var_1_3[iter_1_1][1] == LaunchBallTaskMgr.type_split and self.split_count ~= 0 then
				var_1_7 = var_1_8 < self.split_count + var_1_9 and var_1_8 or self.split_count + var_1_9
			elseif var_1_3[iter_1_1][1] == LaunchBallTaskMgr.type_player_target_round then
				if var_1_3[iter_1_1][4] == self.round then
					var_1_7 = var_1_9 + 1
				end
			elseif var_1_3[iter_1_1][1] == LaunchBallTaskMgr.type_player_round then
				var_1_7 = var_1_9 + 1
			elseif var_1_3[iter_1_1][1] == LaunchBallTaskMgr.type_trigger_skill and self.use_skill ~= 0 then
				var_1_7 = var_1_9 + self.use_skill
			elseif var_1_3[iter_1_1][1] == LaunchBallTaskMgr.type_series_split and self.series_count ~= 0 then
				var_1_7 = var_1_9 + self.series_count
			elseif var_1_3[iter_1_1][1] == LaunchBallTaskMgr.type_close_split and self.mix_count ~= 0 then
				var_1_7 = var_1_9 + self.mix_count
			elseif var_1_3[iter_1_1][1] == LaunchBallTaskMgr.type_over_split and self.over_count ~= 0 then
				var_1_7 = var_1_9 + self.over_count
			elseif var_1_3[iter_1_1][1] == LaunchBallTaskMgr.type_many_split and self.many_count ~= 0 then
				var_1_7 = var_1_9 + self.many_count
			elseif var_1_3[iter_1_1][1] == LaunchBallTaskMgr.type_pass_skill and self.use_pass_skill ~= 0 then
				var_1_7 = var_1_9 + self.use_pass_skill
			elseif var_1_3[iter_1_1][1] == LaunchBallTaskMgr.type_trigger_skill_split and self.skill_count ~= 0 then
				if var_1_3[iter_1_1][3] <= self.skill_count then
					var_1_7 = var_1_8
				end
			elseif var_1_3[iter_1_1][1] == LaunchBallTaskMgr.type_trigger_skill_split_all and self.skill_count ~= 0 then
				var_1_7 = var_1_9 + self.skill_count
			elseif var_1_3[iter_1_1][1] == LaunchBallTaskMgr.type_pass_skill_split and self.pass_skill_count ~= 0 then
				var_1_7 = var_1_9 + self.pass_skill_count
			elseif var_1_3[iter_1_1][1] == LaunchBallTaskMgr.type_trigger_skill_time and self.double_skill_time and var_1_3[iter_1_1][3] >= self.double_skill_time then
				var_1_7 = var_1_8
			end

			if var_1_7 and var_1_7 ~= 0 then
				if var_1_8 < var_1_7 then
					var_1_7 = var_1_8
				end

				table.insert(var_1_4, {
					id = var_1_5,
					progress = var_1_7
				})
			end
		end
	end

	for iter_1_2 = 1, #var_1_4 do
		pg.m02:sendNotification(GAME.UPDATE_TASK_PROGRESS, {
			taskId = var_1_4[iter_1_2].id,
			progress = var_1_4[iter_1_2].progress
		})
	end

	return
end

function LaunchBallTaskMgr.GetRedTip()
	local var_2_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_ZUMA_TASK)

	if var_2_0 and not var_2_0:isEnd() then
		local var_2_1 = getProxy(TaskProxy)

		return underscore.any(var_2_0:getConfig("config_data"), function(arg_3_0)
			assert(var_2_1:getTaskVO(arg_3_0), "without this task:" .. arg_3_0)

			return var_2_1:getTaskVO(arg_3_0):getTaskStatus() == 1
		end)
	end

	return false
end

return LaunchBallTaskMgr
