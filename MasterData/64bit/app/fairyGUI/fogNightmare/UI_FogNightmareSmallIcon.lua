local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oj8cxfh"

function var_0_0:__ctor()
	self.m_statusController = self:getController("status")
	self.m_isSelectController = self:getController("isSelect")
	self.m_touchPic = self:getChild("touchPic")
	self.m_pointIcon = self:getChild("pointIcon")
	self.m_pointIcon2 = self:getChild("pointIcon2")
	self.m_txtCurLv = self:getChild("txtCurLv")
	self.m_effUpgradeS = self:getChild("effUpgradeS")
	self.m_effUnlockS = self:getChild("effUnlockS")
end

var_0_0.StatusCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.IsSelectCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
