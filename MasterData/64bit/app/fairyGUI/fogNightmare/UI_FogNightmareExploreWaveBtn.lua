local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oqxburrmj"

function var_0_0:__ctor()
	self.m_isCompleteController = self:getController("isComplete")
	self.m_tipText = self:getChild("tipText")
end

var_0_0.IsCompleteCtrl = {
	normal = 0,
	complete = 1
}

return var_0_0
