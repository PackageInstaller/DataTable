local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wadyzks"

function var_0_0:__ctor()
	self.m_receiveController = self:getController("receive")
	self.m_descText = self:getChild("descText")
	self.m_rewardList = self:getChild("rewardList")
	self.m_touchNode = self:getChild("touchNode")
end

var_0_0.ReceiveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
