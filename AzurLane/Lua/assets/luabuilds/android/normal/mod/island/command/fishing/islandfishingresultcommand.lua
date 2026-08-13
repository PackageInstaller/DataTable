class = var_0_10000

local var_0_0 = "IslandFishingResultCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = var_2.fishId
	local var_1_2 = var_2.weight
	local var_1_3 = var_2.cupType
	local var_1_4 = var_2.fishPointId
	local var_1_5 = var_2.op
	local var_1_6 = var_2.islandId

	pg = var_1_10010

	local var_1_7 = var_1_10010.ConnectionMgr.GetInstance()

	var_10.Send(var_1_7, 21062, {
		island_id = var_1_6,
		point_id = var_1_4,
		end_result = var_1_5
	}, 21063, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = var_1_5
			IslandConst = var_2_10002

			if var_2_0 == var_2_10002.FISHING_OP_SUCCESS then
				getProxy = var_2_0
				IslandProxy = var_2

				local var_2_1 = var_2_0(var_2)
				local var_2_2 = var_2_0.GetIsland(var_2_1)

				var_2_10003 = var_2_0.GetFishingAgency(var_2_2)

				var_2_0.AddFish(var_2_10003, var_1_1, var_1_2, var_1_3)

				IslandBookHelper = var_2

				var_2.OnFishingEnd(var_1_1)
			end

			if var_1_0 then
				var_1_0()
			end
		else
			pg = var_2_0

			local var_2_3 = var_2_0.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_4(var_2_3, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
