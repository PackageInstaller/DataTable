local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8efhgqa"

function var_0_0:__ctor()
	self.m_taskStateController = self:getController("taskState")
	self.m_title = self:getChild("title")
	self.m_descTxt = self:getChild("descTxt")
	self.m_progressTxt = self:getChild("progressTxt")
	self.m_rewardList = self:getChild("rewardList")
	self.m_getBtn = self:getChild("getBtn")
	self.m_goBtn = self:getChild("goBtn")
end

return var_0_0
