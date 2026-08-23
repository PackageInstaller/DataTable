local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9694f"

function var_0_0:__ctor()
	self.m_bigTabController = self:getController("bigTab")
	self.m_emptyController = self:getController("empty")
	self.m_knight_ph = self:getChild("knight_ph")
	self.m_Comp_first = self:getChild("Comp_first")
	self.m_ComTabPopCell1 = self:getChild("ComTabPopCell1")
	self.m_ComTabPopCell2 = self:getChild("ComTabPopCell2")
	self.m_Comp_top = self:getChild("Comp_top")
	self.m_ComTopBar = self:getChild("ComTopBar")
	self.m_Btn_preview = self:getChild("Btn_preview")
	self.m_Comp_userRank = self:getChild("Comp_userRank")
	self.m_Comp_alliRank = self:getChild("Comp_alliRank")
end

var_0_0.BigTabCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
