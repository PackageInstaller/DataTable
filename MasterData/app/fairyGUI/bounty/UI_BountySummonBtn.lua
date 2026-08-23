local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfxblah"

function var_0_0:__ctor()
	self.m_isFreeController = self:getController("isFree")
	self.m_showRedPointController = self:getController("showRedPoint")
	self.m_freeDrawController = self:getController("freeDraw")
	self.m_freeTimeText = self:getChild("freeTimeText")
	self.m_costComp = self:getChild("costComp")
	self.m_redImg = self:getChild("redImg")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_tipText = self:getChild("tipText")
	self.m_starComp = self:getChild("starComp")
end

return var_0_0
