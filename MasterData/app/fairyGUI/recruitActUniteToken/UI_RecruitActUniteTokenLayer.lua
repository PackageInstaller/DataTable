local var_0_0 = {}

var_0_0.URL = "ui://c84aee4vkhhl24"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_recruitTwentyBtn = self:getChild("recruitTwentyBtn")
	self.m_uniteTokenIcon1 = self:getChild("uniteTokenIcon1")
	self.m_uniteTokenBtn1 = self:getChild("uniteTokenBtn1")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_rightTipLoader = self:getChild("rightTipLoader")
	self.m_luckBtn = self:getChild("luckBtn")
	self.m_luckText = self:getChild("luckText")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_rightArrow = self:getChild("rightArrow")
	self.m_gainTipText = self:getChild("gainTipText")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
