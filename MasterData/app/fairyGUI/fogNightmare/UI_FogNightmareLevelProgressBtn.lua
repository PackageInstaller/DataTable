local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oi4udfj"

function var_0_0:__ctor()
	self.m_buttonController = self:getController("button")
	self.m_levelText = self:getChild("levelText")
	self.m_effectNode = self:getChild("effectNode")
end

var_0_0.ButtonCtrl = {
	down = 3,
	up = 2
}

return var_0_0
