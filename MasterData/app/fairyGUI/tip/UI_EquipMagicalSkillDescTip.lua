local var_0_0 = {}

var_0_0.URL = "ui://sap1qcktek02fret"

function var_0_0:__ctor()
	self.m_numController = self:getController("num")
	self.m_styleController = self:getController("style")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_descComp = self:getChild("descComp")
	self.m_descText2 = self:getChild("descText2")
	self.m_content = self:getChild("content")
end

return var_0_0
