local var_0_0 = {}

var_0_0.URL = "ui://3yl23vbxj4mi1j"

function var_0_0:__ctor()
	self.m_maxController = self:getController("max")
	self.m_infoPopBase = self:getChild("infoPopBase")
end

var_0_0.MaxCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
