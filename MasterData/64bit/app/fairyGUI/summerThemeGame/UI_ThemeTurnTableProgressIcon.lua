local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6k7i7kk3a0"

function var_0_0:__ctor()
	self.m_isAwardGetController = self:getController("isAwardGet")
	self.m_progIcon = self:getChild("progIcon")
	self.m_progText = self:getChild("progText")
	self.m_effectHolderComp = self:getChild("effectHolderComp")
end

var_0_0.IsAwardGetCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
