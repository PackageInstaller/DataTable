local var_0_0 = g.core.model.User.treeData
local TreeBoostBaseAttrComp = class("TreeBoostBaseAttrComp", require("app.fairyGUI.tree.UI_TreeBoostBaseAttrComp"))

function TreeBoostBaseAttrComp:ctor()
	self.m_baseAttrList:setVirtual()
	self.m_baseAttrList:setItemRenderer(handler(self, self._onBaseAttrItemRender))
	self.m_basePercentList:setVirtual()
	self.m_basePercentList:setItemRenderer(handler(self, self._onBasePercentItemRender))
end

function TreeBoostBaseAttrComp:_onBaseAttrItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateCell(self._baseAttr[arg_2_1 + 1])
end

function TreeBoostBaseAttrComp:_onBasePercentItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._percentAttr[arg_3_1 + 1])
end

function TreeBoostBaseAttrComp:updateBaseAttr()
	self._baseAttr = var_0_0:getAllSmallNodeNumAttr()

	self.m_baseAttrList:setNumItems(#self._baseAttr)

	if #self._baseAttr > 3 then
		self.m_baseAttrList:resizeToFit(#self._baseAttr)
	end

	self.m_hasBaseListController:setSelectedIndex(#self._baseAttr > 0 and 1 or 0)

	self._percentAttr = var_0_0:getAllSmallNodePercentAttr()

	self.m_basePercentList:setNumItems(#self._percentAttr)

	if #self._percentAttr > 2 then
		self.m_basePercentList:resizeToFit(#self._percentAttr)
	end

	self.m_hasPercentListController:setSelectedIndex(#self._percentAttr > 0 and 1 or 0)
end

return TreeBoostBaseAttrComp
