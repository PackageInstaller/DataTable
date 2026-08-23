local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ulamy92"

function var_0_0:__ctor()
	self.m_isMaxController = self:getController("isMax")
	self.m_processBar = self:getChild("processBar")
	self.m_maxTxt = self:getChild("maxTxt")
	self.m_honorNum = self:getChild("honorNum")
	self.m_processTxt = self:getChild("processTxt")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
