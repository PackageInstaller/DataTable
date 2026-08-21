local var_0_0 = class("UseTecSpeedUpItemCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(63210, {
		blueprintid = var_1_0.blueprintid,
		itemid = var_1_0.itemid,
		number = var_1_0.number,
		task_id = var_1_0.taskID
	}, 63211, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(BagProxy):removeItemById(var_0, var_0)
			arg_1_0:sendNotification(GAME.USE_TEC_SPEEDUP_ITEM_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips("Error Code" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
