local var_0_0 = g.core.model.User.rechargeData
local RechargeQuickComp = class("RechargeQuickComp", require("app.fairyGUI.recharge.UI_RechargeQuickComp"))

function RechargeQuickComp:ctor()
	self._info = nil
	self._isEnough = true
	self._isBuy = false
	self._costType = 0
	self._costValue = 0
	self._costHasNum = 0
end

function RechargeQuickComp:updateCell(arg_2_1, arg_2_2)
	if not arg_2_1 then
		self:setVisible(false)

		return
	end

	self:setVisible(true)

	self._info = arg_2_1

	self:_updateInitInfo(arg_2_1, arg_2_2)
	self:updateOtherInfo(arg_2_1)
end

function RechargeQuickComp:updateOtherInfo(arg_3_1)
	local var_3_0 = not var_0_0:hasRecharge(arg_3_1.id) or var_0_0:hasDoubleRechargeById(arg_3_1.id)

	self.m_isFirstController:setSelectedIndex(var_3_0 and 1 or 0)

	if var_3_0 then
		local var_3_1 = arg_3_1.gold_gift_first or arg_3_1.gold_gift

		if var_3_1 > 0 then
			self.m_isAdditionalController:setSelectedIndex(1)
			self.m_resNum2:setText(var_3_1)

			goto label_3_0
		end
	end

	self.m_isAdditionalController:setSelectedIndex(0)

	::label_3_0::

	if arg_3_1.extra_gift_type > 0 then
		self.m_isGiftController:setSelectedIndex(1)
		self.m_resIcon3:setURL((g.core.common.Path:getIconByTypeValue(arg_3_1.extra_gift_type, arg_3_1.extra_gift_value, true)))
		self.m_resNum3:setText(arg_3_1.extra_gift_size)
	else
		self.m_isGiftController:setSelectedIndex(0)
	end
end

function RechargeQuickComp:_updateInitInfo(arg_4_1, arg_4_2)
	if (self._init or not arg_4_1) and not arg_4_2 then
		return
	end

	self._init = true

	self.m_item:setURL((g.core.common.Path:getRechargeIconById(arg_4_1.icon)))
	self.m_resIcon2:setURL((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_GOLD, 0, true)))
	self.m_resComp:setTitle(arg_4_1.gold_recharge)
	self.m_resComp:setIcon((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_GOLD, 1, true)))
end

return RechargeQuickComp
