local var_0_0 = class("BackYardRequestShipExpCommand", pm.SimpleCommand)

var_0_0.isTipSettle = true

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if getProxy(ContextProxy):getCurrentContext().mediator.__cname ~= CourtYardMediator.__cname then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(19026, {
		type = 0
	}, 19027, function(arg_2_0)
		local var_2_0 = getProxy(DormProxy)
		local var_2_1 = var_2_0:getRawData()

		var_2_1:consumeFood(arg_2_0.food)
		var_2_1:UpdateLastAddShipExpTime(pg.TimeMgr.GetInstance():GetServerTime())
		var_2_1:UpdateNextSettlementShipExpTime(arg_2_0.next_timestamp)
		var_2_0:updateDrom(var_2_1, BackYardConst.DORM_UPDATE_TYPE_UPDATEFOOD)

		if arg_2_0.exp > 0 then
			local var_2_2 = getProxy(BayProxy)

			for iter_2_0, iter_2_1 in pairs((var_2_1:GetBayShipOnFloor(DormShip.FLOOR_1))) do
				local var_2_3 = var_2_2:getShipById(iter_2_1.id)
				local var_2_4 = var_2_2:getShipById(iter_2_1.id)

				if var_2_4.level ~= var_2_4:getMaxLevel() then
					var_2_4:addExp(arg_2_0.exp)
					var_2_2:updateShip(var_2_4)
					arg_1_0:sendNotification(GAME.BACKYARD_SHIP_EXP_ADDED, {
						id = var_2_4.id,
						exp = arg_2_0.exp
					})
				end

				;({})[var_2_4.id] = var_2_4
				;({})[var_2_3.id] = var_2_3
			end

			arg_1_0:sendNotification(DormProxy.SHIPS_EXP_ADDED, {
				oldShips = {},
				newShips = {},
				exp = arg_2_0.exp,
				food = arg_2_0.food,
				time = var_2_1:GetLastAddShipExpTime(),
				isTipSettle = var_0_0.isTipSettle
			})

			var_0_0.isTipSettle = false
		end

		var_2_0:SettlementShipExp()

		return
	end)

	return
end

return var_0_0
