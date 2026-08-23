local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88omk80ah"

function var_0_0:__ctor()
	self.m_showStyleController = self:getController("showStyle")
	self.m_canQuickJumpController = self:getController("canQuickJump")
	self.m_effectBgNode = self:getChild("effectBgNode")
	self.m_maskBgDadComp = self:getChild("maskBgDadComp")
	self.m_enterComp = self:getChild("enterComp")
	self.m_timeText = self:getChild("timeText")
	self.m_effectNode = self:getChild("effectNode")
	self.m_levelProgressBtn = self:getChild("levelProgressBtn")
	self.m_talentBtn = self:getChild("talentBtn")
	self.m_idleBtn = self:getChild("idleBtn")
	self.m_startPlayBtn = self:getChild("startPlayBtn")
	self.m_selectComp = self:getChild("selectComp")
	self.m_effectStart = self:getChild("effectStart")
	self.m_assistanceBtn = self:getChild("assistanceBtn")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_buffBtn = self:getChild("buffBtn")
	self.m_fundBtn = self:getChild("fundBtn")
	self.m_playTimesComp = self:getChild("playTimesComp")
	self.m_menuGroup = self:getChild("menuGroup")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_serverListBtn = self:getChild("serverListBtn")
	self.m_profitTime = self:getChild("profitTime")
	self.m_profitInfo = self:getChild("profitInfo")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_enter1Transition = self:getTransition("enter1")
end

var_0_0.ShowStyleCtrl = {
	enter = 1,
	menuToEnter = 2,
	menu = 0
}
var_0_0.CanQuickJumpCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
