local var_0_0 = class("ShipAddMoneyCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(19013, {
		id = arg_1_1:getBody()
	}, 19014, function(arg_2_0)
		local var_2_9000

		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(BayProxy)
			local var_2_1 = var_2_0.getShipById(var_2_9000, var_0)
			local var_2_2 = getProxy(DormProxy)
			local var_2_3 = var_2_2:getRawData()
			local var_2_4, var_2_5 = var_2_3.HarvestInimacyAndMoney(var_2_0, var_0)

			var_2_2:updateDrom(var_2_3, BackYardConst.DORM_UPDATE_TYPE_SHIP)

			if var_2_4 == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_getResource_emptry"))
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_shipAddMoney_ok", var_2_1:getName(), var_2_4))
			end

			arg_1_0:sendNotification(GAME.BACKYARD_ADD_MONEY_DONE, {
				id = var_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("backyard_shipAddMoney", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
