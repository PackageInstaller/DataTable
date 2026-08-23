local var_0_0 = {}

var_0_0.URL = "ui://454a48jprlqv1spemjk"

function var_0_0:__ctor()
	self.m_successController = self:getController("success")
	self.m_goodIcon = self:getChild("goodIcon")
	self.m_failReasonTxt = self:getChild("failReasonTxt")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.SuccessCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
