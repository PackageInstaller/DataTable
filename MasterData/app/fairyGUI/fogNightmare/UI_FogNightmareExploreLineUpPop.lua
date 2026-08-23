local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ojop9g2"

function var_0_0:__ctor()
	self.m_showTopTabController = self:getController("showTopTab")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_filterSelController = self:getController("filterSel")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_tipText = self:getChild("tipText")
	self.m_topTabList = self:getChild("topTabList")
	self.m_runnerBanner = self:getChild("runnerBanner")
	self.m_emptyComp = self:getChild("emptyComp")
	self.m_filterBtn = self:getChild("filterBtn")
	self.m_lineList = self:getChild("lineList")
	self.m_content = self:getChild("content")
end

var_0_0.ShowTopTabCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.FilterSelCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
