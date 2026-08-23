local var_0_0 = {}

var_0_0.URL = "ui://16fa1nlapo2z5i"

function var_0_0:__ctor()
	self.m_getStateController = self:getController("getState")
	self.m_showUpController = self:getController("showUp")
	self.m_showDownController = self:getController("showDown")
	self.m_item = self:getChild("item")
	self.m_numTxt = self:getChild("numTxt")
	self.m_eff = self:getChild("eff")
	self.m_proTxt = self:getChild("proTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.GetStateCtrl = {
	got = 2,
	canGet = 1,
	normal = 0
}
var_0_0.ShowUpCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowDownCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
