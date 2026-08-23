local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wmpj7b9"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
