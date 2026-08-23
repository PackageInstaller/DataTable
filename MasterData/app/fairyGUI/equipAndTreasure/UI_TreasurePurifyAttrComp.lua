local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7lbh7c1"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isUpStateController = self:getController("isUpState")
	self.m_attrBg = self:getChild("attrBg")
	self.m_lockBtn = self:getChild("lockBtn")
	self.m_attrName = self:getChild("attrName")
	self.m_attrValue = self:getChild("attrValue")
	self.m_maxValue = self:getChild("maxValue")
	self.m_curAttrTxt = self:getChild("curAttrTxt")
	self.m_tmpAttrTxt = self:getChild("tmpAttrTxt")
	self.m_openLockTxt = self:getChild("openLockTxt")
	self.m_effholder = self:getChild("effholder")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}
var_0_0.IsUpStateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
