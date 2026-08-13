class = var_0_10000

local var_0_0 = "Challenge2InitialRequestCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).mode

	getProxy = var_1_0
	ActivityProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.getActivityByType

	ActivityConst = var_1_10008

	local var_1_4 = var_1_3(var_1_2, var_1_10008.ACTIVITY_TYPE_CHALLENGE)

	getProxy = var_1_10006
	FleetProxy = var_8

	local var_1_5 = var_1_10006(var_8)
	local var_1_6 = var_6.getActivityFleets(var_1_5)[var_1_4.id]
	local var_1_7 = {
		[var_1_1 + 1] = var_1_6[var_1_1 + 1],
		[var_1_1 + 11] = var_1_6[var_1_1 + 11]
	}
	local var_1_8 = {}

	pairs = var_11

	for iter_1_0, iter_1_1 in var_11(var_1_7) do
		if iter_1_1 then
			local var_1_9 = {}

			_ = var_1_10017

			var_1_10017.each(iter_1_1.vanguardShips, function(arg_2_0)
				var_1_9[#var_1_9 + 1] = arg_2_0

				return
			end)

			_ = var_1_10017

			var_1_10017.each(iter_1_1.mainShips, function(arg_3_0)
				var_1_9[#var_1_9 + 1] = arg_3_0

				return
			end)

			_ = var_1_10017

			var_1_10017.each(iter_1_1.subShips, function(arg_4_0)
				var_1_9[#var_1_9 + 1] = arg_4_0

				return
			end)

			var_1_10017 = {}
			pairs = var_1_10018

			for iter_1_2, iter_1_3 in var_1_10018(iter_1_1.commanderIds) do
				table = var_1_10023

				var_1_10023.insert(var_1_10017, {
					pos = iter_1_2,
					id = iter_1_3
				})
			end

			var_1_10018 = {
				id = iter_1_0,
				ship_list = var_1_9,
				commanders = var_1_10017
			}
			table = var_19

			var_19.insert(var_1_8, var_1_10018)
		end
	end

	if not var_1_4 or var_1_4:isEnd() then
		return
	end

	pg = var_11

	local var_1_10 = var_11.ConnectionMgr.GetInstance()

	var_11.Send(var_1_10, 24002, {
		activity_id = var_1_4.id,
		group_list = var_1_8,
		mode = var_1_1
	}, 24003, function(arg_5_0)
		if arg_5_0.result == 0 then
			local function var_5_0()
				local var_6_0 = arg_1_0
				local var_6_1 = var_0.sendNotification

				GAME = var_3_10003

				var_6_1(var_6_0, var_3_10003.CHALLENGE2_INITIAL_DONE, {
					mode = var_1_1
				})

				return
			end

			local var_5_1 = arg_1_0
			local var_5_2 = var_2.sendNotification

			GAME = var_2_10005

			var_5_2(var_5_1, var_2_10005.CHALLENGE2_INFO, {
				callback = var_5_0
			})
		end

		return
	end)

	return
end

return var_0_1
