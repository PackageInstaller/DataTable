local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgd85e5ibhz"

function var_0_0:__ctor()
	self.m_isLockController = self:getController("isLock")
	self.m_isShowLineController = self:getController("isShowLine")
	self.m_discountTickController = self:getController("discountTick")
	self.m_isShowMergeAreaController = self:getController("isShowMergeArea")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_effectPlaceHolder = self:getChild("effectPlaceHolder")
	self.m_mergeBg = self:getChild("mergeBg")
	self.m_mergeTxt = self:getChild("mergeTxt")
	self.m_redpointLoader = self:getChild("redpointLoader")
	self.m_tagTxt = self:getChild("tagTxt")
end

var_0_0.IsLockCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsShowLineCtrl = {
	show = 0,
	hide = 1
}
var_0_0.DiscountTickCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsShowMergeAreaCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
