local TreeBoostBaseAttrCell = class("TreeBoostBaseAttrCell", require("app.fairyGUI.tree.UI_TreeBoostBaseAttrCell"))

function TreeBoostBaseAttrCell:updateCell(arg_1_1)
	local var_1_0, var_1_1 = g.core.lang:getAttr(arg_1_1.type, arg_1_1.value)

	self.m_attrName:setText(var_1_0)
	self.m_attrValue:setText(var_1_1, nil, true)
end

return TreeBoostBaseAttrCell
