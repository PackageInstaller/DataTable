local var_0_0 = {}

var_0_0.URL = "ui://sap1qcktje0cfreu"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_talentList = self:getChild("talentList")
	self.m_content = self:getChild("content")
end

return var_0_0
