local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074vtmo24"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_awardList = self:getChild("awardList")
	self.m_descTxt = self:getChild("descTxt")
	self.m_getBtn = self:getChild("getBtn")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
