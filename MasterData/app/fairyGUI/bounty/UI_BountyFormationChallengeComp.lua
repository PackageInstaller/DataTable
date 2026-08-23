local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfn1mfs"

function var_0_0:__ctor()
	self.m_hideShareAwardController = self:getController("hideShareAward")
	self.m_fightValueText = self:getChild("fightValueText")
	self.m_shareNameText = self:getChild("shareNameText")
	self.m_enemyList = self:getChild("enemyList")
	self.m_killAwardList = self:getChild("killAwardList")
	self.m_shareAwardList = self:getChild("shareAwardList")
	self.m_battleBtn = self:getChild("battleBtn")
	self.m_costComp = self:getChild("costComp")
	self.m_formationBtn = self:getChild("formationBtn")
end

return var_0_0
