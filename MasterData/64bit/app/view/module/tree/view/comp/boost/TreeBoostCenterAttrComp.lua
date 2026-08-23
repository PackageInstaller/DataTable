local TreeBoostCenterAttrComp = class("TreeBoostCenterAttrComp", require("app.fairyGUI.tree.UI_TreeBoostCenterAttrComp"))

function TreeBoostCenterAttrComp:ctor()
	self.m_centerNodeList:setIniter()
	self.m_centerNodeList:setItemRenderer(handler(self, self._onCenterNodeItemRender))
	self:addListen(self.m_centerNodeList)
end

function TreeBoostCenterAttrComp:_onCenterNodeItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateCenterCell(self._centerNodeAttr[arg_2_1 + 1])
end

function TreeBoostCenterAttrComp:updateCenterAndBigNodeAttr(arg_3_1)
	self._centerNodeAttr = arg_3_1

	if #self._centerNodeAttr > 0 then
		self.m_centerNodeList:setNumItems(#self._centerNodeAttr)
		self.m_centerNodeList:resizeToFit(#self._centerNodeAttr)
		self.m_hasListController:setSelectedIndex(1)
	else
		self.m_centerNodeList:setHeight(200)
		self.m_hasListController:setSelectedIndex(0)
	end
end

return TreeBoostCenterAttrComp
