local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnvy33lgich1"

function var_0_0:__ctor()
	self.m_buttonController = self:getController("button")
	self.m_title = self:getChild("title")
end

var_0_0.ButtonCtrl = {
	up = 2,
	down = 3
}

return var_0_0
