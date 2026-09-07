local IslandStartSoloGameCommand = class("IslandStartSoloGameCommand", pm.SimpleCommand)

function IslandStartSoloGameCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(23109, {
		bot_num = arg_1_1:getBody().bot_num
	}, 23110, function(arg_2_0)
		if arg_2_0.result == 0 then
			self:sendNotification(GAME.ISLAND_CHEATER_START_SOLO_GAME_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end, false)

	return
end

return IslandStartSoloGameCommand
