local var_0_0 = {}

var_0_0.URL = "ui://l1121lywokeax"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isEndController = self:getController("isEnd")
	self.m_typeController = self:getController("type")
	self.m_onlyShowRoleController = self:getController("onlyShowRole")
	self.m_awardIconComp = self:getChild("awardIconComp")
	self.m_countTxt = self:getChild("countTxt")
	self.m_scoreLoader = self:getChild("scoreLoader")
	self.m_scoreNumTxt = self:getChild("scoreNumTxt")
	self.m_rolePlaceHolder = self:getChild("rolePlaceHolder")
end

return var_0_0
