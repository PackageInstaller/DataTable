local var_0_0 = {}

var_0_0.URL = "ui://sap1qcktka4afref"

function var_0_0:__ctor()
	self.m_isMaxController = self:getController("isMax")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_attrComp1 = self:getChild("attrComp1")
	self.m_attrComp2 = self:getChild("attrComp2")
	self.m_attrComp3 = self:getChild("attrComp3")
	self.m_attrComp4 = self:getChild("attrComp4")
	self.m_attrComp5 = self:getChild("attrComp5")
	self.m_content = self:getChild("content")
end

return var_0_0
