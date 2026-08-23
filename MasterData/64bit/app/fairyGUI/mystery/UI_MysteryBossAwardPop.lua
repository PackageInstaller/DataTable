local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8ebwsw41"

function var_0_0:__ctor()
	self.m_rankTypeController = self:getController("rankType")
	self.m_popPanel = self:getChild("popPanel")
	self.m_rankRewardList = self:getChild("rankRewardList")
	self.m_posRewardList = self:getChild("posRewardList")
	self.m_content = self:getChild("content")
end

return var_0_0
