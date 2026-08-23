local var_0_0 = g.core.model.User.rechargeData
local RechargeCell = class("RechargeCell", require("app.fairyGUI.recharge.UI_RechargeCell"))

function RechargeCell:ctor()
	self._info = nil
	self._isEnough = true
	self._isBuy = false
	self._costType = 0
	self._costValue = 0
	self._costHasNum = 0

	self.getSharedTrans(self, "listCardAUiLeftIn", "CombineBagList", self)
	self.m_effectHolder:addEffectSpine({
		name = "eff_ui_shop_recharge",
		scale = 1,
		isLoop = true
	})
	self:_addListeners()
end

function RechargeCell:_addListeners()
	self:addClickListener(handler(self, self._onClick))
end

function RechargeCell:_onClick()
	g.core.common.GlobalFunc.doRechargeById(self, self._info.id)
end

function RechargeCell:updateCell(arg_4_1, arg_4_2)
	if not arg_4_1 then
		self:setVisible(false)

		return
	end

	self:setVisible(true)

	self._info = arg_4_1

	self:_updateInitInfo(arg_4_1, arg_4_2)
	self:updateOtherInfo(arg_4_1)
end

function RechargeCell:updateOtherInfo(arg_5_1)
	local var_5_0 = not var_0_0:hasRecharge(arg_5_1.id) or var_0_0:hasDoubleRechargeById(arg_5_1.id)

	self.m_priceComp:setPriceByInfo(arg_5_1)
	self.m_isFirstController:setSelectedIndex(var_5_0 and 1 or 0)

	if var_5_0 then
		local var_5_1 = arg_5_1.gold_gift_first or arg_5_1.gold_gift

		if var_5_1 > 0 then
			self.m_isAdditionalController:setSelectedIndex(1)
			self.m_resNum2:setText(var_5_1)

			goto label_5_0
		end
	end

	self.m_isAdditionalController:setSelectedIndex(0)

	::label_5_0::

	local var_5_2 = 0

	if arg_5_1.extra_gift_type > 0 then
		var_5_2 = var_5_2 + 1

		self.m_resIcon3:setURL((g.core.common.Path:getIconByTypeValue(arg_5_1.extra_gift_type, arg_5_1.extra_gift_value, true)))
		self.m_resNum3:setText(arg_5_1.extra_gift_size)
	end

	if arg_5_1.extra_gift_type_1 > 0 then
		var_5_2 = var_5_2 + 1

		self.m_resIcon4:setURL((g.core.common.Path:getIconByTypeValue(arg_5_1.extra_gift_type_1, arg_5_1.extra_gift_value_1, true)))
		self.m_resNum4:setText(arg_5_1.extra_gift_size_1)
	end

	self.m_isGiftController:setSelectedIndex(var_5_2)
end

function RechargeCell:_updateInitInfo(arg_6_1, arg_6_2)
	if (self._init or not arg_6_1) and not arg_6_2 then
		return
	end

	self._init = true

	self.m_item:setURL((g.core.common.Path:getRechargeIconById(arg_6_1.icon)))
	self.m_resIcon2:setURL((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_GOLD, 1, true)))
	self.m_resComp:setTitle(arg_6_1.gold_recharge)
	self.m_resComp:setIcon((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_GOLD, 1, true)))
end

return RechargeCell
