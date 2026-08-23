local var_0_0 = {}

var_0_0.URL = "ui://kgq5r794o2kaibnk"

function var_0_0:__ctor()
	self.m_selTabController = self:getController("selTab")
	self.m_openHardController = self:getController("openHard")
	self.m_popPanel = self:getChild("popPanel")
	self.m_list = self:getChild("list")
	self.m_tab1 = self:getChild("tab1")
	self.m_tab2 = self:getChild("tab2")
	self.m_tab3 = self:getChild("tab3")
	self.m_tab4 = self:getChild("tab4")
	self.m_content = self:getChild("content")
end

return var_0_0
