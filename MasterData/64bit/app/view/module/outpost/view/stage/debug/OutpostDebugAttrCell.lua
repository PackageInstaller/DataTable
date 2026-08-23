local OutpostDebugAttrCell = class("OutpostDebugAttrCell", require("app.fairyGUI.outpost.UI_OutpostDebugAttrCell"))

function OutpostDebugAttrCell:ctor()
	self:disableAutoChange()
end

function OutpostDebugAttrCell:updateAttr(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:getAttr()
	local var_2_1 = arg_2_2.id

	self.m_attrType:setText(arg_2_2.id, nil, true)
	self.m_attrValue:setText(string.format("%s", (var_2_0:getOriginAttr(var_2_1))), nil, true)
	self.m_attrName:setText(arg_2_2.name)

	if arg_2_2.value_format == 1 then
		self.m_isThousandController:setSelectedIndex(0)
	elseif arg_2_2.value_format == 2 then
		self.m_isThousandController:setSelectedIndex(1)
	end

	local var_2_2 = var_2_0:getChangeAttr(var_2_1)

	if var_2_2 < 0 then
		self.m_changeValue:setText(string.format("战斗中属性更改：%s", var_2_2), nil, true)
		self.m_isAddAttrController:setSelectedIndex(0)
	else
		self.m_changeValue:setText(string.format("战斗中属性更改：%s", var_2_2), nil, true)
		self.m_isAddAttrController:setSelectedIndex(1)
	end
end

return OutpostDebugAttrCell
