local ExplorationBuffAttrPop = class("ExplorationBuffAttrPop", require("app.fairyGUI.exploration.UI_ExplorationBuffAttrPop"), function()
	return fgui.GComponent:create({
		pkgName = "exploration",
		resName = "ExplorationBuffAttrPop"
	})
end)

function ExplorationBuffAttrPop:ctor(arg_2_1)
	self:showAtCenter()

	self._attrList = {}

	self:_initListView()
	self:updateView()
end

function ExplorationBuffAttrPop:_initListView()
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onRenderAttrList))
end

function ExplorationBuffAttrPop:_onRenderAttrList(arg_4_1, arg_4_2)
	arg_4_2:updateView(self._attrList[arg_4_1 + 1])
end

function ExplorationBuffAttrPop:updateView()
	self._attrList = g.core.model.User.explorationData:getEventBuffAttrList()

	if #self._attrList == 0 then
		self.m_isBuffEmptyController:setSelectedIndex(1)
	else
		self.m_isBuffEmptyController:setSelectedIndex(0)
		self.m_attrList:setNumItems(#self._attrList)
	end
end

return ExplorationBuffAttrPop
