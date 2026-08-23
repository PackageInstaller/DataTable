local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jt0v6f"

function var_0_0:__ctor()
	self.m_inRankController = self:getController("inRank")
	self.m_emptyController = self:getController("empty")
	self.m_typeController = self:getController("type")
	self.m_seasonController = self:getController("season")
	self.m_rankList = self:getChild("rankList")
end

var_0_0.InRankCtrl = {
	page0 = 0,
	page2 = 3,
	page1 = 1
}
var_0_0.EmptyCtrl = {
	page0 = 1,
	page1 = 0
}
var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.SeasonCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
