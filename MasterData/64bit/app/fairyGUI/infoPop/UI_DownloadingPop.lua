local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bn7t9d1v5dss7"

function var_0_0:__ctor()
	self.m_effLoading = self:getChild("effLoading")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_proComp = self:getChild("proComp")
	self.m_proTxt = self:getChild("proTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
