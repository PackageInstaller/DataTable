class = var_0_10000

local var_0_0 = "SetMonthCardRatioCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 11601, {
		ratio = var_1_1
	}, 11602, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			PlayerProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			local var_2_0 = var_1.getData(var_2_10003)

			var_2_10003 = var_2.getCardById
			VipCard = var_2_10005

			if var_2_10003(var_2_0, var_2_10005.MONTH) and not var_2_10003:isExpire() then
				var_2_10003.data = var_1_1

				var_2:addVipCard(var_2_10003)
				var_1:updatePlayer(var_2)
			end

			pg = var_2_0

			local var_2_1 = var_2_0.TipsMgr.GetInstance()
			local var_2_2 = var_4.ShowTips

			i18n = var_2_10006

			var_2_2(var_2_1, var_2_10006("month_card_set_ratio_success"))
		else
			pg = var_1

			local var_2_3 = var_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_4(var_2_3, var_2_10003("month_card_set_ratio_fail", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
