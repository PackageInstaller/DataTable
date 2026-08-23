local var_0_0 = {}

var_0_0.URL = "ui://irs65rtsh2kkm6q"

function var_0_0:__ctor()
	self.m_cdController = self:getController("cd")
	self.m_cdBar = self:getChild("cdBar")
	self.m_cdTimeBg = self:getChild("cdTimeBg")
	self.m_cdTimeText = self:getChild("cdTimeText")
end

return var_0_0
