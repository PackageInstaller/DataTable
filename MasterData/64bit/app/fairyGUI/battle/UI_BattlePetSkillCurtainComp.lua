local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2ganwa8"

function var_0_0:__ctor()
	self.m_isSelfController = self:getController("isSelf")
	self.m_effUP = self:getChild("effUP")
end

var_0_0.IsSelfCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
