class = var_0_10000

local var_0_0 = "IslandWildCollectCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().island_id
	local var_1_1 = var_2.fragment_id
	local var_1_2 = var_2.unitId

	getProxy = var_1_10006
	IslandProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)
	local var_1_4 = var_6.GetIsland(var_1_3)

	pg = var_1_10007

	local var_1_5 = var_1_10007.ConnectionMgr.GetInstance()

	var_7.Send(var_1_5, 21529, {
		island_id = var_1_0,
		fragment_id = var_1_1
	}, 21530, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_4

			var_2_10004 = var_1.GetWildCollectAgency(var_2_0)

			var_1.AddCollectFragment(var_2_10004, var_1_1)

			pg = var_2
			var_2_10004 = var_2.GameTrackerMgr.GetInstance()

			local var_2_1 = var_2.Record

			GameTrackerBuilder = var_5

			var_2_1(var_2_10004, var_5.BuildIslandWildCollect(var_1_1))

			var_2_10004 = var_1_4

			local var_2_2 = var_2.DispatchEvent

			IslandGatherCollectAgency = var_5

			var_2_2(var_2_10004, var_5.RemoveGatherUnit, {
				unitId = var_1_2
			})
		else
			pg = var_1

			local var_2_3 = var_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_4(var_2_3, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
