local var_0_0 = {}

var_0_0.URL = "ui://kdymz22pd17pk"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isBigRewardController = self:getController("isBigReward")
	self.m_rewardIcon = self:getChild("rewardIcon")
	self.m_iconIdle1 = self:getChild("iconIdle1")
	self.m_iconIdle2 = self:getChild("iconIdle2")
	self.m_iconIdle3 = self:getChild("iconIdle3")
	self.m_iconEnter1 = self:getChild("iconEnter1")
	self.m_iconEnter3 = self:getChild("iconEnter3")
	self.m_iconEnter2 = self:getChild("iconEnter2")
	self.m_ssrIdle = self:getChild("ssrIdle")
	self.m_ssrAward = self:getChild("ssrAward")
	self.m_srAward = self:getChild("srAward")
	self.m_numText = self:getChild("numText")
	self.m_idle1Transition = self:getTransition("idle1")
	self.m_ssrAward_2Transition = self:getTransition("ssrAward")
	self.m_idle2Transition = self:getTransition("idle2")
	self.m_srAward_2Transition = self:getTransition("srAward")
end

return var_0_0
