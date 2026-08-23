local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bns36ugibxr"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_valueTxt = self:getChild("valueTxt")
end

var_0_0.IsActiveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
