local IslandWildCollectCommand = class("IslandWildCollectCommand", pm.SimpleCommand)

function IslandWildCollectCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.fragment_id
	local var_1_2 = var_1_0.unitId
	local var_1_3 = getProxy(IslandProxy):GetIsland()

	pg.ConnectionMgr.GetInstance():Send(21529, {
		island_id = var_1_0.island_id,
		fragment_id = var_1_0.fragment_id
	}, 21530, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:GetWildCollectAgency():AddCollectFragment(var_1_1)
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildIslandWildCollect(var_1_1))
			var_1_3:DispatchEvent(IslandGatherCollectAgency.RemoveGatherUnit, {
				unitId = var_1_2
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandWildCollectCommand
