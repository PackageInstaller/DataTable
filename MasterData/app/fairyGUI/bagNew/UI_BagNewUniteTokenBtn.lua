local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qrhqr410"

function var_0_0:__ctor()
	self.m_bgStyleController = self:getController("bgStyle")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.BgStyleCtrl = {
	灰色 = 0,
	红色 = 1
}

return var_0_0
