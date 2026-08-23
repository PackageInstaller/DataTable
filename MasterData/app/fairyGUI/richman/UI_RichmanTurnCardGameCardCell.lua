local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwny82n"

function var_0_0:__ctor()
	self.m_isSelectedController = self:getController("isSelected")
	self.m_typeController = self:getController("type")
	self.m_iconBg = self:getChild("iconBg")
	self.m_icon = self:getChild("icon")
	self.m_eff = self:getChild("eff")
	self.m_eff2 = self:getChild("eff2")
	self.m_fadeTransition = self:getTransition("fade")
end

return var_0_0
