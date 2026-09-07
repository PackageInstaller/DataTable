local IslandSyncControlCommand = class("IslandSyncControlCommand", pm.SimpleCommand)

function IslandSyncControlCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(21209, {
		island_id = var_1_0.islandId,
		obj_id = var_1_0.objId,
		slot_id = var_1_0.slotId,
		op = var_1_0.op,
		status = var_1_0.status,
		type = var_1_0.type
	}, 21210, function(arg_2_0)
		if IslandConst.SYNC_TEST_DELAY_ON then
			LeanTween.delayedCall(math.random(IslandConst.SYNC_TEST_DELAY_L, IslandConst.SYNC_TEST_DELAY_R) / 1000, System.Action(function()
				existCall(var_1_0.onResult, arg_2_0.result)

				return
			end))
		else
			existCall(var_1_0.onResult, arg_2_0.result)
		end

		return
	end)

	return
end

return IslandSyncControlCommand
