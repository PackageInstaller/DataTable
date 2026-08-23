local AllianceMenuPop = class("AllianceMenuPop", require("app.fairyGUI.alliance.UI_AllianceMenuPop"), function()
	return fgui.GComponent:create({
		resName = "AllianceMenuPop",
		pkgPath = "ui/alliance/alliance",
		pkgName = "alliance"
	})
end)

function AllianceMenuPop:ctor(arg_2_1)
	self:showAtCenter()
	self.m_touchBg:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClickTouchBg))
	self.m_menuList:updateMenuComp(arg_2_1)

	if arg_2_1.worldPos.x + 350 > display.width then
		self.m_menuList:setPivot(1, 0, true)
	end

	self.m_menuList:setPosition(arg_2_1.worldPos)
end

function AllianceMenuPop:_onClickTouchBg()
	self.m_touchBg:setVisible(false)
	self.m_menuList:setTouchable(false)
	self.m_menuList:playBackTransition(handler(self, self._popSelf))
end

function AllianceMenuPop:_popSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return AllianceMenuPop
