local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepkrgi1emigij"

function var_0_0:__ctor()
	self.m_equipTypeController = self:getController("equipType")
	self.m_stage1 = self:getChild("stage1")
	self.m_stage2 = self:getChild("stage2")
	self.m_stage3 = self:getChild("stage3")
	self.m_stage4 = self:getChild("stage4")
	self.m_stage5 = self:getChild("stage5")
end

return var_0_0
