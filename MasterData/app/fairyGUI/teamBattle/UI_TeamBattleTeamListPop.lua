local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8ltoz97d"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_teamList = self:getChild("teamList")
	self.m_nameInput = self:getChild("nameInput")
	self.m_searchBtn = self:getChild("searchBtn")
	self.m_refreshBtn = self:getChild("refreshBtn")
end

var_0_0.IsEmptyCtrl = {
	empty = 1,
	normal = 0
}

return var_0_0
