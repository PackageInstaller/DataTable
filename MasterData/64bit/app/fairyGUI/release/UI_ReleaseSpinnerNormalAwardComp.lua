local var_0_0 = {}

var_0_0.URL = "ui://ltl1fuv2mg6n1i"

function var_0_0:__ctor()
	self.m_isAwardController = self:getController("isAward")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_numTxt = self:getChild("numTxt")
	self.m_remainBg = self:getChild("remainBg")
	self.m_remainNumTxt = self:getChild("remainNumTxt")
	self.m_eff = self:getChild("eff")
	self.m_txteff = self:getChild("txteff")
end

return var_0_0
