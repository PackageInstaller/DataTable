local AllianceMenuComp = class("AllianceMenuComp", require("app.fairyGUI.alliance.UI_AllianceMenuComp"))

function AllianceMenuComp:ctor()
	self._menuConfigList = {}

	self.m_menuList:setVirtual()
	self.m_menuList:setItemRenderer(handler(self, self._onRenderMenuList))
end

function AllianceMenuComp:updateMenuComp(arg_2_1)
	self.m_enterTransition:play()

	self._menuConfigList = arg_2_1.menuConfigs or {}
	self._guildSnapshot = arg_2_1.guildSnapshot

	self.m_menuList:setNumItems(#self._menuConfigList)
	self.m_menuList:resizeToFit(#self._menuConfigList)

	if #self._menuConfigList > 1 then
		self.m_menuList:setWidth(302)
	else
		self.m_menuList:setWidth(151)
	end
end

function AllianceMenuComp:_onRenderMenuList(arg_3_1, arg_3_2)
	arg_3_2:updateBtn(self._menuConfigList[arg_3_1 + 1], self._guildSnapshot)
end

function AllianceMenuComp:playBackTransition(arg_4_1)
	self.m_backTransition:play(arg_4_1)
end

return AllianceMenuComp
