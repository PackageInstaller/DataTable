local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ojop9ga"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_styleController = self:getController("style")
	self.m_isOtherController = self:getController("isOther")
	self.m_isAlphaController = self:getController("isAlpha")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_addPic = self:getChild("addPic")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.StyleCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsOtherCtrl = {
	normal = 0,
	other = 1
}
var_0_0.IsAlphaCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
