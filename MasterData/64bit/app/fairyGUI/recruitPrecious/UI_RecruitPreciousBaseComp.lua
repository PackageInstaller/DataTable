local var_0_0 = {}

var_0_0.URL = "ui://hw835jy1s4k4b"

function var_0_0:__ctor()
	self.m_isURController = self:getController("isUR")
	self.m_nameBg = self:getChild("nameBg")
	self.m_nameTxt = self:getChild("nameTxt")
end

return var_0_0
