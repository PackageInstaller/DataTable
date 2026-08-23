local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074btdpo"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_typeController = self:getController("type")
	self.m_seasonController = self:getController("season")
	self.m_rankList = self:getChild("rankList")
end

var_0_0.EmptyCtrl = {
	page1 = 0,
	page0 = 1
}
var_0_0.TypeCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.SeasonCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
