local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vzqdx9bnoqa"

function var_0_0:__ctor()
	self.m_mask = self:getChild("mask")
	self.m_highLight = self:getChild("highLight")
	self.m_voteTransition = self:getTransition("vote")
	self.m_normalTransition = self:getTransition("normal")
end

return var_0_0
