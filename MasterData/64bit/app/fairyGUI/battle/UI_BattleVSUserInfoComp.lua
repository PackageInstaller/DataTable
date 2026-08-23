local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2jlo987"

function var_0_0:__ctor()
	self.m_leftController = self:getController("left")
	self.m_nameText = self:getChild("nameText")
	self.m_powerText = self:getChild("powerText")
end

var_0_0.LeftCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
