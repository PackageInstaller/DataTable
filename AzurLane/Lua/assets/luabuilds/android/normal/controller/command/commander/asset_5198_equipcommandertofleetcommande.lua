class = var_0_10000

local var_0_0 = "EquipCommanderToFleetCommande"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().commanderId
	local var_1_1 = var_2.pos
	local var_1_2 = var_2.fleetId
	local var_1_3 = var_2.callback
	local var_1_4

	if var_1_0 ~= 0 then
		getProxy = var_1_10008
		CommanderProxy = var_1_10009
		var_1_10009 = var_1_10008(var_1_10009)

		if not var_1_10008.getCommanderById(var_1_10009, var_1_0) then
			pg = var_1_10008
			var_1_10009 = var_1_10008.TipsMgr.GetInstance()
			var_1_10008 = var_1_10008.ShowTips
			i18n = var_10

			var_1_10008(var_1_10009, var_10("commander_not_exist"))

			return
		end
	end

	getProxy = var_1_10008
	FleetProxy = var_1_10009

	local var_1_5 = var_1_10008(var_1_10009)

	if not var_8.getFleetById(var_1_5, var_1_2) then
		pg = var_1_5

		local var_1_6 = var_1_5.TipsMgr.GetInstance()

		var_1_5 = var_1_5.ShowTips
		i18n = var_1_10012

		var_1_5(var_1_6, var_1_10012("commander_fleet_not_exist"))

		return
	end

	if var_1_0 == 0 and not var_9:getCommanderByPos(var_1_1) then
		if var_1_3 then
			var_1_3()
		end

		return
	end

	pg = var_1_5

	local var_1_7 = var_1_5.ConnectionMgr.GetInstance()

	var_10.Send(var_1_7, 25006, {
		groupid = var_1_2,
		pos = var_1_1,
		commanderid = var_1_0
	}, 25007, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_3.updateCommanderByPos(var_2_0, var_1_1, var_1_4)

			local var_2_1 = var_0

			var_2_3.updateFleet(var_2_1, var_0)

			if var_1_3 then
				var_1_3(var_0)
			end

			local var_2_2 = arg_1_0

			var_2_3 = var_2_3.sendNotification
			GAME = var_2_10003

			var_2_3(var_2_2, var_2_10003.COOMMANDER_EQUIP_TO_FLEET_DONE)
		else
			pg = var_2_3

			local var_2_4 = var_2_3.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			i18n = var_2_10003

			var_2_5(var_2_4, var_2_10003("commander_equip_to_fleet_erro", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
