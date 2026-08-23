local var_0_0 = {}

var_0_0.URL = "ui://nz3msl46k4mx10"

function var_0_0:__ctor()
	self.m_isUnlockController = self:getController("isUnlock")
	self.m_expandedController = self:getController("expanded")
	self.m_isOtherTipController = self:getController("isOtherTip")
	self.m_icon1 = self:getChild("icon1")
	self.m_icon2 = self:getChild("icon2")
	self.m_tipText = self:getChild("tipText")
	self.m_textBgLoader = self:getChild("textBgLoader")
	self.m_otherTipText = self:getChild("otherTipText")
	self.m_redPoint = self:getChild("redPoint")
	self.m_tabBgTransition = self:getTransition("tabBg")
end

var_0_0.IsUnlockCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ExpandedCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsOtherTipCtrl = {
	otherTip = 1,
	newPlayer = 2,
	normal = 0
}

return var_0_0
