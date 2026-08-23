local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2l7jr2e"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_is_emptyController = self:getController("is_empty")
	self.m_List_reward = self:getChild("List_reward")
	self.m_Comp_empty = self:getChild("Comp_empty")
	self.m_List_rank = self:getChild("List_rank")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_teamScoreTxt = self:getChild("teamScoreTxt")
	self.m_selfScoreTxt = self:getChild("selfScoreTxt")
	self.m_topBarComp = self:getChild("topBarComp")
end

var_0_0.TabCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
