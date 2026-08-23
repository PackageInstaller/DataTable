local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnklzqgic2k"

function var_0_0:__ctor()
	self.m_buttonController = self:getController("button")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_icon = self:getChild("icon")
end

var_0_0.ButtonCtrl = {
	down = 1,
	up = 0
}

return var_0_0
