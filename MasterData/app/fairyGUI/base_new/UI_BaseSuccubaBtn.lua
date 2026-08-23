local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepjr2h1emigk0"

function var_0_0:__ctor()
	self.m_IsExpandController = self:getController("IsExpand")
	self.m_showStateController = self:getController("showState")
	self.m_succubauitList = self:getChild("succubauitList")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
