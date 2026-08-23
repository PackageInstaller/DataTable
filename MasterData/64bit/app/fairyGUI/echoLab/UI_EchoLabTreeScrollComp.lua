local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1gcrn2u"

function var_0_0:__ctor()
	self.m_buttonController = self:getController("button")
	self.m_lineParent = self:getChild("lineParent")
	self.m_iconParent = self:getChild("iconParent")
end

var_0_0.ButtonCtrl = {
	up = 2,
	down = 3
}

return var_0_0
