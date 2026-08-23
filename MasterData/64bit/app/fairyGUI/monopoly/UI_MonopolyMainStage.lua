local var_0_0 = {}

var_0_0.URL = "ui://6b52cxc1oky96z"

function var_0_0:__ctor()
	self.m_isShowFiftyController = self:getController("isShowFifty")
	self.m_mapComp = self:getChild("mapComp")
	self.m_titleBg = self:getChild("titleBg")
	self.m_titleTextIcon = self:getChild("titleTextIcon")
	self.m_timeDiGraph = self:getChild("timeDiGraph")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_topBar = self:getChild("topBar")
	self.m_diceBtn = self:getChild("diceBtn")
	self.m_diceTenBtn = self:getChild("diceTenBtn")
	self.m_diceFiftyBtn = self:getChild("diceFiftyBtn")
	self.m_selDiceNumBtn = self:getChild("selDiceNumBtn")
	self.m_nextPointTxt = self:getChild("nextPointTxt")
	self.m_pointRewardComp = self:getChild("pointRewardComp")
	self.m_giftBtn = self:getChild("giftBtn")
	self.m_clickIgnoreMask = self:getChild("clickIgnoreMask")
	self.m_iconEffHolder = self:getChild("iconEffHolder")
	self.m_progressComp = self:getChild("progressComp")
	self.m_skipBtn = self:getChild("skipBtn")
	self.m_diceShowHolder = self:getChild("diceShowHolder")
	self.m_tipsComp = self:getChild("tipsComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_refreshTipTransition = self:getTransition("refreshTip")
	self.m_hideTransition = self:getTransition("hide")
end

return var_0_0
