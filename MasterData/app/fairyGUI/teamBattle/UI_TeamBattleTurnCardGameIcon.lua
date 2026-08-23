local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lpwm797"

function var_0_0:__ctor()
	self.m_isActivatedController = self:getController("isActivated")
	self.m_typeController = self:getController("type")
	self.m_iconMask = self:getChild("iconMask")
	self.m_icon = self:getChild("icon")
	self.m_loop = self:getChild("loop")
	self.m_eff2 = self:getChild("eff2")
	self.m_eff = self:getChild("eff")
	self.m_clickTransition = self:getTransition("click")
end

var_0_0.IsActivatedCtrl = {
	page0 = 2,
	page1 = 3
}
var_0_0.TypeCtrl = {
	page0 = 2,
	page2 = 0,
	page1 = 1
}

return var_0_0
