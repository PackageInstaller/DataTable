local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2jrr84l"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_is_emptyController = self:getController("is_empty")
	self.m_Txt_tip = self:getChild("Txt_tip")
	self.m_List_team_ranking = self:getChild("List_team_ranking")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.TabCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
