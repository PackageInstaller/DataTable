local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm31"

function var_0_0:__ctor()
	self.m_towerController = self:getController("tower")
	self.m_haveBossController = self:getController("haveBoss")
	self.m_towerIcon = self:getChild("towerIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_descComp = self:getChild("descComp")
	self.m_descComp2 = self:getChild("descComp2")
	self.m_targetText = self:getChild("targetText")
	self.m_bossNameText = self:getChild("bossNameText")
	self.m_bossIcon = self:getChild("bossIcon")
	self.m_helpBtn = self:getChild("helpBtn")
	self.m_bossGroup = self:getChild("bossGroup")
	self.m_targetText2 = self:getChild("targetText2")
	self.m_awardList = self:getChild("awardList")
	self.m_awardList2 = self:getChild("awardList2")
	self.m_fightBtn = self:getChild("fightBtn")
	self.m_detailGroup = self:getChild("detailGroup")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.TowerCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.HaveBossCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
