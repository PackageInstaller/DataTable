local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfo8km1k"

function var_0_0:__ctor()
	self.m_selectTypeController = self:getController("selectType")
	self.m_popPanel = self:getChild("popPanel")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_guildCheckBtn = self:getChild("guildCheckBtn")
	self.m_curServerCheckBtn = self:getChild("curServerCheckBtn")
	self.m_crossServerCheckBtn = self:getChild("crossServerCheckBtn")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_ensureBtn = self:getChild("ensureBtn")
	self.m_tipsText = self:getChild("tipsText")
	self.m_content = self:getChild("content")
end

return var_0_0
