class = var_0_10000

local var_0_0 = "ChangeManifestoCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).manifesto

	getProxy = var_1_0
	PlayerProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.getData(var_1_2)

	pg = var_1_10006

	local var_1_4 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_4, 11009, {
		adv = var_1_1
	}, 11010, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = var_1_3
			var_2_0.manifesto = var_1_1

			local var_2_1 = var_0

			var_2_0.updatePlayer(var_2_1, var_1_3)

			pg = var_2_0

			local var_2_2 = var_2_0.TipsMgr.GetInstance()

			var_2_0 = var_2_0.ShowTips
			i18n = var_2_10004

			var_2_0(var_2_2, var_2_10004("player_changeManifesto_ok"))
		else
			pg = var_2_0

			local var_2_3 = var_2_0.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_4(var_2_3, var_2_10004("player_changeManifesto", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
