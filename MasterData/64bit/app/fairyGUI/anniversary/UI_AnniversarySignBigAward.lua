local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiq9hnm28"

function var_0_0:__ctor()
	self.m_isGetController = self:getController("isGet")
	self.m_iconComp = self:getChild("iconComp")
	self.m_numTxt = self:getChild("numTxt")
	self.m_getBigTransition = self:getTransition("getBig")
end

return var_0_0
