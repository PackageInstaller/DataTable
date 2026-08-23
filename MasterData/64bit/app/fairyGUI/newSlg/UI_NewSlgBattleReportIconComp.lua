local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9t50568u3"

function var_0_0:__ctor()
	self.m_isDefenderController = self:getController("isDefender")
	self.m_hasAllianceController = self:getController("hasAlliance")
	self.m_fightRatioTypeController = self:getController("fightRatioType")
	self.m_proBar = self:getChild("proBar")
	self.m_proTxt = self:getChild("proTxt")
	self.m_teamIcon = self:getChild("teamIcon")
	self.m_fightTextAtk = self:getChild("fightTextAtk")
	self.m_fightRatioTxtAtk = self:getChild("fightRatioTxtAtk")
	self.m_nameTxtAtk = self:getChild("nameTxtAtk")
	self.m_fightTextDef = self:getChild("fightTextDef")
	self.m_fightRatioTxtDef = self:getChild("fightRatioTxtDef")
	self.m_nameTxtDef = self:getChild("nameTxtDef")
	self.m_costTxtAtk = self:getChild("costTxtAtk")
	self.m_costTxtDef = self:getChild("costTxtDef")
	self.m_allianceNameAtk = self:getChild("allianceNameAtk")
	self.m_allianceNameDef = self:getChild("allianceNameDef")
end

var_0_0.IsDefenderCtrl = {
	atk = 0,
	def = 1
}
var_0_0.HasAllianceCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.FightRatioTypeCtrl = {
	up = 1,
	discount = 0,
	none = 2
}

return var_0_0
