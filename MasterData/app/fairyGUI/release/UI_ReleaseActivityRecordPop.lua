local var_0_0 = {}

var_0_0.URL = "ui://ltl1fuv2k15o2c"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_showList = self:getChild("showList")
	self.m_emptyComp = self:getChild("emptyComp")
	self.m_content = self:getChild("content")
end

return var_0_0
