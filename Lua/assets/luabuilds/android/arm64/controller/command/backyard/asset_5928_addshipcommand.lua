local AddShipCommand = class("AddShipCommand", pm.SimpleCommand)

function AddShipCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.type
	local var_1_3 = var_1_0.callBack
	local var_1_4 = getProxy(DormProxy)
	local var_1_5 = getProxy(BayProxy):getShipById(var_1_0.id)
	local var_1_6 = var_1_4:getRawData()

	pg.ConnectionMgr.GetInstance():Send(19002, {
		ship_id = var_1_0.id,
		type = var_1_0.type
	}, 19003, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_6:AddShip(var_1_5.id, var_1_2)
			var_1_4:updateDrom(var_1_6, BackYardConst.DORM_UPDATE_TYPE_SHIP)
			self:sendNotification(GAME.ADD_SHIP_DONE, {
				id = var_1_1,
				type = var_1_2
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("backyard_addShip", arg_2_0.result))
		end

		if var_1_3 then
			var_1_3()
		end

		return
	end)

	return
end

return AddShipCommand
