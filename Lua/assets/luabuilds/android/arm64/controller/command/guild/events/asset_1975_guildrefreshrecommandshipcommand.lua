local GuildRefreshRecommandShipCommand = class("GuildRefreshRecommandShipCommand", pm.SimpleCommand)

function GuildRefreshRecommandShipCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	if GuildRefreshRecommandShipCommand.TIME then
		if GuildRefreshRecommandShipCommand.TIME > pg.TimeMgr.GetInstance():GetServerTime() then
			if var_1_0 then
				var_1_0()
			end

			return
		end
	end

	pg.ConnectionMgr.GetInstance():Send(61035, {
		type = 0
	}, 61036, function(arg_2_0)
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.recommends or {}) do
			var_2_0[iter_2_1.user_id] = var_2_0[iter_2_1.user_id] or {}

			table.insert(var_2_0[iter_2_1.user_id], iter_2_1.ship_id)
		end

		local var_2_1 = getProxy(GuildProxy)
		local var_2_2 = var_2_1:getData()

		for iter_2_2, iter_2_3 in ipairs((var_2_2:GetMembers())) do
			local var_2_3 = iter_2_3:GetAssaultFleet()

			var_2_3:ClearAllRecommandShip()

			if var_2_0[iter_2_3.id] then
				var_2_3:SetRecommendList(var_2_0[iter_2_3.id])
			end
		end

		var_2_1:updateGuild(var_2_2)
		self:sendNotification(GAME.REFRESH_ALL_ASSULT_SHIP_RECOMMAND_STATE_DONE)

		GuildRefreshRecommandShipCommand.TIME = pg.TimeMgr.GetInstance():GetServerTime() + 3

		if var_1_0 then
			var_1_0()
		end

		return
	end)

	return
end

return GuildRefreshRecommandShipCommand
