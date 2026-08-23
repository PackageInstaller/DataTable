local TreeTalentComp = class("TreeTalentComp", require("app.fairyGUI.tree.UI_TreeNodeInfoAttrCell"))

function TreeTalentComp:updateData(arg_1_1)
	self.m_desc:setText(arg_1_1.desc)
	self.m_curValue:setText(arg_1_1.curValue)
	self.m_afterValue:setText(arg_1_1.afterValue or "")
	self.m_isMaxController:setSelectedIndex(arg_1_1.isMax and 1 or 0)
	self.m_isShowArrowController:setSelectedIndex(arg_1_1.afterValue and 1 or 0)
end

return TreeTalentComp
