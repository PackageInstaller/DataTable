local UpdateExerciseFleetCommand = class("UpdateExerciseFleetCommand", pm.SimpleCommand)

function UpdateExerciseFleetCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.fleet.vanguardShips
	local var_1_2 = var_1_0.fleet.mainShips
	local var_1_3 = var_1_0.callback
	local var_1_4 = getProxy(MilitaryExerciseProxy):getExerciseFleet()
	local var_1_5 = Clone(var_1_4)
	local var_1_6 = getProxy(FleetProxy):getFleetById(1)

	if table.getCount(var_1_0.fleet.mainShips) == 0 or table.getCount(var_1_1) == 0 then
		var_1_1 = var_1_6.vanguardShips
		var_1_2 = var_1_6.mainShips
		self.resetFleet = true
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
			var_1_4:updateShips(var_2_0)
			getProxy(MilitaryExerciseProxy):updateExerciseFleet(var_1_4)

			if self.resetFleet then
				self.resetFleet = nil

				self:sendNotification(GAME.EXERCISE_FLEET_RESET, var_1_4)
			end

			self:sendNotification(GAME.UPDATE_EXERCISE_FLEET_DONE, {
				oldFleet = var_1_5,
				newFleet = var_1_4
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

return UpdateExerciseFleetCommand
