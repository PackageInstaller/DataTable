local GetIslandOrderExpAwardCommand = class("GetIslandOrderExpAwardCommand", pm.SimpleCommand)

function GetIslandOrderExpAwardCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.level
	local var_1_2 = var_1_0.callback
	local var_1_3 = getProxy(IslandProxy):GetIsland():GetOrderAgency()

	if not var_1_3:CanGetAward(var_1_0.level) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_order_not_get_award"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(21412, {
		lv = var_1_0.level
	}, 21413, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:UpdateGotAwardList(var_1_1)
			self:sendNotification(GAME.ISLAND_GET_ORDER_EXP_AWARD_DONE, {
				dropData = IslandDropHelper.AddItems(arg_2_0),
				callback = var_1_2,
				level = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return GetIslandOrderExpAwardCommand
