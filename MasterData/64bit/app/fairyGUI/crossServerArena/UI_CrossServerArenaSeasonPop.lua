local var_0_0 = {}

var_0_0.URL = "ui://n47h6oaghuisa"

function var_0_0:__ctor()
	self.m_seasonStatusController = self:getController("seasonStatus")
	self.m_hasRankController = self:getController("hasRank")
	self.m_blankSpace = self:getChild("blankSpace")
	self.m_seasonRankTxt = self:getChild("seasonRankTxt")
	self.m_rankGroup = self:getChild("rankGroup")
	self.m_effect = self:getChild("effect")
	self.m_seasonTimeTxt = self:getChild("seasonTimeTxt")
	self.m_seasonGroup = self:getChild("seasonGroup")
	self.m_seasonNumTxt = self:getChild("seasonNumTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_closeTransition = self:getTransition("close")
end

var_0_0.SeasonStatusCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasRankCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
