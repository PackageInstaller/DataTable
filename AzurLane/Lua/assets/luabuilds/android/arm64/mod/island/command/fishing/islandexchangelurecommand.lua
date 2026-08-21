local var_0_0 = class("IslandExchangeLureCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.fishPointId
	local var_1_2 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(21064, {
		bait_id = var_1_0.lureId
	}, 21065, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetFishingAgency()

			if var_1_1 then
				pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandFishingChangeLure(var_1_1, var_2_0:GetBaitId(), var_0))
			end

			var_2_0:UpdateBaitId(var_0)

			if var_1_2 then
				var_1_2()
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
