local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bns36ugibxq"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_unLockTxt = self:getChild("unLockTxt")
	self.m_descTxt = self:getChild("descTxt")
end

var_0_0.IsActiveCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
