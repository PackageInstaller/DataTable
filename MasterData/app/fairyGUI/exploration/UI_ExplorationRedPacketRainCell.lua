local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25xi5376"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_effSmall = self:getChild("effSmall")
	self.m_effBig = self:getChild("effBig")
	self.m_icon = self:getChild("icon")
	self.m_effUpS = self:getChild("effUpS")
	self.m_effUpB = self:getChild("effUpB")
	self.m_effCell = self:getChild("effCell")
	self.m_effReward = self:getChild("effReward")
	self.m_smallTransition = self:getTransition("small")
	self.m_bigTransition = self:getTransition("big")
	self.m_rewardTransition = self:getTransition("reward")
	self.m_normalTransition = self:getTransition("normal")
end

var_0_0.TypeCtrl = {
	page2 = 2,
	page5 = 5,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}

return var_0_0
