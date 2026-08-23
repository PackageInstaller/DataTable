local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lltjv67"

function var_0_0:__ctor()
	self.m_isTimeMatchController = self:getController("isTimeMatch")
	self.m_isReadyController = self:getController("isReady")
	self.m_playerBgComp1 = self:getChild("playerBgComp1")
	self.m_playerBgComp2 = self:getChild("playerBgComp2")
	self.m_playerBgComp3 = self:getChild("playerBgComp3")
	self.m_teamNameTxt = self:getChild("teamNameTxt")
	self.m_condTxt = self:getChild("condTxt")
	self.m_checkOpenBtn = self:getChild("checkOpenBtn")
	self.m_chatComp = self:getChild("chatComp")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_exitBtn = self:getChild("exitBtn")
	self.m_inviteBtn = self:getChild("inviteBtn")
	self.m_formationBtn = self:getChild("formationBtn")
	self.m_startBtn = self:getChild("startBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsTimeMatchCtrl = {
	match = 1,
	["not match"] = 0
}
var_0_0.IsReadyCtrl = {
	ready = 1,
	normal = 0
}

return var_0_0
