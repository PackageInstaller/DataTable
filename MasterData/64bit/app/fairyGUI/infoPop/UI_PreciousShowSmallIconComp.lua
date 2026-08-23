local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bngn1tlgichj"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_icon = self:getChild("icon")
	self.m_nameText = self:getChild("nameText")
end

var_0_0.IsActiveCtrl = {
	normal = 0,
	active = 1
}

return var_0_0
