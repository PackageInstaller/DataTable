class = var_0_10000

local var_0_0 = "IslandGetPointAwardCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 21347, {
		lv = var_1_0
	}, 21348, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			IslandProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)
			local var_2_1 = var_1.GetIsland(var_2_0)

			var_2_10003 = var_1.GetBookAgency(var_2_1)

			var_1.AddPointAwardGotId(var_2_10003, var_1_0)

			IslandDropHelper = var_2

			local var_2_2 = var_2.AddItems(arg_2_0)
			local var_2_3 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_2_10005

			var_2_10003(var_2_3, var_2_10005.ISLAND_GET_POINT_AWARD_DONE, {
				dropData = var_2_2
			})
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
