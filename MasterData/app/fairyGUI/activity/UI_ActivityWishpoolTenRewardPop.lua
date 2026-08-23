local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wg50ikg"

function var_0_0:__ctor()
	self.m_isLessFiveController = self:getController("isLessFive")
	self.m_fishComp1 = self:getChild("fishComp1")
	self.m_awardComp1 = self:getChild("awardComp1")
	self.m_fishComp2 = self:getChild("fishComp2")
	self.m_awardComp2 = self:getChild("awardComp2")
	self.m_fishComp3 = self:getChild("fishComp3")
	self.m_awardComp3 = self:getChild("awardComp3")
	self.m_fishComp4 = self:getChild("fishComp4")
	self.m_awardComp4 = self:getChild("awardComp4")
	self.m_fishComp5 = self:getChild("fishComp5")
	self.m_awardComp5 = self:getChild("awardComp5")
	self.m_fishComp6 = self:getChild("fishComp6")
	self.m_awardComp6 = self:getChild("awardComp6")
	self.m_fishComp7 = self:getChild("fishComp7")
	self.m_awardComp7 = self:getChild("awardComp7")
	self.m_fishComp8 = self:getChild("fishComp8")
	self.m_awardComp8 = self:getChild("awardComp8")
	self.m_fishComp9 = self:getChild("fishComp9")
	self.m_awardComp9 = self:getChild("awardComp9")
	self.m_fishComp10 = self:getChild("fishComp10")
	self.m_awardComp10 = self:getChild("awardComp10")
	self.m_continueText = self:getChild("continueText")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsLessFiveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
