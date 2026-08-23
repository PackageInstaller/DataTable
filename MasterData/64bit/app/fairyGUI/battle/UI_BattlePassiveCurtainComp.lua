local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2jsxscf"

function var_0_0:__ctor()
	self.m_isSelfController = self:getController("isSelf")
	self.m_effUP = self:getChild("effUP")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsSelfCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
