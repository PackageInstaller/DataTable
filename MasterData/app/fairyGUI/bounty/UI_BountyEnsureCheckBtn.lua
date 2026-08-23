local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfnbc440"

function var_0_0:__ctor()
	self.m_isShowTxtController = self:getController("isShowTxt")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_clickComp = self:getChild("clickComp")
end

return var_0_0
