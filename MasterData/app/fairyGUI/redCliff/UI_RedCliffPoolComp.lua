local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2seuwd6q"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_frontComp = self:getChild("frontComp")
	self.m_backComp = self:getChild("backComp")
	self.m_cellSize = self:getChild("cellSize")
	self.m_openTransition = self:getTransition("open")
	self.m_closeTransition = self:getTransition("close")
	self.m_openStateTransition = self:getTransition("openState")
	self.m_closeStateTransition = self:getTransition("closeState")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
