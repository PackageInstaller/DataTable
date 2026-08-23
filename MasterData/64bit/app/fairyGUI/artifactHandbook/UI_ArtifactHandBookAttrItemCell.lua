local var_0_0 = {}

var_0_0.URL = "ui://fl8ril81t9w02r"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_iconImg = self:getChild("iconImg")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_valueTxt = self:getChild("valueTxt")
	self.m_nextValueTxt = self:getChild("nextValueTxt")
end

return var_0_0
