class = var_0_10000

local var_0_0 = "SetIslandSetManifestoCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).manifesto

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 21006, {
		signature = var_1_1
	}, 21007, function(arg_2_0)
		if arg_2_0.ret == 0 then
			getProxy = var_1
			IslandProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_2_10004 = var_1.GetIsland(var_2_0)

			var_1.SetManifesto(var_2_10004, var_1_1)

			var_2_10004 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_5

			var_2_1(var_2_10004, var_5.ISLAND_SET_MANIFESTO_DONE)
		else
			pg = var_1

			local var_2_2 = var_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_3(var_2_2, var_2_10004[arg_2_0.ret] .. arg_2_0.ret)
		end

		return
	end)

	return
end

return var_0_1
