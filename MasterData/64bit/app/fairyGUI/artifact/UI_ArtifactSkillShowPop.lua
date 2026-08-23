local var_0_0 = {}

var_0_0.URL = "ui://nhmdbbcveggpgic1u"

function var_0_0:__ctor()
	self.m_isLineUpController = self:getController("isLineUp")
	self.m_typeController = self:getController("type")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_skillIconComp = self:getChild("skillIconComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_buffDescLabel = self:getChild("buffDescLabel")
	self.m_skillComp = self:getChild("skillComp")
	self.m_content = self:getChild("content")
end

return var_0_0
