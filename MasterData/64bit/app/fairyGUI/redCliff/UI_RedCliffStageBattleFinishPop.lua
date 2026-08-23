local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2snviq60"

function var_0_0:__ctor()
	self.m_isGrandController = self:getController("isGrand")
	self.m_closeBg = self:getChild("closeBg")
	self.m_rank = self:getChild("rank")
	self.m_score = self:getChild("score")
	self.m_finishEffect = self:getChild("finishEffect")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
