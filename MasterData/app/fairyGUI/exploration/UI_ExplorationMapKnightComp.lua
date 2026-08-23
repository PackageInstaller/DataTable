local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25ky9r78"

function var_0_0:__ctor()
	self.m_isMainRoleController = self:getController("isMainRole")
	self.m_bigScaleController = self:getController("bigScale")
	self.m_isBuffMonsterController = self:getController("isBuffMonster")
	self.m_effectDown = self:getChild("effectDown")
	self.m_knightNode = self:getChild("knightNode")
	self.m_nameText = self:getChild("nameText")
	self.m_fightText = self:getChild("fightText")
	self.m_battleLoader = self:getChild("battleLoader")
	self.m_effectUp = self:getChild("effectUp")
	self.m_buffIcon = self:getChild("buffIcon")
end

var_0_0.IsMainRoleCtrl = {
	monster = 0,
	mainRole = 1
}
var_0_0.BigScaleCtrl = {
	big = 1,
	normal = 0
}
var_0_0.IsBuffMonsterCtrl = {
	buff = 1,
	normal = 0
}

return var_0_0
