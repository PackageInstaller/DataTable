local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mtk7x3"

function var_0_0:__ctor()
	self.m_isShowBadgeCompController = self:getController("isShowBadgeComp")
	self.m_bgComp = self:getChild("bgComp")
	self.m_rankComp = self:getChild("rankComp")
	self.m_actionBtn = self:getChild("actionBtn")
	self.m_seasonRankBtn = self:getChild("seasonRankBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_showComp1 = self:getChild("showComp1")
	self.m_showComp2 = self:getChild("showComp2")
	self.m_showComp3 = self:getChild("showComp3")
	self.m_badgeComp = self:getChild("badgeComp")
	self.m_shareComp = self:getChild("shareComp")
	self.m_titleComp = self:getChild("titleComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsShowBadgeCompCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
