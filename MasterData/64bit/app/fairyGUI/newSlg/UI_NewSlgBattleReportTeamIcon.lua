local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9t50568u2"

function var_0_0:__ctor()
	self.m_showMaskController = self:getController("showMask")
	self.m_isEnemyController = self:getController("isEnemy")
	self.m_iconBtn = self:getChild("iconBtn")
	self.m_enemyIcon = self:getChild("enemyIcon")
	self.m_typeComp = self:getChild("typeComp")
end

var_0_0.ShowMaskCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsEnemyCtrl = {
	enemy = 1,
	normal = 0
}

return var_0_0
