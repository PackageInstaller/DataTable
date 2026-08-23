local var_0_0 = g.core.const.ConstMgr.ShopConst
local RechargeHotMonthCardComp = class("RechargeHotMonthCardComp", require("app.fairyGUI.recharge.UI_RechargeHotMonthCardComp"))

function RechargeHotMonthCardComp:ctor()
	self.m_touchBg:addClickListener(handler(self, self._onClick))
end

function RechargeHotMonthCardComp:_onClick()
	self:dispatchCompEvent(var_0_0.SHOP_EVENT_GO_TO, {
		tabType = var_0_0.SHOP_INFO_TAB_TYPE.RECHARGE_TAB_TYPE,
		shopType = var_0_0.SHOP_TYPE.MONTH_CARD
	})
end

function RechargeHotMonthCardComp:updateComp()
	self.m_monthCardComp:updateComp()
end

return RechargeHotMonthCardComp
