local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwny82s"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_effSmall = self:getChild("effSmall")
	self.m_effBig = self:getChild("effBig")
	self.m_effUpS = self:getChild("effUpS")
	self.m_effUpB = self:getChild("effUpB")
	self.m_icon = self:getChild("icon")
	self.m_effCell = self:getChild("effCell")
	self.m_effReward = self:getChild("effReward")
	self.m_smallTransition = self:getTransition("small")
	self.m_bigTransition = self:getTransition("big")
	self.m_rewardTransition = self:getTransition("reward")
	self.m_normalTransition = self:getTransition("normal")
end

return var_0_0
