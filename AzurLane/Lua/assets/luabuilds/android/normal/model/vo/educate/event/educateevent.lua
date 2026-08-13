class = var_0_10000

local var_0_0 = "EducateEvent"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.TYPE_PLAN = 1
var_0_1.TYPE_OPTION = 2
var_0_1.TYPE_BUBBLE = 3

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.child_event
end

function var_0_1.GetPerformance(arg_3_0)
	return arg_3_0:getConfig("performance")
end

return var_0_1
