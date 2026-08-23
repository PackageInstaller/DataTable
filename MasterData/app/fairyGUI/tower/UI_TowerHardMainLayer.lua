local var_0_0 = {}

var_0_0.URL = "ui://foyq921swhq586"

function var_0_0:__ctor()
	self.m_difficultyController = self:getController("difficulty")
	self.m_bgNode = self:getChild("bgNode")
	self.m_titleComp = self:getChild("titleComp")
	self.m_stageBtn2 = self:getChild("stageBtn2")
	self.m_stageBtn3 = self:getChild("stageBtn3")
	self.m_stageBtn5 = self:getChild("stageBtn5")
	self.m_stageBtn4 = self:getChild("stageBtn4")
	self.m_CollectionPlatfpomBtn = self:getChild("CollectionPlatfpomBtn")
	self.m_stageBtnMain = self:getChild("stageBtnMain")
	self.m_progressBtn = self:getChild("progressBtn")
	self.m_mainEffNode = self:getChild("mainEffNode")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_rankRewardBtn = self:getChild("rankRewardBtn")
	self.m_activityBtn = self:getChild("activityBtn")
	self.m_touchBg = self:getChild("touchBg")
	self.m_challageComp = self:getChild("challageComp")
	self.m_topBar = self:getChild("topBar")
	self.m_chatComp = self:getChild("chatComp")
	self.m_effLizi = self:getChild("effLizi")
	self.m_enterTransition = self:getTransition("enter")
	self.m_uiHideTransition = self:getTransition("uiHide")
	self.m_uiShowTransition = self:getTransition("uiShow")
	self.m_mainEffTransition = self:getTransition("mainEff")
end

var_0_0.DifficultyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
