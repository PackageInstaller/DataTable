class = var_0_10000

local var_0_0 = "IslandSignInCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 21310, {
		pos = 0,
		island_id = 0
	}, 21311, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			IslandProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_2_10003 = var_1.GetIsland(var_2_0)

			local var_2_1 = var_1.GetSignInAgency(var_2_10003)

			var_2.MarkSignIn(var_2_1)

			local var_2_2 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_2_10005

			var_2_10003(var_2_2, var_2_10005.ISLAND_SIGN_IN_DONE)

			pg = var_2_10003

			local var_2_3 = var_2_10003.GameTrackerMgr.GetInstance()

			var_2_10003 = var_2_10003.Record
			GameTrackerBuilder = var_5

			var_2_10003(var_2_3, var_5.BuildIslandSignIn())
		else
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_5(var_2_4, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
