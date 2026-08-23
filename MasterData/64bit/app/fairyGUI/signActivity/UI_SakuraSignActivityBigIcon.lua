local var_0_0 = {}

var_0_0.URL = "ui://9j4hqll0yxd1a2h"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_dayIcon = self:getChild("dayIcon")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_itemNameTxt = self:getChild("itemNameTxt")
	self.m_numTxt = self:getChild("numTxt")
	self.m_effBig = self:getChild("effBig")
	self.m_enterTransition = self:getTransition("enter")
	self.m_getTransition = self:getTransition("get")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
