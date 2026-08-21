local var_0_0 = class("GuideSendNotifiesStep", import(".GuideStep"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.notifies = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.notifies) do
		table.insert(arg_1_0.notifies, {
			notify = iter_1_1.notify,
			body = iter_1_1.body
		})
	end

	return
end

function var_0_0.GetType(arg_2_0)
	return GuideStep.TYPE_SENDNOTIFIES
end

function var_0_0.GetNotifies(arg_3_0)
	return arg_3_0.notifies
end

function var_0_0.ExistTrigger(arg_4_0)
	return true
end

return var_0_0
