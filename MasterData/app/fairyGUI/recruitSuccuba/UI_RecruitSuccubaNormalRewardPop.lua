local var_0_0 = {}

var_0_0.URL = "ui://0vs2yqm8v6xl9"

function var_0_0:__ctor()
	self.m_numController = self:getController("num")
	self.m_effHolder = self:getChild("effHolder")
	self.m_reward = self:getChild("reward")
	self.m_reward1 = self:getChild("reward1")
	self.m_reward2 = self:getChild("reward2")
	self.m_reward3 = self:getChild("reward3")
	self.m_reward4 = self:getChild("reward4")
	self.m_reward5 = self:getChild("reward5")
	self.m_reward6 = self:getChild("reward6")
	self.m_reward7 = self:getChild("reward7")
	self.m_reward8 = self:getChild("reward8")
	self.m_reward9 = self:getChild("reward9")
	self.m_reward10 = self:getChild("reward10")
	self.m_costIcon = self:getChild("costIcon")
	self.m_costNumText = self:getChild("costNumText")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_continueBtn = self:getChild("continueBtn")
	self.m_rewardTxt = self:getChild("rewardTxt")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
