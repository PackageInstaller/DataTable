local var_0_0 = class("IslandGetSeasonPtAwardCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().pt or 0

	pg.ConnectionMgr.GetInstance():Send(21022, {
		target_pt = var_1_0
	}, 21023, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(IslandProxy):GetIsland():GetSeasonAgency():GetSeason():AddGotPtAwardList(var_1_0)
			arg_1_0:sendNotification(GAME.ISLAND_GET_SEASON_PT_AWARD_DONE, {
				dropData = IslandDropHelper.AddItems(arg_2_0)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
