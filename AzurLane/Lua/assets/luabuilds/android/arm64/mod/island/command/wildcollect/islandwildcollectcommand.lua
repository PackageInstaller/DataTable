local var_0_0 = class("IslandWildCollectCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.unitId
	local var_1_2 = getProxy(IslandProxy):GetIsland()

	pg.ConnectionMgr.GetInstance():Send(21529, {
		island_id = var_1_0.island_id,
		fragment_id = var_1_0.fragment_id
	}, 21530, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2:GetWildCollectAgency():AddCollectFragment(var_0)
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandWildCollect(var_0))
			var_1_2:DispatchEvent(IslandGatherCollectAgency.RemoveGatherUnit, {
				unitId = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
