local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25nbgf7i"

function var_0_0:__ctor()
	self.m_bgTypeController = self:getController("bgType")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_userHeadComp = self:getChild("userHeadComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_serverTxt = self:getChild("serverTxt")
	self.m_timeTxt = self:getChild("timeTxt")
end

var_0_0.BgTypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
