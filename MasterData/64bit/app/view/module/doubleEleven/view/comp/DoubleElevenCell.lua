local var_0_0 = g.core.model.User.rechargeData
local var_0_1 = g.core.const.ConstMgr.ShopConst
local var_0_2 = g.core.model.User.doubleElevenData
local DoubleElevenCell = class("DoubleElevenCell", require("app.fairyGUI.doubleEleven.UI_DoubleElevenCell"))

function DoubleElevenCell:ctor()
	self._info = nil
	self._isEnough = true
	self._isBuy = false
	self._costType = 0
	self._costValue = 0
	self._costHasNum = 0

	self.getSharedTrans(self, "listCardAUiLeftIn", "CombineBagList", self)
	self.m_effectHolder:addEffectSpine({
		isLoop = true,
		name = "eff_ui_shop_recharge",
		scale = 1
	})
	self:_addListeners()
end

function DoubleElevenCell:_addListeners()
	self:addClickListener(handler(self, self._onClick))
end

function DoubleElevenCell:_onClick()
	if var_0_2:getBuyTimesById(self._saleInfo.id) < self._saleInfo.times then
		g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._info, self._saleInfo.id, 0)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(408317))
	end
end

function DoubleElevenCell:updateCell(arg_4_1, arg_4_2)
	if not arg_4_1 then
		self:setVisible(false)

		return
	end

	self:setVisible(true)

	self._saleInfo = arg_4_1
	self._info = var_0_0:getRechargeInfoByTypeAndPrice(arg_4_1.recharge_type, arg_4_1.money)

	self:_updateInitInfo(self._info, arg_4_2)
	self:updateOtherInfo(self._info)
end

function DoubleElevenCell:updateOtherInfo(arg_5_1)
	self.m_isLimitController:setSelectedIndex(0)

	local var_5_0 = var_0_2:getBuyTimesById(self._saleInfo.id)

	if self._saleInfo.limit_type ~= var_0_1.NUM_BAN_TYPE.NONE then
		self.m_isLimitController:setSelectedIndex(1)
		self.m_limitTimes:setText(g.core.lang:get(408302, {
			num = self._saleInfo.times - var_5_0,
			maxNum = self._saleInfo.times
		}))
	end

	self.m_canBuyController:setSelectedIndex(var_5_0 < self._saleInfo.times and 1 or 0)

	local var_5_1 = not var_0_0:hasRecharge(arg_5_1.id) or var_0_0:hasDoubleRechargeById(arg_5_1.id)

	self.m_priceComp:setPriceByInfo(arg_5_1)

	if var_5_1 then
		local var_5_2 = arg_5_1.gold_gift_first or arg_5_1.gold_gift

		if var_5_2 > 0 then
			self.m_isAdditionalController:setSelectedIndex(1)
			self.m_resNum2:setText(var_5_2)

			goto label_5_0
		end
	end

	self.m_isAdditionalController:setSelectedIndex(0)

	::label_5_0::

	local var_5_3 = 0

	if arg_5_1.extra_gift_type > 0 then
		var_5_3 = var_5_3 + 1

		self.m_resIcon3:setURL((g.core.common.Path:getIconByTypeValue(arg_5_1.extra_gift_type, arg_5_1.extra_gift_value, true)))
		self.m_resNum3:setText(arg_5_1.extra_gift_size)
	end

	if arg_5_1.extra_gift_type_1 > 0 then
		var_5_3 = var_5_3 + 1

		self.m_resIcon4:setURL((g.core.common.Path:getIconByTypeValue(arg_5_1.extra_gift_type_1, arg_5_1.extra_gift_value_1, true)))
		self.m_resNum4:setText(arg_5_1.extra_gift_size_1)
	end

	self.m_isGiftController:setSelectedIndex(var_5_3)
end

function DoubleElevenCell:_updateInitInfo(arg_6_1, arg_6_2)
	if (self._init or not arg_6_1) and not arg_6_2 then
		return
	end

	self._init = true

	self.m_item:setURL((g.core.common.Path:getRechargeIconById(arg_6_1.icon)))
	self.m_resIcon2:setURL((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_GOLD, 1, true)))
	self.m_resComp:setTitle(arg_6_1.gold_recharge)
	self.m_resComp:setIcon((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_GOLD, 1, true)))
end

return DoubleElevenCell
