local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ob7vurroo"

function var_0_0:__ctor()
	self.m_buttonController = self:getController("button")
	self.m_icon = self:getChild("icon")
	self.m_title = self:getChild("title")
end

var_0_0.ButtonCtrl = {
	down = 1,
	up = 0
}

return var_0_0
