local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8e6vvb2a"

function var_0_0:__ctor()
	self.m_taskTypeController = self:getController("taskType")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_taskTitleTxt = self:getChild("taskTitleTxt")
	self.m_taskDescTxt = self:getChild("taskDescTxt")
	self.m_locationBtn = self:getChild("locationBtn")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
