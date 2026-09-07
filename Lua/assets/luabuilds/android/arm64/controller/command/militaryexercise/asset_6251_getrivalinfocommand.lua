local GetRivalInfoCommand = class("GetRivalInfoCommand", pm.SimpleCommand)

function GetRivalInfoCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(18104, {
		id = arg_1_1:getBody()
	}, 18105, function(arg_2_0)
		if arg_2_0.info.id == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_get_player_info_erro"))
		else
			local var_2_0 = {}

			var_2_0.rival = Rival.New(arg_2_0.info)

			self:sendNotification(GAME.GET_RIVAL_INFO_DONE, var_2_0)
		end

		return
	end)

	return
end

return GetRivalInfoCommand
