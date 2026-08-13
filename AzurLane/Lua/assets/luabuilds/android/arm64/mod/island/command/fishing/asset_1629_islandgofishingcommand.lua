class = var_0_10000

local var_0_0 = "IslandGoFishingCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().poolId
	local var_1_1 = var_2.baitId
	local var_1_2 = var_2.islandId
	local var_1_3 = var_2.callback

	pg = var_1_10007

	local var_1_4 = var_1_10007.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 21060, {
		island_id = var_1_2,
		point_id = var_1_0
	}, 21061, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_3 then
				local var_2_0 = var_1_3
				local var_2_1 = arg_2_0.fish_id

				var_2_10004 = arg_2_0.weight

				local var_2_2

				if not arg_2_0.gold_state then
					var_2_2 = 0
				end

				var_2_0(var_2_1, var_2_10004, var_2_2)
			end
		else
			if var_1_3 then
				var_1_3(0, 0)
			end

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
