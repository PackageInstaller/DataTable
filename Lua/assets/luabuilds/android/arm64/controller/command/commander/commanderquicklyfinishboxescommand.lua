local var_0_0 = class("CommanderQuicklyFinishBoxesCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(25037, {
		item_cnt = var_1_0.itemCnt,
		finish_cnt = var_1_0.finishCnt,
		affect_cnt = var_1_0.affectCnt
	}, 25038, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(BagProxy):removeItemById(Item.COMMANDER_QUICKLY_TOOL_ID, var_0)
			arg_1_0:sendNotification(GAME.COMMANDER_QUICKLY_FINISH_BOXES_DONE)
			arg_1_0:sendNotification(GAME.REFRESH_COMMANDER_BOXES)
		else
			arg_1_0:sendNotification(GAME.COMMANDER_QUICKLY_FINISH_BOXES_ERROR)
		end

		return
	end)

	return
end

return var_0_0
