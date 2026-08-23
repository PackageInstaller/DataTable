local var_0_0 = {}

var_0_0.URL = "ui://x323b22nje0c2"

function var_0_0:__ctor()
	self.m_isOwnController = self:getController("isOwn")
	self.m_isWearController = self:getController("isWear")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_stage = self:getChild("stage")
	self.m_level = self:getChild("level")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsOwnCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsWearCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
