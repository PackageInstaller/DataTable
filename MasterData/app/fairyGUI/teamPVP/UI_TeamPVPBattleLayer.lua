local var_0_0 = {}

var_0_0.URL = "ui://akds0szapw126"

function var_0_0:__ctor()
	self.m_isShowReportController = self:getController("isShowReport")
	self.m_isExtraController = self:getController("isExtra")
	self.m_mapController = self:getController("map")
	self.m_mapComp1 = self:getChild("mapComp1")
	self.m_mapComp2 = self:getChild("mapComp2")
	self.m_mapComp3 = self:getChild("mapComp3")
	self.m_mapComp4 = self:getChild("mapComp4")
	self.m_mapComp5 = self:getChild("mapComp5")
	self.m_mapExtraComp = self:getChild("mapExtraComp")
	self.m_reportTxt = self:getChild("reportTxt")
	self.m_scoreComp = self:getChild("scoreComp")
	self.m_extraComp = self:getChild("extraComp")
	self.m_foodReportTxt = self:getChild("foodReportTxt")
	self.m_headComp1 = self:getChild("headComp1")
	self.m_headComp2 = self:getChild("headComp2")
	self.m_headComp3 = self:getChild("headComp3")
	self.m_headComp4 = self:getChild("headComp4")
	self.m_headComp5 = self:getChild("headComp5")
	self.m_headComp6 = self:getChild("headComp6")
	self.m_headComp7 = self:getChild("headComp7")
	self.m_headComp8 = self:getChild("headComp8")
	self.m_headComp9 = self:getChild("headComp9")
	self.m_headComp10 = self:getChild("headComp10")
	self.m_headInfoGroup = self:getChild("headInfoGroup")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
