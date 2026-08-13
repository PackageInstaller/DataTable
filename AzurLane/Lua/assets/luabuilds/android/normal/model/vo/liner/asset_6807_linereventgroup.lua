class = var_0_10000

local var_0_0 = "LinerEventGroup"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.events = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_0:GetIds()) do
		local var_1_0 = arg_1_0.events

		LinerEvent = var_1_10008
		var_1_0[iter_1_1] = var_1_10008.New(iter_1_1)
	end

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.activity_liner_event_group
end

function var_0_1.GetTitle(arg_3_0)
	HXSet = var_1_10001

	return var_1_10001.hxLan(arg_3_0:getConfig("title"))
end

function var_0_1.GetPic(arg_4_0)
	return arg_4_0:getConfig("pic")
end

function var_0_1.GetEvent(arg_5_0, arg_5_1)
	return arg_5_0.events[arg_5_1]
end

function var_0_1.GetEvents(arg_6_0)
	return arg_6_0.events
end

function var_0_1.GetIds(arg_7_0)
	return arg_7_0:getConfig("ids")
end

function var_0_1.GetEventList(arg_8_0)
	local var_8_0 = {}

	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.events) do
		table = var_1_10007

		var_1_10007.insert(var_8_0, iter_8_1)
	end

	return var_8_0
end

function var_0_1.GetConclusions(arg_9_0)
	return arg_9_0:getConfig("conclusion")
end

function var_0_1.GetDrop(arg_10_0)
	Drop = var_1_10001

	return var_1_10001.Create(arg_10_0:getConfig("drop_display"))
end

return var_0_1
