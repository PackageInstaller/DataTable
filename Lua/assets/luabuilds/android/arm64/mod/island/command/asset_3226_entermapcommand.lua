local EnterMapCommand = class("EnterMapCommand", pm.SimpleCommand)

function EnterMapCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(21213, {
		island_id = var_1_0.islandId,
		map_id = var_1_0.mapId
	}, 21214, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(IslandProxy):SetSyncObjInitData(arg_2_0.object_list)

			local var_2_0 = self:IsSelf(var_1_0.islandId)
			local var_2_1

			if var_2_0 then
				var_2_1 = getProxy(IslandProxy):GetIsland() or getProxy(IslandProxy):GetSharedIsland()
			end

			var_2_1:GetWildCollectAgency():InitGatherData(arg_2_0, var_1_0.islandId, var_2_0)
			var_2_1:GetVisitorAgency():InitMapVisitorList(var_1_0.mapId)
			var_2_1:GetActivityNpcAgency():InitNpcList(arg_2_0.npc_list or {})
			existCall(var_1_1)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

function EnterMapCommand:IsSelf(arg_3_1)
	return getProxy(PlayerProxy):getRawData().id == arg_3_1
end

return EnterMapCommand
