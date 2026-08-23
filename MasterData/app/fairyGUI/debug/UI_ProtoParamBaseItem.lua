local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7ynqhj4l"

function var_0_0:__ctor()
	self.m_isBoolController = self:getController("isBool")
	self.m_isRequiredController = self:getController("isRequired")
	self.m_inputValue = self:getChild("inputValue")
end

var_0_0.IsBoolCtrl = {
	bool = 1,
	normal = 0
}
var_0_0.IsRequiredCtrl = {
	required = 1,
	normal = 0
}

return var_0_0
