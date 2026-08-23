local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lehcvi8"

function var_0_0:__ctor()
	self.m_desTxt = self:getChild("desTxt")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_eff = self:getChild("eff")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
