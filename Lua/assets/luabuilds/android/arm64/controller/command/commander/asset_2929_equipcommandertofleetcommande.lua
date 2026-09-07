local EquipCommanderToFleetCommande = class("EquipCommanderToFleetCommande", pm.SimpleCommand)

function EquipCommanderToFleetCommande:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.pos
	local var_1_2 = var_1_0.callback
	local var_1_3

	if var_1_0.commanderId ~= 0 then
		var_1_3 = getProxy(CommanderProxy):getCommanderById(var_1_0.commanderId)

		if not var_1_3 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_not_exist"))

			return
		end
	end

	local var_1_4 = getProxy(FleetProxy)
	local var_1_5 = var_1_4:getFleetById(var_1_0.fleetId)

	if not var_1_5 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("commander_fleet_not_exist"))

		return
	end

	if var_1_0.commanderId == 0 and not var_1_5:getCommanderByPos(var_1_0.pos) then
		if var_1_0.callback then
			var_1_0.callback()
		end

		return
	end

	pg.ConnectionMgr.GetInstance():Send(25006, {
		groupid = var_1_0.fleetId,
		pos = var_1_0.pos,
		commanderid = var_1_0.commanderId
	}, 25007, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_5:updateCommanderByPos(var_1_1, var_1_3)
			var_1_4:updateFleet(var_1_5)

			if var_1_2 then
				var_1_2(var_1_5)
			end

			self:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("commander_equip_to_fleet_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return EquipCommanderToFleetCommande
