class = var_0_10000

local var_0_0 = "GuideHideUIStep"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuideStep"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.nodes = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.hideui) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_1_0 = arg_1_0.nodes
		local var_1_1 = {
			path = iter_1_1.path
		}
		local var_1_2

		if not iter_1_1.delay then
			var_1_2 = 0
		end

		var_1_1.delay = var_1_2

		local var_1_3

		if not iter_1_1.pathIndex then
			var_1_3 = -1
		end

		var_1_1.pathIndex = var_1_3
		var_1_1.hideFlag = iter_1_1.ishide
		var_1_1.type = iter_1_1.type

		var_1_10007(var_1_0, var_1_1)
	end

	return
end

function var_0_1.GetType(arg_2_0)
	GuideStep = var_1_10001

	return var_1_10001.TYPE_HIDEUI
end

function var_0_1.GetHideNodes(arg_3_0)
	return arg_3_0.nodes
end

return var_0_1
