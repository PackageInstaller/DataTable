local var_0_0 = {}

var_0_0.URL = "ui://sap1qcktnyylfrep"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_nameTitle = self:getChild("nameTitle")
	self.m_talentNameText = self:getChild("talentNameText")
	self.m_talentUnLockTxt = self:getChild("talentUnLockTxt")
	self.m_descText = self:getChild("descText")
end

return var_0_0
