local IslandRemoveExpiredTicketCommand = class("IslandRemoveExpiredTicketCommand", pm.SimpleCommand)

function IslandRemoveExpiredTicketCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.tickets
	local var_1_2 = var_1_0.callback
	local var_1_3 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.tickets) do
		table.insert(var_1_3, {
			speed_id = iter_1_1.id,
			end_time = iter_1_1.endTime
		})
	end

	pg.ConnectionMgr.GetInstance():Send(21425, {
		ticket_keys = var_1_3
	}, 21426, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetTicketAgency()

			for iter_2_0, iter_2_1 in ipairs(var_1_3) do
				var_2_0:RemoveTicket(iter_2_1.speed_id, iter_2_1.end_time)
			end

			self:sendNotification(GAME.ISLAND_REMOVE_EXPIRED_TICKET_DONE, {
				tickets = var_1_1,
				callback = var_1_2
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandRemoveExpiredTicketCommand
