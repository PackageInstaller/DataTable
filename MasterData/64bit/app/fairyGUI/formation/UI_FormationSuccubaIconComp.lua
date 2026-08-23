local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99jr2hkk2rs"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isOtherController = self:getController("isOther")
	self.m_addImg = self:getChild("addImg")
	self.m_succubaIcon = self:getChild("succubaIcon")
	self.m_starComp = self:getChild("starComp")
	self.m_advLevel = self:getChild("advLevel")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsEmptyCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsOtherCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
