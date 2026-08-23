local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm1l"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_towerController = self:getController("tower")
	self.m_showBossController = self:getController("showBoss")
	self.m_buffCountController = self:getController("buffCount")
	self.m_buffType1Controller = self:getController("buffType1")
	self.m_buffType2Controller = self:getController("buffType2")
	self.m_towerIcon = self:getChild("towerIcon")
	self.m_towerLockIcon = self:getChild("towerLockIcon")
	self.m_timeText = self:getChild("timeText")
	self.m_lockGroup = self:getChild("lockGroup")
	self.m_effComp = self:getChild("effComp")
	self.m_towerNameBg = self:getChild("towerNameBg")
	self.m_towerName = self:getChild("towerName")
	self.m_stateBg = self:getChild("stateBg")
	self.m_stateText = self:getChild("stateText")
	self.m_stateGroup = self:getChild("stateGroup")
	self.m_effBossComp = self:getChild("effBossComp")
	self.m_bossGroup = self:getChild("bossGroup")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_buffIcon1 = self:getChild("buffIcon1")
	self.m_buffIcon2 = self:getChild("buffIcon2")
	self.m_unlockTransition = self:getTransition("unlock")
	self.m_bossloopTransition = self:getTransition("bossloop")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}
var_0_0.TowerCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.ShowBossCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.BuffCountCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.BuffType1Ctrl = {
	page2 = 2,
	page5 = 5,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}
var_0_0.BuffType2Ctrl = {
	page2 = 2,
	page5 = 5,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}

return var_0_0
