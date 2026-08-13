class = var_0_10000

local var_0_0 = "GuideSendNotifiesStep"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".GuideStep"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.notifies = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.notifies) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.notifies, {
			notify = iter_1_1.notify,
			body = iter_1_1.body
		})
	end

	return
end

function var_0_1.GetType(arg_2_0)
	GuideStep = var_1_10001

	return var_1_10001.TYPE_SENDNOTIFIES
end

function var_0_1.GetNotifies(arg_3_0)
	return arg_3_0.notifies
end

function var_0_1.ExistTrigger(arg_4_0)
	return true
end

return var_0_1
