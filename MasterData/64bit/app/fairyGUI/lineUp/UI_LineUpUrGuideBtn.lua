local var_0_0 = {}

var_0_0.URL = "ui://ij78oondldwnhs"

function var_0_0:__ctor()
	self.m_buttonController = self:getController("button")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ButtonCtrl = {
	down = 3,
	up = 2
}

return var_0_0
