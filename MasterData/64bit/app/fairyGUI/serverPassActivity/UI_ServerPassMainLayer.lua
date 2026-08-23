local var_0_0 = {}

var_0_0.URL = "ui://dy04zo9niea8u"

function var_0_0:__ctor()
	self.m_bgEffectComp = self:getChild("bgEffectComp")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_buyBtn = self:getChild("buyBtn")
	self.m_btnEffectComp = self:getChild("btnEffectComp")
	self.m_awardList = self:getChild("awardList")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
