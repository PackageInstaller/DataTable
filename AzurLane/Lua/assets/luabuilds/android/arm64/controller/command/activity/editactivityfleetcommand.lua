class = var_0_10000

local var_0_0 = "EditActivityFleetCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().actID
	local var_1_1 = var_2.fleets
	local var_1_2 = {}

	pairs = var_1_10006

	for iter_1_0, iter_1_1 in var_1_10006(var_1_1) do
		local var_1_3 = {}

		_ = var_1_10012

		var_1_10012.each(iter_1_1.vanguardShips, function(arg_2_0)
			var_1_3[#var_1_3 + 1] = arg_2_0

			return
		end)

		_ = var_1_10012

		var_1_10012.each(iter_1_1.mainShips, function(arg_3_0)
			var_1_3[#var_1_3 + 1] = arg_3_0

			return
		end)

		_ = var_1_10012

		var_1_10012.each(iter_1_1.subShips, function(arg_4_0)
			var_1_3[#var_1_3 + 1] = arg_4_0

			return
		end)

		var_1_10012 = {}
		pairs = var_1_10013

		for iter_1_2, iter_1_3 in var_1_10013(iter_1_1.commanderIds) do
			table = var_1_10018

			var_1_10018.insert(var_1_10012, {
				pos = iter_1_2,
				id = iter_1_3
			})
		end

		var_1_10013 = {
			id = iter_1_0,
			ship_list = var_1_3,
			commanders = var_1_10012
		}
		table = var_14

		var_14.insert(var_1_2, var_1_10013)
	end

	pg = var_6

	local var_1_4 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_4, 11204, {
		activity_id = var_1_0,
		group_list = var_1_2
	}, 11205, function(arg_5_0)
		if arg_5_0.result == 0 then
			-- block empty
		end

		return
	end)

	return
end

return var_0_1
