local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99nv6b2p"

function var_0_0:__ctor()
	self.m_buttonController = self:getController("button")
	self.m_haloImg = self:getChild("haloImg")
	self.m_lineUpHaloBar = self:getChild("lineUpHaloBar")
	self.m_effectHolder = self:getChild("effectHolder")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ButtonCtrl = {
	down = 3,
	up = 2
}

return var_0_0
