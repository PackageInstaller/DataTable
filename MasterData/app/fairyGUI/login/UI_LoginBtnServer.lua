local var_0_0 = {}

var_0_0.URL = "ui://xigti88cfvx32u"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_stateIcon = self:getChild("stateIcon")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
