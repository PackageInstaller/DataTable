local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnom6a3t"

function var_0_0:__ctor()
	self.m_isActivateController = self:getController("isActivate")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_actStatusTxt = self:getChild("actStatusTxt")
	self.m_ksoulList = self:getChild("ksoulList")
end

var_0_0.IsActivateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
