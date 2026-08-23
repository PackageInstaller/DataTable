local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2oe6dd5"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_skillComp1 = self:getChild("skillComp1")
	self.m_skillComp2 = self:getChild("skillComp2")
	self.m_skillComp3 = self:getChild("skillComp3")
	self.m_valueTxt = self:getChild("valueTxt")
	self.m_eff = self:getChild("eff")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
