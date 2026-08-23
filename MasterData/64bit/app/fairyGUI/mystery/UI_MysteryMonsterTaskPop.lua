local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8efhgq3"

function var_0_0:__ctor()
	self.m_selTabController = self:getController("selTab")
	self.m_openHardController = self:getController("openHard")
	self.m_popPanel = self:getChild("popPanel")
	self.m_tabList = self:getChild("tabList")
	self.m_taskList = self:getChild("taskList")
	self.m_content = self:getChild("content")
end

return var_0_0
