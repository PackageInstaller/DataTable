local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiqt2weo"

function var_0_0:__ctor()
	self.m_selTabController = self:getController("selTab")
	self.m_popPanel = self:getChild("popPanel")
	self.m_bg = self:getChild("bg")
	self.m_titleText = self:getChild("titleText")
	self.m_tabList = self:getChild("tabList")
	self.m_taskList = self:getChild("taskList")
	self.m_oneKeyBtn = self:getChild("oneKeyBtn")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_content = self:getChild("content")
end

return var_0_0
