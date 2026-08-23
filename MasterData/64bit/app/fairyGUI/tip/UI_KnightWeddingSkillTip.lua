local var_0_0 = {}

var_0_0.URL = "ui://sap1qcktktcsfrek"

function var_0_0:__ctor()
	self.m_numController = self:getController("num")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_descText = self:getChild("descText")
	self.m_descList = self:getChild("descList")
	self.m_descText2 = self:getChild("descText2")
	self.m_content = self:getChild("content")
end

return var_0_0
