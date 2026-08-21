local var_0_0 = class("EnterMapCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(21213, {
		island_id = var_1_0.islandId,
		map_id = var_1_0.mapId
	}, 21214, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(IslandProxy):SetSyncObjInitData(arg_2_0.object_list)

			local var_2_0 = arg_1_0:IsSelf(var_1_0.islandId)

			if var_2_0 then
				local var_2_1 = getProxy(IslandProxy):GetIsland() or getProxy(IslandProxy):GetSharedIsland()

				var_2_1:GetWildCollectAgency():InitGatherData(arg_2_0, var_1_0.islandId, var_2_0)
				var_2_1:GetVisitorAgency():InitMapVisitorList(var_1_0.mapId)

				local var_2_2 = arg_2_0.npc_list or {}

				var_2_1:GetActivityNpcAgency():InitNpcList(var_2_2)
				existCall(var_1_1)

				if false then
					pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
				end

				return
			end
		end
	end)

	return
end

function var_0_0.IsSelf(arg_3_0, arg_3_1)
	local var_3_0 = getProxy(PlayerProxy)

	return var_3_0:getRawData().id == arg_3_1
end

return var_0_0
