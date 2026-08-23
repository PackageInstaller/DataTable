local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm36"

function var_0_0:__ctor()
	self.m_hasRankRwdController = self:getController("hasRankRwd")
	self.m_iconEffNode = self:getChild("iconEffNode")
	self.m_helpBtn = self:getChild("helpBtn")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_nameEffNode = self:getChild("nameEffNode")
	self.m_tipComp = self:getChild("tipComp")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_rewardList = self:getChild("rewardList")
	self.m_scoreRatioTxt = self:getChild("scoreRatioTxt")
	self.m_buffList = self:getChild("buffList")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HasRankRwdCtrl = {
	has = 1,
	none = 0
}

return var_0_0
