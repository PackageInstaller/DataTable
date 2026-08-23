local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepme2s2h"

function var_0_0:__ctor()
	self.m_hideTitleController = self:getController("hideTitle")
	self.m_eff = self:getChild("eff")
	self.m_equipIcon = self:getChild("equipIcon")
	self.m_equipName = self:getChild("equipName")
	self.m_numTxt = self:getChild("numTxt")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HideTitleCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
