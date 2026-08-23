local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wk3gjdk"

function var_0_0:__ctor()
	self.m_isReceivedController = self:getController("isReceived")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsReceivedCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
