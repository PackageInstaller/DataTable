local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25ts9h57"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_stateIcon = self:getChild("stateIcon")
end

var_0_0.StateCtrl = {
	lock = 3,
	none = 0,
	cur = 2,
	pass = 1
}

return var_0_0
