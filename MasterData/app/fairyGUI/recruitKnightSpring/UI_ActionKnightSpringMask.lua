local var_0_0 = {}

var_0_0.URL = "ui://16fa1nlapo2z5m"

function var_0_0:__ctor()
	self.m_centerPosController = self:getController("centerPos")
	self.m_isBlackController = self:getController("isBlack")
	self.m_center = self:getChild("center")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.CenterPosCtrl = {
	pos3 = 2,
	pos1 = 0,
	pos7 = 3,
	pos2 = 1,
	pos5 = 5,
	pos6 = 6,
	pos4 = 4,
	pos8 = 7
}
var_0_0.IsBlackCtrl = {
	black = 1,
	normal = 0
}

return var_0_0
