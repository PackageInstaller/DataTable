class = var_0_10000

local var_0_0 = "ActivityPermanentStartCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).activity_id

	getProxy = var_1_0
	ActivityPermanentProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.GetActivityTypeById(var_1_2, var_1_1) and var_4:getDoingActivityId(var_5)

	local function var_1_4()
		local var_2_1

		if var_1_3 == var_1_1 then
			local var_2_0 = arg_1_0

			var_2_1 = var_2_1.sendNotification
			GAME = var_2_10003

			var_2_1(var_2_0, var_2_10003.ACTIVITY_PERMANENT_START_DONE, {
				id = var_1_1
			})

			return
		end

		pg = var_2_1

		local var_2_2 = var_2_1.ConnectionMgr.GetInstance()

		var_0.Send(var_2_2, 11206, {
			activity_id = var_1_1
		}, 11207, function(arg_3_0)
			local var_3_2

			if arg_3_0.result == 0 then
				local var_3_0 = var_0

				var_3_2.startSelectActivity(var_3_0, var_1_1)

				local var_3_1 = arg_1_0

				var_3_2 = var_3_2.sendNotification
				GAME = var_4

				var_3_2(var_3_1, var_4.ACTIVITY_PERMANENT_START_DONE, {
					id = var_1_1
				})
			else
				warning = var_3_2

				var_3_2("error permanent")
			end

			return
		end)

		return
	end

	local function var_1_5(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.ACTIVITY_PERMANENT_STOP, {
			activity_id = arg_4_0,
			callback = arg_4_1
		})

		return
	end

	if var_1_3 and var_1_3 ~= var_1_1 then
		var_1_5(var_1_3, var_1_4)
	else
		var_1_4()
	end

	return
end

return var_0_1
