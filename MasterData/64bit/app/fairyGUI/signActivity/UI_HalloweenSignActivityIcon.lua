local var_0_0 = {}

var_0_0.URL = "ui://9j4hqll0sdcba5e"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_qualityLoader_1 = self:getChild("qualityLoader_1")
	self.m_qualityLoader_2 = self:getChild("qualityLoader_2")
	self.m_dayTxt = self:getChild("dayTxt")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_numTxt = self:getChild("numTxt")
	self.m_effReceive = self:getChild("effReceive")
	self.m_enterTransition = self:getTransition("enter")
	self.m_getTransition = self:getTransition("get")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
