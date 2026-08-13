class = var_0_10000

local var_0_0 = "SingleEventRefreshCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 11202, {
		cmd = 2,
		activity_id = var_1_0.actId
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			ActivityProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.getActivityById(var_2_0, var_1_0.actId)

			var_1.SetDailyEventIds(var_2_1, arg_2_0.number)

			getProxy = var_2
			ActivityProxy = var_2_1

			local var_2_2 = var_2(var_2_1)

			var_2.updateActivity(var_2_2, var_1)

			pg = var_2

			local var_2_3 = var_2.m02
			local var_2_4 = var_2.sendNotification

			GAME = var_5

			var_2_4(var_2_3, var_5.SINGLE_EVENT_REFRESH_DONE, {
				activity = var_1
			})
		else
			pg = var_1

			local var_2_5 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_5, "Refresh single event failed:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
