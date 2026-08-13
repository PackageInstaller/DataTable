class = var_0_10000

local var_0_0 = "WorldShipRepairCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipIds
	local var_1_1 = var_2.totalCost

	nowWorld = var_1_10005

	local var_1_2 = var_1_10005()
	local var_1_3 = var_5.GetInventoryProxy(var_1_2)
	local var_1_4 = var_6.GetItemCount

	WorldItem = var_1_10009

	if var_1_1 > var_1_4(var_1_3, var_1_10009.MoneyId) then
		pg = var_1_3

		local var_1_5 = var_1_3.TipsMgr.GetInstance()

		var_1_3 = var_1_3.ShowTips
		i18n = var_1_10010

		var_1_3(var_1_5, var_1_10010("common_no_item_1"))

		return
	end

	pg = var_1_3

	local var_1_6 = var_1_3.ConnectionMgr.GetInstance()

	var_8.Send(var_1_6, 33407, {
		ship_list = var_1_0
	}, 0, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			_ = var_2_1

			var_2_1.each(var_1_0, function(arg_3_0)
				local var_3_0 = var_0
				local var_3_1 = var_1.GetShip(var_3_0, arg_3_0)

				assert = var_3_0

				var_3_0(var_3_1, "ship not exist: " .. arg_3_0)
				var_3_1:Repair()

				return
			end)

			local var_2_0 = var_0

			var_2_1 = var_2_1.RemoveItem
			WorldItem = var_2_10003

			var_2_1(var_2_0, var_2_10003.MoneyId, var_1_1)

			local var_2_2 = arg_1_0

			var_2_1 = var_2_1.sendNotification
			GAME = var_2_10003

			var_2_1(var_2_2, var_2_10003.WORLD_SHIP_REPAIR_DONE, {
				shipIds = var_1_0
			})
		else
			pg = var_2_1

			local var_2_3 = var_2_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_4(var_2_3, var_2_10003("world_ship_repair_err_", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
