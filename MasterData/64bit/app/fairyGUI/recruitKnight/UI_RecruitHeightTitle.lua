local var_0_0 = {}

var_0_0.URL = "ui://c64rm38ywczdv"

function var_0_0:__ctor()
	self.m_getSSRController = self:getController("getSSR")
end

var_0_0.GetSSRCtrl = {
	get = 1,
	none = 0
}

return var_0_0
