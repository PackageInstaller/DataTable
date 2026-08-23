local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9694g"

function var_0_0:__ctor()
	self.m_bigTabController = self:getController("bigTab")
	self.m_inRankController = self:getController("inRank")
	self.m_typeController = self:getController("type")
	self.m_ComBtnTab1 = self:getChild("ComBtnTab1")
	self.m_ComBtnTab2 = self:getChild("ComBtnTab2")
	self.m_ComTabPopCell1 = self:getChild("ComTabPopCell1")
	self.m_ComTabPopCell2 = self:getChild("ComTabPopCell2")
	self.m_List_reward = self:getChild("List_reward")
	self.m_Comp_self = self:getChild("Comp_self")
end

var_0_0.BigTabCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.InRankCtrl = {
	page0 = 1,
	page1 = 0
}
var_0_0.TypeCtrl = {
	page2 = 2,
	page5 = 5,
	page1 = 0,
	page4 = 4,
	page0 = 1,
	page3 = 3
}

return var_0_0
