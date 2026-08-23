local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25nbgf86"

function var_0_0:__ctor()
	self.m_isSelectController = self:getController("isSelect")
	self.m_buttonController = self:getController("button")
	self.m_headIcon = self:getChild("headIcon")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_touchArea = self:getChild("touchArea")
end

var_0_0.IsSelectCtrl = {
	down = 3,
	up = 2
}
var_0_0.ButtonCtrl = {
	down = 3,
	up = 2
}

return var_0_0
