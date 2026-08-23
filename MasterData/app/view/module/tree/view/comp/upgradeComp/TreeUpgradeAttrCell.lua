local TreeTalentComp = class("TreeTalentComp", require("app.fairyGUI.tree.UI_TreeUpgradeAttrCell"))

function TreeTalentComp:updateCell(arg_1_1, arg_1_2)
	self.m_desc:setText(arg_1_1.desc or "")
	self.m_curValue:setText(arg_1_1.beforeValue or "", nil, true)
	self.m_afterValue:setText(arg_1_1.afterValue or "", nil, true)
	self.m_hasNewController:setSelectedIndex(arg_1_1.hasNew and 1 or 0)
	self.m_hideArrowController:setSelectedIndex(arg_1_2 and 1 or 0)
end

return TreeTalentComp
