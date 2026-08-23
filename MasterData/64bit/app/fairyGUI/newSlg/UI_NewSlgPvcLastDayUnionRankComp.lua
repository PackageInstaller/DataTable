local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9sej770"

function var_0_0:__ctor()
	self.m_inRankController = self:getController("inRank")
	self.m_emptyController = self:getController("empty")
	self.m_List_rank = self:getChild("List_rank")
	self.m_Btn_look = self:getChild("Btn_look")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_Txt_score = self:getChild("Txt_score")
end

var_0_0.InRankCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.EmptyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
