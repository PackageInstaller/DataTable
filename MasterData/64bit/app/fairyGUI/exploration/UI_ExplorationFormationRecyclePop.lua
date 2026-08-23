local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25btyd47"

function var_0_0:__ctor()
	self.m_tabSelController = self:getController("tabSel")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_valueComp = self:getChild("valueComp")
	self.m_ownComp = self:getChild("ownComp")
	self.m_recycleBtn = self:getChild("recycleBtn")
	self.m_sellList = self:getChild("sellList")
	self.m_selectAllBtn = self:getChild("selectAllBtn")
	self.m_emptyLabel = self:getChild("emptyLabel")
	self.m_content = self:getChild("content")
end

var_0_0.TabSelCtrl = {
	page1 = 1,
	page0 = 0,
	page3 = 3,
	page2 = 2
}
var_0_0.IsEmptyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
