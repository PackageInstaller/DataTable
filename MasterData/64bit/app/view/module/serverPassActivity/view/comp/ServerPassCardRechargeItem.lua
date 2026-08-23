local var_0_0 = g.core.model.User.serverPassActivityData
local ServerPassCardRechargeItem = class("ServerPassCardRechargeItem", require("app.fairyGUI.serverPassActivity.UI_ServerPassCardRechargeItem"))

function ServerPassCardRechargeItem:ctor()
	self._itemData = nil

	self:_initItem()
end

function ServerPassCardRechargeItem:_initItem()
	self.m_buyBtn:addClickListener(handler(self, self._onClickBuyBtn))
	self.m_rareAwardList:setVirtual()
	self.m_rareAwardList:setItemRenderer(handler(self, self._onRenderRareItemList))
	self.m_allAwardList:setVirtual()
	self.m_allAwardList:setItemRenderer(handler(self, self._onRenderAllAwardItemList))
end

function ServerPassCardRechargeItem:updateRechargeItem(arg_3_1, arg_3_2)
	self._itemData = arg_3_1

	self.m_ratioTxt:setText(string.format("%d%%", arg_3_1.cfg.discount))
	self.m_rareAwardList:setNumItems(#self._itemData.rareList)
	self.m_allAwardList:setNumItems(#self._itemData.dropList)

	if var_0_0:isPay(arg_3_2) then
		self.m_isBuyController:setSelectedIndex(1)
	else
		self.m_isBuyController:setSelectedIndex(0)
	end

	self.m_buyBtn:setNormalTitle(self._itemData.rechargeInfo.moneyUnit .. self._itemData.rechargeInfo.realMoney)
	self.m_bgEffectComp:removeAllEffect()
	self.m_btnEffectComp:removeAllEffect()

	if arg_3_2 == 1 then
		self.m_bgEffectComp:addEffectSpine({
			isLoop = true,
			name = "eff_ui_serverPass_buybg",
			anim = "play_2",
			scale = 1
		})
		self.m_btnEffectComp:addEffectSpine({
			isLoop = true,
			name = "eff_ui_serverPass_btnbuy",
			anim = "play_2",
			scale = 1
		})
	else
		self.m_bgEffectComp:addEffectSpine({
			isLoop = true,
			name = "eff_ui_serverPass_buybg",
			anim = "play_1",
			scale = 1
		})
		self.m_btnEffectComp:addEffectSpine({
			isLoop = true,
			name = "eff_ui_serverPass_btnbuy",
			anim = "play_1",
			scale = 1
		})
	end
end

function ServerPassCardRechargeItem:_onRenderRareItemList(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._itemData.rareList[arg_4_1 + 1])
end

function ServerPassCardRechargeItem:_onRenderAllAwardItemList(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._itemData.dropList[arg_5_1 + 1])
end

function ServerPassCardRechargeItem:_onClickBuyBtn()
	g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._itemData.rechargeInfo, var_0_0:getId(), self._itemData.cfg.type)
end

return ServerPassCardRechargeItem
