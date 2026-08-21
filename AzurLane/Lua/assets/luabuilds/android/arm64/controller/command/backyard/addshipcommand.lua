local var_0_0 = class("AddShipCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callBack
	local var_1_2 = getProxy(DormProxy)
	local var_1_3 = getProxy(BayProxy):getShipById(var_1_0.id)
	local var_1_4 = getProxy(DormProxy):getRawData()

	pg.ConnectionMgr.GetInstance():Send(19002, {
		ship_id = var_1_0.id,
		type = var_1_0.type
	}, 19003, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_4:AddShip(var_1_3.id, var_0)
			var_1_2:updateDrom(var_1_4, BackYardConst.DORM_UPDATE_TYPE_SHIP)
			arg_1_0:sendNotification(GAME.ADD_SHIP_DONE, {
				id = var_0,
				type = var_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("backyard_addShip", arg_2_0.result))
		end

		if var_1_1 then
			var_1_1()
		end

		return
	end)

	return
end

return var_0_0
