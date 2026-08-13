class = var_0_10000

local var_0_0 = "ActivityPermanentFinishCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().activity_id

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 11208, {
		typ = 1,
		activity_id = var_1_0
	}, 11209, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			getProxy = var_2_3
			ActivityPermanentProxy = var_2_10002

			local var_2_0 = var_2_3(var_2_10002)

			var_2_3.finishNowActivity(var_2_0, var_1_0)

			getProxy = var_2_3
			ActivityProxy = var_2_0

			local var_2_1 = var_2_3(var_2_0)

			var_2_3.deleteActivityById(var_2_1, var_1_0)

			local var_2_2 = arg_1_0

			var_2_3 = var_2_3.sendNotification
			GAME = var_3

			var_2_3(var_2_2, var_3.ACTIVITY_PERMANENT_FINISH_DONE, {
				activity_id = var_1_0
			})
		else
			warning = var_2_3

			var_2_3("error permanent")
		end

		return
	end)

	return
end

return var_0_1
