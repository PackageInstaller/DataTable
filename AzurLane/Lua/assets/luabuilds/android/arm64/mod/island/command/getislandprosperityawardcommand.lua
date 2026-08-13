class = var_0_10000

local var_0_0 = "GetIslandProsperityAwardCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).level

	getProxy = var_1_0
	IslandProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.GetIsland(var_1_2)

	if not var_4.CanGetProsperityAwards(var_1_3, var_1_1) then
		return
	end

	pg = var_5

	local var_1_4 = var_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_4, 21010, {
		level = var_1_1
	}, 21011, function(arg_2_0)
		if arg_2_0.ret == 0 then
			getProxy = var_1
			IslandProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_2_10004 = var_1.GetIsland(var_2_0)

			var_1.ReceiveProsperityAwards(var_2_10004, var_1_1)

			IslandDropHelper = var_2

			local var_2_1 = var_2.AddItems(arg_2_0)
			local var_2_2 = arg_1_0
			local var_2_3 = var_3.sendNotification

			GAME = var_2_10006

			var_2_3(var_2_2, var_2_10006.ISLAND_PROSPERITY_AWARD_DONE, {
				dropData = var_2_1
			})
		else
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_5(var_2_4, var_2_10004[arg_2_0.ret] .. arg_2_0.ret)
		end

		return
	end)

	return
end

return var_0_1
