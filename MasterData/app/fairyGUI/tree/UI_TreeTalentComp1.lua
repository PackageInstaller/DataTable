local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gt62oy"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_icon = self:getChild("icon")
	self.m_curLevel = self:getChild("curLevel")
	self.m_maxLevel = self:getChild("maxLevel")
end

return var_0_0
