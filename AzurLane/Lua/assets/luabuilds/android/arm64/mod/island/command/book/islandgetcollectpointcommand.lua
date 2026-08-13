class = var_0_10000

local var_0_0 = "IslandGetCollectPointCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).ids

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 21345, {
		book_ids = var_1_1
	}, 21346, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			IslandProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.GetIsland(var_2_0)

			var_2_10004 = var_1.GetBookAgency(var_2_1)

			local var_2_2 = var_1.GetTotalPoints(var_2_10004)

			var_1:OnGetPointDone(arg_2_0.collect_list)

			local var_2_3 = var_1:GetTotalPoints()

			pg = var_2_10004

			local var_2_4 = var_2_10004.TipsMgr.GetInstance()

			var_2_10004 = var_2_10004.ShowTips
			i18n = var_2_10007

			var_2_10004(var_2_4, var_2_10007("island_get_collect_point_success", var_2_3 - var_2_2))

			local var_2_5 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = var_7

			var_2_10004(var_2_5, var_7.ISLAND_GET_COLLECT_POINT_DONE)
		else
			pg = var_1

			local var_2_6 = var_1.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_7(var_2_6, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
