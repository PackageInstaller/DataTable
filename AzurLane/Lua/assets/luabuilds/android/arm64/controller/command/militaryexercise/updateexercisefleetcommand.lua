local var_0_0 = class("UpdateExerciseFleetCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.fleet.vanguardShips
	local var_1_2 = var_1_0.fleet.mainShips
	local var_1_3 = var_1_0.callback
	local var_1_4 = Clone((getProxy(MilitaryExerciseProxy):getExerciseFleet()))
	local var_1_5 = getProxy(FleetProxy):getFleetById(1)

	if table.getCount(var_1_0.fleet.mainShips) == 0 or table.getCount(var_1_1) == 0 then
		var_1_1 = var_1_5.vanguardShips
		var_1_2 = var_1_5.mainShips
		arg_1_0.resetFleet = true
	end

	if table.getCount(var_1_1) > 3 or table.getCount(var_1_2) > 3 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(18008, {
		vanguard_ship_id_list = var_1_1,
		main_ship_id_list = var_1_2
	}, 18009, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = {}

			_.each(var_1_1, function(arg_3_0)
				table.insert(var_2_0, arg_3_0)

				return
			end)
			_.each(var_1_2, function(arg_4_0)
				table.insert(var_2_0, arg_4_0)

				return
			end)
			var_0:updateShips({})
			getProxy(MilitaryExerciseProxy):updateExerciseFleet(var_0)

			if arg_1_0.resetFleet then
				arg_1_0.resetFleet = nil

				arg_1_0:sendNotification(GAME.EXERCISE_FLEET_RESET, var_0)
			end

			arg_1_0:sendNotification(GAME.UPDATE_EXERCISE_FLEET_DONE, {
				oldFleet = var_1_4,
				newFleet = var_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		if var_1_3 then
			var_1_3()
		end

		return
	end)

	return
end

return var_0_0
