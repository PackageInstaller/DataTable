local var_0_0 = g.core.model.User.treeData
local TreeBoostNodeComp = class("TreeBoostNodeComp", require("app.fairyGUI.tree.UI_TreeBoostNodeComp"))

function TreeBoostNodeComp:updateNodeComp()
	self.m_baseAttrComp:updateBaseAttr()
	self.m_centerAttrComp:updateCenterAndBigNodeAttr((var_0_0:getAllCenterAndBigNodeAttr()))
end

return TreeBoostNodeComp
