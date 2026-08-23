local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2anu8st1638"

function var_0_0:__ctor()
	self.m_knightSpineDad = self:getChild("knightSpineDad")
	self.m_Btn_shop = self:getChild("Btn_shop")
	self.m_Btn_rank = self:getChild("Btn_rank")
	self.m_Btn_guess = self:getChild("Btn_guess")
	self.m_userName = self:getChild("userName")
	self.m_rank1 = self:getChild("rank1")
	self.m_userHeadComp1 = self:getChild("userHeadComp1")
	self.m_rank2 = self:getChild("rank2")
	self.m_userHeadComp2 = self:getChild("userHeadComp2")
	self.m_rank3 = self:getChild("rank3")
	self.m_userHeadComp3 = self:getChild("userHeadComp3")
	self.m_rank4 = self:getChild("rank4")
	self.m_userHeadComp4 = self:getChild("userHeadComp4")
	self.m_rankUnits = self:getChild("rankUnits")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
