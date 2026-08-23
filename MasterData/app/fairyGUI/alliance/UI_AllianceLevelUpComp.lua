local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcg2dc56"

function var_0_0:__ctor()
	self.m_beforeLevel = self:getChild("beforeLevel")
	self.m_afterLevel = self:getChild("afterLevel")
	self.m_beforeGuildNum = self:getChild("beforeGuildNum")
	self.m_afterGuildNum = self:getChild("afterGuildNum")
	self.m_unlockBuildList = self:getChild("unlockBuildList")
	self.m_showUnlockGroup = self:getChild("showUnlockGroup")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
