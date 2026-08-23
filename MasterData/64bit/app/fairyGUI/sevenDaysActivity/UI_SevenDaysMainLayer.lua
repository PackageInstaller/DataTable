local var_0_0 = {}

var_0_0.URL = "ui://o5p4b64kjdbx0"

function var_0_0:__ctor()
	self.m_actValueController = self:getController("actValue")
	self.m_effBg = self:getChild("effBg")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_uniteTokenPicComp = self:getChild("uniteTokenPicComp")
	self.m_knightBgQuality = self:getChild("knightBgQuality")
	self.m_knightQuality = self:getChild("knightQuality")
	self.m_knightNameTxt = self:getChild("knightNameTxt")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_effTitle = self:getChild("effTitle")
	self.m_cdTxt = self:getChild("cdTxt")
	self.m_taskList = self:getChild("taskList")
	self.m_dayList = self:getChild("dayList")
	self.m_integralAwardList = self:getChild("integralAwardList")
	self.m_curIntegralTxt = self:getChild("curIntegralTxt")
	self.m_integralIconLoader = self:getChild("integralIconLoader")
	self.m_specialIntegralAwardList = self:getChild("specialIntegralAwardList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
