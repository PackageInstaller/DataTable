local var_0_0 = {}

var_0_0.URL = "ui://pbd24sil7en81g"

function var_0_0:__ctor()
	self.m_hasAttackUsersController = self:getController("hasAttackUsers")
	self.m_tiledHolder = self:getChild("tiledHolder")
	self.m_floorComp = self:getChild("floorComp")
	self.m_center = self:getChild("center")
	self.m_touchMap = self:getChild("touchMap")
	self.m_usersComp = self:getChild("usersComp")
end

return var_0_0
