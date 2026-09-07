local WorldShipRepairCommand = class("WorldShipRepairCommand", pm.SimpleCommand)

function WorldShipRepairCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shipIds
	local var_1_2 = var_1_0.totalCost
	local var_1_3 = nowWorld()
	local var_1_4 = var_1_3:GetInventoryProxy()

	if var_1_0.totalCost > var_1_4:GetItemCount(WorldItem.MoneyId) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(33407, {
		ship_list = var_1_0.shipIds
	}, 0, function(arg_2_0)
		if arg_2_0.result == 0 then
			_.each(var_1_1, function(arg_3_0)
				local var_3_0 = var_1_3:GetShip(arg_3_0)

				assert(var_3_0, "ship not exist: " .. arg_3_0)
				var_3_0:Repair()

				return
			end)
			var_1_4:RemoveItem(WorldItem.MoneyId, var_1_2)
			self:sendNotification(GAME.WORLD_SHIP_REPAIR_DONE, {
				shipIds = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("world_ship_repair_err_", arg_2_0.result))
		end

		return
	end)

	return
end

return WorldShipRepairCommand
