local var_0_0 = {}

var_0_0.URL = "ui://akds0szalevb2m"

function var_0_0:__ctor()
	self.m_hasBgController = self:getController("hasBg")
	self.m_rankIndexComp = self:getChild("rankIndexComp")
	self.m_rankRange = self:getChild("rankRange")
	self.m_rewardList = self:getChild("rewardList")
end

return var_0_0
