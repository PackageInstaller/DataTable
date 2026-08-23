local CommonAttrComp = class("CommonAttrComp", require("app.fairyGUI.tip.UI_CommonAttrComp"))

function CommonAttrComp:updateAttrComp(arg_1_1, arg_1_2)
	if not arg_1_1 then
		self:setVisible(false)

		return
	end

	self.m_curAttrComp:updateAttr(arg_1_1)

	if arg_1_2 or not arg_1_1.nextValue then
		self.m_isMaxController:setSelectedIndex(1)

		return
	end

	self.m_isMaxController:setSelectedIndex(0)

	if not arg_1_1.type then
		local var_1_0 = arg_1_1.nextValue or 0

		self.m_nextAttrValue:setText(var_1_0)
		self.m_addAttrValue:setText(var_1_0 - arg_1_1.value)

		return
	end

	local var_1_1, var_1_2 = g.core.lang:getAttr(arg_1_1.type, tonumber(arg_1_1.nextValue), true)
	local var_1_3, var_1_4 = g.core.lang:getAttr(arg_1_1.type, tonumber(arg_1_1.nextValue - arg_1_1.value), true)

	self.m_nextAttrValue:setText(var_1_2)
	self.m_addAttrValue:setText(var_1_4)
end

return CommonAttrComp
