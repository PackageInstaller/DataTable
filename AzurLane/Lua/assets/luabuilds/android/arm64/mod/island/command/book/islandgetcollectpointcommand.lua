local var_0_0 = class("IslandGetCollectPointCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(21345, {
		book_ids = arg_1_1:getBody().ids
	}, 21346, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(IslandProxy):GetIsland():GetBookAgency()

			var_2_0:OnGetPointDone(arg_2_0.collect_list)
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_get_collect_point_success", var_2_0:GetTotalPoints() - var_2_0:GetTotalPoints()))
			arg_1_0:sendNotification(GAME.ISLAND_GET_COLLECT_POINT_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
