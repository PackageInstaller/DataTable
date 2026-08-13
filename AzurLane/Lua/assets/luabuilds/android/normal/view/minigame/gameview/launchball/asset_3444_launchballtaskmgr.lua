class = var_0_10000

local var_0_0 = var_0_10000("LaunchBallTaskMgr")

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
	local var_1_0 = arg_1_0.player

	LaunchBallActivityMgr = var_1_10002

	local var_1_1 = var_1_10002.GetPlayerZhuanshuIndex(var_1_0)
	local var_1_2

	if var_1_1 then
		LaunchBallActivityMgr = var_1_10004
		var_1_10004 = var_1_10004.CheckZhuanShuAble
		ActivityConst = var_1_10005

		if not var_1_10004(var_1_10005.MINIGAME_ZUMA, var_1_1) then
			return
		end
	end

	getProxy = var_1_10004
	ActivityProxy = var_1_10005

	local var_1_3 = var_1_10004(var_1_10005)
	local var_1_4 = var_4.getActivityById

	ActivityConst = var_1_10006

	local var_1_5 = var_1_4(var_1_3, var_1_10006.MINIGAME_ZUMA_TASK)
	local var_1_6 = var_4.getConfig(var_1_5, "config_client")
	local var_1_7 = {}

	for iter_1_0 = 1, #var_1_6 do
		if var_1_6[iter_1_0].player == var_1_0 then
			var_1_7 = var_1_6[iter_1_0].task
		end
	end

	local var_1_8 = {}

	for iter_1_1 = 1, #var_1_7 do
		var_1_10012 = var_1_7[iter_1_1][1]

		local var_1_9 = var_1_7[iter_1_1][2]

		var_1_10014 = var_1_7[iter_1_1][3]

		local var_1_10 = var_1_7[iter_1_1][4]

		getProxy = var_1_10016
		TaskProxy = var_1_10017
		var_1_10017 = var_1_10016(var_1_10017)

		if var_1_10016.getTaskById(var_1_10017, var_1_9) and var_1_10016:getTaskStatus() == 0 then
			var_1_10017 = 0

			local var_1_11 = var_1_10016:getTargetNumber()
			local var_1_12 = var_1_10016:getProgress()

			if var_1_10012 == var_0_0.type_split and arg_1_0.split_count ~= 0 then
				var_1_10017 = var_1_11 < arg_1_0.split_count + var_1_12 and var_1_11 or arg_1_0.split_count + var_1_12
			elseif var_1_10012 == var_0_0.type_player_target_round then
				if var_1_10 == arg_1_0.round then
					var_1_10017 = var_1_12 + 1
				end
			elseif var_1_10012 == var_0_0.type_player_round then
				var_1_10017 = var_1_12 + 1
			elseif var_1_10012 == var_0_0.type_trigger_skill and arg_1_0.use_skill ~= 0 then
				var_1_10017 = var_1_12 + arg_1_0.use_skill
			elseif var_1_10012 == var_0_0.type_series_split and arg_1_0.series_count ~= 0 then
				var_1_10017 = var_1_12 + arg_1_0.series_count
			elseif var_1_10012 == var_0_0.type_close_split and arg_1_0.mix_count ~= 0 then
				var_1_10017 = var_1_12 + arg_1_0.mix_count
			elseif var_1_10012 == var_0_0.type_over_split and arg_1_0.over_count ~= 0 then
				var_1_10017 = var_1_12 + arg_1_0.over_count
			elseif var_1_10012 == var_0_0.type_many_split and arg_1_0.many_count ~= 0 then
				var_1_10017 = var_1_12 + arg_1_0.many_count
			elseif var_1_10012 == var_0_0.type_pass_skill and arg_1_0.use_pass_skill ~= 0 then
				var_1_10017 = var_1_12 + arg_1_0.use_pass_skill
			elseif var_1_10012 == var_0_0.type_trigger_skill_split and arg_1_0.skill_count ~= 0 then
				if var_1_10014 <= arg_1_0.skill_count then
					var_1_10017 = var_1_11
				end
			elseif var_1_10012 == var_0_0.type_trigger_skill_split_all and arg_1_0.skill_count ~= 0 then
				var_1_10017 = var_1_12 + arg_1_0.skill_count
			elseif var_1_10012 == var_0_0.type_pass_skill_split and arg_1_0.pass_skill_count ~= 0 then
				var_1_10017 = var_1_12 + arg_1_0.pass_skill_count
			elseif var_1_10012 == var_0_0.type_trigger_skill_time and arg_1_0.double_skill_time and arg_1_0.double_skill_time <= var_1_10014 then
				var_1_10017 = var_1_11
			end

			if var_1_10017 and var_1_10017 ~= 0 then
				if var_1_11 < var_1_10017 then
					var_1_10017 = var_1_11
				end

				table = var_20

				var_20.insert(var_1_8, {
					id = var_1_9,
					progress = var_1_10017
				})
			end
		end
	end

	for iter_1_2 = 1, #var_1_8 do
		pg = var_1_10012

		local var_1_13 = var_1_10012.m02

		var_1_10012 = var_1_10012.sendNotification
		GAME = var_1_10014

		var_1_10012(var_1_13, var_1_10014.UPDATE_TASK_PROGRESS, {
			taskId = var_1_8[iter_1_2].id,
			progress = var_1_8[iter_1_2].progress
		})
	end

	return
end

function var_0_0.GetRedTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_2_0 = var_1_10000(var_1_10001)
	local var_2_1 = var_0.getActivityById

	ActivityConst = var_1_10002

	if var_2_1(var_2_0, var_1_10002.MINIGAME_ZUMA_TASK) and not var_0:isEnd() then
		local var_2_2 = var_0
		local var_2_3 = var_0.getConfig(var_2_2, "config_data")

		getProxy = var_2_2
		TaskProxy = var_3

		local var_2_4 = var_2_2(var_3)

		underscore = var_3

		return var_3.any(var_2_3, function(arg_3_0)
			assert = var_2_10001

			local var_3_0 = var_2_4

			var_2_10001(var_2.getTaskVO(var_3_0, arg_3_0), "without this task:" .. arg_3_0)

			local var_3_1 = var_2_4
			local var_3_2 = var_1.getTaskVO(var_3_1, arg_3_0)

			return var_1.getTaskStatus(var_3_2) == 1
		end)
	end

	return false
end

return var_0_0
