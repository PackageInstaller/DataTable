local var_0_0 = class("ChangeManifestoCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(PlayerProxy)
	local var_1_1 = getProxy(PlayerProxy):getData()

	pg.ConnectionMgr.GetInstance():Send(11009, {
		adv = arg_1_1:getBody().manifesto
	}, 11010, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1.manifesto = var_0

			var_1_0:updatePlayer(var_1_1)
			pg.TipsMgr.GetInstance():ShowTips(i18n("player_changeManifesto_ok"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("player_changeManifesto", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
