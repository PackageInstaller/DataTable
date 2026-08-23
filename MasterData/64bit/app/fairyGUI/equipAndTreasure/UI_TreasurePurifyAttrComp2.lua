local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7lbh7cd"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isUpStateController = self:getController("isUpState")
	self.m_attrBg = self:getChild("attrBg")
	self.m_attrName = self:getChild("attrName")
	self.m_attrValue = self:getChild("attrValue")
	self.m_maxValue = self:getChild("maxValue")
	self.m_curAttrTxt = self:getChild("curAttrTxt")
	self.m_tmpAttrTxt = self:getChild("tmpAttrTxt")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.IsUpStateCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
