local var_0_0 = g.core.model.User.gmPassCardData
local PassCardNewBuyPop = class("PassCardNewBuyPop", require("app.fairyGUI.newPassCard.UI_PassCardNewBuyPop"), function()
	return fgui.GComponent:create({
		pkgName = "newPassCard",
		isFullScreen = false,
		pkgPath = "ui/newPassCard/newPassCard",
		resName = "PassCardNewBuyPop"
	}, ...)
end)

function PassCardNewBuyPop:ctor()
	self:getView():setSize(display.width, display.height)
	self:showAtCenter()
	self.m_buyBtn:addClickListener(handler(self, self._onBuyBtnClick))
	self.m_closePnl:addClickListener(handler(self, self.closePnl))
	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self.onItemRenderer))
	self:initRewardView()
	self.m_enterTransition:play()
end

function PassCardNewBuyPop:initRewardView()
	local var_3_0, var_3_1 = var_0_0:getAllPassCardAwards()

	self._payList = var_3_1

	self.m_itemList:setNumItems(#self._payList)

	local var_3_2 = var_0_0:getActivityCfg()

	self.m_discountTxt:setText(var_3_2.ratio .. "%")

	local var_3_3 = g.core.config.gm_passcard_reward_info.get(var_3_2.show_3)
	local var_3_4 = g.core.common.Goods:convert({
		type = var_3_3.pay_type,
		value = var_3_3.pay_value,
		size = var_3_3.pay_size
	})
	local var_3_5 = g.core.config.knight_base_info.get(var_3_2.show)

	self.m_headIconComp:setIcon(g.core.common.Path:getKnightIconById(var_3_5.icon_id))
	self.m_itemIcon:setIcon(var_3_4.bigIcon)
	self.m_itemTitleTxt:setText(var_3_4.name)
	self.m_knightName:setText(var_3_5.name)

	local var_3_6 = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(g.core.const.ConstMgr.RechargeConst.RECHARGE_TYPE.PASS_CARD_NEW, var_3_2.money)

	self._rechargeInfo = var_3_6

	self.m_buyBtn:setTitle((var_3_6.moneyUnit or "") .. var_3_6.realMoney)
end

function PassCardNewBuyPop:closePnl()
	if not self._close then
		self._close = true

		self.m_backTransition:play(handler(self, self.onFinishClose))
	end
end

function PassCardNewBuyPop:onFinishClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function PassCardNewBuyPop:onItemRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateIcon(self._payList[arg_6_1 + 1])
end

function PassCardNewBuyPop:_onBuyBtnClick()
	g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._rechargeInfo, var_0_0:getRechargeId(), 0)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return PassCardNewBuyPop
