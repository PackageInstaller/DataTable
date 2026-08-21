local var_0_0 = class("ChangeEducateCharacterCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_9000
	local var_1_0 = getProxy(PlayerProxy)
	local var_1_1 = var_1_0.getRawData(var_1_9000):GetEducateCharacter()

	pg.ConnectionMgr.GetInstance().Send(var_1_0, 27041, {
		ending_id = arg_1_1:getBody().id
	}, 27042, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_0 > 0 and var_1_1 and pg.secretary_special_ship[var_1_1] and pg.secretary_special_ship[var_1_1].group == pg.secretary_special_ship[var_0].group and pg.secretary_special_ship[var_0].genghuan_word == 1 then
				getProxy(PlayerProxy):setFlag("change_tb", true)
			end

			local var_2_0 = getProxy(PlayerProxy)
			local var_2_1 = var_2_0:getData()

			var_2_1:SetEducateCharacter(var_0)
			var_2_0:updatePlayer(var_2_1)
			arg_1_0:sendNotification(GAME.CHANGE_EDUCATE_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
