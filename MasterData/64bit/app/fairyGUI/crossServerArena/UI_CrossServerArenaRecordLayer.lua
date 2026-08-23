local var_0_0 = {}

var_0_0.URL = "ui://n47h6oaghuis13"

function var_0_0:__ctor()
	self.m_tabSelController = self:getController("tabSel")
	self.m_emptyController = self:getController("empty")
	self.m_recordList = self:getChild("recordList")
	self.m_topBarComp = self:getChild("topBarComp")
end

var_0_0.TabSelCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.EmptyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
