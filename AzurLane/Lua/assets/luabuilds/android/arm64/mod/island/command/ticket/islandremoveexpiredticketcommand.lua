local var_0_0 = class("IslandRemoveExpiredTicketCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.tickets) do
		table.insert({}, {
			speed_id = iter_1_1.id,
			end_time = iter_1_1.endTime
		})
	end

	pg.ConnectionMgr.GetInstance():Send(21425, {
		ticket_keys = {}
	}, 21426, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetTicketAgency()

			for iter_2_0, iter_2_1 in ipairs(var_1_2) do
				var_2_0:RemoveTicket(iter_2_1.speed_id, iter_2_1.end_time)
			end

			arg_1_0:sendNotification(GAME.ISLAND_REMOVE_EXPIRED_TICKET_DONE, {
				tickets = var_0,
				callback = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
