local var_0_0 = {}

var_0_0.URL = "ui://9n9qtghbvxtc1z"

function var_0_0:__ctor()
	self.m_fightStateController = self:getController("fightState")
	self.m_enemyPageController = self:getController("enemyPage")
	self.m_stateController = self:getController("state")
	self.m_fightState_2 = self:getChild("fightState")
	self.m_enemyNumList = self:getChild("enemyNumList")
	self.m_enemyList = self:getChild("enemyList")
	self.m_fightBtn = self:getChild("fightBtn")
	self.m_recoverTxt = self:getChild("recoverTxt")
	self.m_timeGroup = self:getChild("timeGroup")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_skillComp = self:getChild("skillComp")
	self.m_lockTxt = self:getChild("lockTxt")
end

return var_0_0
