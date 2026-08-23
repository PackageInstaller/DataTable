local OutpostBagPop = class("OutpostBagPop", require("app.fairyGUI.outpost.UI_OutpostBagPop"), function()
	return fgui.GComponent:create({
		pkgName = "outpost",
		isFullScreen = false,
		pkgPath = "ui/outpost/outpost",
		resName = "OutpostBagPop"
	}, ...)
end)

function OutpostBagPop:ctor()
	self:_initPop()
	self:showAtCenter()
end

function OutpostBagPop:_initPop()
	self.m_bagList:setVirtual(self)
	self.m_bagList:setItemRenderer(handler(self, self._onBagItemRender))
end

function OutpostBagPop:onLoad()
	self._bagList = g.core.model.User.outpostData:getBagData():getBagItemList(true)

	if #self._bagList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_bagList:setNumItems(#self._bagList)
		self.m_isEmptyController:setSelectedIndex(0)
	end
end

function OutpostBagPop:_onBagItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateBagItemComp(self._bagList[arg_5_1 + 1])
end

return OutpostBagPop
