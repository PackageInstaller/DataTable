local var_0_0 = {}

var_0_0.URL = "ui://e2ymx4waxfgb15"

function var_0_0:__ctor()
	self.m_isOpenController = self:getController("isOpen")
	self.m_effLoop = self:getChild("effLoop")
	self.m_effEnter = self:getChild("effEnter")
	self.m_boxLoader = self:getChild("boxLoader")
	self.m_eff = self:getChild("eff")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_numTxt = self:getChild("numTxt")
	self.m_awardGroup = self:getChild("awardGroup")
	self.m_enterTransition = self:getTransition("enter")
	self.m_rewardTransition = self:getTransition("reward")
end

return var_0_0
