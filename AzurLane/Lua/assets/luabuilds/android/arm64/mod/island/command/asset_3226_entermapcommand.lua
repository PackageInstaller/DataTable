class = var_0_10000

local var_0_0 = "EnterMapCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).callback

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 21213, {
		island_id = var_2.islandId,
		map_id = var_2.mapId
	}, 21214, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			IslandProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_1.SetSyncObjInitData(var_2_0, arg_2_0.object_list)

			local var_2_1 = arg_1_0

			if var_1.IsSelf(var_2_1, var_0.islandId) then
				getProxy = var_2_10002
				IslandProxy = var_2_10004
				var_2_10004 = var_2_10002(var_2_10004)

				if not var_2_10002.GetIsland(var_2_10004) then
					getProxy = var_2_10002
					IslandProxy = var_2_10004
					var_2_10004 = var_2_10002(var_2_10004)
					var_2_10002 = var_2_10002.GetSharedIsland(var_2_10004)
				end

				local var_2_2 = var_2_10002:GetWildCollectAgency()

				var_3.InitGatherData(var_2_2, arg_2_0, var_0.islandId, var_1)

				local var_2_3 = var_2_10002:GetVisitorAgency()

				var_2_10004.InitMapVisitorList(var_2_3, var_0.mapId)

				local var_2_4 = var_2_10002:GetActivityNpcAgency()

				var_2_10004 = var_2_10004.InitNpcList

				local var_2_5

				if not arg_2_0.npc_list then
					var_2_5 = {}
				end

				var_2_10004(var_2_4, var_2_5)

				existCall = var_2_10004

				var_2_10004(var_1_1)

				if false then
					pg = var_1

					local var_2_6 = var_1.TipsMgr.GetInstance()
					local var_2_7 = var_1.ShowTips

					ERROR_MESSAGE = var_2_10004

					var_2_7(var_2_6, var_2_10004[arg_2_0.result] .. arg_2_0.result)
				end

				return
			end
		end
	end)

	return
end

function var_0_1.IsSelf(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_3_0 = var_1_10002(var_1_10004)

	return var_2.getRawData(var_3_0).id == arg_3_1
end

return var_0_1
