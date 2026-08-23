local var_0_0 = {}

var_0_0.URL = "ui://5c0f8ijkpmhr12"

function var_0_0:__ctor()
	self.m_isGetController = self:getController("isGet")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_backEnTxt = self:getChild("backEnTxt")
	self.m_numChangeComp = self:getChild("numChangeComp")
	self.m_banGraph = self:getChild("banGraph")
end

return var_0_0
