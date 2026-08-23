local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2gi2ib1"

function var_0_0:__ctor()
	self.m_sideTypeController = self:getController("sideType")
	self.m_criSprite = self:getChild("criSprite")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.SideTypeCtrl = {
	right = 1,
	left = 0
}

return var_0_0
