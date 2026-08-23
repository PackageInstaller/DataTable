local var_0_0 = {}

var_0_0.URL = "ui://akds0szaasmv2t"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_hasBgController = self:getController("hasBg")
	self.m_rewardList = self:getChild("rewardList")
	self.m_honorNum = self:getChild("honorNum")
	self.m_rankLoader = self:getChild("rankLoader")
	self.m_nameTxt = self:getChild("nameTxt")
end

return var_0_0
