local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6ppb7kk39l"

function var_0_0:__ctor()
	self.m_getAwardController = self:getController("getAward")
	self.m_icon = self:getChild("icon")
end

var_0_0.GetAwardCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
