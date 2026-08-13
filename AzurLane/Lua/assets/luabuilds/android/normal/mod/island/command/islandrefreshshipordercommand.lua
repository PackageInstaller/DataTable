class = var_0_10000

local var_0_0 = "IslandRefreshShipOrderCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	getProxy = var_1_10004
	IslandProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.GetIsland(var_1_1)
	local var_1_3 = var_4.GetOrderAgency(var_1_2)

	if not var_4.GetShipOrderSlot(var_1_3, var_1_0) then
		return
	end

	pg = var_1_3

	local var_1_4 = var_1_3.ConnectionMgr.GetInstance()

	var_6.Send(var_1_4, 21429, {
		slot_id = var_1_0
	}, 21430, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_1.Init(var_2_0, arg_2_0.slot, true)

			local var_2_1 = arg_1_0
			local var_2_2 = var_1.sendNotification

			GAME = var_3

			var_2_2(var_2_1, var_3.ISLAND_REFRESH_SHIP_ORDER_DONE, {
				id = var_1_0
			})
		end

		return
	end)

	return
end

return var_0_1
