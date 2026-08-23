local var_0_0 = g.core.const.ConstMgr.RechargeConst
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.rechargeData
local NewYearWishGiftCell = class("NewYearWishGiftCell", require("app.fairyGUI.newYearWish.UI_NewYearWishGiftCell"))

function NewYearWishGiftCell:ctor()
	return
end

function NewYearWishGiftCell:updateCell(arg_2_1)
	local var_2_0 = var_0_2:getRechargeInfoByTypeAndPrice(arg_2_1.recharge_type, arg_2_1.recharge_money)

	self.m_moneyText:setText(g.core.lang:get(408002, {
		moneyUnit = var_2_0.moneyUnit,
		money = var_2_0.realMoney
	}))
	self.m_iconLoader:setURL(var_0_1:getRechargeIconById(arg_2_1.icon))

	arg_2_1.buyTimes = arg_2_1.buyTimes or 0

	if arg_2_1.limit_type == var_0_0.GIFT_LIMIT_TYPE.NORMAL then
		self.m_isSellOutController:setSelectedIndex(0)
	else
		self.m_isSellOutController:setSelectedIndex(arg_2_1.times - arg_2_1.buyTimes > 0 and 0 or 1)
	end
end

return NewYearWishGiftCell
