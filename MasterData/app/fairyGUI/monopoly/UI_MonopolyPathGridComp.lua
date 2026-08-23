local var_0_0 = {}

var_0_0.URL = "ui://6b52cxc1oky95w"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_qualityController = self:getController("quality")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_effDown = self:getChild("effDown")
	self.m_title = self:getChild("title")
	self.m_gridEventTxt = self:getChild("gridEventTxt")
	self.m_effHolder = self:getChild("effHolder")
	self.m_effRefreshHolder = self:getChild("effRefreshHolder")
	self.m_imgIcon = self:getChild("imgIcon")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_effUp = self:getChild("effUp")
	self.m_eff = self:getChild("eff")
	self.m_boxComp = self:getChild("boxComp")
	self.m_leUpTransition = self:getTransition("leUp")
end

return var_0_0
