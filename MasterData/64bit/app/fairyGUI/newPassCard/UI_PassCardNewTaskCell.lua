local var_0_0 = {}

var_0_0.URL = "ui://gc6wunfkh36u1z"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_numTxt = self:getChild("numTxt")
	self.m_allNumTxt = self:getChild("allNumTxt")
	self.m_taskBtn = self:getChild("taskBtn")
end

return var_0_0
