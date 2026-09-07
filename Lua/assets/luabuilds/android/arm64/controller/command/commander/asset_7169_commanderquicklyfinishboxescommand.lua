local CommanderQuicklyFinishBoxesCommand = class("CommanderQuicklyFinishBoxesCommand", pm.SimpleCommand)

function CommanderQuicklyFinishBoxesCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.itemCnt

	pg.ConnectionMgr.GetInstance():Send(25037, {
		item_cnt = var_1_0.itemCnt,
		finish_cnt = var_1_0.finishCnt,
		affect_cnt = var_1_0.affectCnt
	}, 25038, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(BagProxy):removeItemById(Item.COMMANDER_QUICKLY_TOOL_ID, var_1_1)
			self:sendNotification(GAME.COMMANDER_QUICKLY_FINISH_BOXES_DONE)
			self:sendNotification(GAME.REFRESH_COMMANDER_BOXES)
		else
			self:sendNotification(GAME.COMMANDER_QUICKLY_FINISH_BOXES_ERROR)
		end

		return
	end)

	return
end

return CommanderQuicklyFinishBoxesCommand
