local TreeBoostModuleAttrComp = class("TreeBoostModuleAttrComp", require("app.fairyGUI.tree.UI_TreeBoostModuleAttrComp"))

function TreeBoostModuleAttrComp:ctor()
	self.m_baseAttrList:setVirtual()
	self.m_baseAttrList:setItemRenderer(handler(self, self._onBaseAttrItemRender))
end

function TreeBoostModuleAttrComp:_onBaseAttrItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateCell(self._attrList[arg_2_1 + 1])
end

function TreeBoostModuleAttrComp:updateBaseAttr(arg_3_1)
	self._attrList = arg_3_1

	if #self._attrList > 0 then
		self.m_baseAttrList:setNumItems(#self._attrList)
		self.m_baseAttrList:resizeToFit(#self._attrList)
		self.m_hasListController:setSelectedIndex(1)
	else
		self.m_hasListController:setSelectedIndex(0)
	end
end

return TreeBoostModuleAttrComp
