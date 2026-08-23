local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2gwxe5r"

function var_0_0:__ctor()
	self.m_turn_tabController = self:getController("turn_tab")
	self.m_tabController = self:getController("tab")
	self.m_is_emptyController = self:getController("is_empty")
	self.m_time_stateController = self:getController("time_state")
	self.m_popPanel = self:getChild("popPanel")
	self.m_ComTabPopCell1 = self:getChild("ComTabPopCell1")
	self.m_ComTabPopCell2 = self:getChild("ComTabPopCell2")
	self.m_tab_1 = self:getChild("tab_1")
	self.m_tab_2 = self:getChild("tab_2")
	self.m_tab_3 = self:getChild("tab_3")
	self.m_tab_4 = self:getChild("tab_4")
	self.m_List_guess = self:getChild("List_guess")
	self.m_Txt_desc = self:getChild("Txt_desc")
	self.m_Comp_guessAward1 = self:getChild("Comp_guessAward1")
	self.m_Comp_guessAward2 = self:getChild("Comp_guessAward2")
	self.m_Comp_Empty = self:getChild("Comp_Empty")
	self.m_Txt_timeCd = self:getChild("Txt_timeCd")
	self.m_content = self:getChild("content")
end

var_0_0.Turn_tabCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page3 = 3
}
var_0_0.TabCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Time_stateCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page4 = 4
}

return var_0_0
