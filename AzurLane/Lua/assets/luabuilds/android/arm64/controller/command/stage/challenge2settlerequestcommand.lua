class = var_0_10000

local var_0_0 = "Challenge2SettleRequestCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	ActivityProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_3.getActivityByType

	ActivityConst = var_1_10007

	if not var_1_2(var_1_1, var_1_10007.ACTIVITY_TYPE_CHALLENGE) or var_4:isEnd() then
		return
	end

	pg = var_1_10005

	local var_1_3 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 24009, {
		activity_id = var_4.id
	}, 24010, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = arg_1_0
			local var_2_1 = var_1.sendNotification

			GAME = var_2_10004

			var_2_1(var_2_0, var_2_10004.CHALLENGE2_SETTLE_DONE)
		end

		return
	end)

	return
end

return var_0_1
