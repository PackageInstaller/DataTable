local var_0_0 = {}

var_0_0.URL = "ui://akds0szapw12h"

function var_0_0:__ctor()
	self.m_isDeadController = self:getController("isDead")
	self.m_attackTowerController = self:getController("attackTower")
	self.m_isNpcController = self:getController("isNpc")
	self.m_showBuffController = self:getController("showBuff")
	self.m_knightComp = self:getChild("knightComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_hpBar = self:getChild("hpBar")
	self.m_buffEff = self:getChild("buffEff")
	self.m_npcNameTxt = self:getChild("npcNameTxt")
end

return var_0_0
