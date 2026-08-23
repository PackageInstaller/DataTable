local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ulamy9q"

function var_0_0:__ctor()
	self.m_isMaxController = self:getController("isMax")
	self.m_popPanel = self:getChild("popPanel")
	self.m_ksoulList = self:getChild("ksoulList")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_starComp = self:getChild("starComp")
	self.m_activateBtn = self:getChild("activateBtn")
	self.m_attributes = self:getChild("attributes")
	self.m_content = self:getChild("content")
end

return var_0_0
