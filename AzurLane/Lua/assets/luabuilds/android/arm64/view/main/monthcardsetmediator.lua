class = var_0_10000

local var_0_0 = "MonthCardSetMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_SET_RATIO = "MonthCardSetMediator:ON_SET_RATIO"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.getRawData(var_1_0)

	arg_1_0:bind(var_0_1.ON_SET_RATIO, function(arg_2_0, arg_2_1)
		local var_2_0 = var_1_1
		local var_2_1 = var_2.getCardById

		VipCard = var_2_10005

		local var_2_3

		if var_2_1(var_2_0, var_2_10005.MONTH).data ~= arg_2_1 then
			local var_2_2 = arg_1_0

			var_2_3 = var_2_3.sendNotification
			GAME = var_2_10006

			var_2_3(var_2_2, var_2_10006.MONTH_CARD_SET_RATIO, arg_2_1)
		else
			pg = var_2_3

			local var_2_4 = var_2_3.TipsMgr.GetInstance()
			local var_2_5 = var_3.ShowTips

			i18n = var_2_10006

			var_2_5(var_2_4, var_2_10006("month_card_set_ratio_not_change"))
		end

		return
	end)

	local var_1_2 = arg_1_0.viewComponent

	var_3.setPlayer(var_1_2, var_1_1)

	local var_1_3 = var_1_1
	local var_1_4 = var_1_1.getCardById

	VipCard = var_6

	local var_1_5 = var_1_4(var_1_3, var_6.MONTH)
	local var_1_6 = arg_1_0.viewComponent

	var_4.setRatio(var_1_6, var_1_5.data)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return var_0_1
