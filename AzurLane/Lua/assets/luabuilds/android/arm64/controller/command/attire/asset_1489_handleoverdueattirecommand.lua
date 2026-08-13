class = var_0_10000

local var_0_0 = "HandleOverDueAttireCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	AttireProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)

	if #var_2.getExpiredChaces(var_1_0) > 0 then
		local var_1_1 = arg_1_0
		local var_1_2 = arg_1_0.sendNotification

		GAME = var_1_10007

		var_1_2(var_1_1, var_1_10007.HANDLE_OVERDUE_ATTIRE_DONE, var_3)
	end

	return
end

return var_0_1
