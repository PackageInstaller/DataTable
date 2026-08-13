class = var_0_10000

local var_0_0 = "IslandExchangeLureCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().lureId
	local var_1_1 = var_2.fishPointId
	local var_1_2 = var_2.callback

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 21064, {
		bait_id = var_1_0
	}, 21065, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			IslandProxy = var_2_10002

			local var_2_0 = var_2_2(var_2_10002)
			local var_2_1 = var_2_2.GetIsland(var_2_0)

			var_2_2 = var_2_2.GetFishingAgency(var_2_1)

			if var_1_1 then
				var_2_10003 = var_2_2

				local var_2_3 = var_2_2.GetBaitId(var_2_10003)

				pg = var_2_10003

				local var_2_4 = var_2_10003.GameTrackerMgr.GetInstance()

				var_2_10003 = var_2_10003.Record
				GameTrackerBuilder = var_2_10005

				var_2_10003(var_2_4, var_2_10005.BuildIslandFishingChangeLure(var_1_1, var_2_3, var_1_0))
			end

			var_2_10003 = var_2_2

			var_2_2.UpdateBaitId(var_2_10003, var_1_0)

			if var_1_2 then
				var_1_2()
			end
		else
			pg = var_2_2

			local var_2_5 = var_2_2.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_6(var_2_5, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
