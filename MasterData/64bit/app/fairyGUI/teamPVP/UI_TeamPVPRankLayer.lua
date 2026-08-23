local var_0_0 = {}

var_0_0.URL = "ui://akds0szalevb2k"

function var_0_0:__ctor()
	self.m_tabSelController = self:getController("tabSel")
	self.m_typeSelController = self:getController("typeSel")
	self.m_rankList = self:getChild("rankList")
	self.m_rankRewardList = self:getChild("rankRewardList")
	self.m_honorRewardList = self:getChild("honorRewardList")
	self.m_myRank = self:getChild("myRank")
	self.m_honorNum = self:getChild("honorNum")
	self.m_honorTip = self:getChild("honorTip")
	self.m_crossTip = self:getChild("crossTip")
	self.m_myTitle = self:getChild("myTitle")
	self.m_topBarComp = self:getChild("topBarComp")
end

return var_0_0
