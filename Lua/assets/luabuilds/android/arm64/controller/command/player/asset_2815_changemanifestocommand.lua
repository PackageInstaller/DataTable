local ChangeManifestoCommand = class("ChangeManifestoCommand", pm.SimpleCommand)

function ChangeManifestoCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().manifesto
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = var_1_1:getData()

	pg.ConnectionMgr.GetInstance():Send(11009, {
		adv = var_1_0
	}, 11010, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2.manifesto = var_1_0

			var_1_1:updatePlayer(var_1_2)
			pg.TipsMgr.GetInstance():ShowTips(i18n("player_changeManifesto_ok"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("player_changeManifesto", arg_2_0.result))
		end

		return
	end)

	return
end

return ChangeManifestoCommand
