local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfxblad"

function var_0_0:__ctor()
	self.m_showKillController = self:getController("showKill")
	self.m_monsterIconComp = self:getChild("monsterIconComp")
	self.m_effCard = self:getChild("effCard")
	self.m_shareRwdIcon1 = self:getChild("shareRwdIcon1")
	self.m_shareRwdIcon2 = self:getChild("shareRwdIcon2")
	self.m_killRwdIcon1 = self:getChild("killRwdIcon1")
	self.m_killRwdIcon2 = self:getChild("killRwdIcon2")
	self.m_starComp = self:getChild("starComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_challengeBtn = self:getChild("challengeBtn")
	self.m_challengeTipText = self:getChild("challengeTipText")
	self.m_shareBtn = self:getChild("shareBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switchTransition = self:getTransition("switch")
end

return var_0_0
