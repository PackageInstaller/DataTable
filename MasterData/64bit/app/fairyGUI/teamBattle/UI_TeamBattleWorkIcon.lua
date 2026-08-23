local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lo3z8e8"

function var_0_0:__ctor()
	self.m_hideSelectController = self:getController("hideSelect")
	self.m_eff = self:getChild("eff")
end

var_0_0.HideSelectCtrl = {
	normal = 0,
	hide = 1
}

return var_0_0
