local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2mbs1t"

function var_0_0:__ctor()
	self.m_btnTypeController = self:getController("btnType")
	self.m_iconLoader = self:getChild("iconLoader")
end

var_0_0.BtnTypeCtrl = {
	goon = 1,
	quit = 0,
	page3 = 3,
	page2 = 2
}

return var_0_0
