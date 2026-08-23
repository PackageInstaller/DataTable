local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5sp297dc"

function var_0_0:__ctor()
	self.m_isGetController = self:getController("isGet")
	self.m_awardList = self:getChild("awardList")
	self.m_getAwardBtn = self:getChild("getAwardBtn")
	self.m_taskNameText = self:getChild("taskNameText")
	self.m_taskNumText = self:getChild("taskNumText")
end

return var_0_0
