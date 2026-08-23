local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcrv0q7"

function var_0_0:__ctor()
	self.m_isInvitedOnlyController = self:getController("isInvitedOnly")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_guildList = self:getChild("guildList")
	self.m_searchInput = self:getChild("searchInput")
	self.m_searchBtn = self:getChild("searchBtn")
	self.m_refreshBtn = self:getChild("refreshBtn")
	self.m_clearBtn = self:getChild("clearBtn")
end

return var_0_0
