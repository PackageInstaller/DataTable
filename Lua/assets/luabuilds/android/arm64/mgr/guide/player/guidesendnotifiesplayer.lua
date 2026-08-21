local var_0_0 = class("GuideSendNotifiesPlayer", import(".GuidePlayer"))

function var_0_0.OnExecution(arg_1_0, arg_1_1, arg_1_2)
	for iter_1_0, iter_1_1 in ipairs((arg_1_1:GetNotifies())) do
		pg.m02:sendNotification(iter_1_1.notify, iter_1_1.body)
	end

	arg_1_2()

	return
end

return var_0_0
