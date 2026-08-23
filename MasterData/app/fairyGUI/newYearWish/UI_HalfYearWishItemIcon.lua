local var_0_0 = {}

var_0_0.URL = "ui://vpe6pr94nnig5v"

function var_0_0:__ctor()
	self.m_qulityController = self:getController("qulity")
	self.m_isGetAwardController = self:getController("isGetAward")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_numberText = self:getChild("numberText")
end

return var_0_0
