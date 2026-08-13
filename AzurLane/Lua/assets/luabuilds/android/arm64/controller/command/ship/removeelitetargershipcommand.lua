class = var_0_10000

local var_0_0 = "RemoveEliteTargerShipCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.callback

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 13111, {
		ship_id = var_1_0
	}, 13112, function(arg_2_0)
		getProxy = var_2_10001
		ChapterProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)

		var_1.setEliteCache(var_2_0, arg_2_0.fleet_list)

		local var_2_1 = arg_1_0
		local var_2_2 = var_1.sendNotification

		GAME = var_4

		var_2_2(var_2_1, var_4.REMOVE_ELITE_TARGET_SHIP_DONE, {
			shipId = var_1_0
		})

		existCall = var_2_2

		var_2_2(var_1_1)

		return
	end)

	return
end

return var_0_1
