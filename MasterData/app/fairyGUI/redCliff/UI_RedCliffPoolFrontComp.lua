local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2smu7uc"

function var_0_0:__ctor()
	self.m_poolTypeController = self:getController("poolType")
	self.m_upgradeStateController = self:getController("upgradeState")
	self.m_poolStateController = self:getController("poolState")
	self.m_poolIcon = self:getChild("poolIcon")
	self.m_poolName = self:getChild("poolName")
	self.m_poolTip = self:getChild("poolTip")
	self.m_tipGroup = self:getChild("tipGroup")
	self.m_rank = self:getChild("rank")
	self.m_score = self:getChild("score")
	self.m_myInfoGroup = self:getChild("myInfoGroup")
	self.m_startTimeTxt = self:getChild("startTimeTxt")
	self.m_matchUserBtn = self:getChild("matchUserBtn")
	self.m_upgradeBtn = self:getChild("upgradeBtn")
	self.m_closeTransition = self:getTransition("close")
	self.m_enterTransition = self:getTransition("enter")
	self.m_openTransition = self:getTransition("open")
end

return var_0_0
