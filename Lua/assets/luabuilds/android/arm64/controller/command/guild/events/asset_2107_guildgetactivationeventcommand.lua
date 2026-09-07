local GuildGetActivationEventCommand = class("GuildGetActivationEventCommand", import(".GuildEventBaseCommand"))

function GuildGetActivationEventCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = getProxy(GuildProxy)

	if not var_1_2:ShouldFetchActivationEvent() and not var_1_0.force then
		if var_1_0.callback then
			var_1_0.callback()
		end

		return
	end

	pg.ConnectionMgr.GetInstance():Send(61005, {
		type = 0
	}, 61006, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2:getData()
			local var_2_1 = var_2_0:GetActiveEvent()

			if var_2_1 then
				var_2_1:Deactivate()
			end

			var_2_0:GetEventById(arg_2_0.operation.operation_id):Active(arg_2_0.operation)
			var_1_2:AddFetchActivationEventCDTime()
			var_1_2:updateGuild(var_2_0)
			self:sendNotification(GAME.GUILD_GET_ACTIVATION_EVENT_DONE)
			pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inGuildEvent")
			pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inGuildBossEvent")

			if var_1_1 then
				var_1_1()
			end
		else
			local var_2_2 = var_1_2:getData()
			local var_2_3 = var_2_2:GetActiveEvent()

			if var_2_3 then
				var_2_3:Deactivate()
			end

			var_1_2:updateGuild(var_2_2)
			self:sendNotification(GAME.ON_GUILD_EVENT_END)

			if var_1_1 then
				var_1_1()
			end
		end

		return
	end)

	return
end

return GuildGetActivationEventCommand
