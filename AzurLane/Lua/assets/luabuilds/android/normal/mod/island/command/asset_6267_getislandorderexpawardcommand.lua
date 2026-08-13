class = var_0_10000

local var_0_0 = "GetIslandOrderExpAwardCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().level
	local var_1_1 = var_2.callback

	getProxy = var_1_10005
	IslandProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.GetIsland(var_1_2)
	local var_1_4 = var_5.GetOrderAgency(var_1_3)
	local var_1_6

	if not var_5.CanGetAward(var_1_4, var_1_0) then
		pg = var_1_6

		local var_1_5 = var_1_6.TipsMgr.GetInstance()

		var_1_6 = var_1_6.ShowTips
		i18n = var_8

		var_1_6(var_1_5, var_8("island_order_not_get_award"))

		return
	end

	pg = var_1_6

	local var_1_7 = var_1_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_7, 21412, {
		lv = var_1_0
	}, 21413, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_1.UpdateGotAwardList(var_2_0, var_1_0)

			IslandDropHelper = var_2_1
			var_2_1 = var_2_1.AddItems(arg_2_0)
			var_2_10003 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_2_10004

			var_2_2(var_2_10003, var_2_10004.ISLAND_GET_ORDER_EXP_AWARD_DONE, {
				dropData = var_2_1,
				callback = var_1_1,
				level = var_1_0
			})
		else
			pg = var_2_1

			local var_2_3 = var_2_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_4(var_2_3, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
