class = var_0_10000

local var_0_0 = "ActivityPermanentStopCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().activity_id
	local var_1_1 = var_2.callback

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 11208, {
		typ = 2,
		activity_id = var_1_0
	}, 11209, function(arg_2_0)
		local var_2_4

		if arg_2_0.result == 0 then
			getProxy = var_2_4
			ActivityPermanentProxy = var_2_10002

			local var_2_0 = var_2_4(var_2_10002)

			var_2_4.StopNowActivity(var_2_0, var_1_0)

			getProxy = var_2_4
			ActivityProxy = var_2_0

			local var_2_1 = var_2_4(var_2_0)

			if var_2_4.RawGetActivityById(var_2_1, var_1_0) then
				getProxy = var_2_4
				ActivityProxy = var_2_1

				local var_2_2 = var_2_4(var_2_1)

				var_2_4.deleteActivityById(var_2_2, var_1_0)
			end

			local var_2_3 = arg_1_0

			var_2_4 = var_2_4.sendNotification
			GAME = var_3

			var_2_4(var_2_3, var_3.ACTIVITY_PERMANENT_STOP_DONE, {
				activity_id = var_1_0
			})

			existCall = var_2_4

			var_2_4(var_1_1)
		else
			warning = var_2_4

			var_2_4("error permanent")
		end

		return
	end)

	return
end

return var_0_1
