local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074btdph"

function var_0_0:__ctor()
	self.m_inRankController = self:getController("inRank")
	self.m_emptyController = self:getController("empty")
	self.m_tipTypeController = self:getController("tipType")
	self.m_rankList = self:getChild("rankList")
end

var_0_0.InRankCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.EmptyCtrl = {
	page1 = 0,
	page0 = 1
}
var_0_0.TipTypeCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
