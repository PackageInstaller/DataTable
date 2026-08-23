local var_0_0 = {}

var_0_0.URL = "ui://pbd24silca8h75"

function var_0_0:__ctor()
	self.m_hasAttackUsersController = self:getController("hasAttackUsers")
	self.m_tiledHolder = self:getChild("tiledHolder")
	self.m_floorComp = self:getChild("floorComp")
	self.m_touchMap = self:getChild("touchMap")
	self.m_usersComp = self:getChild("usersComp")
	self.m_ctrlComp = self:getChild("ctrlComp")
	self.m_worldPos = self:getChild("worldPos")
end

return var_0_0
