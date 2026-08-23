local var_0_0 = {}

var_0_0.URL = "ui://9n9qtghbf1u7mic65"

function var_0_0:__ctor()
	self.m_buildStateController = self:getController("buildState")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_posTxt = self:getChild("posTxt")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_shareBtn = self:getChild("shareBtn")
	self.m_TimeTxt = self:getChild("TimeTxt")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
