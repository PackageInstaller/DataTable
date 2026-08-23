local var_0_0 = {}

var_0_0.URL = "ui://pbd24silwcih19"

function var_0_0:__ctor()
	self.m_isGetController = self:getController("isGet")
	self.m_isDailyController = self:getController("isDaily")
	self.m_awardList = self:getChild("awardList")
	self.m_getAwardBtn = self:getChild("getAwardBtn")
	self.m_taskNameText = self:getChild("taskNameText")
	self.m_curNumTxt = self:getChild("curNumTxt")
	self.m_targetNumTxt = self:getChild("targetNumTxt")
end

return var_0_0
