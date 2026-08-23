local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ul9lw73k"

function var_0_0:__ctor()
	self.m_groupController = self:getController("group")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_soulTab = self:getChild("soulTab")
	self.m_soulList = self:getChild("soulList")
	self.m_infoComp = self:getChild("infoComp")
	self.m_sellBtn = self:getChild("sellBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
