local var_0_0 = {}

var_0_0.URL = "ui://whf5j5b58llx1h"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_tipText = self:getChild("tipText")
	self.m_userList = self:getChild("userList")
	self.m_awardList = self:getChild("awardList")
	self.m_rankText = self:getChild("rankText")
	self.m_damageText = self:getChild("damageText")
	self.m_topBar = self:getChild("topBar")
end

return var_0_0
