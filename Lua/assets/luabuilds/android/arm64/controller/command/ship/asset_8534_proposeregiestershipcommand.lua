local ProposeRegiesterShipCommand = class("ProposeRegiesterShipCommand", pm.SimpleCommand)

function ProposeRegiesterShipCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = getProxy(BayProxy):getShipById(var_1_0)

	if not var_1_1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_error_noShip", var_1_0))

		return
	end

	if not var_1_1.propose or var_1_1:ShowPropose() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(12032, {
		ship_id = var_1_0
	}, 12033, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(PlayerProxy)
			local var_2_1 = var_2_0:getData()

			var_2_1:SetProposeShipId(var_1_0)
			var_2_0:updatePlayer(var_2_1)
			self:sendNotification(GAME.PROPOSE_REGISTER_SHIP_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_proposeShip", arg_2_0.result))
		end

		return
	end)

	return
end

return ProposeRegiesterShipCommand
