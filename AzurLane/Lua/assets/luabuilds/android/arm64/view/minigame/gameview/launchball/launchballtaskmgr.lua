local var_0_0 = class("LaunchBallTaskMgr")

var_0_0.type_split = 1
var_0_0.type_series_split = 2
var_0_0.type_close_split = 3
var_0_0.type_over_split = 4
var_0_0.type_many_split = 5
var_0_0.type_pass_skill = 200
var_0_0.type_pass_skill_split = 201
var_0_0.type_trigger_skill = 300
var_0_0.type_trigger_skill_split = 301
var_0_0.type_trigger_skill_split_all = 302
var_0_0.type_trigger_skill_time = 303
var_0_0.type_player_target_round = 400
var_0_0.type_player_round = 401

function var_0_0.CheckTaskUpdate(arg_1_0)
	local var_1_0 = LaunchBallActivityMgr.GetPlayerZhuanshuIndex(arg_1_0.player)

	if var_1_0 and not LaunchBallActivityMgr.CheckZhuanShuAble(ActivityConst.MINIGAME_ZUMA, var_1_0) then
		return
	end

	local var_1_2 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_ZUMA_TASK):getConfig("config_client")
	local var_1_3 = {}

	for iter_1_0 = 1, #var_1_2 do
		if var_1_2[iter_1_0].player == arg_1_0.player then
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

			if var_1_3[iter_1_1][1] == var_0_0.type_split and arg_1_0.split_count ~= 0 then
				var_1_7 = var_1_8 < arg_1_0.split_count + var_1_9 and var_1_8 or arg_1_0.split_count + var_1_9
			elseif var_1_3[iter_1_1][1] == var_0_0.type_player_target_round then
				if var_1_3[iter_1_1][4] == arg_1_0.round then
					var_1_7 = var_1_9 + 1
				end
			elseif var_1_3[iter_1_1][1] == var_0_0.type_player_round then
				var_1_7 = var_1_9 + 1
			elseif var_1_3[iter_1_1][1] == var_0_0.type_trigger_skill and arg_1_0.use_skill ~= 0 then
				var_1_7 = var_1_9 + arg_1_0.use_skill
			elseif var_1_3[iter_1_1][1] == var_0_0.type_series_split and arg_1_0.series_count ~= 0 then
				var_1_7 = var_1_9 + arg_1_0.series_count
			elseif var_1_3[iter_1_1][1] == var_0_0.type_close_split and arg_1_0.mix_count ~= 0 then
				var_1_7 = var_1_9 + arg_1_0.mix_count
			elseif var_1_3[iter_1_1][1] == var_0_0.type_over_split and arg_1_0.over_count ~= 0 then
				var_1_7 = var_1_9 + arg_1_0.over_count
			elseif var_1_3[iter_1_1][1] == var_0_0.type_many_split and arg_1_0.many_count ~= 0 then
				var_1_7 = var_1_9 + arg_1_0.many_count
			elseif var_1_3[iter_1_1][1] == var_0_0.type_pass_skill and arg_1_0.use_pass_skill ~= 0 then
				var_1_7 = var_1_9 + arg_1_0.use_pass_skill
			elseif var_1_3[iter_1_1][1] == var_0_0.type_trigger_skill_split and arg_1_0.skill_count ~= 0 then
				if var_1_3[iter_1_1][3] <= arg_1_0.skill_count then
					var_1_7 = var_1_8
				end
			elseif var_1_3[iter_1_1][1] == var_0_0.type_trigger_skill_split_all and arg_1_0.skill_count ~= 0 then
				var_1_7 = var_1_9 + arg_1_0.skill_count
			elseif var_1_3[iter_1_1][1] == var_0_0.type_pass_skill_split and arg_1_0.pass_skill_count ~= 0 then
				var_1_7 = var_1_9 + arg_1_0.pass_skill_count
			elseif var_1_3[iter_1_1][1] == var_0_0.type_trigger_skill_time and arg_1_0.double_skill_time and var_1_3[iter_1_1][3] >= arg_1_0.double_skill_time then
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

function var_0_0.GetRedTip()
	local var_2_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_ZUMA_TASK)

	if var_2_0 and not var_2_0:isEnd() then
		local var_2_1 = getProxy(TaskProxy)

		return underscore.any(var_2_0:getConfig("config_data"), function(arg_3_0)
			assert(var_2_1:getTaskVO(arg_3_0), "without this task:" .. arg_3_0)

			local var_3_0 = var_2_1:getTaskVO(arg_3_0)

			return var_3_0:getTaskStatus() == 1
		end)
	end

	return false
end

return var_0_0
