local TreeBoostModuleScrollComp = class("TreeBoostModuleScrollComp", require("app.fairyGUI.tree.UI_TreeBoostModuleScrollComp"))

function TreeBoostModuleScrollComp:updateScrollComp(arg_1_1, arg_1_2)
	self.m_baseAttrComp:updateBaseAttr(arg_1_1)
	self.m_centerAttrComp:updateCenterAndBigNodeAttr(arg_1_2)
end

return TreeBoostModuleScrollComp
