local var_0_0 = {}

var_0_0.URL = "ui://cw1w6t2bwczd2"

function var_0_0:__ctor()
	self.m_isNewController = self:getController("isNew")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_icon = self:getChild("icon")
	self.m_ssrEffReward = self:getChild("ssrEffReward")
	self.m_ssrIdleEffReward = self:getChild("ssrIdleEffReward")
	self.m_srEffReward = self:getChild("srEffReward")
	self.m_rEffReward = self:getChild("rEffReward")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
