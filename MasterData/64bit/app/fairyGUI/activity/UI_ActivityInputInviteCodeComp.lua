local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wy8kt5x"

function var_0_0:__ctor()
	self.m_inviteStatusController = self:getController("inviteStatus")
	self.m_confirmInviteBtn = self:getChild("confirmInviteBtn")
	self.m_inputComp = self:getChild("inputComp")
	self.m_inviteRewardList = self:getChild("inviteRewardList")
	self.m_taskList = self:getChild("taskList")
	self.m_taskRewardList = self:getChild("taskRewardList")
	self.m_touchNode = self:getChild("touchNode")
	self.m_enterTransition = self:getTransition("enter")
	self.m_cutTransition = self:getTransition("cut")
end

var_0_0.InviteStatusCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
