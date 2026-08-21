local var_0_0 = class("GetRivalInfoCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(18104, {
		id = arg_1_1:getBody()
	}, 18105, function(arg_2_0)
		if arg_2_0.info.id == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_get_player_info_erro"))
		else
			({}).rival = Rival.New(arg_2_0.info)

			arg_1_0:sendNotification(GAME.GET_RIVAL_INFO_DONE, {})
		end

		return
	end)

	return
end

return var_0_0
