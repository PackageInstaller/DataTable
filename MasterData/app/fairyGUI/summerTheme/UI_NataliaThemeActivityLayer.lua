local var_0_0 = {}

var_0_0.URL = "ui://99hn30597x0kmw2y3o"

function var_0_0:__ctor()
	self.m_hideUIController = self:getController("hideUI")
	self.m_movieComp = self:getChild("movieComp")
	self.m_knightComp = self:getChild("knightComp")
	self.m_themeTitleComp = self:getChild("themeTitleComp")
	self.m_pvBtn = self:getChild("pvBtn")
	self.m_previewBgBtn = self:getChild("previewBgBtn")
	self.m_jumpSkinBtn = self:getChild("jumpSkinBtn")
	self.m_jumpShopBtn = self:getChild("jumpShopBtn")
	self.m_jumpChoukaBtn = self:getChild("jumpChoukaBtn")
	self.m_exploreBtn = self:getChild("exploreBtn")
	self.m_themeGameBtn = self:getChild("themeGameBtn")
	self.m_passCardBtn = self:getChild("passCardBtn")
	self.m_bossBattleBtn = self:getChild("bossBattleBtn")
	self.m_themeDungeonBtn = self:getChild("themeDungeonBtn")
	self.m_themeTaskBtn = self:getChild("themeTaskBtn")
	self.m_themeShopBtn = self:getChild("themeShopBtn")
	self.m_themeGiftBtn = self:getChild("themeGiftBtn")
	self.m_bgComp = self:getChild("bgComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_hideUIGroup = self:getChild("hideUIGroup")
	self.m_showUIComp = self:getChild("showUIComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_showTransition = self:getTransition("show")
	self.m_hideTransition = self:getTransition("hide")
	self.m_enter_1Transition = self:getTransition("enter_1")
end

var_0_0.HideUICtrl = {
	显示 = 0,
	隐藏 = 1
}

return var_0_0
