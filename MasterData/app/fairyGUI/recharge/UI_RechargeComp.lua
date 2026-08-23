local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52weu6r2z"

function var_0_0:__ctor()
	self.m_compBg = self:getChild("compBg")
	self.m_goodsList = self:getChild("goodsList")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_confirmBtn2 = self:getChild("confirmBtn2")
	self.m_permanentRechargeBtn = self:getChild("permanentRechargeBtn")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_loaderBtn = self:getChild("loaderBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
