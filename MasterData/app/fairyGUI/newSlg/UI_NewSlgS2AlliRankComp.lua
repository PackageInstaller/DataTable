local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9693i"

function var_0_0:__ctor()
	self.m_inRankController = self:getController("inRank")
	self.m_emptyController = self:getController("empty")
	self.m_List_rank = self:getChild("List_rank")
	self.m_Comp_self = self:getChild("Comp_self")
	self.m_mineGroup = self:getChild("mineGroup")
end

var_0_0.InRankCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}
var_0_0.EmptyCtrl = {
	page0 = 1,
	page1 = 0
}

return var_0_0
