local var_0_0 = {}

var_0_0.URL = "ui://c84aee4v8ts32t"

function var_0_0:__ctor()
	self.m_isFreeController = self:getController("isFree")
	self.m_showRedPointController = self:getController("showRedPoint")
	self.m_freeDrawController = self:getController("freeDraw")
	self.m_freeTimeText = self:getChild("freeTimeText")
	self.m_costComp = self:getChild("costComp")
	self.m_redImg = self:getChild("redImg")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
