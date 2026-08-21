local var_0_0 = class("MonthCardSetMediator", import("..base.ContextMediator"))

var_0_0.ON_SET_RATIO = "MonthCardSetMediator:ON_SET_RATIO"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(PlayerProxy):getRawData()

	arg_1_0:bind(var_0_0.ON_SET_RATIO, function(arg_2_0, arg_2_1)
		if var_1_0:getCardById(VipCard.MONTH).data ~= arg_2_1 then
			arg_1_0:sendNotification(GAME.MONTH_CARD_SET_RATIO, arg_2_1)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("month_card_set_ratio_not_change"))
		end

		return
	end)
	arg_1_0.viewComponent:setPlayer(var_1_0)
	arg_1_0.viewComponent:setRatio(var_1_0:getCardById(VipCard.MONTH).data)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return var_0_0
