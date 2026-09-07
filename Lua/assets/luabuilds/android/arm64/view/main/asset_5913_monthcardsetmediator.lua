local MonthCardSetMediator = class("MonthCardSetMediator", import("..base.ContextMediator"))

MonthCardSetMediator.ON_SET_RATIO = "MonthCardSetMediator:ON_SET_RATIO"

function MonthCardSetMediator:register()
	local var_1_0 = getProxy(PlayerProxy):getRawData()

	self:bind(MonthCardSetMediator.ON_SET_RATIO, function(arg_2_0, arg_2_1)
		if var_1_0:getCardById(VipCard.MONTH).data ~= arg_2_1 then
			self:sendNotification(GAME.MONTH_CARD_SET_RATIO, arg_2_1)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("month_card_set_ratio_not_change"))
		end

		return
	end)
	self.viewComponent:setPlayer(var_1_0)
	self.viewComponent:setRatio(var_1_0:getCardById(VipCard.MONTH).data)

	return
end

function MonthCardSetMediator:listNotificationInterests()
	return {}
end

function MonthCardSetMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return MonthCardSetMediator
