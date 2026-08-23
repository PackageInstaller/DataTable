local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ulhuzp3u"

function var_0_0:__ctor()
	self.m_isActivateController = self:getController("isActivate")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_actStatusTxt = self:getChild("actStatusTxt")
	self.m_ksoulList = self:getChild("ksoulList")
end

return var_0_0
