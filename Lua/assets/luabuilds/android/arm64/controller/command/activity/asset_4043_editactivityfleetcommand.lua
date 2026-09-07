local EditActivityFleetCommand = class("EditActivityFleetCommand", pm.SimpleCommand)

function EditActivityFleetCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_0.fleets) do
		local var_1_2 = {}

		_.each(iter_1_1.vanguardShips, function(arg_2_0)
			var_1_2[#var_1_2 + 1] = arg_2_0

			return
		end)
		_.each(iter_1_1.mainShips, function(arg_3_0)
			var_1_2[#var_1_2 + 1] = arg_3_0

			return
		end)
		_.each(iter_1_1.subShips, function(arg_4_0)
			var_1_2[#var_1_2 + 1] = arg_4_0

			return
		end)

		local var_1_3 = {}

		for iter_1_2, iter_1_3 in pairs(iter_1_1.commanderIds) do
			table.insert(var_1_3, {
				pos = iter_1_2,
				id = iter_1_3
			})
		end

		table.insert(var_1_1, {
			id = iter_1_0,
			ship_list = var_1_2,
			commanders = var_1_3
		})
	end

	pg.ConnectionMgr.GetInstance():Send(11204, {
		activity_id = var_1_0.actID,
		group_list = var_1_1
	}, 11205, function(arg_5_0)
		if arg_5_0.result == 0 then
			-- block empty
		end

		return
	end)

	return
end

return EditActivityFleetCommand
