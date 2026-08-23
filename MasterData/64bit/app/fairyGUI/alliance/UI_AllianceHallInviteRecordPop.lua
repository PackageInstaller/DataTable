local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcrv0q9"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_searchInput = self:getChild("searchInput")
	self.m_searchBtn = self:getChild("searchBtn")
	self.m_guildList = self:getChild("guildList")
end

return var_0_0
