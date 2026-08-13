class = var_0_10000

local var_0_0 = "UpdateExerciseFleetCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().fleet.vanguardShips
	local var_1_1 = var_3.mainShips
	local var_1_2 = var_2.callback

	getProxy = var_1_10007
	MilitaryExerciseProxy = var_1_10008

	local var_1_3 = var_1_10007(var_1_10008)
	local var_1_4 = var_7.getExerciseFleet(var_1_3)

	Clone = var_1_3

	local var_1_5 = var_1_3(var_1_4)

	getProxy = var_10
	FleetProxy = var_1_10011

	local var_1_6 = var_10(var_1_10011)
	local var_1_7 = var_10.getFleetById(var_1_6, 1)

	table = var_1_6

	if var_1_6.getCount(var_1_1) ~= 0 then
		table = var_12

		if var_12.getCount(var_1_0) == 0 then
			var_1_0 = var_1_7.vanguardShips
			var_1_1 = var_1_7.mainShips
			arg_1_0.resetFleet = true
		end

		table = var_12

		if not (var_12.getCount(var_1_0) > 3) then
			table = var_12

			if var_12.getCount(var_1_1) > 3 then
				return
			end

			pg = var_12

			local var_1_8 = var_12.ConnectionMgr.GetInstance()

			var_12.Send(var_1_8, 18008, {
				vanguard_ship_id_list = var_1_0,
				main_ship_id_list = var_1_1
			}, 18009, function(arg_2_0)
				local var_2_0

				if arg_2_0.result == 0 then
					getProxy = var_2_0
					MilitaryExerciseProxy = var_2_10002
					var_2_0 = var_2_0(var_2_10002)

					local var_2_1 = {}

					_ = var_2_10003

					var_2_10003.each(var_1_0, function(arg_3_0)
						table = var_3_10001

						var_3_10001.insert(var_2_1, arg_3_0)

						return
					end)

					_ = var_2_10003

					var_2_10003.each(var_1_1, function(arg_4_0)
						table = var_3_10001

						var_3_10001.insert(var_2_1, arg_4_0)

						return
					end)

					local var_2_2 = var_1_4

					var_2_10003.updateShips(var_2_2, var_2_1)
					var_2_0:updateExerciseFleet(var_1_4)

					if arg_1_0.resetFleet then
						var_2_10003 = arg_1_0
						var_2_10003.resetFleet = nil

						local var_2_3 = arg_1_0

						var_2_10003 = var_2_10003.sendNotification
						GAME = var_5

						var_2_10003(var_2_3, var_5.EXERCISE_FLEET_RESET, var_1_4)
					end

					local var_2_4 = arg_1_0

					var_2_10003 = var_2_10003.sendNotification
					GAME = var_5

					var_2_10003(var_2_4, var_5.UPDATE_EXERCISE_FLEET_DONE, {
						oldFleet = var_1_5,
						newFleet = var_1_4
					})
				else
					pg = var_2_0

					local var_2_5 = var_2_0.TipsMgr.GetInstance()
					local var_2_6 = var_1.ShowTips

					errorTip = var_2_10003

					var_2_6(var_2_5, var_2_10003("", arg_2_0.result))
				end

				if var_1_2 then
					var_1_2()
				end

				return
			end)

			return
		end
	end
end

return var_0_1
