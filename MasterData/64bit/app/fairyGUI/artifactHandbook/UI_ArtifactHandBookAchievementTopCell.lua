local var_0_0 = {}

var_0_0.URL = "ui://fl8ril81w7z336"

function var_0_0:__ctor()
	self.m_hadAdditionController = self:getController("hadAddition")
	self.m_valueAdditionController = self:getController("valueAddition")
	self.m_stateController = self:getController("state")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_attrAddList = self:getChild("attrAddList")
	self.m_processBar = self:getChild("processBar")
	self.m_processTxt = self:getChild("processTxt")
	self.m_attrLevelAddList = self:getChild("attrLevelAddList")
	self.m_nextAddComp = self:getChild("nextAddComp")
end

return var_0_0
