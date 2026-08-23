local InfoUserMenuComp = class("InfoUserMenuComp", require("app.fairyGUI.infoPop.UI_InfoUserMenuComp"))

function InfoUserMenuComp:ctor(arg_1_1)
	self._type = nil
	self._menuData = {}
	self._playInfo = nil

	self.m_menuList:setVirtual()
	self.m_menuList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_enterTransition:play()
end

function InfoUserMenuComp:updateMenu(arg_2_1, arg_2_2)
	self._menuData = arg_2_1 or {}
	self._playInfo = arg_2_2

	self.m_menuList:setNumItems(#arg_2_1)
	self.m_menuList:resizeToFit(#arg_2_1)
end

function InfoUserMenuComp:_onItemRenderer(arg_3_1, arg_3_2)
	if self._menuData[arg_3_1 + 1] then
		arg_3_2:updateBtn(self._menuData[arg_3_1 + 1], self._playInfo)
	end
end

function InfoUserMenuComp:setDir(arg_4_1)
	self.m_posTypeController:setSelectedIndex(arg_4_1 and 0 or 1)
end

return InfoUserMenuComp
