local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1jr2h3d"

function var_0_0:__ctor()
	self.m_hasOwnController = self:getController("hasOwn")
	self.m_canComposeController = self:getController("canCompose")
	self.m_iconComp = self:getChild("iconComp")
	self.m_curFrag = self:getChild("curFrag")
	self.m_needFrag = self:getChild("needFrag")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
