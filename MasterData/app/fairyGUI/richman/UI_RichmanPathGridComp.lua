local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwvrxa6"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_title = self:getChild("title")
	self.m_gridEventTxt = self:getChild("gridEventTxt")
	self.m_effHolder = self:getChild("effHolder")
	self.m_effRefreshHolder = self:getChild("effRefreshHolder")
end

return var_0_0
