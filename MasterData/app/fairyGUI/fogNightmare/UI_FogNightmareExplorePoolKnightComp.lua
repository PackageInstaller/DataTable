local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oadkwrrno"

function var_0_0:__ctor()
	self.m_hasKeepsakeController = self:getController("hasKeepsake")
	self.m_isFriendController = self:getController("isFriend")
	self.m_isDeadController = self:getController("isDead")
	self.m_knightComp = self:getChild("knightComp")
	self.m_addKeepsakeBtn = self:getChild("addKeepsakeBtn")
	self.m_noKeepsakeLoader = self:getChild("noKeepsakeLoader")
	self.m_keepsakeIcon = self:getChild("keepsakeIcon")
	self.m_mask = self:getChild("mask")
end

var_0_0.HasKeepsakeCtrl = {
	has = 1,
	lock = 0,
	none = 2
}
var_0_0.IsFriendCtrl = {
	friend = 1,
	normal = 0
}
var_0_0.IsDeadCtrl = {
	alive = 0,
	dead = 1
}

return var_0_0
