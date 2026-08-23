local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2ijna3r"

function var_0_0:__ctor()
	self.m_firstFightController = self:getController("firstFight")
	self.m_leftKnightComp = self:getChild("leftKnightComp")
	self.m_rightKnightComp = self:getChild("rightKnightComp")
	self.m_lUserInfoCompDad = self:getChild("lUserInfoCompDad")
	self.m_rUserInfoCompDad = self:getChild("rUserInfoCompDad")
	self.m_effLineLeft = self:getChild("effLineLeft")
	self.m_effLineRight = self:getChild("effLineRight")
	self.m_effVS = self:getChild("effVS")
	self.m_effBg = self:getChild("effBg")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.FirstFightCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
