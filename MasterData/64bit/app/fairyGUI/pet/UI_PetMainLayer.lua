local var_0_0 = {}

var_0_0.URL = "ui://ko1uzjo7if4x9"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_isHelpClickController = self:getController("isHelpClick")
	self.m_rightPetSpineDadComp = self:getChild("rightPetSpineDadComp")
	self.m_leftPetSpineDadComp = self:getChild("leftPetSpineDadComp")
	self.m_petSpineDadComp = self:getChild("petSpineDadComp")
	self.m_nameComp = self:getChild("nameComp")
	self.m_showBtn = self:getChild("showBtn")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_devComp = self:getChild("devComp")
	self.m_blankBg = self:getChild("blankBg")
	self.m_leftBtn = self:getChild("leftBtn")
	self.m_rightBtn = self:getChild("rightBtn")
	self.m_domainBtn = self:getChild("domainBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_switchTransition = self:getTransition("switch")
	self.m_backTransition = self:getTransition("back")
	self.m_enterTransition = self:getTransition("enter")
	self.m_right_inTransition = self:getTransition("right_in")
	self.m_left_inTransition = self:getTransition("left_in")
	self.m_juzhong_1Transition = self:getTransition("juzhong_1")
	self.m_enter_lineupTransition = self:getTransition("enter_lineup")
	self.m_juzhong_2Transition = self:getTransition("juzhong_2")
	self.m_uihideTransition = self:getTransition("uihide")
	self.m_uishowTransition = self:getTransition("uishow")
end

return var_0_0
