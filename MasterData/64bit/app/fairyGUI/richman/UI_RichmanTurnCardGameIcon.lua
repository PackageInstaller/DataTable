local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwny829"

function var_0_0:__ctor()
	self.m_isActivatedController = self:getController("isActivated")
	self.m_typeController = self:getController("type")
	self.m_icon = self:getChild("icon")
	self.m_iconMask = self:getChild("iconMask")
	self.m_loop = self:getChild("loop")
	self.m_eff2 = self:getChild("eff2")
	self.m_eff = self:getChild("eff")
	self.m_clickTransition = self:getTransition("click")
end

return var_0_0
