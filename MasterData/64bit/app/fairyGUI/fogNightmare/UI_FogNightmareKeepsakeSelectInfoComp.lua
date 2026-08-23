local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oadkwrrmb"

function var_0_0:__ctor()
	self.m_changeController = self:getController("change")
	self.m_powerChangeController = self:getController("powerChange")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_curIcon = self:getChild("curIcon")
	self.m_nextIcon = self:getChild("nextIcon")
	self.m_wearBg = self:getChild("wearBg")
	self.m_wearText = self:getChild("wearText")
	self.m_curSuitIcon = self:getChild("curSuitIcon")
	self.m_curSuitNameText = self:getChild("curSuitNameText")
	self.m_curSuitGroup = self:getChild("curSuitGroup")
	self.m_nextSuitIcon = self:getChild("nextSuitIcon")
	self.m_nextSuitNameText = self:getChild("nextSuitNameText")
	self.m_nextSuitGroup = self:getChild("nextSuitGroup")
	self.m_txtPower = self:getChild("txtPower")
	self.m_suitChangeTipText = self:getChild("suitChangeTipText")
end

var_0_0.ChangeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.PowerChangeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
