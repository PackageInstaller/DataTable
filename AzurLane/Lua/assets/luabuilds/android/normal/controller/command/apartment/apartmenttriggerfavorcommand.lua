class = var_0_10000

local var_0_0 = "ApartmentTriggerFavorCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().groupId
	local var_1_1 = var_2.triggerId

	getProxy = var_1_10005
	ApartmentProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.getApartment(var_1_2, var_1_0)

	pg = var_1_2

	if var_1_2.dorm3d_favor_trigger[var_1_1].is_repeat == 0 and var_1_3.triggerCountDic[var_1_1] > 0 or var_5.stamina < var_7.is_daily_max then
		return
	end

	pg = var_8

	local var_1_4 = var_8.ConnectionMgr.GetInstance()

	var_8.Send(var_1_4, 28003, {
		ship_group = var_1_0,
		trigger_id = var_1_1
	}, 28004, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0
			local var_2_2

			var_2_1, var_2_2 = var_2_1.triggerFavor(var_2_0, var_1_0, var_1_1)

			local var_2_3 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_2_10005

			var_2_10003(var_2_3, var_2_10005.APARTMENT_TRIGGER_FAVOR_DONE, {
				triggerId = var_1_1,
				cost = var_2_2,
				delta = var_2_1,
				apartment = var_1_3
			})
		else
			pg = var_2_1

			local var_2_4 = var_2_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_5(var_2_4, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
