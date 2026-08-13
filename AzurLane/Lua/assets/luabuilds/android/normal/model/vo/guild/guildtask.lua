class = var_0_10000

local var_0_0 = "GuildTask"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

var_0_1.STATE_EMPTY = 0
var_0_1.STATE_ONGOING = 2
var_0_1.STATE_FINISHED = 3
var_0_1.PRIVATE_TASK_TYPE_EVENT = {
	400
}
var_0_1.PRIVATE_TASK_TYPE_BATTLE = {
	20,
	11
}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.id then
		var_1_0 = 0
	end

	arg_1_0.id = var_1_0
	arg_1_0.configId = arg_1_0.id

	local var_1_1

	if not arg_1_1.progress then
		var_1_1 = 0
	end

	arg_1_0.progress = var_1_1

	local var_1_2

	if not arg_1_1.monday_0clock then
		var_1_2 = 0
	end

	arg_1_0.endTime = 0

	if var_1_2 > 0 then
		arg_1_0.endTime = var_1_2 + 0
	end

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.guild_mission_template
end

function var_0_1.GetLivenessAddition(arg_3_0)
	return arg_3_0:getConfig("guild_active")
end

function var_0_1.isExpire(arg_4_0)
	return arg_4_0.endTime > 0 and arg_4_0:isEnd()
end

function var_0_1.getProgress(arg_5_0)
	return arg_5_0.progress
end

function var_0_1.updateProgress(arg_6_0, arg_6_1)
	arg_6_0.progress = arg_6_1

	return
end

function var_0_1.isEnd(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_7_0) >= arg_7_0.endTime
end

function var_0_1.getState(arg_8_0)
	if arg_8_0.id == 0 or arg_8_0:isEnd() then
		return var_0_1.STATE_EMPTY
	elseif arg_8_0:isFinished() then
		return var_0_1.STATE_FINISHED
	else
		return var_0_1.STATE_ONGOING
	end

	return
end

function var_0_1.GetPresonTaskId(arg_9_0)
	return arg_9_0:getConfig("task_id")
end

function var_0_1.GetPrivateTaskName(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.GetPresonTaskId(var_10_0)

	pg = var_10_0

	return var_10_0.task_data_template[var_10_1].desc
end

function var_0_1.IsSamePrivateTask(arg_11_0, arg_11_1)
	return arg_11_1 and arg_11_1.id == arg_11_0:GetPresonTaskId()
end

function var_0_1.isFinished(arg_12_0)
	return arg_12_0.progress >= arg_12_0:getMaxProgress()
end

function var_0_1.getMaxProgress(arg_13_0)
	return arg_13_0:getConfig("max_num")
end

function var_0_1.isRemind(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.getConfig(var_14_0, "warning_time")[arg_14_1]

	pg = var_14_0

	local var_14_2 = var_14_0.TimeMgr.GetInstance()

	return var_14_1 >= var_3.GetServerWeek(var_14_2)
end

function var_0_1.GetScale(arg_15_0)
	return arg_15_0:getConfig("task_scale")
end

function var_0_1.GetDesc(arg_16_0)
	return arg_16_0:getConfig("name")
end

function var_0_1.GetPrivateAward(arg_17_0)
	return arg_17_0:getConfig("award_display")
end

function var_0_1.GetCaptailAward(arg_18_0)
	return arg_18_0:getConfig("award_capital_display") * arg_18_0:getMaxProgress()
end

function var_0_1.GetCurrCaptailAward(arg_19_0)
	return arg_19_0.progress * arg_19_0:getConfig("award_capital_display")
end

function var_0_1.PrivateBeFinished(arg_20_0)
	local var_20_0 = var_0_1.STATE_ONGOING
	local var_20_1 = arg_20_0

	if var_20_0 == arg_20_0.getState(var_20_1) then
		local var_20_2 = arg_20_0
		local var_20_3 = arg_20_0.GetPresonTaskId(var_20_2)

		getProxy = var_20_2
		TaskProxy = var_20_1

		local var_20_4 = var_20_2(var_20_1)
		local var_20_5

		if not var_2.getTaskById(var_20_4, var_20_3) then
			var_20_5 = var_2:getFinishTaskById(var_20_3)
		end

		local var_20_6

		if var_20_5 and var_20_5:isFinish() then
			var_20_6 = not var_20_5:isReceive()
		end

		return var_20_6
	end

	return false
end

function var_0_1.SamePrivateTaskType(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.GetPresonTaskId(var_21_0)

	pg = var_21_0

	local var_21_2 = var_21_0.task_data_template[var_21_1].sub_type

	_ = var_1_10004

	return var_1_10004.any(arg_21_1, function(arg_22_0)
		return arg_22_0 == var_21_2
	end)
end

return var_0_1
