local var_0_0 = {}

var_0_0.URL = "ui://l1121lywokeaf"

function var_0_0:__ctor()
	self.m_popPanel = self:getChild("popPanel")
	self.m_buyScoreBtn = self:getChild("buyScoreBtn")
	self.m_resComp = self:getChild("resComp")
	self.m_chooseNumComp = self:getChild("chooseNumComp")
	self.m_scoreItemName = self:getChild("scoreItemName")
	self.m_curScoreTxt = self:getChild("curScoreTxt")
	self.m_targetScoreTxt = self:getChild("targetScoreTxt")
	self.m_scoreDescTxt = self:getChild("scoreDescTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_content = self:getChild("content")
end

return var_0_0
