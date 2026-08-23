local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9sej772"

function var_0_0:__ctor()
	self.m_inRankController = self:getController("inRank")
	self.m_showComBoxController = self:getController("showComBox")
	self.m_emptyController = self:getController("empty")
	self.m_List_rank = self:getChild("List_rank")
	self.m_Txt_commandValue = self:getChild("Txt_commandValue")
	self.m_Txt_score = self:getChild("Txt_score")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_Btn_look = self:getChild("Btn_look")
end

var_0_0.InRankCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowComBoxCtrl = {
	page0 = 1,
	page1 = 0
}
var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
