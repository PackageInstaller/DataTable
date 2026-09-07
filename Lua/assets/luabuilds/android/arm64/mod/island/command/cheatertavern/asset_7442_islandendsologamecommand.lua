local IslandEndSoloGameCommand = class("IslandEndSoloGameCommand", pm.SimpleCommand)

function IslandEndSoloGameCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(23111, {
		Type = 1
	}, 23112, function(arg_2_0)
		if arg_2_0.result == 0 then
			self:sendNotification(GAME.ISLAND_CHEATER_END_SOLO_GAME_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end, false)

	return
end

return IslandEndSoloGameCommand
