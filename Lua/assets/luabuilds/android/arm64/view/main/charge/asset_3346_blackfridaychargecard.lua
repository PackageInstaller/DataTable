local BlackFridayChargeCard = class("BlackFridayChargeCard", import(".ChargeCard"))

function BlackFridayChargeCard:Ctor(arg_1_1)
	BlackFridayChargeCard.super.Ctor(self, arg_1_1)

	self.unlockBlock = self.tr:Find("real_tpl/unlock_block")
	self.unlockBlockLabel = self.tr:Find("real_tpl/unlock_block/label/Text")

	return
end

function BlackFridayChargeCard:update(arg_2_1, arg_2_2, arg_2_3)
	BlackFridayChargeCard.super.update(self, arg_2_1, arg_2_2, arg_2_3)

	if self:inTime(unlockTime) then
		setActive(self.unlockBlock, false)
	end

	local var_2_1

	do
		setActive(self.unlockBlock, true)

		local var_2_0 = arg_2_1:getConfig("time")

		setText(self.unlockBlockLabel, i18n("blackfriday_shop_tip", var_2_0[1][1][3], var_2_0[1][2][1]))

		var_2_1 = self:inTime() and arg_2_1:isTip()
	end

	setActive(self.focusTip, var_2_1)

	return
end

function BlackFridayChargeCard:inTime()
	return pg.TimeMgr.GetInstance():inTime((self.goods:getConfig("time")))
end

return BlackFridayChargeCard
