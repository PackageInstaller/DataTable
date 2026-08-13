class = var_0_10000

local var_0_0 = "GuildMissionNode"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseVO"))

var_0_1.STATE_DOING = 0
var_0_1.STATE_SUCCESS = 1
var_0_1.STATE_FAILED = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.node_id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.position = arg_1_1.position
	arg_1_0.status = arg_1_1.status

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.guild_event_node
end

function var_0_1.GetPosition(arg_3_0)
	return arg_3_0.position
end

function var_0_1.IsFinish(arg_4_0)
	return arg_4_0.status > 0
end

function var_0_1.IsSuccess(arg_5_0)
	return arg_5_0.status > var_0_1.STATE_SUCCESS
end

function var_0_1.GetIcon(arg_6_0)
	return arg_6_0:getConfig("icon")
end

function var_0_1.GetAwards(arg_7_0)
	if arg_7_0.status == var_0_1.STATE_SUCCESS then
		return arg_7_0:getConfig("success_award")
	elseif arg_7_0.status == var_0_1.STATE_FAILED then
		return arg_7_0:getConfig("fail_award")
	end

	return
end

function var_0_1.GetLog(arg_8_0)
	if arg_8_0.status == var_0_1.STATE_SUCCESS or arg_8_0.status == var_0_1.STATE_FAILED then
		local var_8_0 = arg_8_0
		local var_8_1 = arg_8_0.GetAwards(var_8_0)

		getDropInfo = var_8_0

		local var_8_2 = var_8_0(var_8_1)
		local var_8_3 = arg_8_0:getConfig("fail_describe")

		if arg_8_0.status == var_0_1.STATE_SUCCESS then
			var_8_3 = arg_8_0:getConfig("success_describe")
		end

		string = var_4

		return var_4.gsub(var_8_3, "$1", var_8_2)
	end

	return
end

function var_0_1.IsItemType(arg_9_0)
	return arg_9_0:getConfig("item") == "box"
end

function var_0_1.IsBattleType(arg_10_0)
	return arg_10_0:getConfig("item") == "sairendanchuan"
end

return var_0_1
