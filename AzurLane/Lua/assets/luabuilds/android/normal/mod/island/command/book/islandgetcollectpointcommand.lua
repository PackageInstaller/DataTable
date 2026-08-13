class = var_0_10000

local var_0_0 = "IslandGetCollectPointCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().ids

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 21345, {
		book_ids = var_1_0
	}, 21346, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			IslandProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)
			local var_2_1 = var_1.GetIsland(var_2_0)

			var_2_10003 = var_1.GetBookAgency(var_2_1)

			local var_2_2 = var_1.GetTotalPoints(var_2_10003)

			var_1:OnGetPointDone(arg_2_0.collect_list)

			local var_2_3 = var_1

			var_2_10003 = var_1.GetTotalPoints(var_2_3)
			pg = var_2_3

			local var_2_4 = var_2_3.TipsMgr.GetInstance()
			local var_2_5 = var_4.ShowTips

			i18n = var_2_10006

			var_2_5(var_2_4, var_2_10006("island_get_collect_point_success", var_2_10003 - var_2_2))

			local var_2_6 = arg_1_0
			local var_2_7 = var_4.sendNotification

			GAME = var_6

			var_2_7(var_2_6, var_6.ISLAND_GET_COLLECT_POINT_DONE)
		else
			pg = var_1

			local var_2_8 = var_1.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_9(var_2_8, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
