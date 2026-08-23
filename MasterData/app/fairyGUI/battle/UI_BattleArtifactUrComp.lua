local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2kue3bd"

function var_0_0:__ctor()
	self.m_sideTypeController = self:getController("sideType")
	self.m_effNode = self:getChild("effNode")
end

var_0_0.SideTypeCtrl = {
	left = 0,
	right = 1
}

return var_0_0
