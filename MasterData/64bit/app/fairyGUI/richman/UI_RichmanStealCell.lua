local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwi6ei38"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_stateController = self:getController("state")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_powerTxt = self:getChild("powerTxt")
	self.m_mapLvTxt = self:getChild("mapLvTxt")
	self.m_actionBtn = self:getChild("actionBtn")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_protectTimeTxt = self:getChild("protectTimeTxt")
end

return var_0_0
