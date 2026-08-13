class = var_0_10000

local var_0_0 = "IslandSyncControlCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 21209, {
		island_id = var_1_1.islandId,
		obj_id = var_1_1.objId,
		slot_id = var_1_1.slotId,
		op = var_1_1.op,
		status = var_1_1.status,
		type = var_1_1.type
	}, 21210, function(arg_2_0)
		IslandConst = var_2_10001

		local var_2_0

		if var_2_10001.SYNC_TEST_DELAY_ON then
			math = var_2_0
			var_2_0 = var_2_0.random
			IslandConst = var_2_10002

			local var_2_1 = var_2_10002.SYNC_TEST_DELAY_L

			IslandConst = var_2_10003
			var_2_0 = var_2_0(var_2_1, var_2_10003.SYNC_TEST_DELAY_R)
			LeanTween = var_2_1

			local var_2_2 = var_2_1.delayedCall
			local var_2_3 = var_2_0 / 1000

			System = var_2_10004

			var_2_2(var_2_3, var_2_10004.Action(function()
				existCall = var_3_10000

				var_3_10000(var_1_1.onResult, arg_2_0.result)

				return
			end))
		else
			existCall = var_2_0

			var_2_0(var_1_1.onResult, arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
