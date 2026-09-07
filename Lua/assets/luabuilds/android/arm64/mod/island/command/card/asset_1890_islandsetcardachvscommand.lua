local IslandSetCardAchvsCommand = class("IslandSetCardAchvsCommand", pm.SimpleCommand)

function IslandSetCardAchvsCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().achvIds
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		table.insert(var_1_1, pg.island_achievement[iter_1_1].group)
	end

	pg.ConnectionMgr.GetInstance():Send(21338, {
		group_list = var_1_1
	}, 21339, function(arg_2_0)
		if arg_2_0.result == 0 then
			self:sendNotification(GAME.ISLAND_SET_CARD_ACHVS_DONE, {
				achvIds = var_1_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandSetCardAchvsCommand
