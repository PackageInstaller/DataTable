local var_0_0 = class("CommanderUsePrefabCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(FleetProxy):getFleetById(var_1_0.fleetId)
	local var_1_2 = getProxy(CommanderProxy):getPrefabFleetById(var_1_0.pid)

	if var_1_2:isEmpty() or var_1_2:isSame(getProxy(FleetProxy):getFleetById(var_1_0.fleetId):getCommanders()) then
		return
	end

	seriesAsync({
		function(arg_2_0)
			if var_1_1:getCommanderByPos(1) then
				arg_1_0:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET, {
					commanderId = 0,
					pos = 1,
					fleetId = var_0,
					callback = arg_2_0
				})
			else
				arg_2_0()
			end

			return
		end,
		function(arg_3_0)
			if var_1_1:getCommanderByPos(2) then
				arg_1_0:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET, {
					commanderId = 0,
					pos = 2,
					fleetId = var_0,
					callback = arg_3_0
				})
			else
				arg_3_0()
			end

			return
		end,
		function(arg_4_0)
			local var_4_0 = var_1_2:getCommanderByPos(1)

			if var_4_0 then
				arg_1_0:sendNotification(GAME.SELECT_FLEET_COMMANDER, {
					pos = 1,
					fleetId = var_0,
					commanderId = var_4_0.id,
					callback = arg_4_0
				})
			else
				arg_4_0()
			end

			return
		end,
		function(arg_5_0)
			local var_5_0 = var_1_2:getCommanderByPos(2)

			if var_5_0 then
				arg_1_0:sendNotification(GAME.SELECT_FLEET_COMMANDER, {
					pos = 2,
					fleetId = var_0,
					commanderId = var_5_0.id,
					callback = arg_5_0
				})
			else
				arg_5_0()
			end

			return
		end
	}, function()
		arg_1_0:sendNotification(GAME.USE_COMMANDER_PREFBA_DONE)

		return
	end)

	return
end

return var_0_0
