local var_0_0 = class("IslandUnlockIllustrationCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(21343, {
		book_ids = arg_1_1:getBody().ids
	}, 21344, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetBookAgency()

			var_2_0:AddUnlock(var_0)

			local var_2_1 = var_2_0:GetTotalPoints() - var_2_0:GetTotalPoints()

			if var_2_1 > 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_get_collect_point_success", var_2_1))
			end

			;({}).dropData = IslandDropHelper.AddItems(arg_2_0)
			;({}).ids = var_0

			arg_1_0:sendNotification(GAME.ISLAND_UNLOCK_ILLUSTRATION_DONE, {})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
