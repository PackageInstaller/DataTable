local var_0_0 = {}

var_0_0.URL = "ui://x323b22nje0cc"

function var_0_0:__ctor()
	self.m_menuController = self:getController("menu")
	self.m_infoPopBase = self:getChild("infoPopBase")
end

var_0_0.MenuCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
