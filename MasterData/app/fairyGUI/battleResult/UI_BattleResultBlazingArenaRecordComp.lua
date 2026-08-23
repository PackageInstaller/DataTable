local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkv3rkmibyw"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_hideRankController = self:getController("hideRank")
	self.m_resultController = self:getController("result")
	self.m_rankNameTxt = self:getChild("rankNameTxt")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_resultList = self:getChild("resultList")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
