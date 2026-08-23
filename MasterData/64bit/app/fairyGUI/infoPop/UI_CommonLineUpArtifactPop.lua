local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnbh0lgic3c"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_tabList = self:getChild("tabList")
	self.m_topTabList = self:getChild("topTabList")
	self.m_artifactList = self:getChild("artifactList")
	self.m_filterBtn = self:getChild("filterBtn")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsEmptyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
