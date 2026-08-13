class = var_0_10000

local var_0_0 = "ExitIslandCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.callback

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 21204, {
		island_id = var_1_0
	}, 21205, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			IslandProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_2_10004 = var_1.GetIsland(var_2_0)

			local var_2_1

			if var_1.IsPrivate(var_2_10004) then
				var_2_10004 = var_1
				var_2_1 = var_1.GetSystemTipInfos(var_2_10004)
				getProxy = var_2_0
				SystemTipProxy = var_2_10005
				var_2_10005 = var_2_0(var_2_10005)

				var_3.SetIslandTipData(var_2_10005, var_2_1.awardCnt, var_2_1.emptyCnt, var_2_1.timestamps, var_2_1.postFlag)
			end

			getProxy = var_2_1
			IslandProxy = var_2_10004
			var_2_10004 = var_2_1(var_2_10004)

			var_2.ExitIsland(var_2_10004)

			var_2_10004 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_2_10005

			var_2_2(var_2_10004, var_2_10005.ISLAND_EXIT_DONE)

			if var_1_1 then
				var_1_1()
			end
		else
			pg = var_1

			local var_2_3 = var_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_4(var_2_3, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
