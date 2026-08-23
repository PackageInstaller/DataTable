local var_0_0 = {}

var_0_0.URL = "ui://p5u2oelkg3iq3d"

function var_0_0:__ctor()
	self.m_receiveStatusController = self:getController("receiveStatus")
	self.m_baseItem = self:getChild("baseItem")
end

var_0_0.ReceiveStatusCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
