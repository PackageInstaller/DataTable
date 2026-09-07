local FinishPhantomQuestCommand = class("FinishPhantomQuestCommand", pm.SimpleCommand)

function FinishPhantomQuestCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.questId
	local var_1_2 = getProxy(TechnologyProxy):getBluePrintById(var_1_0.bluePrintId)
	local var_1_3 = var_1_2:getPhantomQuestInfo(var_1_0.questId)

	if var_1_3.unlocked or var_1_3.progress < var_1_3.config.target_num then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(12210, {
		ship_id = var_1_2.shipId,
		skin_shadow_id = var_1_0.questId
	}, 12211, function(arg_2_0)
		local var_2_0 = ShipBluePrint.getPhantomQuestCostDrop(var_1_3)

		if var_2_0 then
			reducePlayerOwn(var_2_0)
		end

		getProxy(BayProxy):updateShipSkin(var_1_2.shipId, var_1_1, 0)
		self:sendNotification(GAME.FINISH_PHANTOM_QUEST_DONE)

		return
	end)

	return
end

return FinishPhantomQuestCommand
