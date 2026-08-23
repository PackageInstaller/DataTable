local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oadkwrrni"

function var_0_0:__ctor()
	self.m_isFriendController = self:getController("isFriend")
	self.m_stateController = self:getController("state")
	self.m_knight = self:getChild("knight")
	self.m_stateText = self:getChild("stateText")
end

var_0_0.IsFriendCtrl = {
	friend = 1,
	normal = 0
}
var_0_0.StateCtrl = {
	isUsed = 1,
	isDead = 2,
	normal = 0
}

return var_0_0
