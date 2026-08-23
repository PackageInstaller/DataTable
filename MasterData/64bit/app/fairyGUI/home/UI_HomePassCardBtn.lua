local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgra3m5ibky"

function var_0_0:__ctor()
	self.m_normalScaleController = self:getController("normalScale")
	self.m_effectComp = self:getChild("effectComp")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.NormalScaleCtrl = {
	small = 0,
	big = 1
}

return var_0_0
