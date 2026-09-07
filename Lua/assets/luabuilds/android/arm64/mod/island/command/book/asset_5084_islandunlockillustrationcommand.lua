local IslandUnlockIllustrationCommand = class("IslandUnlockIllustrationCommand", pm.SimpleCommand)

function IslandUnlockIllustrationCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().ids

	pg.ConnectionMgr.GetInstance():Send(21343, {
		book_ids = var_1_0
	}, 21344, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetBookAgency()

			var_2_0:AddUnlock(var_1_0)

			local var_2_1 = var_2_0:GetTotalPoints() - var_2_0:GetTotalPoints()
			local var_2_2

			if var_2_1 > 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_get_collect_point_success", var_2_1))

				var_2_2 = {}
			end

			var_2_2.dropData = IslandDropHelper.AddItems(arg_2_0)
			var_2_2.ids = var_1_0

			self:sendNotification(GAME.ISLAND_UNLOCK_ILLUSTRATION_DONE, var_2_2)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandUnlockIllustrationCommand
