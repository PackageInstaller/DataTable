local var_0_0 = class("IslandGoFishingCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(21060, {
		island_id = var_1_0.islandId,
		point_id = var_1_0.poolId
	}, 21061, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_2 then
				local var_2_0 = arg_2_0.gold_state or 0

				var_1_2(arg_2_0.fish_id, arg_2_0.weight, var_2_0)
			end
		else
			if var_1_2 then
				var_1_2(0, 0)
			end

			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
