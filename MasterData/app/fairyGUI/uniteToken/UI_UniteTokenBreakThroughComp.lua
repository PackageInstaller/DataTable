local var_0_0 = {}

var_0_0.URL = "ui://3yl23vbxscpe3f"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_activeController = self:getController("active")
	self.m_showSkillNumController = self:getController("showSkillNum")
	self.m_curStarTxt = self:getChild("curStarTxt")
	self.m_nextStarTxt = self:getChild("nextStarTxt")
	self.m_curMaxStarTxt = self:getChild("curMaxStarTxt")
	self.m_curSkillComp1 = self:getChild("curSkillComp1")
	self.m_nextSkillComp1 = self:getChild("nextSkillComp1")
	self.m_curSkillComp2 = self:getChild("curSkillComp2")
	self.m_nextSkillComp2 = self:getChild("nextSkillComp2")
	self.m_attrBg = self:getChild("attrBg")
	self.m_tipsBtn = self:getChild("tipsBtn")
	self.m_upgradeBtn = self:getChild("upgradeBtn")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_itemNameTxt = self:getChild("itemNameTxt")
	self.m_itemNumTxt = self:getChild("itemNumTxt")
	self.m_processBar = self:getChild("processBar")
	self.m_universalBtn = self:getChild("universalBtn")
	self.m_fragIcon = self:getChild("fragIcon")
	self.m_sellBtn = self:getChild("sellBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_maxSkillComp1 = self:getChild("maxSkillComp1")
	self.m_maxSkillComp2 = self:getChild("maxSkillComp2")
	self.m_backTransition = self:getTransition("back")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 5,
	page1 = 1
}
var_0_0.ActiveCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowSkillNumCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
