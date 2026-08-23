local var_0_0 = {}

var_0_0.URL = "ui://3yl23vbxscpe39"

function var_0_0:__ctor()
	self.m_hasPassiveController = self:getController("hasPassive")
	self.m_title1 = self:getChild("title1")
	self.m_touchPanel = self:getChild("touchPanel")
	self.m_title2 = self:getChild("title2")
	self.m_attrList = self:getChild("attrList")
	self.m_tipsBtn = self:getChild("tipsBtn")
	self.m_skillComp = self:getChild("skillComp")
	self.m_passiveSkillComp = self:getChild("passiveSkillComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.HasPassiveCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
