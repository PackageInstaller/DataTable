local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnv90elgiche"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_tabList = self:getChild("tabList")
	self.m_skillList = self:getChild("skillList")
	self.m_filterBtn = self:getChild("filterBtn")
	self.m_content = self:getChild("content")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
