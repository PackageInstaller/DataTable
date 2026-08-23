local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwvksz0"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isAutoController = self:getController("isAuto")
	self.m_mapComp = self:getChild("mapComp")
	self.m_topBar = self:getChild("topBar")
	self.m_stealComp = self:getChild("stealComp")
	self.m_monsterComp = self:getChild("monsterComp")
	self.m_eventList = self:getChild("eventList")
	self.m_selDiceNumBtn = self:getChild("selDiceNumBtn")
	self.m_autoBtn = self:getChild("autoBtn")
	self.m_diceBtn = self:getChild("diceBtn")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_logBtn = self:getChild("logBtn")
	self.m_infoBtn = self:getChild("infoBtn")
	self.m_moduleBtn = self:getChild("moduleBtn")
	self.m_build1 = self:getChild("build1")
	self.m_build2 = self:getChild("build2")
	self.m_build3 = self:getChild("build3")
	self.m_build4 = self:getChild("build4")
	self.m_levelComp = self:getChild("levelComp")
	self.m_clickIgnoreMask = self:getChild("clickIgnoreMask")
	self.m_iconEffHolder = self:getChild("iconEffHolder")
	self.m_title11 = self:getChild("title11")
	self.m_cancelAutoBtn = self:getChild("cancelAutoBtn")
	self.m_tipComp = self:getChild("tipComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_refreshTipTransition = self:getTransition("refreshTip")
end

return var_0_0
