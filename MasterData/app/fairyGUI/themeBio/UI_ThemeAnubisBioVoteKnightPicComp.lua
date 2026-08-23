local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vl5qqbr"

function var_0_0:__ctor()
	self.m_isResultController = self:getController("isResult")
	self.m_stateController = self:getController("state")
	self.m_hasVotedController = self:getController("hasVoted")
	self.m_icon = self:getChild("icon")
end

return var_0_0
