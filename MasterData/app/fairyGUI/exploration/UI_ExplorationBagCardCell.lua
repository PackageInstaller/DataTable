local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25dtno7n"

function var_0_0:__ctor()
	self.m_isHelpController = self:getController("isHelp")
	self.m_showTypeController = self:getController("showType")
	self.m_isUsingController = self:getController("isUsing")
	self.m_cardIcon = self:getChild("cardIcon")
	self.m_quality = self:getChild("quality")
	self.m_starComp = self:getChild("starComp")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_elementLoader = self:getChild("elementLoader")
end

var_0_0.IsHelpCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowTypeCtrl = {
	page0 = 0,
	page2 = 3,
	page1 = 1,
	page3 = 2
}
var_0_0.IsUsingCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
