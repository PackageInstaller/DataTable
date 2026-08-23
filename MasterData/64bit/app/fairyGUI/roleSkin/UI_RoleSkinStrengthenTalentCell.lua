local var_0_0 = {}

var_0_0.URL = "ui://x323b22nje0c7"

function var_0_0:__ctor()
	self.m_activeController = self:getController("active")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_descTxt = self:getChild("descTxt")
end

var_0_0.ActiveCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
