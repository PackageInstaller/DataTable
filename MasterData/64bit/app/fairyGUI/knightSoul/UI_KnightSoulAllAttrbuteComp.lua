local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ullw08v"

function var_0_0:__ctor()
	self.m_hadAdditionController = self:getController("hadAddition")
	self.m_valueAdditionController = self:getController("valueAddition")
	self.m_attrAddList = self:getChild("attrAddList")
	self.m_attrLevelAddList = self:getChild("attrLevelAddList")
	self.m_nextAddComp = self:getChild("nextAddComp")
end

return var_0_0
