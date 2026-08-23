local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2oe6dd6"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_icon = self:getChild("icon")
	self.m_cdTxt = self:getChild("cdTxt")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
