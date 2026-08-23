local var_0_0 = {}

var_0_0.URL = "ui://pbd24silr0zj61"

function var_0_0:__ctor()
	self.m_recoverTimeController = self:getController("recoverTime")
	self.m_recoverTimeText = self:getChild("recoverTimeText")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
