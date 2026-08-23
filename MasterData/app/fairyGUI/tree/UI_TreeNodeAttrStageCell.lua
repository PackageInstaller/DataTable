local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gwzpi3l"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_isConditionActiveController = self:getController("isConditionActive")
	self.m_stageName = self:getChild("stageName")
	self.m_baseStr = self:getChild("baseStr")
	self.m_extraStr = self:getChild("extraStr")
	self.m_conditionStr = self:getChild("conditionStr")
	self.m_activeStr = self:getChild("activeStr")
end

return var_0_0
