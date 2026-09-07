local GuildGetAssaultFleetCommand = class("GuildGetAssaultFleetCommand", import(".GuildEventBaseCommand"))

function GuildGetAssaultFleetCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = getProxy(GuildProxy)

	if not var_1_1:ShouldRequestForamtion() then
		if var_1_0 then
			var_1_0()
		end

		return
	end

	pg.ConnectionMgr.GetInstance():Send(61011, {
		type = 0
	}, 61012, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_1:getData()
			local var_2_1 = {}

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.recommends or {}) do
				var_2_1[iter_2_1.user_id] = var_2_1[iter_2_1.user_id] or {}

				table.insert(var_2_1[iter_2_1.user_id], iter_2_1.ship_id)
			end

			for iter_2_2, iter_2_3 in ipairs(arg_2_0.ships) do
				local var_2_2 = var_2_0:getMemberById(iter_2_3.user_id)

				if var_2_2 then
					local var_2_3 = GuildAssaultFleet.New(iter_2_3)

					if var_2_1[var_2_2.id] then
						var_2_3:SetRecommendList(var_2_1[var_2_2.id])
					end

					var_2_2:UpdateAssaultFleet(var_2_3)
				end
			end

			var_1_1:updateGuild(var_2_0)
			self:sendNotification(GAME.GUILD_GET_ASSAULT_FLEET_DONE)
			pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inGuildEvent")

			if var_1_0 then
				var_1_0()
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return GuildGetAssaultFleetCommand
