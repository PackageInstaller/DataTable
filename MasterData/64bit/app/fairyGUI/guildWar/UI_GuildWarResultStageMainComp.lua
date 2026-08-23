local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mtk7x2"

function var_0_0:__ctor()
	self.m_isShowBadgeCompController = self:getController("isShowBadgeComp")
	self.m_bgComp = self:getChild("bgComp")
	self.m_titleComp = self:getChild("titleComp")
	self.m_rankComp = self:getChild("rankComp")
	self.m_fightIndexText = self:getChild("fightIndexText")
	self.m_showGuild1 = self:getChild("showGuild1")
	self.m_showGuild2 = self:getChild("showGuild2")
	self.m_showGuild3 = self:getChild("showGuild3")
	self.m_badgeComp = self:getChild("badgeComp")
	self.m_fightRankBtn = self:getChild("fightRankBtn")
	self.m_seasonRankBtn = self:getChild("seasonRankBtn")
	self.m_actionBtn = self:getChild("actionBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_chatComp = self:getChild("chatComp")
	self.m_shareComp = self:getChild("shareComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsShowBadgeCompCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
