class = var_0_10000

local var_0_0 = "GuildGetActivationEventCommand"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuildEventBaseCommand"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().force
	local var_1_1 = var_2.callback

	getProxy = var_1_10005
	GuildProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	if not var_5.ShouldFetchActivationEvent(var_1_2) and not var_1_0 then
		if var_1_1 then
			var_1_1()
		end

		return
	end

	pg = var_6

	local var_1_3 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 61005, {
		type = 0
	}, 61006, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = arg_2_0.operation.operation_id
			local var_2_1 = var_0
			local var_2_2 = var_2.getData(var_2_1)

			if var_2.GetActiveEvent(var_2_2) then
				var_3:Deactivate()
			end

			local var_2_3 = var_2:GetEventById(var_2_0)

			var_4.Active(var_2_3, arg_2_0.operation)

			local var_2_4 = var_0

			var_5.AddFetchActivationEventCDTime(var_2_4)

			local var_2_5 = var_0

			var_5.updateGuild(var_2_5, var_2)

			local var_2_6 = arg_1_0
			local var_2_7 = var_5.sendNotification

			GAME = var_7

			var_2_7(var_2_6, var_7.GUILD_GET_ACTIVATION_EVENT_DONE)

			pg = var_2_7

			local var_2_8 = var_2_7.ShipFlagMgr.GetInstance()

			var_5.UpdateFlagShips(var_2_8, "inGuildEvent")

			pg = var_5

			local var_2_9 = var_5.ShipFlagMgr.GetInstance()

			var_5.UpdateFlagShips(var_2_9, "inGuildBossEvent")

			if var_1_1 then
				var_1_1()
			end
		else
			local var_2_10 = var_0
			local var_2_11 = var_1.getData(var_2_10)

			if var_1.GetActiveEvent(var_2_11) then
				var_2:Deactivate()
			end

			local var_2_12 = var_0

			var_3.updateGuild(var_2_12, var_1)

			local var_2_13 = arg_1_0
			local var_2_14 = var_3.sendNotification

			GAME = var_5

			var_2_14(var_2_13, var_5.ON_GUILD_EVENT_END)

			if var_1_1 then
				var_1_1()
			end
		end

		return
	end)

	return
end

return var_0_1
