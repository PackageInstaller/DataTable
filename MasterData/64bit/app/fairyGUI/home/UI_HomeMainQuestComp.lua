local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgq5115ibow"

function var_0_0:__ctor()
	self.m_taskStateController = self:getController("taskState")
	self.m_taskText = self:getChild("taskText")
	self.m_awardIcon = self:getChild("awardIcon")
	self.m_finishEffSpine = self:getChild("finishEffSpine")
end

var_0_0.TaskStateCtrl = {
	page0 = 0,
	page3 = 3,
	page2 = 2,
	page1 = 1
}

return var_0_0
