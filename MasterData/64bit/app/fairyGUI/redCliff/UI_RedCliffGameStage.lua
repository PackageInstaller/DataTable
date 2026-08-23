local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2smu7uf"

function var_0_0:__ctor()
	self.m_cdController = self:getController("cd")
	self.m_mapComp = self:getChild("mapComp")
	self.m_quitBtn = self:getChild("quitBtn")
	self.m_clockComp = self:getChild("clockComp")
	self.m_leftTime = self:getChild("leftTime")
	self.m_damageTxt = self:getChild("damageTxt")
	self.m_rankComp = self:getChild("rankComp")
	self.m_topTip = self:getChild("topTip")
	self.m_fertileTip = self:getChild("fertileTip")
	self.m_recordBoard = self:getChild("recordBoard")
	self.m_battleCheckBtn = self:getChild("battleCheckBtn")
	self.m_matchUserBtn = self:getChild("matchUserBtn")
	self.m_failEffectLoader = self:getChild("failEffectLoader")
	self.m_robGroup = self:getChild("robGroup")
	self.m_enterTransition = self:getTransition("enter")
	self.m_failTransition = self:getTransition("fail")
end

return var_0_0
