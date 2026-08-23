local var_0_0 = {}

var_0_0.URL = "ui://bspi99sbira5v"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isEnouchController = self:getController("isEnouch")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_numTxt = self:getChild("numTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_costIcon = self:getChild("costIcon")
	self.m_costNumTxt = self:getChild("costNumTxt")
	self.m_lockStr = self:getChild("lockStr")
	self.m_limitDesc = self:getChild("limitDesc")
	self.m_limitNumTxt = self:getChild("limitNumTxt")
end

return var_0_0
