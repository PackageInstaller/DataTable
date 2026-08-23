local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2oe6dd4"

function var_0_0:__ctor()
	self.m_winOwnerController = self:getController("winOwner")
	self.m_winStateController = self:getController("winState")
	self.m_stateController = self:getController("state")
	self.m_ownSpine = self:getChild("ownSpine")
	self.m_enemySpine = self:getChild("enemySpine")
	self.m_mySuccubaLoader = self:getChild("mySuccubaLoader")
	self.m_otherSuccubaLoader = self:getChild("otherSuccubaLoader")
	self.m_effVS = self:getChild("effVS")
	self.m_myValueTxt = self:getChild("myValueTxt")
	self.m_otherValueTxt = self:getChild("otherValueTxt")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.WinOwnerCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.WinStateCtrl = {
	平局 = 0,
	大胜 = 3,
	中胜 = 2,
	小胜 = 1
}
var_0_0.StateCtrl = {
	page2 = 2,
	page3 = 3,
	page1 = 1,
	page0 = 0
}

return var_0_0
