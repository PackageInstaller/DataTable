local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcrv0q7"

function var_0_0:__ctor()
	self.m_isOnlyController = self:getController("isOnly")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_guildList = self:getChild("guildList")
	self.m_searchInput = self:getChild("searchInput")
	self.m_searchBtn = self:getChild("searchBtn")
	self.m_refreshBtn = self:getChild("refreshBtn")
	self.m_recruitBtn = self:getChild("recruitBtn")
	self.m_clearBtn = self:getChild("clearBtn")
	self.m_content = self:getChild("content")
end

var_0_0.IsOnlyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
