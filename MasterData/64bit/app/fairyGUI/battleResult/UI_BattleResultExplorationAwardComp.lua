local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nknhc3mibxg"

function var_0_0:__ctor()
	self.m_hideBuffController = self:getController("hideBuff")
	self.m_awardList = self:getChild("awardList")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_buffIcon = self:getChild("buffIcon")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
