local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mjwtub"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_enemyList = self:getChild("enemyList")
	self.m_buildComp = self:getChild("buildComp")
	self.m_desc1Txt = self:getChild("desc1Txt")
	self.m_value1Txt = self:getChild("value1Txt")
	self.m_desc1 = self:getChild("desc1")
	self.m_desc2Txt = self:getChild("desc2Txt")
	self.m_value2Txt = self:getChild("value2Txt")
	self.m_desc2 = self:getChild("desc2")
	self.m_playNumText = self:getChild("playNumText")
	self.m_addBtn = self:getChild("addBtn")
	self.m_enter_0Transition = self:getTransition("enter_0")
	self.m_enter_1Transition = self:getTransition("enter_1")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
