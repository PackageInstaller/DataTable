local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5116r76u"

function var_0_0:__ctor()
	self.m_arrowController = self:getController("arrow")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_equipIcon = self:getChild("equipIcon")
	self.m_tipIcon = self:getChild("tipIcon")
	self.m_starComp = self:getChild("starComp")
end

return var_0_0
