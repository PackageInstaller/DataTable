local var_0_0 = g.core.const.ConstMgr.ThemeConst
local ThemePassCardRewardCell = class("ThemePassCardRewardCell", require("app.fairyGUI.themePasscard.UI_ThemePassCardRewardCell"))

function ThemePassCardRewardCell:ctor()
	self.m_freeList:setVirtual(self)
	self.m_freeList:setItemRenderer(handler(self, self._onFreeItemRender))
	self.m_payList:setVirtual(self)
	self.m_payList:setItemRenderer(handler(self, self._onPayItemRender))
	self.m_btn:addClickListener(handler(self, self._onBtnClicked))
	self.m_stateController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onStateChanged))
end

function ThemePassCardRewardCell:_initView(arg_2_1)
	if not self._themeValue then
		self._themeValue = arg_2_1

		local var_2_0 = var_0_0.THEME_RES_KEY_ALIAS[arg_2_1] or arg_2_1

		self.m_starIcon:setIcon(g.core.common.Path:getThemePassCardImage("pic_zl_star1", var_2_0))
		self.m_btn:setIcon(g.core.common.Path:getThemePassCardImage("btn_zl_little1", var_2_0))
		self:_onStateChanged()
	end
end

function ThemePassCardRewardCell:_onStateChanged()
	local var_3_0 = var_0_0.THEME_ACTIVITY_PASS_CARD_BTN_COLOR[self._themeValue] or var_0_0.THEME_ACTIVITY_PASS_CARD_BTN_COLOR[var_0_0.THEME_VALUE.RIE]

	self.m_btnText:setColor(self.m_stateController:getSelectedIndex() == 0 and var_3_0[1] or var_3_0[2])
end

function ThemePassCardRewardCell:updatePassCardCell(arg_4_1, arg_4_2, arg_4_3)
	self:_initView(arg_4_3)

	self._data = arg_4_1

	local var_4_0 = self._data.cfg.num
	local var_4_1 = g.core.lang:get(425503)

	if arg_4_1.cfg.action == 350 or arg_4_1.cfg.action == 439 or arg_4_1.cfg.action == 450 then
		var_4_0 = self._data.cfg.num - 1
		var_4_1 = g.core.lang:get(425506)
	elseif arg_4_1.cfg.star == 0 then
		var_4_0 = arg_4_1.cfg.star
		var_4_1 = g.core.lang:get(425506)
	end

	self.m_rankText:setText(var_4_0)

	self._themeValue = arg_4_3

	if arg_4_1.payLimit > 0 then
		self.m_buyLimitText:setText(g.core.lang:get(425502, {
			cur = arg_4_1.payNum,
			max = arg_4_1.payLimit
		}))
		self.m_isLimitBuyController:setSelectedIndex(1)
	else
		self.m_isLimitBuyController:setSelectedIndex(0)
	end

	if arg_4_1.payNum > 0 then
		self.m_isBuyController:setSelectedIndex(1)
	else
		self.m_isBuyController:setSelectedIndex(0)
	end

	self.m_stateController:setSelectedIndex(arg_4_1.state)
	self.m_freeList:setNumItems(#arg_4_1.freeAwards)
	self.m_payList:setNumItems(#arg_4_1.payAwards)

	local var_4_2 = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(31, arg_4_1.cfg.money)

	self._rechargeInfo = var_4_2

	if arg_4_1.state >= 1 then
		self.m_btnText:setText(var_4_2.moneyUnit .. var_4_2.realMoney)
	else
		self.m_btnText:setText(var_4_1)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			themeValue = self._themeValue,
			id = self._data.id
		}
	})
end

function ThemePassCardRewardCell:_onFreeItemRender(arg_5_1, arg_5_2)
	local var_5_0 = self._data.freeAwards[arg_5_1 + 1]

	arg_5_2:initView(self._themeValue)
	arg_5_2:updateIcon(var_5_0, self._data.state == 2, self._data.state == 1)
end

function ThemePassCardRewardCell:_onPayItemRender(arg_6_1, arg_6_2)
	local var_6_0 = self._data.payAwards[arg_6_1 + 1]

	arg_6_2:initView(self._themeValue)
	arg_6_2:updateIcon(var_6_0, self._data.payNum > 0)
end

function ThemePassCardRewardCell:_onBtnClicked()
	if self._data.state >= 1 then
		self:dispatchCompEvent("do_pay_item", {
			rechargeInfo = self._rechargeInfo,
			id = self._data.id
		})
	else
		if g.core.model.User.themeData:getActivityData(self._themeValue):getActivityState() ~= g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.START then
			g.core.module.ModuleManager:tip((g.core.lang:get(1005)))

			return
		end

		g.view.entrance.ModuleGotoProxy:gotoModule(self._data.cfg.route_id)
	end
end

function ThemePassCardRewardCell:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "get_free_award" then
		self:dispatchCompEvent("req_free_award", self._data)

		return true
	end
end

return ThemePassCardRewardCell
