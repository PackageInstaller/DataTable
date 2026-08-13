class = var_0_10000

local var_0_0 = "IslandUnlockIllustrationCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().ids

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 21343, {
		book_ids = var_1_0
	}, 21344, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			IslandProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)
			local var_2_1 = var_1.GetIsland(var_2_0)

			var_2_10003 = var_1.GetBookAgency(var_2_1)

			local var_2_2 = var_1.GetTotalPoints(var_2_10003)

			var_1:AddUnlock(var_1_0)

			local var_2_3 = var_1:GetTotalPoints() - var_2_2
			local var_2_5

			if 0 < var_2_3 then
				pg = var_2_5

				local var_2_4 = var_2_5.TipsMgr.GetInstance()

				var_2_5 = var_2_5.ShowTips
				i18n = var_2_10007

				var_2_5(var_2_4, var_2_10007("island_get_collect_point_success", var_2_3))
			end

			IslandDropHelper = var_2_5

			local var_2_6 = var_2_5.AddItems(arg_2_0)
			local var_2_7 = arg_1_0
			local var_2_8 = var_6.sendNotification

			GAME = var_2_10008

			var_2_8(var_2_7, var_2_10008.ISLAND_UNLOCK_ILLUSTRATION_DONE, {
				dropData = var_2_6,
				ids = var_1_0
			})
		else
			pg = var_1

			local var_2_9 = var_1.TipsMgr.GetInstance()
			local var_2_10 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_10(var_2_9, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
