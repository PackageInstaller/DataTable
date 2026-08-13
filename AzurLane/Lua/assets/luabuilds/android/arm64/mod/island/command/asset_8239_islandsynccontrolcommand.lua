class = var_0_10000

local var_0_0 = "IslandSyncControlCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 21209, {
		island_id = var_1_0.islandId,
		obj_id = var_1_0.objId,
		slot_id = var_1_0.slotId,
		op = var_1_0.op,
		status = var_1_0.status,
		type = var_1_0.type
	}, 21210, function(arg_2_0)
		IslandConst = var_2_10001

		local var_2_0

		if var_2_10001.SYNC_TEST_DELAY_ON then
			math = var_2_0
			var_2_0 = var_2_0.random
			IslandConst = var_2_10003

			local var_2_1 = var_2_10003.SYNC_TEST_DELAY_L

			IslandConst = var_2_10004
			var_2_0 = var_2_0(var_2_1, var_2_10004.SYNC_TEST_DELAY_R)
			LeanTween = var_2_10002

			local var_2_2 = var_2_10002.delayedCall
			local var_2_3 = var_2_0 / 1000

			System = var_2_10005

			var_2_2(var_2_3, var_2_10005.Action(function()
				existCall = var_3_10000

				var_3_10000(var_1_0.onResult, arg_2_0.result)

				return
			end))
		else
			existCall = var_2_0

			var_2_0(var_1_0.onResult, arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
