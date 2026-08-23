local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mhetdm6r"

function var_0_0:__ctor()
	self.m_showBadgeCountController = self:getController("showBadgeCount")
	self.m_badgeComp1 = self:getChild("badgeComp1")
	self.m_badgeComp2 = self:getChild("badgeComp2")
	self.m_badgeComp3 = self:getChild("badgeComp3")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ShowBadgeCountCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
