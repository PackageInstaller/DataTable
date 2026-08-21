local var_0_0 = class("IslandSetCardAchvsCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in ipairs(arg_1_1:getBody().achvIds) do
		table.insert({}, pg.island_achievement[iter_1_1].group)
	end

	pg.ConnectionMgr.GetInstance():Send(21338, {
		group_list = {}
	}, 21339, function(arg_2_0)
		if arg_2_0.result == 0 then
			arg_1_0:sendNotification(GAME.ISLAND_SET_CARD_ACHVS_DONE, {
				achvIds = var_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
