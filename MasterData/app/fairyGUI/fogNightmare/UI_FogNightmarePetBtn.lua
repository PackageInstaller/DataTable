local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88odexu9rrrp"

function var_0_0:__ctor()
	self.m_hasStarController = self:getController("hasStar")
	self.m_isLockController = self:getController("isLock")
	self.m_hasPetController = self:getController("hasPet")
	self.m_qualityLine = self:getChild("qualityLine")
	self.m_petLoader = self:getChild("petLoader")
	self.m_rankText = self:getChild("rankText")
	self.m_starGroupComp = self:getChild("starGroupComp")
	self.m_petGroup = self:getChild("petGroup")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_openText = self:getChild("openText")
end

var_0_0.HasStarCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsLockCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasPetCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
