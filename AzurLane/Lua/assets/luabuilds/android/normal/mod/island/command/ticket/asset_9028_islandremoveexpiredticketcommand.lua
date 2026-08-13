class = var_0_10000

local var_0_0 = "IslandRemoveExpiredTicketCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().tickets
	local var_1_1 = var_2.callback
	local var_1_2 = {}

	ipairs = var_1_10006

	for iter_1_0, iter_1_1 in var_1_10006(var_1_0) do
		table = var_1_10011

		var_1_10011.insert(var_1_2, {
			speed_id = iter_1_1.id,
			end_time = iter_1_1.endTime
		})
	end

	pg = var_6

	local var_1_3 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 21425, {
		ticket_keys = var_1_2
	}, 21426, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			IslandProxy = var_2_10002

			local var_2_0 = var_2_2(var_2_10002)
			local var_2_1 = var_2_2.GetIsland(var_2_0)

			var_2_2 = var_2_2.GetTicketAgency(var_2_1)
			ipairs = var_2_1

			for iter_2_0, iter_2_1 in var_2_1(var_1_2) do
				var_2_2:RemoveTicket(iter_2_1.speed_id, iter_2_1.end_time)
			end

			var_2_10003 = arg_1_0

			local var_2_3 = var_2.sendNotification

			GAME = var_4

			var_2_3(var_2_10003, var_4.ISLAND_REMOVE_EXPIRED_TICKET_DONE, {
				tickets = var_1_0,
				callback = var_1_1
			})
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_5(var_2_4, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
