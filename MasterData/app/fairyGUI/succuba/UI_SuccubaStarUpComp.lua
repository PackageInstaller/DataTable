local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1nc3m9"

function var_0_0:__ctor()
	self.m_isStarMaxController = self:getController("isStarMax")
	self.m_enoughController = self:getController("enough")
	self.m_starText = self:getChild("starText")
	self.m_starMaxText = self:getChild("starMaxText")
	self.m_starNextText = self:getChild("starNextText")
	self.m_skillIcon1 = self:getChild("skillIcon1")
	self.m_skillNameText1 = self:getChild("skillNameText1")
	self.m_skillDescText1 = self:getChild("skillDescText1")
	self.m_skillGroup1 = self:getChild("skillGroup1")
	self.m_skillIcon2 = self:getChild("skillIcon2")
	self.m_skillNameText2 = self:getChild("skillNameText2")
	self.m_skillDescText2 = self:getChild("skillDescText2")
	self.m_skillGroup2 = self:getChild("skillGroup2")
	self.m_baseAttrComp = self:getChild("baseAttrComp")
	self.m_talentSkillComp = self:getChild("talentSkillComp")
	self.m_charmLvComp = self:getChild("charmLvComp")
	self.m_fragIcon = self:getChild("fragIcon")
	self.m_fragNameText = self:getChild("fragNameText")
	self.m_progText = self:getChild("progText")
	self.m_progBar = self:getChild("progBar")
	self.m_starUpBtn = self:getChild("starUpBtn")
	self.m_fragBtn = self:getChild("fragBtn")
	self.m_overflowFragIcon = self:getChild("overflowFragIcon")
	self.m_fragSellBtn = self:getChild("fragSellBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_advanceTransition = self:getTransition("advance")
end

return var_0_0
