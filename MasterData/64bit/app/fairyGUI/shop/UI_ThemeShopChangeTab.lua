local var_0_0 = {}

var_0_0.URL = "ui://454a48jpu75v1spemie"

function var_0_0:__ctor()
	self.m_isSelectController = self:getController("isSelect")
	self.m_stateController = self:getController("state")
	self.m_unSelectLoader = self:getChild("unSelectLoader")
	self.m_selectLoader = self:getChild("selectLoader")
	self.m_unOpenLoader = self:getChild("unOpenLoader")
end

return var_0_0
