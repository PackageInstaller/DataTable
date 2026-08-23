local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9694h"

function var_0_0:__ctor()
	self.m_inRankController = self:getController("inRank")
	self.m_emptyController = self:getController("empty")
	self.m_List_rank = self:getChild("List_rank")
	self.m_Comp_rank = self:getChild("Comp_rank")
	self.m_Icon_rank = self:getChild("Icon_rank")
	self.m_Txt_commandValue = self:getChild("Txt_commandValue")
	self.m_Txt_score = self:getChild("Txt_score")
	self.m_Txt_Name = self:getChild("Txt_Name")
	self.m_mineGroup = self:getChild("mineGroup")
end

var_0_0.InRankCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.EmptyCtrl = {
	page1 = 0,
	page0 = 1
}

return var_0_0
