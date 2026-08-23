local ActivitySubscriptionTipsComp = class("ActivitySubscriptionTipsComp", require("app.fairyGUI.activity.UI_ActivitySubscriptionTipsComp"))

function ActivitySubscriptionTipsComp:ctor()
	self:addClickListener(handler(self, self._onGoToRecharge))
	self.m_gotoRechargeBtn:addClickListener(handler(self, self._onGoToRecharge))
end

function ActivitySubscriptionTipsComp:onLoad()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.MONTH_CARD) then
		self:setVisible(false)
	end
end

function ActivitySubscriptionTipsComp:updateViewById(arg_3_1)
	if self._active and arg_3_1 == self._id then
		return
	end

	self._id = arg_3_1

	local var_3_0, var_3_1 = self:_getShowInfoById(arg_3_1)

	self._active = var_3_0

	if not var_3_0 then
		self.m_stateController:setSelectedIndex(0)
	else
		self.m_stateController:setSelectedIndex(1)
	end

	self.m_descTxt:setText(var_3_1)
end

function ActivitySubscriptionTipsComp:_getShowInfoById(arg_4_1)
	return g.core.model.User.activityMonthCardData:isPrivilegeActivatedByIndex(1), g.core.config.privilege_guide_info.get(arg_4_1).des
end

function ActivitySubscriptionTipsComp:setShowState(arg_5_1)
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.RECHARGE_SUBSCRIPTION) then
		self:setVisible(false)

		return
	end

	self:setVisible(arg_5_1)
end

function ActivitySubscriptionTipsComp:_onGoToRecharge()
	local var_6_0

	if self._active then
		do return end

		var_6_0 = {
			tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.RECHARGE_TAB_TYPE
		}
	end

	var_6_0.shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.MONTH_CARD

	g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE, var_6_0)
end

return ActivitySubscriptionTipsComp
