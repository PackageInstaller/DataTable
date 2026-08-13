class = var_0_10000

local var_0_0 = "IslandWildGatherCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().island_id
	local var_1_1 = var_2.gather_id

	getProxy = var_1_10005
	IslandProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)
	local var_1_3 = var_5.GetIsland(var_1_2)
	local var_1_4 = var_2.unitId

	pg = var_1_2

	local var_1_5 = var_1_2.ConnectionMgr.GetInstance()

	var_7.Send(var_1_5, 21524, {
		island_id = var_1_0,
		gather_id = var_1_1
	}, 21525, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			pg = var_2_1

			local var_2_0 = var_2_1.GameTrackerMgr.GetInstance()

			var_2_1 = var_2_1.Record
			GameTrackerBuilder = var_2_10004

			var_2_1(var_2_0, var_2_10004.BuildIslandWildGather(var_1_4))

			IslandDropHelper = var_2_1
			var_2_1 = var_2_1.AddItems({
				drop_list = arg_2_0.drop_list
			})
			var_2_10004 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_2_10005

			var_2_2(var_2_10004, var_2_10005.ISLAND_DROPMAIN_AWARD, {
				dropData = var_2_1
			})

			var_2_10004 = var_1_3

			local var_2_3 = var_2.DispatchEvent

			IslandGatherCollectAgency = var_5

			var_2_3(var_2_10004, var_5.RemoveGatherUnit, {
				unitId = var_1_4
			})
		else
			pg = var_2_1

			local var_2_4 = var_2_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_5(var_2_4, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
