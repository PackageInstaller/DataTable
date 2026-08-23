local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oj8cxfc"

function var_0_0:__ctor()
	self.m_isSmallController = self:getController("isSmall")
	self.m_bigStatusController = self:getController("bigStatus")
	self.m_isSelect_bController = self:getController("isSelect_b")
	self.m_numTypeController = self:getController("numType")
	self.m_touchLoader = self:getChild("touchLoader")
	self.m_line = self:getChild("line")
	self.m_effCurved = self:getChild("effCurved")
	self.m_lineLoader = self:getChild("lineLoader")
	self.m_pointLoader = self:getChild("pointLoader")
	self.m_lineBg = self:getChild("lineBg")
	self.m_touchPic = self:getChild("touchPic")
	self.m_lockProgress = self:getChild("lockProgress")
	self.m_pointIcon2 = self:getChild("pointIcon2")
	self.m_pointIcon = self:getChild("pointIcon")
	self.m_txtCurLv = self:getChild("txtCurLv")
	self.m_effUpgradeB = self:getChild("effUpgradeB")
	self.m_effUnlockB = self:getChild("effUnlockB")
	self.m_smallIcon1 = self:getChild("smallIcon1")
	self.m_smallIcon2 = self:getChild("smallIcon2")
	self.m_smallIcon3 = self:getChild("smallIcon3")
	self.m_smallIcon4 = self:getChild("smallIcon4")
end

var_0_0.IsSmallCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.BigStatusCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.IsSelect_bCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.NumTypeCtrl = {
	["3个"] = 1,
	["4个"] = 2,
	["2个"] = 0
}

return var_0_0
