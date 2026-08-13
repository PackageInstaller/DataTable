class = var_0_10000

local var_0_0 = "CommanderUsePrefabCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().pid
	local var_1_1 = var_2.fleetId

	getProxy = var_1_10005
	FleetProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)
	local var_1_3 = var_5.getFleetById(var_1_2, var_1_1)

	getProxy = var_1_10006
	CommanderProxy = var_8

	local var_1_4 = var_1_10006(var_8)
	local var_1_5 = var_6.getPrefabFleetById(var_1_4, var_1_0)

	if var_6.isEmpty(var_1_5) or var_6:isSame(var_1_3:getCommanders()) then
		return
	end

	local var_1_6 = {
		function(arg_2_0)
			local var_2_0 = var_1_3

			if var_1.getCommanderByPos(var_2_0, 1) then
				local var_2_1 = arg_1_0
				local var_2_2 = var_2.sendNotification

				GAME = var_2_10005

				var_2_2(var_2_1, var_2_10005.COOMMANDER_EQUIP_TO_FLEET, {
					commanderId = 0,
					pos = 1,
					fleetId = var_1_1,
					callback = arg_2_0
				})
			else
				arg_2_0()
			end

			return
		end,
		function(arg_3_0)
			local var_3_0 = var_1_3

			if var_1.getCommanderByPos(var_3_0, 2) then
				local var_3_1 = arg_1_0
				local var_3_2 = var_2.sendNotification

				GAME = var_2_10005

				var_3_2(var_3_1, var_2_10005.COOMMANDER_EQUIP_TO_FLEET, {
					commanderId = 0,
					pos = 2,
					fleetId = var_1_1,
					callback = arg_3_0
				})
			else
				arg_3_0()
			end

			return
		end,
		function(arg_4_0)
			local var_4_0 = var_0

			if var_1.getCommanderByPos(var_4_0, 1) then
				local var_4_1 = arg_1_0
				local var_4_2 = var_2.sendNotification

				GAME = var_2_10005

				var_4_2(var_4_1, var_2_10005.SELECT_FLEET_COMMANDER, {
					pos = 1,
					fleetId = var_1_1,
					commanderId = var_1.id,
					callback = arg_4_0
				})
			else
				arg_4_0()
			end

			return
		end,
		function(arg_5_0)
			local var_5_0 = var_0

			if var_1.getCommanderByPos(var_5_0, 2) then
				local var_5_1 = arg_1_0
				local var_5_2 = var_2.sendNotification

				GAME = var_2_10005

				var_5_2(var_5_1, var_2_10005.SELECT_FLEET_COMMANDER, {
					pos = 2,
					fleetId = var_1_1,
					commanderId = var_1.id,
					callback = arg_5_0
				})
			else
				arg_5_0()
			end

			return
		end
	}

	seriesAsync = var_8

	var_8(var_1_6, function()
		local var_6_0 = arg_1_0
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10003

		var_6_1(var_6_0, var_2_10003.USE_COMMANDER_PREFBA_DONE)

		return
	end)

	return
end

return var_0_1
