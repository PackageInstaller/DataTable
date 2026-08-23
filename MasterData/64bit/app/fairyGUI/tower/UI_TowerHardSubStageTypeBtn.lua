local var_0_0 = {}

var_0_0.URL = "ui://foyq921sjum88i"

function var_0_0:__ctor()
	self.m_isOpenController = self:getController("isOpen")
	self.m_groupController = self:getController("group")
	self.m_difficultyController = self:getController("difficulty")
	self.m_hard = self:getChild("hard")
	self.m_hardKazari = self:getChild("hardKazari")
	self.m_effTitle = self:getChild("effTitle")
	self.m_effectNode = self:getChild("effectNode")
	self.m_towerOrder = self:getChild("towerOrder")
	self.m_towerName = self:getChild("towerName")
	self.m_touchComp = self:getChild("touchComp")
	self.m_towerOpenTime = self:getChild("towerOpenTime")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsOpenCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.GroupCtrl = {
	page3 = 3,
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.DifficultyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
