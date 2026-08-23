local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lzqgm3q"

function var_0_0:__ctor()
	self.m_isFinishController = self:getController("isFinish")
	self.m_eff = self:getChild("eff")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_timeComp = self:getChild("timeComp")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_descTxt = self:getChild("descTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_diffComp1 = self:getChild("diffComp1")
	self.m_diffComp2 = self:getChild("diffComp2")
	self.m_diffComp3 = self:getChild("diffComp3")
	self.m_battleBtn = self:getChild("battleBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_resetTransition = self:getTransition("reset")
end

var_0_0.IsFinishCtrl = {
	finish = 1,
	normal = 0
}

return var_0_0
