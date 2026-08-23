local var_0_0 = {}

var_0_0.URL = "ui://q8j59504ojr06c"

function var_0_0:__ctor()
	self.m_preTxt = self:getChild("preTxt")
	self.m_stageTxt = self:getChild("stageTxt")
	self.m_effComp = self:getChild("effComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
