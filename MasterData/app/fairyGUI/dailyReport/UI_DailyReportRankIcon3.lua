local var_0_0 = {}

var_0_0.URL = "ui://8l7hr9r1t26b2x"

function var_0_0:__ctor()
	self.m_rankController = self:getController("rank")
	self.m_emptyController = self:getController("empty")
	self.m_knightHeadIcon = self:getChild("knightHeadIcon")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_svrNameTxt = self:getChild("svrNameTxt")
end

return var_0_0
