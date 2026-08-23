local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gwzpi3k"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_isConditionActiveController = self:getController("isConditionActive")
	self.m_qualityName = self:getChild("qualityName")
	self.m_activeStr = self:getChild("activeStr")
	self.m_baseStr = self:getChild("baseStr")
	self.m_extraStr = self:getChild("extraStr")
	self.m_conditionStr = self:getChild("conditionStr")
	self.m_stageList = self:getChild("stageList")
end

return var_0_0
