local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9ci966f"

function var_0_0:__ctor()
	self.m_inRankController = self:getController("inRank")
	self.m_showComBoxController = self:getController("showComBox")
	self.m_emptyController = self:getController("empty")
	self.m_tipTypeController = self:getController("tipType")
	self.m_rankList = self:getChild("rankList")
	self.m_chooseCompHideTouch = self:getChild("chooseCompHideTouch")
	self.m_chooseComp = self:getChild("chooseComp")
end

var_0_0.InRankCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.ShowComBoxCtrl = {
	page0 = 1,
	page1 = 0
}
var_0_0.EmptyCtrl = {
	page0 = 1,
	page1 = 0
}
var_0_0.TipTypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
