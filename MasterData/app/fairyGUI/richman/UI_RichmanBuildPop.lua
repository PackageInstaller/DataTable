local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwi6ei30"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_levelStateController = self:getController("levelState")
	self.m_typeController = self:getController("type")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_buildLoader = self:getChild("buildLoader")
	self.m_lvTxt = self:getChild("lvTxt")
	self.m_buildNameTxt = self:getChild("buildNameTxt")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_lvUpBtn = self:getChild("lvUpBtn")
	self.m_lvUpDescTxt = self:getChild("lvUpDescTxt")
	self.m_lvUpRewardList = self:getChild("lvUpRewardList")
	self.m_curLvTxt = self:getChild("curLvTxt")
	self.m_nextLvTxt = self:getChild("nextLvTxt")
	self.m_lvUp = self:getChild("lvUp")
	self.m_productTimeTxt = self:getChild("productTimeTxt")
	self.m_hangupTimeTxt = self:getChild("hangupTimeTxt")
	self.m_previewList = self:getChild("previewList")
	self.m_rewardList = self:getChild("rewardList")
	self.m_getBtn = self:getChild("getBtn")
	self.m_productDesTxt = self:getChild("productDesTxt")
	self.m_hangUp = self:getChild("hangUp")
	self.m_otherRewardList = self:getChild("otherRewardList")
	self.m_attackBtn = self:getChild("attackBtn")
	self.m_other = self:getChild("other")
	self.m_fightValuePreText = self:getChild("fightValuePreText")
	self.m_fightValueText = self:getChild("fightValueText")
	self.m_knightList = self:getChild("knightList")
	self.m_defeat = self:getChild("defeat")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
