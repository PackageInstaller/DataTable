local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88owspz1emigas"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isOtherController = self:getController("isOther")
	self.m_addImg = self:getChild("addImg")
	self.m_succubaIcon = self:getChild("succubaIcon")
	self.m_starComp = self:getChild("starComp")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsOtherCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
