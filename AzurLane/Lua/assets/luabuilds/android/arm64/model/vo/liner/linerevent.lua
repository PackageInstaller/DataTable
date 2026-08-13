class = var_0_10000

local var_0_0 = "LinerEvent"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.activity_liner_event
end

function var_0_1.GetOptionName(arg_3_0)
	HXSet = var_1_10001

	return var_1_10001.hxLan(arg_3_0:getConfig("option"))
end

function var_0_1.GetOptionDisplay(arg_4_0)
	local var_4_0 = {}

	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0:getConfig("option_desc_display")) do
		HXSet = var_4_1

		local var_4_1 = var_4_1.hxLan(iter_4_1[1])

		table = var_1_10008

		var_1_10008.insert(var_4_0, var_4_1)
	end

	return var_4_0
end

function var_0_1.GetTitle(arg_5_0)
	HXSet = var_1_10001

	return var_1_10001.hxLan(arg_5_0:getConfig("title"))
end

function var_0_1.GetLogDesc(arg_6_0)
	HXSet = var_1_10001

	return var_1_10001.hxLan(arg_6_0:getConfig("option_desc"))
end

function var_0_1.GetReasoningDesc(arg_7_0)
	HXSet = var_1_10001

	return var_1_10001.hxLan(arg_7_0:getConfig("option_desc_2"))
end

return var_0_1
