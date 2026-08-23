local var_0_0 = {}

var_0_0.URL = "ui://3yl23vbxfqzb42"

function var_0_0:__ctor()
	self.m_activeController = self:getController("active")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_descTxt = self:getChild("descTxt")
end

var_0_0.ActiveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
