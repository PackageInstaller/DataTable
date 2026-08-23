local var_0_0 = {}

var_0_0.URL = "ui://q8j59504ojr069"

function var_0_0:__ctor()
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_effLoop = self:getChild("effLoop")
	self.m_effPlay = self:getChild("effPlay")
	self.m_effUp = self:getChild("effUp")
	self.m_effDown = self:getChild("effDown")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
