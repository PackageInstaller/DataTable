local var_0_0 = {}

var_0_0.URL = "ui://9n9qtghbw5ib7l"

function var_0_0:__ctor()
	self.m_hasStarController = self:getController("hasStar")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_qualityBar = self:getChild("qualityBar")
	self.m_petLoader = self:getChild("petLoader")
	self.m_rankText = self:getChild("rankText")
	self.m_starGroupComp = self:getChild("starGroupComp")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
