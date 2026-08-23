local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkpbi8s"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_isLockController = self:getController("isLock")
	self.m_petLoader = self:getChild("petLoader")
	self.m_qualityBarLoader = self:getChild("qualityBarLoader")
	self.m_bigStageTxt = self:getChild("bigStageTxt")
	self.m_starComp = self:getChild("starComp")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_openText = self:getChild("openText")
end

var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsLockCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
