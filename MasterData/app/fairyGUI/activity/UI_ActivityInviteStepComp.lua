local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wy8kt60"

function var_0_0:__ctor()
	self.m_receiveController = self:getController("receive")
	self.m_inviteConditionText = self:getChild("inviteConditionText")
	self.m_rewardList = self:getChild("rewardList")
	self.m_touchNode = self:getChild("touchNode")
end

var_0_0.ReceiveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
