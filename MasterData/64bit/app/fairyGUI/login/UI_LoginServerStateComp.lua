local var_0_0 = {}

var_0_0.URL = "ui://xigti88c8prx3l"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
end

var_0_0.StateCtrl = {
	维护 = 0,
	爆满 = 3,
	火热 = 2,
	流畅 = 1
}

return var_0_0
