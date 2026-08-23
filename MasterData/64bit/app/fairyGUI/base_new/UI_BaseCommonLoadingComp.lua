local var_0_0 = {}

var_0_0.URL = "ui://kvb3znep9ifywkk32r"

function var_0_0:__ctor()
	self.m_isNightController = self:getController("isNight")
	self.m_bgImg = self:getChild("bgImg")
	self.m_iconImg = self:getChild("iconImg")
	self.m_title = self:getChild("title")
	self.m_descText = self:getChild("descText")
	self.m_effComp = self:getChild("effComp")
	self.m_loadingText = self:getChild("loadingText")
	self.m_loadingTextCN = self:getChild("loadingTextCN")
	self.m_enter_0Transition = self:getTransition("enter_0")
	self.m_enter_1Transition = self:getTransition("enter_1")
end

var_0_0.IsNightCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
