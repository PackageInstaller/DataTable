local Challenge2InitialRequestCommand = class("Challenge2InitialRequestCommand", pm.SimpleCommand)

function Challenge2InitialRequestCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().mode
	local var_1_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE)
	local var_1_2 = getProxy(FleetProxy):getActivityFleets()[var_1_1.id]
	local var_1_3 = {}

	for iter_1_0, iter_1_1 in pairs({
		[var_1_0 + 1] = var_1_2[var_1_0 + 1],
		[var_1_0 + 11] = var_1_2[var_1_0 + 11]
	}) do
		if iter_1_1 then
			local var_1_4 = {}

			_.each(iter_1_1.vanguardShips, function(arg_2_0)
				var_1_4[#var_1_4 + 1] = arg_2_0

				return
			end)
			_.each(iter_1_1.mainShips, function(arg_3_0)
				var_1_4[#var_1_4 + 1] = arg_3_0

				return
			end)
			_.each(iter_1_1.subShips, function(arg_4_0)
				var_1_4[#var_1_4 + 1] = arg_4_0

				return
			end)

			local var_1_5 = {}

			for iter_1_2, iter_1_3 in pairs(iter_1_1.commanderIds) do
				table.insert(var_1_5, {
					pos = iter_1_2,
					id = iter_1_3
				})
			end

			table.insert(var_1_3, {
				id = iter_1_0,
				ship_list = var_1_4,
				commanders = var_1_5
			})
		end
	end

	if not var_1_1 or var_1_1:isEnd() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(24002, {
		activity_id = var_1_1.id,
		group_list = var_1_3,
		mode = var_1_0
	}, 24003, function(arg_5_0)
		if arg_5_0.result == 0 then
			self:sendNotification(GAME.CHALLENGE2_INFO, {
				callback = function()
					self:sendNotification(GAME.CHALLENGE2_INITIAL_DONE, {
						mode = var_1_0
					})

					return
				end
			})
		end

		return
	end)

	return
end

return Challenge2InitialRequestCommand
