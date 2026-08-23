local var_0_0 = {}

var_0_0.URL = "ui://2r646mayqufe1g"

function var_0_0:__ctor()
	self.m_useController = self:getController("use")
	self.m_isLockController = self:getController("isLock")
	self.m_isLimitTimeController = self:getController("isLimitTime")
	self.m_iconComp = self:getChild("iconComp")
	self.m_mask = self:getChild("mask")
	self.m_frameLoader = self:getChild("frameLoader")
	self.m_effHolder = self:getChild("effHolder")
	self.m_frameRedPointComp = self:getChild("frameRedPointComp")
end

var_0_0.UseCtrl = {
	use = 1,
	none = 0
}
var_0_0.IsLockCtrl = {
	open = 0,
	lock = 1
}
var_0_0.IsLimitTimeCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
