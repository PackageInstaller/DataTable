local ShipAddInimacyCommand = class("ShipAddInimacyCommand", pm.SimpleCommand)

function ShipAddInimacyCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(19011, {
		id = var_1_0
	}, 19012, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(BayProxy)
			local var_2_1 = getProxy(DormProxy)
			local var_2_2 = var_2_1:getRawData()
			local var_2_3, var_2_4 = var_2_2.HarvestInimacyAndMoney(var_2_0, var_1_0)

			var_2_1:updateDrom(var_2_2, BackYardConst.DORM_UPDATE_TYPE_SHIP)

			if inimacy == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_getResource_emptry"))
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_shipAddInimacy_ok", var_2_0:getShipById(var_1_0):getName()))
			end

			self:sendNotification(GAME.BACKYARD_ADD_INTIMACY_DONE, {
				id = var_1_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("backyard_shipAddInimacy", arg_2_0.result))
		end

		return
	end)

	return
end

return ShipAddInimacyCommand
