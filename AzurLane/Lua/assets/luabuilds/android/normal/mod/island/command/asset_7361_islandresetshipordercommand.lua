class = var_0_10000

local var_0_0 = "IslandResetShipOrderCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	IslandProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_3.GetIsland(var_1_2)
	local var_1_4 = var_3.GetOrderAgency(var_1_3)

	pg = var_1_3

	local var_1_5 = var_1_3.ConnectionMgr.GetInstance()

	var_4.Send(var_1_5, 21429, {
		slot_id = 0
	}, 21430, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_4

			var_1.UpdateNextManualReloadDelegateTime(var_2_0, arg_2_0.next_time)

			local var_2_1 = {}

			ipairs = var_2_0

			local var_2_2

			if not arg_2_0.appoint_list then
				var_2_2 = {}
			end

			for iter_2_0, iter_2_1 in var_2_0(var_2_2) do
				IslandShipOrderDelegateSlot = var_2_10007
				var_2_1[var_2_10007.New(iter_2_1).id] = var_2_10007
			end

			local var_2_3 = var_1_4

			var_2.AddDelegateSlotList(var_2_3, var_2_1)

			local var_2_4 = var_1_4
			local var_2_5 = var_2.GetShipSlotList(var_2_4)

			pairs = var_2_4

			for iter_2_2, iter_2_3 in var_2_4(var_2_5) do
				if iter_2_3:IsEmpty() then
					iter_2_3:Reset()
				end
			end

			local var_2_6 = arg_1_0
			local var_2_7 = var_3.sendNotification

			GAME = var_5

			var_2_7(var_2_6, var_5.ISLAND_RESET_SHIP_ORDER_DONE)
		end

		return
	end)

	return
end

return var_0_1
