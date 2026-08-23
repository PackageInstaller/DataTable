local RechargeGemCell = class("RechargeGemCell", require("app.fairyGUI.recharge.UI_RechargeGemCell"))

function RechargeGemCell:ctor()
	self._info = nil
	self._isEnough = true
	self._isBuy = false
	self._costType = 0
	self._costValue = 0
	self._costHasNum = 0

	self:_addListeners()
end

function RechargeGemCell:_addListeners()
	self:addClickListener(handler(self, self._onClick))
end

function RechargeGemCell:_onClick()
	g.core.common.GlobalFunc.doRechargeById(self, self._info.id)
end

function RechargeGemCell:updateCell(arg_4_1, arg_4_2)
	if not arg_4_1 then
		self:setVisible(false)

		return
	end

	self:setVisible(true)

	self._info = arg_4_1

	self.m_item:setURL((g.core.common.Path:getRechargeIconById(arg_4_1.icon)))
	self.m_nameTxt:setText(arg_4_1.name)
	self.m_priceComp:setTitle(arg_4_1.realMoney)
end

return RechargeGemCell
