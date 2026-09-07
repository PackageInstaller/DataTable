local UseTecSpeedUpItemCommand = class("UseTecSpeedUpItemCommand", pm.SimpleCommand)

function UseTecSpeedUpItemCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.itemid
	local var_1_2 = var_1_0.number

	pg.ConnectionMgr.GetInstance():Send(63210, {
		blueprintid = var_1_0.blueprintid,
		itemid = var_1_0.itemid,
		number = var_1_0.number,
		task_id = var_1_0.taskID
	}, 63211, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(BagProxy):removeItemById(var_1_1, var_1_2)
			self:sendNotification(GAME.USE_TEC_SPEEDUP_ITEM_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips("Error Code" .. arg_2_0.result)
		end

		return
	end)

	return
end

return UseTecSpeedUpItemCommand
