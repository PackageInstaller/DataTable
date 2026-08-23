local var_0_0 = {}

var_0_0.URL = "ui://nhmdbbcvdq86j"

function var_0_0:__ctor()
	self.m_isLinkController = self:getController("isLink")
	self.m_idleEffectDown = self:getChild("idleEffectDown")
	self.m_maskKnight = self:getChild("maskKnight")
	self.m_levelText = self:getChild("levelText")
	self.m_title1 = self:getChild("title1")
	self.m_touchPanel = self:getChild("touchPanel")
	self.m_title2 = self:getChild("title2")
	self.m_attrList = self:getChild("attrList")
	self.m_tipsBtn = self:getChild("tipsBtn")
	self.m_enterEffect = self:getChild("enterEffect")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_skillDesc1 = self:getChild("skillDesc1")
	self.m_skill1 = self:getChild("skill1")
	self.m_skillIcon2 = self:getChild("skillIcon2")
	self.m_skillDesc2 = self:getChild("skillDesc2")
	self.m_skill2 = self:getChild("skill2")
	self.m_idleEffectUp = self:getChild("idleEffectUp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
