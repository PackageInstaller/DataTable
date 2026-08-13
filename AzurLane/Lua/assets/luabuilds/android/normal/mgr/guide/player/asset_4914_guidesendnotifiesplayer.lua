class = var_0_10000

local var_0_0 = "GuideSendNotifiesPlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuidePlayer"))

function var_0_1.OnExecution(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.GetNotifies(var_1_0)

	ipairs = var_1_0

	for iter_1_0, iter_1_1 in var_1_0(var_1_1) do
		pg = var_1_10009

		local var_1_2 = var_1_10009.m02

		var_1_10009.sendNotification(var_1_2, iter_1_1.notify, iter_1_1.body)
	end

	arg_1_2()

	return
end

return var_0_1
