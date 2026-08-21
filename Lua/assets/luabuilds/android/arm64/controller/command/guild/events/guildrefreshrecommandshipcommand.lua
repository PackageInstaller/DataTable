local var_0_0 = class("GuildRefreshRecommandShipCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	if var_0_0.TIME then
		if var_0_0.TIME > pg.TimeMgr.GetInstance():GetServerTime() then
			if var_1_0 then
				var_1_0()
			end

			return
		end
	end

	pg.ConnectionMgr.GetInstance():Send(61035, {
		type = 0
	}, 61036, function(arg_2_0)
		local var_2_0 = arg_2_0.recommends or {}

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			if not ({})[iter_2_1.user_id] then
				({})[iter_2_1.user_id] = {}
			end

			table.insert(({})[iter_2_1.user_id], iter_2_1.ship_id)
		end

		local var_2_1 = getProxy(GuildProxy)
		local var_2_2 = var_2_1:getData()

		for iter_2_2, iter_2_3 in ipairs((var_2_2:GetMembers())) do
			local var_2_3 = iter_2_3:GetAssaultFleet()

			var_2_3:ClearAllRecommandShip()

			if ({})[iter_2_3.id] then
				var_2_3:SetRecommendList(({})[iter_2_3.id])
			end
		end

		var_2_1:updateGuild(var_2_2)
		arg_1_0:sendNotification(GAME.REFRESH_ALL_ASSULT_SHIP_RECOMMAND_STATE_DONE)

		var_0_0.TIME = pg.TimeMgr.GetInstance():GetServerTime() + 3

		if var_1_0 then
			var_1_0()
		end

		return
	end)

	return
end

return var_0_0
