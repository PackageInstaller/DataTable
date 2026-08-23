local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9hyzz4o"

function var_0_0:__ctor()
	self.m_isLineupController = self:getController("isLineup")
	self.m_embryoIcon = self:getChild("embryoIcon")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_starComp = self:getChild("starComp")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_lappingIcon = self:getChild("lappingIcon")
	self.m_authorityNum = self:getChild("authorityNum")
end

var_0_0.IsLineupCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
