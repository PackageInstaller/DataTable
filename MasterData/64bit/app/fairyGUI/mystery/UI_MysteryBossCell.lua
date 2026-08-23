local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8eivux36"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_timeShowController = self:getController("timeShow")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_bossNameTxt = self:getChild("bossNameTxt")
	self.m_unlockTxt = self:getChild("unlockTxt")
	self.m_battleTxt = self:getChild("battleTxt")
	self.m_rebornTxt = self:getChild("rebornTxt")
	self.m_canBattleTxt = self:getChild("canBattleTxt")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
