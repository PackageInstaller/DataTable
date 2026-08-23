local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25xi537c"

function var_0_0:__ctor()
	self.m_eff = self:getChild("eff")
	self.m_iconComp = self:getChild("iconComp")
	self.m_numTxt = self:getChild("numTxt")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
