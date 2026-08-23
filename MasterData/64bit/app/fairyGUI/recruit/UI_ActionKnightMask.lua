local var_0_0 = {}

var_0_0.URL = "ui://nz3msl46rol1gibyo"

function var_0_0:__ctor()
	self.m_centerPosController = self:getController("centerPos")
	self.m_isBlackController = self:getController("isBlack")
	self.m_center = self:getChild("center")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.CenterPosCtrl = {
	pos2 = 1,
	pos1 = 0,
	pos8 = 7,
	pos7 = 6,
	pos6 = 5,
	pos5 = 4,
	pos4 = 3,
	pos3 = 2
}
var_0_0.IsBlackCtrl = {
	normal = 0,
	black = 1
}

return var_0_0
