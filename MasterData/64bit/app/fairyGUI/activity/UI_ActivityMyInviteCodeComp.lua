local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wy8kt5w"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_codeText = self:getChild("codeText")
	self.m_copyBtn = self:getChild("copyBtn")
	self.m_rewardList = self:getChild("rewardList")
	self.m_rechargeList = self:getChild("rechargeList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_cutTransition = self:getTransition("cut")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
